#this script will most likely not work on Windows 7

#download LAN profile
wget https://raw.githubusercontent.com/lovellt/ISE_Config/master/HH_Wired.xml -outfile HH_Wired.xml
#download WLAN profile
wget https://raw.githubusercontent.com/lovellt/ISE_Config/master/HH_Wireless.xml -outfile HH_Wireless.xml

#Check for LAN profile, start wired autoconfig, set wired autoconfig to auto, apply profile, delete profile file
if ((Get-FileHash .\HH_Wired.xml -algorithm sha1).Hash -eq "F68D1D4F0C8EB1FA481EEB780C284D6576A084BD")
  {
    cmd /c "sc config dot3svc start=auto"
    cmd /c "net start dot3svc"
    cmd /c netsh lan add profile HH_Wired.xml
    remove-item HH_Wired.xml
  }

  else 
  {write-host "HH_Wired.xml not found or corrupt, connect to the internet"}

#Check for WLAN profile, apply profile, delete profile file
if ((Get-FileHash .\HH_Wireless.xml -algorithm sha1).Hash -eq "54F4682037F100DDB16F5B5C8A4E8A10F3FC56D5")
  {  
    cmd /c netsh wlan add profile HH_Wireless.xml
    remove-item HH_Wireless.xml
    
    #Block Adhoc networks
    netsh wlan add filter permission=denyall networktype=adhoc

    #Block HHGuest
    netsh wlan add filter permission=block ssid=HHGuest networktype=infrastructure
    
    #delete HHGuest
    netsh wlan delete profile name=HHguest

    #delete HHA1r
    netsh wlan delete profile name=HHA1r
    
    #delete HHA1r
    netsh wlan delete profile name=HHA1r-5g
    
    #Put HHAr1-Test as the top priority (win10)
    netsh wlan set profileorder name="HHAr1-Test" interface="Wi-Fi" priority=1
    
    
  }
   else 
  {write-host "HH_Wireless.xml not found or corrupt, connect to the internet"}
