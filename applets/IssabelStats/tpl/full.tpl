<!DOCTYPE html>
<html lang="fa" dir="rtl">
<head>
    <meta charset="utf-8">
    <title>داشبورد جامع</title>
    <!-- لود فونت وزیرمتن -->
    <link href="Vazirmatn-font-face.css" rel="stylesheet" type="text/css" />
    <!-- لود Tailwind CSS -->
    <script src="3.4.17.js"></script>
	<script src="chart.js"></script>
    <!-- تنظیم فونت پیش‌فرض در Tailwind -->
    <script>
      tailwind.config = {
        theme: {
          extend: {
            fontFamily: { vazir: ['Vazirmatn', 'sans-serif'] },
            colors: { issabel: '#2c3e50' }
          }
        }
      }
    </script>
</head>
<body class="font-vazir bg-slate-50 min-h-screen p-6 text-slate-800">

    <!-- هدر صفحه -->
    <div class="flex flex-wrap justify-between items-center bg-white p-4 rounded-2xl shadow-sm border border-slate-200 mb-6">
        <h1 class="text-xl font-bold text-slate-700 flex items-center gap-2">
            <span class="text-2xl">📊</span> داشبورد جامع سیستم
        </h1>
        <div class="bg-slate-100 text-slate-600 px-4 py-1.5 rounded-full text-sm font-medium mt-2 sm:mt-0 flex items-center gap-2">
            <span>📅 امروز: {$date_jalali}</span>
            <span class="text-slate-300">|</span>
            <span>⏰ ساعت: {$time}</span>
        </div>
    </div>

    <!-- کارت‌های اصلی (ریسپانسیو) -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
        <!-- کارت داخلی‌ها -->
        <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200 text-center hover:shadow-md transition-shadow">
            <h3 class="text-slate-500 text-sm font-semibold mb-2">📞 داخلی‌ها</h3>
            <div class="text-4xl font-extrabold text-slate-800 mb-2">{$ext_total}</div>
            <div class="flex justify-center gap-3 text-sm">
                <span class="text-emerald-500 font-medium">✓ {$ext_online} آنلاین</span>
                <span class="text-rose-500 font-medium">✗ {$ext_offline} آفلاین</span>
            </div>
        </div>

        <!-- کارت ترانک‌ها -->
        <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200 text-center hover:shadow-md transition-shadow">
            <h3 class="text-slate-500 text-sm font-semibold mb-2">🔌 ترانک‌ها</h3>
            <div class="text-4xl font-extrabold text-slate-800 mb-2">{$trunk_total}</div>
            <div class="flex justify-center gap-3 text-sm">
                <span class="text-emerald-500 font-medium">✓ {$trunk_online} فعال</span>
                <span class="text-rose-500 font-medium">✗ {$trunk_offline} قطع</span>
            </div>
        </div>

        <!-- کارت تماس‌های فعال -->
        <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200 text-center hover:shadow-md transition-shadow">
            <h3 class="text-slate-500 text-sm font-semibold mb-2">📈 تماس‌های فعال</h3>
            <div class="text-4xl font-extrabold text-slate-800 mb-2">{$active_calls}</div>
            <div class="text-blue-500 text-sm font-medium">{$active_channels} کانال مشغول</div>
        </div>

        <!-- کارت آمار امروز -->
        <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200 text-center hover:shadow-md transition-shadow">
            <h3 class="text-slate-500 text-sm font-semibold mb-2">📋 تماس‌های امروز</h3>
            <div class="text-4xl font-extrabold text-slate-800 mb-2">{$cdr_total_calls}</div>
            <div class="flex justify-center gap-3 text-sm">
                <span class="text-emerald-500 font-medium">✓ {$cdr_answered} پاسخ</span>
                <span class="text-rose-500 font-medium">✗ {$cdr_failed} ناموفق</span>
            </div>
        </div>
    </div>

    <!-- بخش پایینی: ترانک‌ها و صف‌ها -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <!-- باکس ترانک‌ها -->
        <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200">
            <h3 class="text-lg font-bold text-slate-700 mb-4 border-b border-slate-100 pb-2">🔌 وضعیت ترانک‌ها</h3>
            {if $trunks|@count > 0}
                <ul class="space-y-3">
                    {foreach $trunks as $t}
                    <li class="flex justify-between items-center bg-slate-50 p-3 rounded-xl border border-slate-100">
                        <div class="flex flex-col">
                            <span class="font-bold text-slate-700">{$t.name}</span>
                            <span class="text-xs text-slate-400" dir="ltr">{$t.host}</span>
                        </div>
                        <span class="px-3 py-1 rounded-full text-xs font-bold {if $t.status == 'OK'}bg-emerald-100 text-emerald-700{else}bg-rose-100 text-rose-700{/if}">
                            {$t.status}
                        </span>
                    </li>
                    {/foreach}
                </ul>
            {else}
                <div class="text-center py-8 text-slate-400 text-sm">ترانکی یافت نشد.</div>
            {/if}
        </div>

        <!-- باکس صف‌ها -->
        <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200">
            <h3 class="text-lg font-bold text-slate-700 mb-4 border-b border-slate-100 pb-2">🎧 وضعیت صف‌ها</h3>
            <ul class="space-y-3">
                <li class="flex justify-between items-center p-3 border-b border-slate-100">
                    <span class="text-slate-600">کل صف‌ها</span>
                    <span class="font-bold text-slate-800 text-lg">{$queue_total}</span>
                </li>
                <li class="flex justify-between items-center p-3 border-b border-slate-100">
                    <span class="text-slate-600">اپراتورهای فعال</span>
                    <span class="font-bold text-emerald-500 text-lg">{$queue_members}</span>
                </li>
                <li class="flex justify-between items-center p-3 border-b border-slate-100">
                    <span class="text-slate-600">تماس‌های در انتظار</span>
                    <span class="font-bold text-rose-500 text-lg">{$queue_waiting}</span>
                </li>
                <li class="flex justify-between items-center p-3 bg-blue-50 rounded-xl mt-4">
                    <span class="text-blue-700 font-medium">میانگین زمان مکالمه امروز</span>
                    <span class="font-bold text-blue-700 text-lg">{$cdr_avg_duration} <span class="text-xs">ثانیه</span></span>
                </li>
            </ul>
        </div>
    </div>

    <!-- بخش جدید: نمودارها و آمار پیشرفته -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mt-6">
        <!-- نمودار ترافیک تماس -->
        <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200 lg:col-span-2">
            <h3 class="text-lg font-bold text-slate-700 mb-4 border-b border-slate-100 pb-2">📈 ترافیک تماس‌های امروز (ساعتی)</h3>
            <div class="relative h-64">
                <canvas id="trafficChart"></canvas>
            </div>
        </div>

        <!-- نمودار دایره‌ای موفق/ناموفق -->
        <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200">
            <h3 class="text-lg font-bold text-slate-700 mb-4 border-b border-slate-100 pb-2">🥧 نسبت تماس‌ها</h3>
            <div class="relative h-64 flex justify-center">
                <canvas id="pieChart"></canvas>
            </div>
        </div>
    </div>

    <!-- پرتماس‌ترین داخلی‌ها -->
    <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200 mt-6">
        <h3 class="text-lg font-bold text-slate-700 mb-4 border-b border-slate-100 pb-2">🏆 ۵ داخلی پرتماس امروز</h3>
        {if $top_extensions|@count > 0}
            <div class="overflow-x-auto">
                <table class="w-full text-sm text-right text-slate-600">
                    <thead class="text-xs text-slate-400 uppercase bg-slate-50">
                        <tr>
                            <th class="px-4 py-3 rounded-r-lg">داخلی</th>
                            <th class="px-4 py-3">تعداد تماس</th>
                            <th class="px-4 py-3 rounded-l-lg">مدت مکالمه (کل)</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $top_extensions as $ext}
                        <tr class="border-b border-slate-100 hover:bg-slate-50">
                            <td class="px-4 py-3 font-bold text-slate-800">{$ext.ext}</td>
                            <td class="px-4 py-3 text-blue-500 font-medium">{$ext.call_count} تماس</td>
                            <td class="px-4 py-3" dir="ltr">{math equation="floor(x/60)" x=$ext.talk_time} دقیقه و {math equation="x%60" x=$ext.talk_time} ثانیه</td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        {else}
            <div class="text-center py-4 text-slate-400 text-sm">امروز هنوز تماسی از داخلی‌ها ثبت نشده است.</div>
        {/if}
    </div>

    <!-- اسکریپت‌های رسم نمودار -->
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        // داده‌های ترافیک از PHP
        var trafficData = {$traffic_data};
        var labels = [];
        var inboundData = [];
        var outboundData = [];

        // ساخت لیبل ساعت‌ها و جدا کردن داده‌های ورودی/خروجی
        for (var i = 0; i < 24; i++) {
            labels.push(i.toString().padStart(2, '0') + ":00");
            inboundData.push(trafficData[i].inbound);
            outboundData.push(trafficData[i].outbound);
        }

        // رسم نمودار ترافیک (ستونی)
        var ctxTraffic = document.getElementById('trafficChart').getContext('2d');
        new Chart(ctxTraffic, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [
                    { label: 'ورودی (Inbound)', data: inboundData, backgroundColor: '#3b82f6', borderRadius: 4 },
                    { label: 'خروجی (Outbound)', data: outboundData, backgroundColor: '#10b981', borderRadius: 4 }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: { beginAtZero: true, ticks: { stepSize: 1, precision: 0 } },
                    x: { grid: { display: false } }
                },
                plugins: { legend: { position: 'top', labels: { font: { family: 'Vazirmatn' } } } }
            }
        });

        // رسم نمودار دایره‌ای (موفق/ناموفق)
        var ctxPie = document.getElementById('pieChart').getContext('2d');
        new Chart(ctxPie, {
            type: 'doughnut',
            data: {
                labels: ['پاسخ داده شده', 'ناموفق'],
                datasets: [{
                    data: [{$cdr_answered}, {$cdr_failed}],
                    backgroundColor: ['#10b981', '#ef4444'],
                    borderWidth: 0,
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { position: 'bottom', labels: { font: { family: 'Vazirmatn' } } } },
                cutout: '65%'
            }
        });
    });
    </script>
</body>
</html>