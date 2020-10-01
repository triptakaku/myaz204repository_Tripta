#Login to azure
Login-AzAccount

New-AzResourceGroup -Name AZ-204-RES -Location 'East US'

New-AzResourceGroup -Name AZ-204-IAAS-GRP -Location 'East US'

New-AzVM -ResourceGroupName AZ-204-IAAS-GRP -Location 'East US' -Name My-VM-01 `
-VirtualNetworkName my-vnet-01 `
-SubnetName webapp-subnet `
-PublicIpAddressName my-pip-01 `
-SecurityGroupName my-nsg-01 `
-OpenPorts 80,3389

#Install IIS
Set-AzVMExtension -ResourceGroupName "AZ-204-IAAS-GRP" `
-ExtensionName "IIS" `
-VMName "My-VM-01" `
-Location "EastUS" `
-Publisher Microsoft.Compute `
-ExtensionType CustomScriptExtension `
-TypeHandlerVersion 1.8 `
-SettingString '{"commandToExecute":"powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $($env:computername)"}'

Get-AzPublicIpAddress -ResourceGroupName AZ-204-IAAS-GRP | Select "IpAddress" | Format-Table

New-Az