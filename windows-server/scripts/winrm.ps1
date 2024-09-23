Enable-PSRemoting -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LocalAccountTokenFilterPolicy" -Value 1 -Type DWord

#winrm quickconfig -force
#Set-Item wsman:\localhost\client\trustedhosts "*"
#Restart-Service WinRM

# Configure WinRM to allow Basic Authentication
#winrm set winrm/config/service/auth '@{Basic="true"}'
#
## Configure WinRM to allow unencrypted communication
#winrm set winrm/config/service '@{AllowUnencrypted="true"}'
##
#winrm get winrm/config
## Add a firewall rule to allow incoming WinRM traffic on ports 5985 (HTTP) and 5986 (HTTPS)
#netsh advfirewall firewall add rule name="WinRM" dir=in action=allow protocol=TCP localport=5985,5986
#
#Enable-NetFirewallRule -Name "Windows Remote Management (HTTP-In)"
# Allow incoming WinRM traffic on HTTP (Port 5985)
#New-NetFirewallRule -Name "WinRM-HTTP" -DisplayName "WinRM (HTTP-In)" -Direction Inbound -Protocol TCP -LocalPort 5985 -Action Allow
#
## Allow incoming WinRM traffic on HTTPS (Port 5986)
#New-NetFirewallRule -Name "WinRM-HTTPS" -DisplayName "WinRM (HTTPS-In)" -Direction Inbound -Protocol TCP -LocalPort 5986 -Action Allow
