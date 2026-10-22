# PixDesk sürümleri

PixDesk uzak masaüstü uygulamasının Windows kurulum paketleri burada yayımlanır.

## Kurulum

PowerShell'i açıp şunu yapıştırın:

```powershell
irm https://raw.githubusercontent.com/Pixenzo/PixDesk-releases/main/install.ps1 | iex
```

Betik son sürümü indirir, özetini doğrular ve kurulumu başlatır. Kurulum yönetici izni ister.

Ya da kurulum paketini [son sürüm](https://github.com/Pixenzo/PixDesk-releases/releases/latest) sayfasından indirin. Paket henüz kod imzası taşımadığı için Windows "Bilgisayarınız korundu" uyarısı gösterebilir: **Ek bilgi → Yine de çalıştır**.

### Linux

[Son sürüm](https://github.com/Pixenzo/PixDesk-releases/releases/latest) sayfasından `.AppImage` dosyasını indirin, çalıştırılabilir yapıp açın:

```bash
chmod +x PixDesk_*_amd64.AppImage
./PixDesk_*_amd64.AppImage
```

Debian/Ubuntu için `.deb` paketi de vardır (`sudo apt install ./PixDesk_*_amd64.deb`). Otomatik güncelleme AppImage'da çalışır.

Wayland'de ekran paylaşımı için masaüstünün portal uygulaması, PipeWire ve `gtk-layer-shell` gerekir. Arch/CachyOS'ta:

```bash
sudo pacman -S --needed xdg-desktop-portal-kde pipewire gtk-layer-shell
```

İlk bağlantıda masaüstü ekran paylaşımı için izin ister; izin hatırlanır.

## Notlar


- **Güncelleme:** Kurulu uygulama yeni sürümü kendisi bulur ve onayınızla kurar. Güncelleme dosyaları imzalıdır; uygulama imzası tutmayan bir dosyayı kurmaz.
- **Doğrulama:** Her sürümde `SHA256SUMS.txt` bulunur.

Kaynak kod bu depoda değildir; bu depo yalnızca derleme iş akışını ve sürümleri barındırır.
