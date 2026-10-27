درود . 

1- به مسیر /var/www/html/modules/dashboard/applets/

در ایزابل رفته دو پوشه IssabelClock و  IssabelStats به طور کامل به پوشه applets منتقل کنید .

2- تمام محتویات موجود در پوشه file رابه پوشه html در ایزابل منتقل کنید :

/var/www/html

3- سپس در محیط کنسول ایزابل دستورات زیر به به ترتیب وارد کنید :
1-

chown -R asterisk:asterisk /var/www/html/modules/dashboard/applets/IssabelStats/

2-

chmod -R 755 /var/www/html/modules/dashboard/applets/IssabelStats/

sqlite3 /var/www/db/dashboard.db "INSERT INTO applet (code, name, icon) VALUES ('Applet_IssabelStats', 'آمار داخلی و ترانک', 'stats.png');"

sqlite3 /var/www/db/dashboard.db "INSERT INTO default_applet_by_user (id_applet, username) SELECT id, 'admin' FROM applet WHERE code='Applet_IssabelStats';"


chown -R asterisk:asterisk /var/www/html/modules/dashboard/applets/IssabelClock/

chmod -R 755 /var/www/html/modules/dashboard/applets/IssabelClock/

sqlite3 /var/www/db/dashboard.db "INSERT INTO applet (code, name, icon) VALUES ('Applet_IssabelClock', 'تاریخ و ساعت', 'clock.png');"

sqlite3 /var/www/db/dashboard.db "INSERT INTO default_applet_by_user (id_applet, username) SELECT id, 'admin' FROM applet WHERE code='Applet_IssabelClock';"


در نهایت برای پاک کردن کش ایزابل این دستور را وارد کنید :

rm -rf /var/www/html/var/templates_c/*

به محیط ایزابل لاگین کرده و در بخش مدیرت میزکار و یا applet-admin دو گزینه آمار داخلی و ترانک و تاریخ و ساعت را تیک زده و در نهایت ذخیره کنید

<img width="487" height="163" alt="image" src="https://github.com/user-attachments/assets/ada68904-6ca7-4808-b1ea-03e31f0c9db0" />

<img width="973" height="315" alt="image" src="https://github.com/user-attachments/assets/674dadd0-9b7b-4e95-8aba-a7f5c9c778c9" />

<img width="1335" height="577" alt="sshot-257" src="https://github.com/user-attachments/assets/0ba3fd33-ddc4-410f-ae15-dda215b27c6b" />

<img width="1301" height="402" alt="sshot-258" src="https://github.com/user-attachments/assets/0c418a39-f4ed-4ced-a77c-09555bf6fcfe" />



