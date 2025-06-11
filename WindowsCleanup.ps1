# PowerShell Temizlik Betiği v2.2 🚀
# Bu betik, sisteminizdeki geçici, önbellek ve gereksiz dosyaları otomatik olarak temizler.

# Yönetici yetkisi kontrolü
# Bu betiği çalıştırabilmek için yönetici yetkileri gereklidir.
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Bu betiği çalıştırabilmek için yönetici yetkileri gereklidir." -ForegroundColor Red
    Write-Host "Lütfen betiği yönetici olarak yeniden başlatın." -ForegroundColor Red
    Start-Sleep -Seconds 5
    exit
}

Write-Host "================================================================================" -ForegroundColor Green
Write-Host "=== Geçici ve Gereksiz Dosyaları Temizleme Betiği Başlıyor! ✨                ===" -ForegroundColor Green
Write-Host "================================================================================" -ForegroundColor Green
Write-Host "Lütfen betiğin çalışması sırasında sabırlı olun, bu biraz zaman alabilir..." -ForegroundColor Yellow

# Temizlenecek Ana Yollar 📂
$pathsToClean = @(
    "$env:TEMP",                 # Kullanıcıya özel geçici dosyalar
    "$env:WINDIR\Temp",          # Sistem geçici dosyaları
    "$env:LOCALAPPDATA\Temp",    # Kullanıcıya özel yerel geçici dosyalar
    "$env:WINDIR\Prefetch",      # Prefetch dosyaları (dikkatli olun, bazen performansı düşürebilir)
    "$env:APPDATA\Microsoft\Windows\Recent", # Son kullanılan dosyalar (kısayollarını siler)
    "$env:LOCALAPPDATA\Microsoft\Windows\WebCache", # Edge/IE WebCache (tarayıcı önbelleği)
    "$env:ProgramData\Microsoft\Windows\WER\ReportArchive", # Windows Hata Raporlama Arşivi
    "$env:ProgramData\Microsoft\Windows\WER\Temp",         # Windows Hata Raporlama Geçici
    "C:\Windows\SoftwareDistribution\Download" # Windows Update geçici dosyaları
)

# Tarayıcı Önbellekleri ve Günlükleri (Varsa) 🌐
$browserCachePaths = @(
    "$env:LOCALAPDATA\Google\Chrome\User Data\Default\Cache",
    "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache",
    "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache",
    "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Code Cache",
    "$env:APPDATA\Mozilla\Firefox\Profiles\*\cache2",
    "$env:APPDATA\Mozilla\Firefox\Profiles\*\startupCache",
    "$env:LOCALAPPDATA\Opera Software\Opera Stable\Cache",
    "$env:LOCALAPDATA\BraveSoftware\Brave-Browser\User Data\Default\Cache"
)

# Dosyaları ve Klasörleri Silme Fonksiyonu
function Remove-Items {
    param(
        [string[]]$Paths,
        [string]$ItemType,
        [string]$Emoji
    )
    foreach ($path in $Paths) {
        if (Test-Path $path) {
            # Satır boyunca uzanan başlık ve emoji
            $message = "Temizleniyor: $($path) ($ItemType) $Emoji"
            $line = "=" * 80
            Write-Host "`n$line" -ForegroundColor DarkGreen
            Write-Host "$message" -ForegroundColor DarkGreen
            Write-Host "$line`n" -ForegroundColor DarkGreen
            
            try {
                # Klasörü ve içindeki tüm öğeleri sil
                Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue -Confirm:$false
                
                # Klasör silindikten sonra tekrar oluştur (eğer yoksa)
                if (-not (Test-Path $path)) {
                    New-Item -Path $path -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
                    Write-Host "Klasör yeniden oluşturuldu: $path ✅" -ForegroundColor Gray
                }
            }
            catch {
                Write-Host "Hata oluştu: $_" -ForegroundColor Red
            }
        } else {
            Write-Host "--- Atlanıyor (yol bulunamadı): $($path) ($ItemType) 🤷‍♀️ ---" -ForegroundColor DarkYellow
        }
    }
}

# Ana Temizlik İşlemleri
Remove-Items -Paths $pathsToClean -ItemType "Geçici ve Sistem Dosyaları" -Emoji "🧹"
Remove-Items -Paths $browserCachePaths -ItemType "Tarayıcı Önbelleği" -Emoji "🌐"

# Geri Dönüşüm Kutusunu Boşaltma (Tüm Sürücüler İçin)
$line = "=" * 80
Write-Host "`n$line" -ForegroundColor DarkGreen
Write-Host "Geri Dönüşüm Kutusu boşaltılıyor... 🗑️" -ForegroundColor DarkGreen
Write-Host "$line`n" -ForegroundColor DarkGreen
try {
    # Clear-RecycleBin cmdlet'i ile tüm geri dönüşüm kutularını boşaltıyoruz
    # -Force parametresi onay istemeden işlemi tamamlar.
    Clear-RecycleBin -Force -ErrorAction Stop # -ErrorAction Stop hatayı yakalamamızı sağlar
    Write-Host "Geri Dönüşüm Kutusu başarıyla boşaltıldı. ✅" -ForegroundColor Green
}
catch {
    Write-Host "Geri Dönüşüm Kutusunu boşaltırken bir hata oluştu: $_" -ForegroundColor Red
}

# Disk Temizleme Sihirbazı'nı Çalıştırma (isteğe bağlı, daha fazla temizlik için)
$line = "=" * 80
Write-Host "`n$line" -ForegroundColor DarkGreen
Write-Host "Windows Disk Temizleme Sihirbazı başlatılıyor (ek temizlik için) 🚀" -ForegroundColor Blue
Write-Host "$line`n" -ForegroundColor DarkGreen
Write-Host "Bu işlem ek Windows geçici dosyalarını temizleyebilir ve biraz zaman alabilir." -ForegroundColor Blue
Start-Process cleanmgr.exe -ArgumentList "/sagerun:1" -Wait -ErrorAction SilentlyContinue

Write-Host "`n================================================================================" -ForegroundColor Green
Write-Host "=== Temizlik işlemi tamamlandı! Bilgisayarınız artık daha temiz olmalı. 🎉   ===" -ForegroundColor Green
Write-Host "================================================================================" -ForegroundColor Green
Write-Host "İyi günler dilerim! 😊"
