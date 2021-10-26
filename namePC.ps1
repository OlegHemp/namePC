Set-ExecutionPolicy Unrestricted
Add-Type -assembly System.Windows.Forms
$window_form = New-Object System.Windows.Forms.Form
$window_form.Text ='Имя компа из реестра'
$window_form.Width = 450
$window_form.Height = 140
$window_form.AutoSize = $true
$FormLabel1 = New-Object System.Windows.Forms.Label
$FormLabel1.Text = "Укажите путь к ОС Windows: "
$FormLabel1.Location = New-Object System.Drawing.Point(10,10)
$FormLabel1.AutoSize = $true
$window_form.Controls.Add($FormLabel1)
$FormLabel2 = New-Object System.Windows.Forms.Label
$FormLabel2.Text = "Имя компьютера:"
$FormLabel2.Location = New-Object System.Drawing.Point(10,30)
$FormLabel2.AutoSize = $true
$window_form.Controls.Add($FormLabel2)
$dlg = new-object Windows.Forms.FolderBrowserDialog
$dlg.Description = "Укажите путь к папке с ОС Windows"
$dlg.ShowNewFolderButton = 'true'
$button = new-object Windows.Forms.Button 
$button.Text = "Указать" 
$button.Location = New-Object System.Drawing.Point(20,60)
$button.add_click({
    $dlg.ShowDialog()
    $patchOS = $dlg.SelectedPath
    $FormLabel1.Text ="Укажите путь к ОС Windows: "
    $FormLabel1.Text = $FormLabel1.Text + $patchOS
    if ($Env:windir -eq $dlg.SelectedPath)
    {
        $a = Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\ComputerName\ComputerName
        $FormLabel2.Text = "Имя компьютера:  " + $a.ComputerName
    }
    else
    {
        REG LOAD HKLM\ZZzz ($patchOS + '\system32\config\system')
        $a = Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\ZZzz\ControlSet001\Control\ComputerName\ComputerName
        $FormLabel2.Text = "Имя компьютера:  " + $a.ComputerName
        $null = REG UNLOAD HKLM\ZZzz  
    }
}) 
$window_form.Controls.Add($button) 
$window_form.Add_Shown({$window_form.Activate()}) 
$window_form.ShowDialog()
#$dlg.Selected


