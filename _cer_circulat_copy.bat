@ECHO OFF
setlocal enabledelayedexpansion

set "place=C:\Users\123\windows"
set "path_cer_input=C:\Users\123\windows\enc\*.cer_enc"
set "path_key_input=C:\Users\123\windows\enc\*.key_enc"
set "path_out=!path_cert_enc!\enc_out_circulat"
set "log=!place!\enc_circulat.log"
set "list=!place!\enc_circulat.list"
set "cer_name=!place!\1113.cer_enc"
  
set datetimef=%date:~-4%-%date:~3,2%-%date:~0,2%  %time:~0,2%:%time:~3,2%:%time:~6,2%
echo %datetimef% >> !log!

mkdir !enc_out_circulat! 2> NUL


copy /v /-y "!path_cer_input!" "!cer_name!"
type !cer_name! >> !log!

  
  echo 'конец списка' >> !log!
  echo '------------' >> !log!
  
  
  )