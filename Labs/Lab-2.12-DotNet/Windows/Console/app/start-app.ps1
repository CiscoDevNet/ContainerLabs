
while(1){
  $timenow = get-date -Format u
  $logPath="c:\resource-check\logs"
  $dcmd = C:\resource-check\DockerOnWindows.ResourceCheck.Console.exe
  "$timenow $dcmd"  >> $logPath\log.out
   
   #log analytics section begins here
    $rand1 = Get-Random -Minimum 4 -Maximum 100
    $rand2 = Get-Random -Minimum 5 -Maximum 300
    $mq = "TradeFX  1 MQ current depth is $rand1 "
    $mq2 = "FIXREUT 3 current depth is $rand2"
    "$timenow $mq" >> $logPath\log.out
    "$timenow $mq2" >> $logPath\log.out

  Get-Content $logPath\log.out -tail 10 

  wget -UseBasicParsing http://front-end
  wget -UseBasicParsing http://front-end/About
  wget -UseBasicParsing http://front-end/Contact

  Start-Sleep -Seconds 5
    Clear 
 }