Param(
  [string]$crackType,
  [string]$Wordlist,
  [string]$inputArgument,
  [string]$help
)
 $startTime = (Get-Date)
 Write-Host ""
 Write-Host "********************************************************************************************************"
 Write-Host ""
 Write-Host "--------------------------------   Welcome to the Md5 Hash Cracker ! -----------------------------------"
 
$rep =  "********************************************************************************************************`r`n-------------------------------   Welcome to the Md5 Hash Cracker ! ------------------------------------`r`n"
Write-Host ""
Write-Host "Progressing..."
$rep | Set-Content  "Report.txt"
if($crackType -eq 'single'){
    $inputHash = $inputArgument
    $inputHash = $inputHash.ToUpper()
    if($inputHash.length -ne 32){
        Write-Host ""
        Write-Host "--------------------------------------------------------------------------------------------------------"
        Write-Host ""
        $rep1 = "<<< Input error >>> '$inputHash' is not a hash value.`r`n"
        Write-Host "<<< Input error >>> '$inputHash' is not a valid hash value."  
        Write-Host "Please re-run the program and enter the 32 character hash value for -inputArgument parameter."
        $rep1 | Add-Content  "Report.txt"
        $rep1 = "Please re-run the program and enter the 32 character hash value for -inputArgument parameter.`r`n"
        $rep1 | Add-Content  "Report.txt"
        $rep = "--------------------------------   Goodbye from the Md5 Hash Cracker ! ---------------------------------`r`n"
        $rep | Add-Content "Report.txt"
        Write-Host ""
        Write-Host "--------------------------------   Goodbye from the Md5 Hash Cracker ! ---------------------------------"
        Write-Host ""
        $endTime = (Get-Date)
        $elapsedTime = $endTime-$startTime
        $runtime = 'Duration: {0:ss} sec' -f $elapsedTime
        $rep = 'Duration: {0:ss} sec' -f $elapsedTime
        $rep | Add-Content "Report.txt"
        $rep = "********************************************************************************************************`r`n"
        $rep | Add-Content "Report.txt"
        Write-Host "$runtime"
        Write-Host ""
        Write-Host "********************************************************************************************************"
        Write-Host ""
        exit   
    }
    
    $DB = Get-Content -Path $Wordlist
    $kontrol = 'true'

    foreach($Data in $DB){
        $word = $Data
        $md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
        $utf8 = new-object -TypeName System.Text.UTF8Encoding
        $hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($word)))
        $hash = $hash -replace '[-]',""
       
        if($inputHash -eq $hash){
            $cevap = $word
            $buldu = "true"
            break
        }
        else{
            $buldu = "false"
        }   
    }
    Write-Host ""
    Write-Host "--------------------------------------------------------------------------------------------------------"
    if($buldu -eq $kontrol){
        Write-Host ""
        Write-Host "The input hash '$inputHash' is cracked -----> $cevap" 
        $rep2 = "The input hash '$inputHash' is cracked -----> $cevap`r`n"
        $rep2 | Add-Content 'Report.txt'
    }
    else{
        Write-Host "" 
        Write-Host "The input hash '$inputHash' could not cracked."
        $rep3 = "The input hash '$inputHash' could not cracked.`r`n"
        $rep3 | Add-Content 'Report.txt' 
    }
    Write-Host ""
    Write-Host "--------------------------------------------------------------------------------------------------------"
}


if($crackType -eq 'plural'){
    $inputHashFile = $inputArgument
    $count = 0
    Write-Host ""
    $DB = Get-Content -Path $inputHashFile
   
    foreach($Data in $DB){
        Write-Host ""
        $inputHash = $Data
        $inputHash = $inputHash.ToUpper()
        $kontrol = 'true'
        
        $DB2 = Get-Content -Path $Wordlist
        Write-Host "--------------------------------------------------------------------------------------------------------"
        foreach($Data2 in $DB2){
            $word2 = $Data2
            $md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
            $utf8 = new-object -TypeName System.Text.UTF8Encoding
            $hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($word2)))
            $hash = $hash -replace '[-]',""
            
            if($inputHash -eq $hash){
                $cevap = $word2
                $buldu = "true"
                break
            }
            else{
                $buldu = "false"
            }          
        }
        
        $count = $count + 1 
        if($buldu -eq $kontrol){
            Write-Host ""
            $rep1 = "$count. hash in the file '$inputHash' is cracked -----> $cevap`r`n" 
            $rep1 | Add-Content  "Report.txt"
            Write-Host "$count. hash in the file '$inputHash' is cracked -----> $cevap" 
        }
        else{
            Write-Host ""
            $rep1 = "$count. hash in the file '$inputHash'  could not cracked. <<< Input error >>>`r`n" 
            $rep1 | Add-Content  "Report.txt"
            Write-Host "$count. hash in the file '$inputHash'  could not cracked. <<< Input error >>>" 
        }          
    }
    Write-Host ""
    Write-Host "--------------------------------------------------------------------------------------------------------"
}

#Birden fazla hash text dosyasindan okunup cracklenecegi zaman
if($help -eq 'h'){
    Write-Host ""
    Write-Host "--------------------------------------------------------------------------------------------------------"
    Write-Host ""
    Write-Host "If you have just 1 hash to crack you can use:"
    Write-Host ""
    Write-Host "[-crackType]: 'single'"
    Write-Host "[-Wordlist]: The path of wordlist file"
    Write-Host "[-inputArgument]: The hash that you want to crack"
    Write-Host ""
    Write-Host "Example usage ----> .\md5HashCracker.ps1 -crackType single -Wordlist C:\Users\decoder\Desktop\inputWordList.txt -inputArgument 900150983CD24FB0D6963F7D28E17F72"
    Write-Host ""
    Write-Host "--------------------------------------------------------------------------------------------------------"
    Write-Host ""
    Write-Host "If you have more than 1 hashes to crack you can use:."
    Write-Host ""
    Write-Host "[-crackType]: 'plural'"
    Write-Host "[-Wordlist]: The path of wordlist file"
    Write-Host "[-inputArgument]: The path of hashlist file"
    Write-Host ""
    Write-Host "Example usage ----> .\md5HashCracker.ps1 -crackType plural -Wordlist C:\Users\decoder\Desktop\inputWordList.txt -inputArgument C:\Users\decoder\Desktop\inputHashList.txt"
    Write-Host ""
    Write-Host "--------------------------------------------------------------------------------------------------------"
}

$rep = "--------------------------------   Goodbye from the Md5 Hash Cracker ! ---------------------------------`r`n"
$rep | Add-Content "Report.txt"
Write-Host ""
Write-Host "--------------------------------   Goodbye from the Md5 Hash Cracker ! ---------------------------------"
Write-Host ""
$endTime = (Get-Date)
$elapsedTime = $endTime-$startTime
$runtime = 'Duration: {0:ss} sec' -f $elapsedTime
$rep = 'Duration: {0:ss} sec' -f $elapsedTime
$rep | Add-Content "Report.txt"
$rep = "********************************************************************************************************`r`n"
$rep | Add-Content "Report.txt"
Write-Host "$runtime"
Write-Host ""
Write-Host "********************************************************************************************************"
Write-Host ""
