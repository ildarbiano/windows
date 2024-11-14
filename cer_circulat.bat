@ECHO OFF
setlocal enabledelayedexpansion

set "place=C:\Users\123\windows"
set "path_input_cer=C:\Users\123\windows\enc\*.cer_enc"
set "path_input_key=C:\Users\123\windows\enc\*.key_enc"
set "path_out=!place!\enc_out_circulat"
set "log=!place!\%~n0.log"
set "list=!place!\enc_circulat.list"
set "path_restore=!place!\restore"
set "openssl=C:\ProgramData\OpenSSL-1.1.1h_win32\openssl.exe"
set "pass=jDn5opLp1lz"

mkdir !enc_out_circulat! 2> NUL

:: формирование формата времени для записи в лог истории скрипта
set datetime=%date:~-4%-%date:~3,2%-%date:~0,2%  %time:~0,2%:%time:~3,2%:%time:~6,2%
echo '....................' >> !log!
echo 'Начало тиражирования !datetime!' >> !log!

:: Цикл клонирования с тиражём
for /F %%f in (!list!) do (
:: извлекаем из списка fqdn и выаодим его в лог файл
  set "file_name=%%f"
  echo '.......... для "!fqdn_name!":' >> !log! 
  
:: формируем имя клона
  set "cer_name=!path_out!\!file_name!.cer_enc"
  set "key_name=!path_out!\!file_name!.key_enc"
  
:: копируем key и вывод md5
  copy /v "!path_input_key!" "!key_name!"
  echo "md5 у оригинального .key_enc" >> !log!
  !openssl! rsa -noout  -modulus -in !path_input_key! | !openssl! md5 >> !log! 
  echo "md5 на клоне .key_enc" >> !log!
  !openssl! rsa -noout  -modulus -in !key_name! | !openssl! md5 >> !log!

 

:: копируем cer и вывод md5
  copy /v "!path_input_cer!" "!cer_name!"
  echo "md5 у оригинального .cer_enc" >> !log!
  !openssl! rsa -noout  -modulus -in !path_input_cer! | !openssl! md5 >> !log!
  echo "md5 на клоне .cer_enc" >> !log!
  !openssl! rsa -noout  -modulus -in !cer_name! | !openssl! md5 >> !log!


  echo "----" >> !log!
   

  )

 

echo 'КОНЕЦ списка тиража.' >> !log!
echo '....................' >> !log!
