# PixDesk kurulum betiği.
#
# Kullanım (PowerShell):
#   irm https://raw.githubusercontent.com/Pixenzo/PixDesk-releases/main/install.ps1 | iex
#
# Belirli bir sürüm (ör. bir deneme sürümü) için önce:
#   $env:PIXDESK_VERSION = 'v0.3.0'
#
# Son sürümün kurulum paketini indirir, SHA-256 özetini sürümdeki
# SHA256SUMS.txt ile karşılaştırır ve kurulumu başlatır. Kurulum yönetici
# izni ister (UAC). Paket tarayıcıyla indirilmediği için Windows'un
# "internetten indirildi" uyarısı çıkmaz.

& {
    $ErrorActionPreference = 'Stop'
    $ProgressPreference = 'SilentlyContinue'
    # Windows PowerShell 5.1 varsayılan olarak TLS 1.2 kullanmayabilir.
    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

    $base = 'https://github.com/Pixenzo/PixDesk-releases/releases/latest/download'
    if ($env:PIXDESK_VERSION) {
        if ($env:PIXDESK_VERSION -notmatch '^v\d+\.\d+\.\d+$') {
            Write-Host "Geçersiz sürüm: $($env:PIXDESK_VERSION) (ör. v0.3.0)" -ForegroundColor Red
            return
        }
        $base = "https://github.com/Pixenzo/PixDesk-releases/releases/download/$($env:PIXDESK_VERSION)"
    }

    if (-not [Environment]::Is64BitOperatingSystem) {
        Write-Host 'PixDesk yalnızca 64 bit Windows üzerinde çalışır.' -ForegroundColor Red
        return
    }

    Write-Host 'PixDesk: son sürüm aranıyor...'
    $manifest = Invoke-RestMethod "$base/latest.json"
    $url = $manifest.platforms.'windows-x86_64'.url
    if (-not $url -or -not $url.StartsWith('https://github.com/Pixenzo/PixDesk-releases/releases/download/')) {
        Write-Host 'Sürüm bilgisi okunamadı.' -ForegroundColor Red
        return
    }
    $name = [IO.Path]::GetFileName($url)
    $sums = (Invoke-WebRequest "$base/SHA256SUMS.txt" -UseBasicParsing).Content
    $expected = ($sums -split "`n" | Where-Object { $_ -match [regex]::Escape($name) } | Select-Object -First 1) -replace '\s.*$', ''
    if (-not $expected) {
        Write-Host 'Sürümün özet dosyasında bu paket yok.' -ForegroundColor Red
        return
    }

    $file = Join-Path $env:TEMP $name
    Write-Host "PixDesk $($manifest.version) indiriliyor..."
    Invoke-WebRequest $url -OutFile $file -UseBasicParsing

    $actual = (Get-FileHash $file -Algorithm SHA256).Hash
    if ($actual -ne $expected.Trim().ToUpperInvariant()) {
        Remove-Item $file -Force
        Write-Host 'İndirilen dosyanın özeti tutmuyor; kurulum yapılmadı.' -ForegroundColor Red
        return
    }

    Write-Host 'Kurulum başlatılıyor (yönetici izni istenecek)...'
    try {
        Start-Process -FilePath $file -Wait
    } finally {
        Remove-Item $file -Force -ErrorAction SilentlyContinue
    }
    Write-Host 'Tamam. PixDesk Başlat menüsünde.' -ForegroundColor Green
}
