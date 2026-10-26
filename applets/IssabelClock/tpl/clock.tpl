<link href="Vazirmatn-font-face.css" rel="stylesheet" type="text/css" />
<script src="3.4.17.js"></script>
<div dir="rtl" style="font-family: 'Vazirmatn', Tahoma, sans-serif; padding: 5px;">
    
    <!-- کارت تاریخ شمسی -->
    <div style="background-color: #ffffff !important; border: 1px solid #e2e8f0; border-radius: 12px; padding: 15px; text-align: center; margin-bottom: 10px; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
        <div style="color: #64748b; font-size: 13px; margin-bottom: 5px; font-weight: 600;">📅 تاریخ امروز</div>
        <div style="color: #1e293b; font-size: 20px; font-weight: 800; letter-spacing: 1px;">{$date_jalali}</div>
    </div>

    <!-- کارت ساعت زنده (با استایل خطی برای جلوگیری از تداخل) -->
    <div style="background: linear-gradient(135deg, #1e293b, #0f172a) !important; border-radius: 12px; padding: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
        <div style="color: #94a3b8; font-size: 13px; margin-bottom: 5px; font-weight: 600;">⏰ ساعت سیستم</div>
        <div id="live-clock" style="color: #ffffff !important; font-size: 32px; font-weight: bold; font-family: monospace; letter-spacing: 2px;" dir="ltr">00:00:00</div>
    </div>
</div>

<script>
    // استفاده از setInterval برای به‌روزرسانی مداوم بدون نیاز به لود مجدد
    if (typeof window.issabelClockInterval !== 'undefined') {
        clearInterval(window.issabelClockInterval);
    }

    window.issabelClockInterval = setInterval(function() {
        var clockElement = document.getElementById('live-clock');
        if (clockElement) {
            var now = new Date();
            var h = String(now.getHours()).padStart(2, '0');
            var m = String(now.getMinutes()).padStart(2, '0');
            var s = String(now.getSeconds()).padStart(2, '0');
            clockElement.innerText = h + ':' + m + ':' + s;
        }
    }, 1000);
</script>