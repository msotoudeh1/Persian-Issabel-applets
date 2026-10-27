<?php
class Applet_IssabelClock
{
    function handleJSON_getContent($smarty, $module_name, $appletlist)
    {
        // محاسبه تاریخ شمسی با فرمت جدید
        $smarty->assign('date_jalali', $this->getJalaliDateFormatted());
        
        // رندر قالب
        $html = $smarty->fetch('file:' . dirname(__FILE__) . '/tpl/clock.tpl');

        header('Content-Type: application/json');
        
        // استفاده از JSON_UNESCAPED_UNICODE برای جلوگیری از خطای کاراکترهای فارسی
        $response = json_encode(array(
            'status' => 'success',
            'message' => '(no message)',
            'html' => $html
        ), JSON_UNESCAPED_UNICODE);

        if ($response === false) {
            return json_encode(array('status' => 'error', 'message' => 'JSON Error: ' . json_last_error_msg()));
        }
        
        return $response;
    }

    // تابع تبدیل تاریخ میلادی به شمسی با نام روز و ماه
    private function getJalaliDateFormatted() {
        $gy = date('Y'); $gm = date('m'); $gd = date('d');
        $g_d_m = array(0,31,59,90,120,151,181,212,243,273,304,334);
        if($gy > 1600){ $jy=979; $gy-=1600; }else{ $jy=0; $gy-=621; }
        $gy2 = ($gm > 2) ? ($gy + 1) : $gy;
        $days = (365 * $gy) + ((int)(($gy2 + 3) / 4)) - ((int)(($gy2 + 99) / 100)) + ((int)(($gy2 + 399) / 400)) - 80 + $gd + $g_d_m[$gm - 1];
        $jy += 33 * ((int)($days / 12053)); $days %= 12053;
        $jy += 4 * ((int)($days / 1461)); $days %= 1461;
        if($days > 365){ $jy += (int)(($days - 1) / 365); $days = ($days - 1) % 365; }
        if($days < 186){ $jm = 1 + (int)($days / 31); $jd = 1 + ($days % 31); }else{ $jm = 7 + (int)(($days - 186) / 30); $jd = 1 + (($days - 186) % 30); }

        // تعریف ایمن آرایه ماه‌ها با ایندکس عددی
        $months = array(
            1 => "فروردین", 2 => "اردیبهشت", 3 => "خرداد", 
            4 => "تیر", 5 => "مرداد", 6 => "شهریور", 
            7 => "مهر", 8 => "آبان", 9 => "آذر", 
            10 => "دی", 11 => "بهمن", 12 => "اسفند"
        );
        $month_name = isset($months[$jm]) ? $months[$jm] : '';

        // تعریف ایمن روزهای هفته
        $day_of_week = date('w'); 
        $weekdays = array(
            0 => "یکشنبه", 1 => "دوشنبه", 2 => "سه‌شنبه", 
            3 => "چهارشنبه", 4 => "پنجشنبه", 5 => "جمعه", 6 => "شنبه"
        );
        $weekday_name = isset($weekdays[$day_of_week]) ? $weekdays[$day_of_week] : '';

        return "امروز {$weekday_name} ، {$jd} {$month_name} {$jy}";
    }
}