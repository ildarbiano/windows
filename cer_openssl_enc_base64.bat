@ECHO OFF
setlocal enabledelayedexpansion


set "path_cert=C:\Users\123\windows"
set "pass=jDn5opLp1lz"
set "path_enc=!path_cert!\enc"
set "path_restore=!path_cert!\restore"
set "path_log_md5=!path_cert!\openssl_key_cer_md5.log"
set "openssl=C:\ProgramData\OpenSSL-1.1.1h_win32\openssl.exe"
rem set "date=начало"
set datetimef=%date:~-4%-%date:~3,2%-%date:~0,2%  %time:~0,2%:%time:~3,2%:%time:~6,2%
rem date >> !path_log_md5!

echo %datetimef% >> !path_log_md5!
echo "see log work !path_log_md5!"



mkdir !path_enc! 2> NUL
mkdir !path_restore! 2> NUL



rem(a b c) это список (не обязательно из 3-х элементов)
:: переменная %%i (нужно ставить символ после процентов, а не между) по очереди проходит по значениям в списке

:: Для обозначения параметра переменная можно использовать любые знаки, кроме цифр 0–9, чтобы не было конфликта с параметрами пакетных файлов %0–%9. 
:: Для простых пакетных файлов вполне достаточно обозначений с одним знаком, например %%f.
for %%f in (!path_cert!\*.cer) do (
:: очистка имени файла переменной %%f , подлежащих шифрованию. 
:: где ~n сообщает cmd, что нужно расширить f так, чтобы она равнялась только имени файла, за вычетом расширения
  set "file_name=%%~nf"
  echo "name of file which we' encode is - "!file_name!""
:: вывод имени файлов ключа и сертификата в лог файл
  echo "имя файла сертификата\ключа, которые будем шифровать = !file_name!" >> !path_log_md5!

:: шифрование ключа
  set "file_key=!path_cert!\!file_name!.key"
  set "file_key_enc=!path_enc!\!file_name!.key_enc"
  set "file_key_restore=!path_restore!\!file_name!.key_restore"
  !openssl! rsa -noout  -modulus -in !file_key! | !openssl! md5 >> !path_log_md5!

:: шифрование сертификата
  set "file_cer=!path_cert!\!file_name!.cer"
  set "file_cer_enc=!path_enc!\!file_name!.cer_enc"
  set "file_cer_restore=!path_restore!\!file_name!.cer_restore"
  !openssl! x509 -noout -modulus -in !file_cer! | !openssl! md5 >> !path_log_md5!

  echo 'конец' >> !path_log_md5!


  !openssl! enc -aes-256-cbc -base64 -salt -md sha256 -in !file_key! -out !file_key_enc! -pass pass:!pass!
  !openssl! enc -aes-256-cbc -base64 -salt -md sha256 -in !file_cer! -out !file_cer_enc! -pass pass:!pass!
  !openssl! enc -aes-256-cbc -base64 -salt -md sha256 -d -in !file_key_enc! -out !file_key_restore!  -k !pass!
  !openssl! enc -aes-256-cbc -base64 -salt -md sha256 -d -in !file_cer_enc! -out !file_cer_restore!  -k !pass!

  echo '-----------------------' >> !path_log_md5!

  )