# What has been done here:

1. 2 Images Windows Server 2019 and Debian 11
2. Developed directory structure. Might not be the best.
3. Worked on creating for each of these images:
- {image}.pkr.hcl files and variables.pkr.hcl and plugins.pkr.hcl in order to be pretty and easy to navigate what is what.

--> Debian:
- Had to find a boot order for the image.
- Preseed file.
- Offloaded the variables into a type map variable in order to make its manaagement easier.
- 4 scripts:
- Installs ansible
- Set ups the machine
- Installs docker
- Cleanup
- Use of ansible to install some packages
- File provisioners to get the jenkins-agent.service file (developed that one)
- Secrets file that contains the api key for the jenkins slave
- Scripts that configures and starts jenkins slave (not working) service is not enabled and started (alright for now)
- Outputing the image into a folder called build in format box and using template variables. Making random images each time.

--> Windows-Slave: 
- Had to find a boot order for the image. 
- Had to figure out how to autounattend.
- Developed similar structure as in debian 11.
- Strategy for building the image is the same as in Deb 11
- Found example ps1 scripts that might be usefull for configuring the OS. Needs to be further investigated.
- Tried remote powershell:
--> Worked when it was manually configured.
--> For some reason, I am experiancing problems configuring it with scripts.
---> This approach worked:
----> 
This has been performed not on the remote to be accessed but the host that I am accessing it from.
```powershell
winrm quickconfig
winrm enumerate winrm/config/listener
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "<ip-of-remote-ps>" -Concatenate

$cred = Get-Credential
Enter-PSSession -ComputerName 192.168.2.210 -Credential $cred
```
----> Left Overs:
-> Install Java Automatically pref 17.
-> Agent Installation auto-mation.
-> Connection From Slave to Server. (remote ps)
-> Install DB MS SQL Dev tools. Probably via chocolately.


> Most of the things I did manually to test and see how it needs to be done.
> In office it takes a huge amount of time due to network speed. Also packer is not very good with windows when something is about to fail it takes 30 minutes to actually fail.

