<link href="Vazirmatn-font-face.css" rel="stylesheet" type="text/css" />
<script src="https://3.4.17.js"></script>
<script>tailwind.config = { theme: { extend: { fontFamily: { vazir: ['Vazirmatn', 'sans-serif'] } } } }</script>

<div dir="rtl" class="font-vazir text-slate-800" style="padding: 15px; width: 100%; box-sizing: border-box;">
    <!-- ارتفاع ثابت 260 پیکسل -->
    <div class="bg-white rounded-2xl shadow-md overflow-hidden border border-gray-100 flex flex-col" style="height: 260px; width: 100%; box-sizing: border-box;">
        
        <!-- بخش بالایی: تاریخ -->
        <div class="flex-1 bg-slate-50 flex flex-col justify-center items-center p-4 border-b border-gray-200 relative overflow-hidden">
            <div class="absolute -top-6 -right-6 w-20 h-20 bg-blue-100 rounded-full mix-blend-multiply filter blur-xl opacity-70"></div>
            
            <div class="text-gray-500 text-sm mb-2 flex items-center gap-1.5 font-medium z-10">
                <svg class="w-4 h-4 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                تاریخ امروز
            </div>
            <div class="text-3xl font-extrabold text-slate-700 tracking-wide z-10">{$date_jalali}</div>
        </div>

        <!-- بخش پایینی: ساعت -->
        <div class="flex-1 bg-gradient-to-br from-slate-800 to-slate-900 flex flex-col justify-center items-center p-4 relative">
            <div class="text-slate-400 text-sm mb-2 flex items-center gap-1.5 font-medium">
                <svg class="w-4 h-4 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                ساعت سیستم
            </div>
            <div id="live-clock" class="text-4xl font-mono font-bold text-emerald-400 tracking-widest drop-shadow-md" dir="ltr">00:00:00</div>
        </div>

    </div>
</div>

<script>
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