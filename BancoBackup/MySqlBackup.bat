echo on

echo Iniciando Backup
echo Lembrando que a maneira de salvar a informação sem a criação de um novo banco é --no-create-db depois do comando --routines

for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set dt=%%a
set year=%dt:~0,4%
set month=%dt:~4,2%
set day=%dt:~6,2%

set dt=%day%-%month%-%year%

For /f "tokens=1-4 delims=:." %%a in ('echo %time%') do (set tm=%%a%%b)

set bkupfilename=%dt%-%tm%

echo Backing up to file: %bkupfilename%

"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe"  --routines -u Adaptus -p  adaptus > D:\Projetos\.Net\ASP\Adaptus\BancoBackup\"Adaptus-%bkupfilename%".sql

set zip="C:\Program Files\7-Zip\7z.exe"
%zip% a -tgzip D:\Projetos\.Net\ASP\Adaptus\BancoBackup\"Adaptus-%bkupfilename%".gz D:\Projetos\.Net\ASP\Adaptus\BancoBackup\"Adaptus-%bkupfilename%".sql
del D:\Projetos\.Net\ASP\Adaptus\BancoBackup\"Adaptus-%bkupfilename%".sql

echo on


echo Backup Completo!