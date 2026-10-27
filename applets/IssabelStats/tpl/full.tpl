<!DOCTYPE html>
<html lang="fa" dir="rtl">
<head>
    <meta charset="utf-8">
    <title>داشبورد جامع</title>
    <link href="Vazirmatn-font-face.css" rel="stylesheet" type="text/css" />
    <script src="3.4.17.js"></script>
    <script src="chart.js"></script>
    <script>
      tailwind.config = {
        theme: {
          extend: {
            fontFamily: { vazir: ['Vazirmatn', 'sans-serif'] },
            colors: { darkbg: '#0f172a', cardbg: '#1e293b', cardborder: '#334155' }
          }
        }
      }
    </script>
    <style>
        ::-webkit-scrollbar { width: 8px; height: 8px; }
        ::-webkit-scrollbar-track { background: #0f172a; }
        ::-webkit-scrollbar-thumb { background: #334155; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #475569; }
    </style>
</head>
<body class="font-vazir bg-darkbg min-h-screen p-6 text-slate-200 overflow-y-auto">

    <!-- هدر صفحه -->
    <div class="flex flex-col lg:flex-row justify-between items-center bg-cardbg p-5 rounded-2xl shadow-lg border border-cardborder mb-6 gap-4">
        <div class="flex items-center gap-3 w-full lg:w-auto">
            <div class="bg-blue-500/20 p-2 rounded-xl border border-blue-500/30">
                <svg class="w-6 h-6 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path></svg>
            </div>
            <h1 class="text-xl font-bold text-white">داشبورد جامع سیستم تلفنی</h1>
        </div>
        
        <div class="flex flex-wrap items-center gap-3 w-full lg:w-auto justify-end">
            <div class="flex bg-slate-800 rounded-xl p-1 border border-slate-700 gap-1">
                <button onclick="switchPeriod('day')" id="btn-day" class="px-4 py-1.5 rounded-lg text-sm font-bold transition-all duration-300">امروز</button>
                <button onclick="switchPeriod('month')" id="btn-month" class="px-4 py-1.5 rounded-lg text-sm font-bold transition-all duration-300 text-slate-400 hover:text-white">این ماه</button>
                <button onclick="switchPeriod('year')" id="btn-year" class="px-4 py-1.5 rounded-lg text-sm font-bold transition-all duration-300 text-slate-400 hover:text-white">امسال</button>
            </div>

            <div class="bg-slate-800 text-slate-300 px-4 py-2 rounded-xl text-sm font-medium flex items-center gap-3 border border-slate-700">
                <span class="flex items-center gap-1.5">
                    <svg class="w-4 h-4 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                    {$date_jalali}
                </span>
                <span class="text-slate-600">|</span>
                <span class="flex items-center gap-1.5 text-blue-400" dir="ltr">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    {$time}
                </span>
            </div>
        </div>
    </div>

    <!-- کارت‌های اصلی -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5 mb-6">
        <div class="bg-cardbg p-6 rounded-2xl shadow-lg border border-cardborder relative overflow-hidden group hover:border-blue-500/50 transition-colors">
            <div class="absolute -top-10 -right-10 w-32 h-32 bg-blue-500 rounded-full mix-blend-multiply filter blur-3xl opacity-20 group-hover:opacity-40 transition-opacity"></div>
            <h3 class="text-slate-400 text-sm font-semibold mb-2 relative z-10">📞 داخلی‌ها</h3>
            <div class="text-5xl font-extrabold text-white mb-4 relative z-10">{$ext_total}</div>
            <div class="flex gap-4 text-xs font-medium relative z-10">
                <span class="flex items-center gap-1 text-emerald-400"><span class="w-2 h-2 rounded-full bg-emerald-400"></span> {$ext_online} آنلاین</span>
                <span class="flex items-center gap-1 text-rose-400"><span class="w-2 h-2 rounded-full bg-rose-400"></span> {$ext_offline} آفلاین</span>
            </div>
        </div>

        <div class="bg-cardbg p-6 rounded-2xl shadow-lg border border-cardborder relative overflow-hidden group hover:border-indigo-500/50 transition-colors">
            <div class="absolute -top-10 -right-10 w-32 h-32 bg-indigo-500 rounded-full mix-blend-multiply filter blur-3xl opacity-20 group-hover:opacity-40 transition-opacity"></div>
            <h3 class="text-slate-400 text-sm font-semibold mb-2 relative z-10">🔌 ترانک‌ها</h3>
            <div class="text-5xl font-extrabold text-white mb-4 relative z-10">{$trunk_total}</div>
            <div class="flex gap-4 text-xs font-medium relative z-10">
                <span class="flex items-center gap-1 text-emerald-400"><span class="w-2 h-2 rounded-full bg-emerald-400"></span> {$trunk_online} فعال</span>
                <span class="flex items-center gap-1 text-rose-400"><span class="w-2 h-2 rounded-full bg-rose-400"></span> {$trunk_offline} قطع</span>
            </div>
        </div>

        <div class="bg-cardbg p-6 rounded-2xl shadow-lg border border-cardborder relative overflow-hidden group hover:border-purple-500/50 transition-colors">
            <div class="absolute -top-10 -right-10 w-32 h-32 bg-purple-500 rounded-full mix-blend-multiply filter blur-3xl opacity-20 group-hover:opacity-40 transition-opacity"></div>
            <h3 class="text-slate-400 text-sm font-semibold mb-2 relative z-10">📈 تماس‌های فعال</h3>
            <div class="text-5xl font-extrabold text-white mb-4 relative z-10">{$active_calls}</div>
            <div class="text-xs font-medium text-purple-300 relative z-10">{$active_channels} کانال مشغول</div>
        </div>

        <div class="bg-cardbg p-6 rounded-2xl shadow-lg border border-cardborder relative overflow-hidden group hover:border-emerald-500/50 transition-colors">
            <div class="absolute -top-10 -right-10 w-32 h-32 bg-emerald-500 rounded-full mix-blend-multiply filter blur-3xl opacity-20 group-hover:opacity-40 transition-opacity"></div>
            <h3 class="text-slate-400 text-sm font-semibold mb-2 relative z-10" id="stat-title">📋 تماس‌های امروز</h3>
            <div class="text-5xl font-extrabold text-white mb-4 relative z-10" id="stat-total">{$cdr_total_calls}</div>
            <div class="flex gap-4 text-xs font-medium relative z-10">
                <span class="text-emerald-400">✓ <span id="stat-answered">{$cdr_answered}</span> پاسخ</span>
                <span class="text-rose-400">✗ <span id="stat-failed">{$cdr_failed}</span> ناموفق</span>
            </div>
        </div>
    </div>

    <!-- بخش نمودارها -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-6">
        <div class="bg-cardbg p-6 rounded-2xl shadow-lg border border-cardborder lg:col-span-2">
            <h3 class="text-lg font-bold text-white mb-4 border-b border-slate-700 pb-2">📈 ترافیک تماس‌ها</h3>
            <div class="relative h-64">
                <canvas id="trafficChart"></canvas>
            </div>
        </div>
        <div class="bg-cardbg p-6 rounded-2xl shadow-lg border border-cardborder">
            <h3 class="text-lg font-bold text-white mb-4 border-b border-slate-700 pb-2">🥧 نسبت تماس‌ها</h3>
            <div class="relative h-64 flex justify-center">
                <canvas id="pieChart"></canvas>
            </div>
        </div>
    </div>

    <!-- بخش جدول داخلی‌ها و صف‌ها -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
        <div class="bg-cardbg p-6 rounded-2xl shadow-lg border border-cardborder">
            <h3 class="text-lg font-bold text-white mb-4 border-b border-slate-700 pb-2">🏆 ۵ داخلی پرتماس</h3>
            <div class="overflow-x-auto">
                <table class="w-full text-sm text-right text-slate-300">
                    <thead class="text-xs text-slate-400 uppercase bg-slate-800/50">
                        <tr>
                            <th class="px-4 py-3 rounded-r-lg">داخلی</th>
                            <th class="px-4 py-3">تعداد تماس</th>
                            <th class="px-4 py-3 rounded-l-lg">مدت مکالمه</th>
                        </tr>
                    </thead>
                    <tbody id="top-ext-body"></tbody>
                </table>
            </div>
        </div>

        <div class="bg-cardbg p-6 rounded-2xl shadow-lg border border-cardborder">
            <h3 class="text-lg font-bold text-white mb-4 border-b border-slate-700 pb-2">🎧 وضعیت صف‌ها</h3>
            <ul class="space-y-3">
                <li class="flex justify-between items-center bg-slate-800/50 p-4 rounded-xl border border-slate-700">
                    <span class="text-slate-300 font-medium">کل صف‌ها</span>
                    <span class="font-bold text-blue-400 text-xl">{$queue_total}</span>
                </li>
                <li class="flex justify-between items-center bg-slate-800/50 p-4 rounded-xl border border-slate-700">
                    <span class="text-slate-300 font-medium">اپراتورهای فعال</span>
                    <span class="font-bold text-emerald-400 text-xl">{$queue_members}</span>
                </li>
                <li class="flex justify-between items-center bg-slate-800/50 p-4 rounded-xl border border-slate-700">
                    <span class="text-slate-300 font-medium">تماس‌های در انتظار</span>
                    <span class="font-bold text-rose-400 text-xl">{$queue_waiting}</span>
                </li>
                <li class="flex justify-between items-center bg-gradient-to-l from-blue-900/40 to-slate-800/50 p-4 rounded-xl border border-blue-500/30 mt-4">
                    <span class="text-blue-300 font-medium">میانگین زمان مکالمه</span>
                    <span class="font-bold text-white text-xl" id="stat-avg">{$cdr_avg_duration} <span class="text-xs font-normal text-blue-300">ثانیه</span></span>
                </li>
            </ul>
        </div>
    </div>

    <!-- بخش آخرین تماس‌های ورودی و خروجی -->
    <div class="bg-cardbg p-6 rounded-2xl shadow-lg border border-cardborder">
        <h3 class="text-lg font-bold text-white mb-4 border-b border-slate-700 pb-2 flex items-center gap-2">
            <svg class="w-5 h-5 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"></path></svg>
            آخرین تماس‌های ورودی و خروجی
        </h3>
        <div class="overflow-x-auto">
            <table class="w-full text-sm text-right text-slate-300">
                <thead class="text-xs text-slate-400 uppercase bg-slate-800/50">
                    <tr>
                        <th class="px-4 py-3 rounded-r-lg">زمان</th>
                        <th class="px-4 py-3">جهت</th>
                        <th class="px-4 py-3">از (مبدا)</th>
                        <th class="px-4 py-3">به (مقصد)</th>
                        <th class="px-4 py-3">مدت</th>
                        <th class="px-4 py-3 rounded-l-lg">وضعیت</th>
                    </tr>
                </thead>
                <tbody id="recent-calls-body">
                    <!-- توسط جاوااسکریپت پر می‌شود -->
                </tbody>
            </table>
        </div>
        
        <!-- بخش دکمه‌های صفحه‌بندی -->
        <div id="pagination-container" class="flex justify-center items-center gap-2 mt-6"></div>
    </div>

    <!-- المان مخفی برای نگهداری JSON -->
    <div id="json-data" style="display:none;">{$period_data_json}</div>

    {literal}
    <script>
    var allData = {};
    var trafficChart, pieChart;
    
    // متغیرهای صفحه‌بندی
    var recentCallsData = [];
    var currentPage = 1;
    var rowsPerPage = 10; // تعداد ردیف در هر صفحه

    document.addEventListener("DOMContentLoaded", function() {
        var jsonText = document.getElementById('json-data').innerText;
        try {
            allData = JSON.parse(jsonText);
        } catch (e) {
            console.error("JSON Parse Error:", e);
            return;
        }

        Chart.defaults.color = '#94a3b8'; 
        Chart.defaults.borderColor = '#334155';

        var ctxTraffic = document.getElementById('trafficChart').getContext('2d');
        trafficChart = new Chart(ctxTraffic, {
            type: 'bar',
            data: { labels: [], datasets: [
                { label: 'ورودی (Inbound)', data: [], backgroundColor: '#3b82f6', borderRadius: 4 },
                { label: 'خروجی (Outbound)', data: [], backgroundColor: '#10b981', borderRadius: 4 }
            ]},
            options: {
                responsive: true, maintainAspectRatio: false,
                scales: {
                    y: { beginAtZero: true, ticks: { stepSize: 1, precision: 0 }, grid: { color: '#1e293b' } },
                    x: { grid: { display: false } }
                },
                plugins: { legend: { position: 'top', labels: { font: { family: 'Vazirmatn' } } } }
            }
        });

        var ctxPie = document.getElementById('pieChart').getContext('2d');
        pieChart = new Chart(ctxPie, {
            type: 'doughnut',
            data: {
                labels: ['پاسخ داده شده', 'ناموفق'],
                datasets: [{ data: [0, 0], backgroundColor: ['#10b981', '#ef4444'], borderWidth: 0, hoverOffset: 4 }]
            },
            options: {
                responsive: true, maintainAspectRatio: false,
                plugins: { legend: { position: 'bottom', labels: { font: { family: 'Vazirmatn' } } } },
                cutout: '70%'
            }
        });

        switchPeriod('day');
    });

    function switchPeriod(period) {
        if (!allData || !allData[period]) return;

        ['day', 'month', 'year'].forEach(p => {
            var btn = document.getElementById('btn-' + p);
            if (p === period) {
                btn.className = 'px-4 py-1.5 rounded-lg text-sm font-bold bg-blue-600 text-white shadow-lg transition-all duration-300';
            } else {
                btn.className = 'px-4 py-1.5 rounded-lg text-sm font-bold text-slate-400 hover:text-white transition-all duration-300';
            }
        });

        var titles = {'day': '📋 تماس‌های امروز', 'month': '📋 تماس‌های این ماه', 'year': '📋 تماس‌های امسال'};
        document.getElementById('stat-title').innerText = titles[period];

        var data = allData[period];

        // آپدیت کارت‌ها
        document.getElementById('stat-total').innerText = data.stats.total;
        document.getElementById('stat-answered').innerText = data.stats.answered;
        document.getElementById('stat-failed').innerText = data.stats.failed;
        document.getElementById('stat-avg').innerHTML = data.stats.avg_duration + ' <span class="text-xs font-normal text-blue-300">ثانیه</span>';

        // آپدیت نمودار ترافیک
        var labels = [];
        var inboundData = [];
        var outboundData = [];

        if (period === 'day') {
            for (var i = 0; i < 24; i++) labels.push(i.toString().padStart(2, '0') + ":00");
        } else if (period === 'month') {
            for (var i = 1; i <= 31; i++) labels.push(i.toString());
        } else {
            for (var i = 1; i <= 12; i++) labels.push('ماه ' + i);
        }

        data.traffic.forEach(function(item) {
            inboundData.push(item.inbound);
            outboundData.push(item.outbound);
        });

        trafficChart.data.labels = labels;
        trafficChart.data.datasets[0].data = inboundData;
        trafficChart.data.datasets[1].data = outboundData;
        trafficChart.update();

        pieChart.data.datasets[0].data = [data.stats.answered, data.stats.failed];
        pieChart.update();

        // آپدیت جدول داخلی‌ها
        var tbody = document.getElementById('top-ext-body');
        tbody.innerHTML = '';
        if (data.top && data.top.length > 0) {
            data.top.forEach(function(row) {
                var mins = Math.floor(row.talk_time / 60);
                var secs = row.talk_time % 60;
                tbody.innerHTML += `
                    <tr class="border-b border-slate-700/50 hover:bg-slate-800/50 transition-colors">
                        <td class="px-4 py-3 font-bold text-blue-400">${row.ext}</td>
                        <td class="px-4 py-3 text-emerald-400 font-medium">${row.call_count} تماس</td>
                        <td class="px-4 py-3 text-slate-400" dir="ltr">${mins}:${secs}</td>
                    </tr>
                `;
            });
        } else {
            tbody.innerHTML = '<tr><td colspan="3" class="text-center py-4 text-slate-500 text-sm">داده‌ای یافت نشد.</td></tr>';
        }

        // *** بخش جدید: مقداردهی اولیه برای جدول تماس‌های اخیر ***
        recentCallsData = data.recent || [];
        renderRecentCalls(1); // همیشه از صفحه اول شروع می‌شود
    }

    // تابع رسم جدول تماس‌های اخیر با صفحه‌بندی
    function renderRecentCalls(page) {
        currentPage = page;
        var start = (page - 1) * rowsPerPage;
        var end = start + rowsPerPage;
        var paginatedData = recentCallsData.slice(start, end);

        var recentBody = document.getElementById('recent-calls-body');
        recentBody.innerHTML = '';

        if (paginatedData.length > 0) {
            paginatedData.forEach(function(row) {
                var d = new Date(row.calldate.replace(' ', 'T'));
                var timeStr = d.toLocaleTimeString('fa-IR');
                var dateStr = d.toLocaleDateString('fa-IR');
                
                // اگر بازه امروز است فقط ساعت، در غیر این صورت تاریخ و ساعت
                var isDay = document.getElementById('btn-day').classList.contains('bg-blue-600');
                var displayTime = isDay ? timeStr : dateStr + ' - ' + timeStr;
                
                var isIn = row.direction === 'inbound';
                var dirBadge = isIn 
                    ? '<span class="px-2 py-1 rounded-lg bg-emerald-500/20 text-emerald-400 text-xs border border-emerald-500/30">ورودی</span>'
                    : '<span class="px-2 py-1 rounded-lg bg-blue-500/20 text-blue-400 text-xs border border-blue-500/30">خروجی</span>';
                
                var statusColor = row.disposition === 'ANSWERED' ? 'text-emerald-400' : 'text-rose-400';
                
                var mins = Math.floor(row.billsec / 60);
                var secs = row.billsec % 60;
                var duration = (mins > 0 ? mins + ':' : '') + secs.toString().padStart(2, '0');

                recentBody.innerHTML += `
                    <tr class="border-b border-slate-700/50 hover:bg-slate-800/50 transition-colors">
                        <td class="px-4 py-3 text-slate-300 text-xs" dir="ltr">${displayTime}</td>
                        <td class="px-4 py-3">${dirBadge}</td>
                        <td class="px-4 py-3 text-slate-200" dir="ltr">${row.src}</td>
                        <td class="px-4 py-3 text-slate-200" dir="ltr">${row.dst}</td>
                        <td class="px-4 py-3 text-slate-400" dir="ltr">${duration}</td>
                        <td class="px-4 py-3 ${statusColor} font-medium text-xs">${row.disposition}</td>
                    </tr>
                `;
            });
        } else {
            recentBody.innerHTML = '<tr><td colspan="6" class="text-center py-4 text-slate-500 text-sm">تماسی در این دوره ثبت نشده است.</td></tr>';
        }

        renderPagination();
    }

    // تابع رسم دکمه‌های صفحه‌بندی
    function renderPagination() {
        var totalPages = Math.ceil(recentCallsData.length / rowsPerPage);
        var pagContainer = document.getElementById('pagination-container');
        pagContainer.innerHTML = '';

        if (totalPages <= 1) return; // اگر فقط یک صفحه بود، نیازی به دکمه نیست

        // دکمه قبلی
        var prevBtn = document.createElement('button');
        prevBtn.className = `px-3 py-1.5 rounded-lg border border-slate-600 text-sm ${currentPage === 1 ? 'opacity-50 cursor-not-allowed text-slate-500' : 'text-slate-200 hover:bg-slate-700 transition-colors'}`;
        prevBtn.innerText = 'قبلی';
        prevBtn.onclick = () => { if(currentPage > 1) renderRecentCalls(currentPage - 1); };
        pagContainer.appendChild(prevBtn);

        // شماره صفحات
        for (let i = 1; i <= totalPages; i++) {
            // نمایش صفحات اطراف صفحه فعلی و صفحات اول و آخر
            if (i === 1 || i === totalPages || (i >= currentPage - 1 && i <= currentPage + 1)) {
                var pageBtn = document.createElement('button');
                pageBtn.className = `px-3 py-1.5 rounded-lg border border-slate-600 text-sm ${currentPage === i ? 'bg-blue-600 text-white border-blue-500 shadow-md' : 'text-slate-200 hover:bg-slate-700 transition-colors'}`;
                pageBtn.innerText = i;
                pageBtn.onclick = () => renderRecentCalls(i);
                pagContainer.appendChild(pageBtn);
            } else if (i === currentPage - 2 || i === currentPage + 2) {
                // سه نقطه برای صفحات مخفی
                var dots = document.createElement('span');
                dots.innerText = '...';
                dots.className = 'px-2 text-slate-500';
                pagContainer.appendChild(dots);
            }
        }

        // دکمه بعدی
        var nextBtn = document.createElement('button');
        nextBtn.className = `px-3 py-1.5 rounded-lg border border-slate-600 text-sm ${currentPage === totalPages ? 'opacity-50 cursor-not-allowed text-slate-500' : 'text-slate-200 hover:bg-slate-700 transition-colors'}`;
        nextBtn.innerText = 'بعدی';
        nextBtn.onclick = () => { if(currentPage < totalPages) renderRecentCalls(currentPage + 1); };
        pagContainer.appendChild(nextBtn);
    }
    </script>
    {/literal}
</body>
</html>