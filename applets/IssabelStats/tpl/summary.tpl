
<link href="Vazirmatn-font-face.css" rel="stylesheet" type="text/css" />
<script src="3.4.17.js"></script>
<script>tailwind.config = { theme: { extend: { fontFamily: { vazir: ['Vazirmatn', 'sans-serif'] } } } }</script>

<div dir="rtl" class="font-vazir text-slate-800" style="padding: 15px; width: 100%; box-sizing: border-box;">
    <!-- ارتفاع ثابت 260 پیکسل -->
    <div class="bg-white rounded-2xl shadow-md overflow-hidden border border-gray-100 flex flex-col" style="height: 260px; width: 100%; box-sizing: border-box;">
        
        <!-- بخش بالایی: آمار داخلی و ترانک (پس‌زمینه روشن) -->
        <div class="flex-1 bg-slate-50 flex justify-around items-center p-2 border-b border-gray-200 relative">
            <!-- افکت پس‌زمینه -->
            <div class="absolute -top-6 -left-6 w-16 h-16 bg-blue-100 rounded-full mix-blend-multiply filter blur-xl opacity-70"></div>
            
            <!-- ستون داخلی‌ها -->
            <div class="text-center z-10 w-1/2 border-l border-gray-300">
                <div class="text-gray-500 text-[11px] mb-1 flex items-center justify-center gap-1 font-medium">
                    <svg class="w-3.5 h-3.5 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path></svg>
                    داخلی‌ها
                </div>
                <div class="text-2xl font-extrabold text-slate-700">{$ext_total}</div>
                <div class="flex justify-center gap-2 text-[10px] mt-1 font-medium">
                    <span class="text-emerald-500">✓ {$ext_online}</span>
                    <span class="text-rose-500">✗ {$ext_offline}</span>
                </div>
            </div>

            <!-- ستون ترانک‌ها -->
            <div class="text-center z-10 w-1/2">
                <div class="text-gray-500 text-[11px] mb-1 flex items-center justify-center gap-1 font-medium">
                    <svg class="w-3.5 h-3.5 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 9l3 3-3 3m5 0h3M5 20h14a2 2 0 002-2V6a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                    ترانک‌ها
                </div>
                <div class="text-2xl font-extrabold text-slate-700">{$trunk_total}</div>
                <div class="flex justify-center gap-2 text-[10px] mt-1 font-medium">
                    <span class="text-emerald-500">✓ {$trunk_online}</span>
                    <span class="text-rose-500">✗ {$trunk_offline}</span>
                </div>
            </div>
        </div>

        <!-- بخش پایینی: آمار تماس‌ها و دکمه (پس‌زمینه تیره) -->
        <div class="flex-1 bg-gradient-to-br from-slate-800 to-slate-900 flex flex-col justify-center items-center p-3 relative">
            <div class="text-slate-400 text-[11px] mb-1 flex items-center gap-1.5 font-medium">
                <svg class="w-3.5 h-3.5 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path></svg>
                تماس‌های امروز
            </div>
            
            <div class="flex items-center gap-4 mb-2">
                <div class="text-2xl font-mono font-bold text-white">{$cdr_total_calls}</div>
                <div class="flex flex-col text-[10px] border-r border-slate-600 pr-3">
                    <span class="text-emerald-400">✓ {$cdr_answered} پاسخ</span>
                    <span class="text-rose-400">✗ {$cdr_failed} ناموفق</span>
                </div>
            </div>

            <!-- دکمه مودال -->
            <button onclick="openFullStatsModal()" class="w-full bg-blue-600 hover:bg-blue-500 text-white text-xs font-bold py-1.5 px-4 rounded-lg transition-all border border-blue-400/30 flex items-center justify-center gap-1">
                مشاهده داشبورد جامع
            </button>
        </div>

    </div>
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