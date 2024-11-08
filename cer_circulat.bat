@ECHO OFF
setlocal enabledelayedexpansion

set "path_input_cer=C:\Users\123\windows\enc\*.cer_enc"
set "path_input_key=C:\Users\123\windows\enc\*.key_enc"
set "path_out=!path_cert_enc!\enc_out_circulat"
set "log=!place!\enc_circulat.log"
set "list=!place!\enc_circulat.list"

mkdir !enc_out_circulat! 2> NUL

:: формирование формата времени для записи в лог истории скрипта
set datetimef=%date:~-4%-%date:~3,2%-%date:~0,2%  %time:~0,2%:%time:~3,2%:%time:~6,2%
echo %datetimef% >> !log!

for %%f in (!list!) do (
  set "file_name=%%f"
  type %%f >> !log!
  )
  
  set "cer_name=!path_out!\!file_name!.cer_enc"
  set "key_name=!path_out!\!file_name!.key_enc"
  copy /v "!path_input_cer!" "!cer_name!"
  copy /v "!path_input_key!" "!key_name!"
  
  
  echo 'конец списка' >> !log!
  echo '------------' >> !log!
  
  
  )
  
  
:: if ююю (echo !file_name! >> !log!)  else (echo "-" >> !log!) 