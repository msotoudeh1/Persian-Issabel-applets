<?php
class Applet_IssabelStats
{
    function handleJSON_getContent($smarty, $module_name, $appletlist)
    {
        $data = $this->fetchStatsData();
        foreach ($data as $key => $value) $smarty->assign($key, $value);
        $html = $smarty->fetch('file:' . dirname(__FILE__) . '/tpl/summary.tpl');
        header('Content-Type: application/json');
        return json_encode(array('status' => 'success', 'message' => '(no message)', 'html' => $html));
    }

    function handleJSON_getFull($smarty, $module_name, $appletlist)
    {
        $data = $this->fetchStatsData();
        foreach ($data as $key => $value) $smarty->assign($key, $value);
        $html = $smarty->fetch('file:' . dirname(__FILE__) . '/tpl/full.tpl');
        echo $html;
        exit;
    }

    private function fetchStatsData()
    {
        $peers_data = $this->getSipPeers();
        $queue_data = $this->getQueueStatus();
        $channel_data = $this->getActiveChannels();
        
        $cdr_day = $this->getCDRStats('day');
        $cdr_month = $this->getCDRStats('month');
        $cdr_year = $this->getCDRStats('year');

        $traffic_day = $this->getTrafficChartData('day');
        $traffic_month = $this->getTrafficChartData('month');
        $traffic_year = $this->getTrafficChartData('year');

        $top_day = $this->getTopExtensions('day');
        $top_month = $this->getTopExtensions('month');
        $top_year = $this->getTopExtensions('year');

        // دریافت تماس‌های اخیر برای هر سه دوره
        $recent_day = $this->getRecentCalls('day');
        $recent_month = $this->getRecentCalls('month');
        $recent_year = $this->getRecentCalls('year');

        $period_data = array(
            'day' => array('stats' => $cdr_day, 'traffic' => $traffic_day, 'top' => $top_day, 'recent' => $recent_day),
            'month' => array('stats' => $cdr_month, 'traffic' => $traffic_month, 'top' => $top_month, 'recent' => $recent_month),
            'year' => array('stats' => $cdr_year, 'traffic' => $traffic_year, 'top' => $top_year, 'recent' => $recent_year)
        );

        $ext_total = count($peers_data['extensions']);
        $ext_online = 0;
        $trunk_total = count($peers_data['trunks']);
        $trunk_online = 0;
        $trunks_list = array();

        foreach ($peers_data['extensions'] as $ext) if ($ext['status'] === 'OK') $ext_online++;
        foreach ($peers_data['trunks'] as $trunk) {
            if ($trunk['status'] === 'OK') $trunk_online++;
            $trunks_list[] = $trunk;
        }

        return array(
            'asterisk_ok' => $peers_data['asterisk_ok'],
            'time' => date('H:i:s'),
            'date_jalali' => $this->getJalaliDate(), 
            'ext_total' => $ext_total,
            'ext_online' => $ext_online,
            'ext_offline' => $ext_total - $ext_online,
            'trunk_total' => $trunk_total,
            'trunk_online' => $trunk_online,
            'trunk_offline' => $trunk_total - $trunk_online,
            'trunks' => $trunks_list,
            'queue_total' => $queue_data['total'],
            'queue_members' => $queue_data['members'],
            'queue_waiting' => $queue_data['waiting'],
            'active_calls' => $channel_data['calls'],
            'active_channels' => $channel_data['channels'],
            'cdr_total_calls' => $cdr_day['total'],
            'cdr_answered' => $cdr_day['answered'],
            'cdr_failed' => $cdr_day['failed'],
            'cdr_avg_duration' => $cdr_day['avg_duration'],
            'period_data_json' => json_encode($period_data, JSON_UNESCAPED_UNICODE)
        );
    }

    // --- تابع جدید برای دریافت ۱۰ تماس اخیر ورودی و خروجی ---
    private function getRecentCalls($period) {
        $calls = array();
        try {
            $pdo = new PDO('mysql:host=localhost;dbname=asteriskcdrdb;charset=utf8', 'asteriskuser', 'database_password');
            
            $where = "DATE(calldate) = CURDATE()";
            if ($period == 'month') $where = "MONTH(calldate) = MONTH(CURDATE()) AND YEAR(calldate) = YEAR(CURDATE())";
            if ($period == 'year') $where = "YEAR(calldate) = YEAR(CURDATE())";

            // شرط فیلتر: فقط تماس‌های داخلی، ورودی از ترانک یا IVR
            $sql = "SELECT calldate, src, dst, dcontext, disposition, billsec 
                    FROM cdr 
                    WHERE $where 
                    AND (dcontext LIKE 'from-internal%' OR dcontext LIKE 'from-did%' OR dcontext LIKE 'ivr-%' OR dcontext LIKE 'from-trunk%' OR dcontext LIKE 'from-pstn%')
                    ORDER BY calldate DESC LIMIT 100";
                    
            $stmt = $pdo->query($sql);
            while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                // تشخیص جهت تماس بر اساس کانتکست
                $is_inbound = (stripos($row['dcontext'], 'from-internal') === false);
                $row['direction'] = $is_inbound ? 'inbound' : 'outbound';
                $calls[] = $row;
            }
        } catch (PDOException $e) {}
        return $calls;
    }

    private function getSipPeers() {
        $extensions = array(); $trunks = array();
        $db_trunks = array();

        try {
            $pdo = new PDO('mysql:host=localhost;dbname=asterisk;charset=utf8', 'asteriskuser', '123tosan8661');
            $stmt = $pdo->query("SELECT name, tech, channelid FROM trunks");
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $trunk_name = trim(!empty($row['channelid']) ? $row['channelid'] : $row['name']);
                $db_trunks[$trunk_name] = array('tech' => strtoupper($row['tech']), 'status' => 'UNKNOWN');
            }
        } catch (PDOException $e) { }

        $sip_out = array(); @exec('/usr/sbin/asterisk -rx "sip show peers" 2>/dev/null', $sip_out);
        $pjsip_out = array(); @exec('/usr/sbin/asterisk -rx "pjsip show endpoints" 2>/dev/null', $pjsip_out);

        foreach ($sip_out as $line) {
            $line = trim($line);
            if (empty($line) || stripos($line, 'Name/username') === 0 || stripos($line, 'sip peers') !== false || stripos($line, 'objects found') !== false) continue;
            $parts = preg_split('/\s+/', $line);
            if (count($parts) < 1) continue;
            $raw_name = $parts[0];
            $name = explode('/', $raw_name)[0];
            $status = 'UNKNOWN';
            if (preg_match('/\s(OK|UNREACHABLE|LAGGED)\b/i', $line, $sm)) $status = strtoupper($sm[1]);
            
            if (array_key_exists($name, $db_trunks)) {
                $db_trunks[$name]['status'] = $status;
            } else {
                $extensions[] = array('name' => $name, 'status' => $status, 'host' => 'SIP');
            }
        }

        foreach ($db_trunks as $name => $info) {
            if ($info['tech'] === 'PJSIP') {
                foreach ($pjsip_out as $line) {
                    if (stripos($line, 'Endpoint: ' . $name) !== false) {
                        $db_trunks[$name]['status'] = (stripos($line, 'Unavailable') !== false || stripos($line, 'Unknown') !== false) ? 'UNREACHABLE' : 'OK';
                    }
                }
            }
        }

        foreach ($db_trunks as $name => $info) {
            $trunks[] = array('name' => $name, 'status' => $info['status'], 'host' => $info['tech']);
        }

        foreach ($pjsip_out as $line) {
            if (preg_match('/Endpoint:\s+([^\s]+)/', $line, $pm)) {
                $name = $pm[1];
                if ($name === 'dummy_endpoint' || array_key_exists($name, $db_trunks)) continue;
                $status = (stripos($line, 'Unavailable') !== false || stripos($line, 'Unknown') !== false) ? 'UNREACHABLE' : 'OK';
                $exists = false;
                foreach ($extensions as $e) { if ($e['name'] === $name) $exists = true; }
                if (!$exists) $extensions[] = array('name' => $name, 'status' => $status, 'host' => 'PJSIP');
            }
        }
        return array('extensions' => $extensions, 'trunks' => $trunks, 'asterisk_ok' => !empty($sip_out) || !empty($pjsip_out));
    }

    private function getQueueStatus() {
        $output = array(); @exec('/usr/sbin/asterisk -rx "queue show" 2>/dev/null', $output);
        $total_queues = 0; $total_members = 0; $total_waiting = 0;
        foreach ($output as $line) {
            if (preg_match('/^(\w+)\s+has\s+(\d+)\s+calls/i', $line, $m)) {
                $total_queues++; $total_waiting += (int)$m[2];
            }
        }
        @exec('/usr/sbin/asterisk -rx "queue show" 2>/dev/null | grep -c "Members:"', $member_lines);
        if (isset($member_lines[0])) $total_members = (int)$member_lines[0];
        return array('total' => $total_queues, 'members' => $total_members, 'waiting' => $total_waiting);
    }

    private function getActiveChannels() {
        $output = array(); @exec('/usr/sbin/asterisk -rx "core show channels" 2>/dev/null', $output);
        $calls = 0; $channels = 0;
        foreach ($output as $line) {
            if (preg_match('/^(\d+)\s+active channel/i', $line, $m)) $channels = (int)$m[1];
            if (preg_match('/^(\d+)\s+active call/i', $line, $m)) $calls = (int)$m[1];
        }
        return array('calls' => $calls, 'channels' => $channels);
    }

    private function getCDRStats($period) {
        $stats = array('total' => 0, 'answered' => 0, 'failed' => 0, 'avg_duration' => 0);
        try {
            $pdo = new PDO('mysql:host=localhost;dbname=asteriskcdrdb;charset=utf8', 'asteriskuser', '123tosan8661');
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            
            $where = "DATE(calldate) = CURDATE()";
            if ($period == 'month') $where = "MONTH(calldate) = MONTH(CURDATE()) AND YEAR(calldate) = YEAR(CURDATE())";
            if ($period == 'year') $where = "YEAR(calldate) = YEAR(CURDATE())";

            $sql = "SELECT COUNT(*) as total, 
                    SUM(CASE WHEN disposition = 'ANSWERED' THEN 1 ELSE 0 END) as answered, 
                    SUM(CASE WHEN disposition IN ('BUSY', 'FAILED', 'NO ANSWER') THEN 1 ELSE 0 END) as failed, 
                    AVG(CASE WHEN disposition = 'ANSWERED' THEN duration ELSE NULL END) as avg_duration 
                    FROM cdr WHERE $where";
                    
            $stmt = $pdo->query($sql);
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            if ($row) {
                $stats['total'] = (int)$row['total']; 
                $stats['answered'] = (int)$row['answered'];
                $stats['failed'] = (int)$row['failed']; 
                $stats['avg_duration'] = round((float)$row['avg_duration']);
            }
        } catch (PDOException $e) { }
        return $stats;
    }

    private function getTrafficChartData($period) {
        if ($period == 'day') $data = array_fill(0, 24, array('inbound' => 0, 'outbound' => 0));
        elseif ($period == 'month') $data = array_fill(0, 31, array('inbound' => 0, 'outbound' => 0));
        else $data = array_fill(0, 12, array('inbound' => 0, 'outbound' => 0));
        
        try {
            $pdo = new PDO('mysql:host=localhost;dbname=asteriskcdrdb;charset=utf8', 'asteriskuser', '123tosan8661');
            
            $groupBy = 'HOUR(calldate)';
            $where = "DATE(calldate) = CURDATE()";
            $offset = 0;

            if ($period == 'month') {
                $groupBy = 'DAY(calldate)';
                $where = "MONTH(calldate) = MONTH(CURDATE()) AND YEAR(calldate) = YEAR(CURDATE())";
                $offset = 1;
            }
            if ($period == 'year') {
                $groupBy = 'MONTH(calldate)';
                $where = "YEAR(calldate) = YEAR(CURDATE())";
                $offset = 1;
            }

            $sql = "SELECT $groupBy as t, 
                    SUM(CASE WHEN dcontext LIKE 'from-did%' OR dcontext LIKE 'ivr-%' OR dcontext LIKE 'from-trunk%' OR dcontext LIKE 'from-pstn%' THEN 1 ELSE 0 END) as inbound,
                    SUM(CASE WHEN dcontext LIKE 'from-internal%' THEN 1 ELSE 0 END) as outbound
                    FROM cdr WHERE $where GROUP BY $groupBy";
                    
            $stmt = $pdo->query($sql);
            while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $h = (int)$row['t'] - $offset;
                if(isset($data[$h])) {
                    $data[$h]['inbound'] = (int)$row['inbound'];
                    $data[$h]['outbound'] = (int)$row['outbound'];
                }
            }
        } catch (PDOException $e) {}
        return $data;
    }

    private function getTopExtensions($period) {
        $top = array();
        try {
            $pdo = new PDO('mysql:host=localhost;dbname=asteriskcdrdb;charset=utf8', 'asteriskuser', '123tosan8661');
            
            $where = "DATE(calldate) = CURDATE()";
            if ($period == 'month') $where = "MONTH(calldate) = MONTH(CURDATE()) AND YEAR(calldate) = YEAR(CURDATE())";
            if ($period == 'year') $where = "YEAR(calldate) = YEAR(CURDATE())";

            $sql = "SELECT src as ext, COUNT(*) as call_count, SUM(billsec) as talk_time 
                    FROM cdr 
                    WHERE $where AND dcontext LIKE 'from-internal%' AND LENGTH(src) <= 5
                    GROUP BY src ORDER BY call_count DESC LIMIT 5";
            $stmt = $pdo->query($sql);
            while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $top[] = $row;
            }
        } catch (PDOException $e) {}
        return $top;
    }

    private function getJalaliDate() {
        $gy = date('Y'); $gm = date('m'); $gd = date('d');
        $g_d_m = array(0,31,59,90,120,151,181,212,243,273,304,334);
        if($gy > 1600){ $jy=979; $gy-=1600; }else{ $jy=0; $gy-=621; }
        $gy2 = ($gm > 2) ? ($gy + 1) : $gy;
        $days = (365 * $gy) + ((int)(($gy2 + 3) / 4)) - ((int)(($gy2 + 99) / 100)) + ((int)(($gy2 + 399) / 400)) - 80 + $gd + $g_d_m[$gm - 1];
        $jy += 33 * ((int)($days / 12053)); $days %= 12053;
        $jy += 4 * ((int)($days / 1461)); $days %= 1461;
        if($days > 365){ $jy += (int)(($days - 1) / 365); $days = ($days - 1) % 365; }
        if($days < 186){ $jm = 1 + (int)($days / 31); $jd = 1 + ($days % 31); }else{ $jm = 7 + (int)(($days - 186) / 30); $jd = 1 + (($days - 186) % 30); }
        return "$jy/$jm/$jd";
    }
}
