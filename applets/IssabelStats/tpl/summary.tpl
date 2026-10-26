
<link href="Vazirmatn-font-face.css" rel="stylesheet" type="text/css" />
<script src="3.4.17.js"></script>

<script>
  tailwind.config = { theme: { extend: { fontFamily: { vazir: ['Vazirmatn', 'sans-serif'] } } } }
</script>

<div dir="rtl" class="font-vazir p-1">
    {if !$asterisk_ok}
    <div class="bg-red-100 text-red-700 p-2 rounded-lg mb-3 text-xs text-center">
        ⚠️ Unable to connect to Asterisk.
    </div>
    {/if}

    <div class="grid grid-cols-2 gap-3 mb-4">
        <div class="bg-white border border-gray-200 rounded-xl p-4 shadow-sm text-center">
            <h4 class="text-gray-500 text-sm mb-1">📞 داخلی‌ها</h4>
            <div class="text-2xl font-bold text-gray-800">{$ext_total}</div>
            <div class="text-emerald-500 text-xs mt-1">✓ {$ext_online} آنلاین</div>
            <div class="text-rose-500 text-xs">✗ {$ext_offline} آفلاین</div>
        </div>
        <div class="bg-white border border-gray-200 rounded-xl p-4 shadow-sm text-center">
            <h4 class="text-gray-500 text-sm mb-1">📊 تماس‌ها</h4>
            <div class="text-2xl font-bold text-gray-800">{$cdr_total_calls}</div>
            <div class="text-emerald-500 text-xs mt-1">✓ {$cdr_answered} پاسخ</div>
        </div>
    </div>

    <!-- دکمه باز کردن مودال با اصلاح عرض و استایل مدرن -->
    <div class="w-full flex justify-center px-1">
        <button onclick="openFullStatsModal()" class="w-[95%] bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white font-bold py-2.5 px-4 rounded-xl transition-all duration-300 shadow-md hover:shadow-lg border border-blue-600 text-sm flex items-center justify-center gap-2">
            <span>🔍</span>
            مشاهده داشبورد جامع
        </button>
    </div>

    <div class="text-[10px] text-gray-400 text-left mt-3">آخرین به‌روزرسانی: {$time}</div>
</div>

<script>
function openFullStatsModal() {
    var iframeSrc = '?menu=dashboard&rawmode=yes&applet=IssabelStats&action=getFull';
    var modalContent = '<iframe src="' + iframeSrc + '" frameborder="0" style="width:100%; height:100%; display:block; border:none; overflow:hidden;"></iframe>';
    
    var w = Math.floor(window.innerWidth * 0.95);
    var h = Math.floor(window.innerHeight * 0.90);

    ShowModalPopUP('آمار جامع سیستم تلفنی', w, h, modalContent);

    setTimeout(function() {
        $('.neo-modal-issabel-popup-content').css({
            'width': w + 'px', 'height': h + 'px', 'max-width': 'none', 'max-height': 'none', 'top': '5vh', 'left': '2.5vw'
        });
    }, 100);
}
</script>