<style>
    .is-grid { display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 10px; font-family: Tahoma, sans-serif; }
    .is-card { flex: 1 1 120px; background: #fff; border: 1px solid #e3e6ea; border-radius: 8px; padding: 12px; box-shadow: 0 1px 2px rgba(0,0,0,.05); text-align: center; }
    .is-card h4 { margin: 0 0 5px 0; color: #555; font-size: 12px; }
    .is-big { font-size: 24px; font-weight: bold; color: #2c3e50; }
    .is-green { color: #27ae60; font-size: 11px; }
    .is-red { color: #c0392b; font-size: 11px; }
    .is-blue { color: #2980b9; font-size: 11px; }
    .is-trunk-list { list-style: none; padding: 0; margin: 0; text-align: right; font-size: 11px; }
    .is-trunk-list li { padding: 4px 0; border-bottom: 1px solid #eee; }
    .is-queue-item { background: #f9f9f9; border: 1px solid #eee; border-radius: 6px; padding: 8px; margin-bottom: 6px; font-size: 11px; }
    .is-queue-item h5 { margin: 0 0 4px 0; color: #333; font-size: 12px; }
</style>

<div>
    {if !$asterisk_ok}
    <div style="background:#f8d7da; color:#721c24; padding:8px; border-radius:4px; margin-bottom:8px; font-size:11px;">
        ⚠️ Unable to connect to Asterisk.
    </div>
    {/if}

    <!-- ردیف اول: کارت‌های خلاصه -->
    <div class="is-grid">
        <div class="is-card">
            <h4>📞 داخلی‌ها</h4>
            <div class="is-big">{$ext_total}</div>
            <div class="is-green">✓ {$ext_online} آنلاین</div>
            <div class="is-red">✗ {$ext_offline} آفلاین</div>
        </div>
        <div class="is-card">
            <h4>🔌 ترانک‌ها</h4>
            <div class="is-big">{$trunk_total}</div>
            <div class="is-green">✓ {$trunk_online} فعال</div>
            <div class="is-red">✗ {$trunk_offline} قطع</div>
        </div>
        <div class="is-card">
            <h4>📊 تماس‌های فعال</h4>
            <div class="is-big">{$active_calls}</div>
            <div class="is-blue">{$active_channels} کانال</div>
        </div>
        <div class="is-card">
            <h4>📈 آمار امروز</h4>
            <div class="is-big">{$cdr_total_calls}</div>
            <div class="is-green">✓ {$cdr_answered} پاسخ داده شده</div>
            <div class="is-red">✗ {$cdr_failed} ناموفق</div>
        </div>
    </div>

    <!-- ردیف دوم: صف‌ها و ترانک‌ها -->
    <div class="is-grid">
        <!-- صف‌ها -->
        <div class="is-card" style="flex: 2 1 300px;">
            <h4>🎧 صف‌های تماس</h4>
            <div style="margin-top: 6px;">
                <div class="is-queue-item">
                    <h5>تعداد صف‌ها: <strong>{$queue_total}</strong></h5>
                    <div>اپراتورهای فعال: <strong class="is-green">{$queue_members}</strong></div>
                    <div>تماس‌های در انتظار: <strong class="is-red">{$queue_waiting}</strong></div>
                </div>
            </div>
        </div>

        <!-- ترانک‌ها -->
        <div class="is-card" style="flex: 2 1 300px;">
            <h4>وضعیت ترانک‌ها</h4>
            {if $trunks|@count > 0}
            <ul class="is-trunk-list">
                {foreach $trunks as $t}
                <li>
                    <strong>{$t.name}</strong>
                    <span style="color:{if $t.status == 'OK'}#27ae60{else}#c0392b{/if}; float:left;">{$t.status}</span>
                </li>
                {/foreach}
            </ul>
            {else}
            <p style="font-size:11px; color:#999;">ترانکی تعریف نشده است.</p>
            {/if}
        </div>
    </div>

    <!-- ردیف سوم: آمار CDR -->
    {if $cdr_total_calls > 0}
    <div class="is-grid">
        <div class="is-card" style="flex: 1 1 100%;">
            <h4>📋 خلاصه تماس‌های امروز</h4>
            <div style="display: flex; justify-content: space-around; margin-top: 8px;">
                <div><span class="is-big">{$cdr_answered}</span><br><span class="is-green">پاسخ داده شده</span></div>
                <div><span class="is-big">{$cdr_failed}</span><br><span class="is-red">ناموفق</span></div>
                <div><span class="is-big">{$cdr_avg_duration}s</span><br><span class="is-blue">میانگین مدت</span></div>
            </div>
        </div>
    </div>
    {/if}

    <div style="font-size:10px; color:#999; text-align:left; margin-top:5px;">آخرین به‌روزرسانی: {$time}</div>
</div>