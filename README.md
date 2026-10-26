درود . 
1- به مسیر /var/www/html/modules/dashboard/applets/

در ایزابل رفته دو پوشه IssabelClock و  IssabelStats به طور کامل به پوشه applets منتقل کنید .

2- تمام محتویات موجود در پوشه file رابه پوشه html در ایزابل منتقل کنید :

/var/www/html

3- سپس در محیط کنسول ایزایب دستورات زیر به به ترتیب وارد کنید :

chown -R asterisk:asterisk /var/www/html/modules/dashboard/applets/IssabelStats/

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

<img width="1592" height="698" alt="image" src="https://github.com/user-attachments/assets/932e13d8-a71e-4034-93f9-3b7c2869ab4d" />


<img width="1198" height="426" alt="Screenshot 2026-10-26 163213" src="https://github.com/user-attachments/assets/ee2732fa-fa86-4c76-a801-61802d75b3d9" />


<img width="1117" height="503" alt="Screenshot 2026-10-26 163238" src="https://github.com/user-attachments/assets/7c73a03c-b3a7-4a81-8764-4358eaa4271e" />


