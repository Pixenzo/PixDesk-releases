# PixDesk sürümleri

PixDesk uzak masaüstü uygulamasının Windows kurulum paketleri burada yayımlanır.

## Kurulum

PowerShell'i açıp şunu yapıştırın:

```powershell
irm https://raw.githubusercontent.com/Pixenzo/PixDesk-releases/main/install.ps1 | iex
```

Betik son sürümü indirir, özetini doğrular ve kurulumu başlatır. Kurulum yönetici izni ister.

Ya da kurulum paketini [son sürüm](https://github.com/Pixenzo/PixDesk-releases/releases/latest) sayfasından indirin. Paket henüz kod imzası taşımadığı için Windows "Bilgisayarınız korundu" uyarısı gösterebilir: **Ek bilgi → Yine de çalıştır**.

## Notlar


- **Güncelleme:** Kurulu uygulama yeni sürümü kendisi bulur ve onayınızla kurar. Güncelleme dosyaları imzalıdır; uygulama imzası tutmayan bir dosyayı kurmaz.
- **Doğrulama:** Her sürümde `SHA256SUMS.txt` bulunur.

Kaynak kod bu depoda değildir; bu depo yalnızca derleme iş akışını ve sürümleri barındırır.
