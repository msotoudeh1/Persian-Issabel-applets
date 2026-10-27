<img width="1302" height="394" alt="image" src="https://github.com/user-attachments/assets/0901aa5f-af14-4d61-9b15-cf79b83bda49" />



درود . 

نسخه جدید جهت استفاده آپلود شد . تغییر تم به دارک مد و به همراه افزودن قابلیت انتخاب امار بر مبنای روز و ماه و سال

1- به مسیر زیر
```
 /var/www/html/modules/dashboard/applets/
```
 

در ایزابل رفته دو پوشه IssabelClock و  IssabelStats به طور کامل به پوشه applets منتقل کنید .

2- تمام محتویات موجود در پوشه file رابه پوشه html در ایزابل منتقل کنید :
```
/var/www/html
```
3- سپس در محیط کنسول ایزابل دستورات زیر به به ترتیب وارد کنید :

```
chown -R asterisk:asterisk /var/www/html/modules/dashboard/applets/IssabelStats/
```

```
chmod -R 755 /var/www/html/modules/dashboard/applets/IssabelStats/
```

```
sqlite3 /var/www/db/dashboard.db "INSERT INTO applet (code, name, icon) VALUES ('Applet_IssabelStats', 'آمار داخلی و ترانک', 'stats.png');"
```

```
sqlite3 /var/www/db/dashboard.db "INSERT INTO default_applet_by_user (id_applet, username) SELECT id, 'admin' FROM applet WHERE code='Applet_IssabelStats';"
```

```
chown -R asterisk:asterisk /var/www/html/modules/dashboard/applets/IssabelClock/
```

```
chmod -R 755 /var/www/html/modules/dashboard/applets/IssabelClock/
```

```
sqlite3 /var/www/db/dashboard.db "INSERT INTO applet (code, name, icon) VALUES ('Applet_IssabelClock', 'تاریخ و ساعت', 'clock.png');"
```

```
sqlite3 /var/www/db/dashboard.db "INSERT INTO default_applet_by_user (id_applet, username) SELECT id, 'admin' FROM applet WHERE code='Applet_IssabelClock';"
```


در نهایت برای پاک کردن کش ایزابل این دستور را وارد کنید :
```
rm -rf /var/www/html/var/templates_c/*
```

به محیط ایزابل لاگین کرده و در بخش مدیرت میزکار و یا applet-admin دو گزینه آمار داخلی و ترانک و تاریخ و ساعت را تیک زده و در نهایت ذخیره کنید.

نکته :

در حال حاضر 100 رکورد آخر در بخش آخرین تماس‌های ورودی و خروجی نمایش داده می شود . جهت افزایش و یا کاهش این مقدار ، فایل index.php موجود در پوشه IssabelStats را باز کرده و عدد 100 را  به دلخواه تغییر دهید : 

ORDER BY calldate DESC LIMIT 100";

نمایش امار بر مبنای روز و ماه و سال



<img width="487" height="163" alt="image" src="https://github.com/user-attachments/assets/ada68904-6ca7-4808-b1ea-03e31f0c9db0" />


<img width="1360" height="1664" alt="photo" src="https://github.com/user-attachments/assets/a421e59a-bcd3-402b-802c-9b0f629c9827" />




