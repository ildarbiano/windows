@ECHO OFF

setlocal enabledelayedexpansion


# Полный путь до исходных файлов
$base_file_key = "C:\11111\socks.txt.key"
$base_file_crt = "C:\11111\socks.txt.crt"

# Каталог в котором будут находятся итоговые файлы
$Folder_dst = "C:\11111\out"

# Перечисление
$servers = @("server_1","server_2","server_3","server_4","server_5","server_6")

Write-Output "-------------------------------------------------------------------------"
# Цикл , перечисление списка серверов
ForEach ($server in $servers) {
  
  # Формируем значение в переменных с конечными именами файлов 
  $out_file_key = "$Folder_dst\$server.key"
  $out_file_crt = "$Folder_dst\$server.crt"

  # Вывод в текущею консоль
  Write-Output "   $base_file_key   $out_file_key"
  Write-Output "   $base_file_crt   $out_file_crt"

  Copy-Item -Path "$base_file_key" -Destination "$out_file_key"
  Copy-Item -Path "$base_file_crt" -Destination "$out_file_crt"
  }