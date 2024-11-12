@ECHO OFF
setlocal enabledelayedexpansion

set "place=C:\Users\123\windows"
set "path_cert_enc=C:\Users\123\windows\enc"
set "path_out=!path_cert_enc!\enc_out_circulat"
set "log=!place!\enc_circulat.log"
set "list=!place!\enc_circulat.list"
set datetimef=%date:~-4%-%date:~3,2%-%date:~0,2%  %time:~0,2%:%time:~3,2%:%time:~6,2%

echo %datetimef% >> !log!

mkdir !enc_out_circulat! 2> NUL

for %%f in (!path_cert_enc!\*.cer_enc) do (
:: очистка имени файла переменной %%f , подлежащих шифрованию. 
:: где ~n сообщает cmd, что нужно расширить f так, чтобы она равнялась только имени файла, за вычетом расширения
  set "file_name=%%~nf"
  echo "filename is - "!file_name!""
:: вывод имени файлов ключа и сертификата в лог файл
  echo "имя файла, которое будет тиражироваться = !file_name!" >> !log!
  echo "то есть пара !file_name!.cer_enc и !file_name!.key_enc" будет иметь свою пару по списку ниже: >> !log!
  
:: копирование ключа

:: вывод результата копирования в историю скрипта


:: копирование сертификата
  
:: вывод результата копирования в историю скрипта
  
  echo 'конец списка' >> !log!
  echo '------------' >> !log!
  
  
  )