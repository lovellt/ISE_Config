cmd /c "sc config "dot3svc" start=auto"
cmd /c "net start dot3svc"
cmd /c netsh lan add profile 
