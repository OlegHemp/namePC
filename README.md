# namePC
Узнаём имя PC из реестра/удалённого реестра. Это удобно, если подключаем внешний диск с другого компьютера и узнаём его сетевое имя компьютера.
Скрипт написан на <b>PowerShell</b>. Необходимо запускать с правами администратора. 
* После запуска, нужно выбрать директорию, где установлена ОС Windows.

  ![alt text](https://github.com/OlegHemp/namePC/blob/main/create.PNG)
  
* Затем, программа покажет директорию с ОС Windows  и сетевое имя компьютера.

  ![alt text](https://github.com/OlegHemp/namePC/blob/main/res.PNG)
  
Если не рассматривать GUI, cуть работы скрипта заложена в проверке соответствует ли выбранная директория (<i>$dlg.SelectedPath</i>) переменной окружения %windir%.
Если, да, то вытаскиваем данные из ветки HKLM работающей ОС.
```powershell
if ($Env:windir -eq $dlg.SelectedPath)
    {
        $a = Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\ComputerName\ComputerName
```
Если нет, то подключаем файл реестра (выбранная_директория\system32\config\system) как куст реестра <i>HKLM\ZZzz</i>. 
Считываем имя компьютера в переменную $a  и отключаем куст реестра.
```powershell
{
        REG LOAD HKLM\ZZzz ($patchOS + '\system32\config\system')
        $a = Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\ZZzz\ControlSet001\Control\ComputerName\ComputerName
        $FormLabel2.Text = "Имя компьютера:  " + $a.ComputerName
        $null = REG UNLOAD HKLM\ZZzz  
    }
```



