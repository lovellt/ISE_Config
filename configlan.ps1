wget https://raw.githubusercontent.com/lovellt/ISE_Config/master/HH_wired -outfile hhwired.xml

if ((Get-FileHash .\hhwired.xml -algorithm md5).Hash -eq "E5E3E7E10C8A3B174FFF00AF0A88ED31")
  {
    cmd /c "sc config dot3svc start=auto"
    cmd /c "net start dot3svc"
    cmd /c netsh lan add profile hhwired.xml
    remove-item hhwired.xml
  }

else 
  {write-host "xml not found, connect to the internet"}
