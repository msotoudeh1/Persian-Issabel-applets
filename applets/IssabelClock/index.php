<?php
class Applet_IssabelClock
{
    function handleJSON_getContent($smarty, $module_name, $appletlist)
    {
        // محاسبه تاریخ شمسی
        $smarty->assign('date_jalali', $this->getJalaliDate());
        
        // رندر قالب
        $html = $smarty->fetch('file:' . dirname(__FILE__) . '/tpl/clock.tpl');

        header('Content-Type: application/json');
        return json_encode(array(
            'status' => 'success',
            'message' => '(no message)',
            'html' => $html
        ));
    }

    // تابع تبدیل تاریخ میلادی به شمسی
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