Param(
  [string]$crackType,
  [string]$Wordlist,
  [string]$help
)

# Sadece tek bir hash crack edilecegi zaman. (Bu hash input olarak shellden istenir)
if($crackType -eq 'single'){
    Write-Host ""
    $inputHash = Read-Host -Prompt 'Cracklemek istediginiz 32 karakterlik md5 hashini giriniz'
    $inputHash = $inputHash.ToUpper()
    while($inputHash.length -ne 32){
        $inputHash = Read-Host -Prompt 'ERROR ! Hash degerini yanlis girdiniz. Lutfen 32 karakterli hash degerini girin'
        if($inputHash.length -eq 32){
            break
        }
        else{
            continue
        }    
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
        Write-Host "Hash olarak girilen'$inputHash' hash fonksiyonu icin md5 crack cevabi -----> $cevap" 
    }
    else{
        Write-Host "" 
        Write-Host "Hash olarak girilen '$inputHash' icin md5 crack yapilamadi." 
    }
    Write-Host ""
    Write-Host "--------------------------------------------------------------------------------------------------------"
}



#Birden fazla hash text dosyasindan okunup cracklenecegi zaman
if($crackType -eq 'plural'){
    Write-Host ""
    $inputHashFile = Read-Host -Prompt 'Cracklenecek hashleri tutan dosyanin pathini girin'  
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
        
        if($buldu -eq $kontrol){
            Write-Host ""
            Write-Host "Dosyadan okunan '$Hash' hash fonksiyonu icin md5 crack cevabi -----> $cevap" 
        }
        else{
            Write-Host ""
            Write-Host "Dosyadan okunan '$inputHash' hash fonksiyonu icin md5 crack yapilamadi." 
        }          
    }
    Write-Host ""
    Write-Host "---------------------------------------------------------------------------------------------------------------------"
}

#Birden fazla hash text dosyasindan okunup cracklenecegi zaman
if($help -eq 'h'){
    Write-Host "---------------------------------------------------------------------------------------------------------------------"
    Write-Host ""
    Write-Host "Crackleyeceginiz md5 hash fonksiyonu 1 tane ise '-crackType' parametresi icin 'single' parametresini kullanabilirsiniz."
    Write-Host "Ornek kullanim ----> ./md5HashCracker.ps1 -crackType single  -Wordlist C:\Users\decoder\Desktop\inputWordList.txt"
    Write-Host "Buradaki -Wordlist parametresine sozlugunuzun pathini vermelisiniz."
    Write-Host ""
    Write-Host "---------------------------------------------------------------------------------------------------------------------"
    Write-Host ""
    Write-Host "Crackleyeceginiz md5 hashleri dosyada ise '-crackType' parametresi icin 'plural' parametresini kullanin."
    Write-Host "Ornek kullanim ----> ./md5HashCracker.ps1 -crackType plural  -Wordlist C:\Users\decoder\Desktop\inputWordList.txt"
    Write-Host "Buradaki -Wordlist parametresine sozlugunuzun pathini vermelisiniz."
    Write-Host ""
    Write-Host "---------------------------------------------------------------------------------------------------------------------"
}
Write-Host ""
