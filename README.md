# QTUN WebUI Magisk Module

**QTUN WebUI** adalah module **Magisk** untuk menjalankan **QTUN Tunneling Control Panel** di perangkat Android dengan dukungan **PHP7 webserver**.

Project ini memudahkan pengelolaan:
- login web panel
- manajemen user
- config file QTUN
- integrasi dashboard Clash
- kontrol service `start / stop / restart`
- live log status service

## View

Tampilan utama module menampilkan:
- halaman login
- dashboard manager
- daftar user
- editor config
- embed Clash Dashboard
- service status dan live logs

## Fitur

- **WebUI berbasis PHP7**
- **Tampilan mobile-friendly**
- **Login page**
- **User manager**
- **Config manager**
- **Clash dashboard embed**
- **Service control**
- **Live logs**
- **Auto status indicator**
- **Support QTUN script bridge**

## Full support QTUN Mod MV1.1.3

Binary / release QTUN dapat diambil dari repository berikut:

**QTUN-TUNNELING Releases**  
https://github.com/InetByOu/QTUN-TUNNELING/releases

## Kebutuhan

- Device Android
- **Magisk**
- Module ini berjalan bersama environment QTUN
- Akses ke local webserver `127.0.0.1:80`

## Instalasi
1. Unduh module dari halaman release.
2. Install module melalui **Magisk Manager**.
3. Reboot perangkat jika diperlukan.
4. Pastikan QTUN dan file pendukung sudah tersedia.
5. Buka browser lalu akses:

```text
http://127.0.0.1:80
http://localhostkamu

```

## Login Default

```text
Username : admin
Password : admin123
```

## Struktur Umum

Module ini menempatkan file pada lokasi berikut:

```text
/data/adb/php7/
├── files/
│   ├── bin/
│   ├── config/
│   └── www/
└── scripts/
```

Script launcher WebUI akan dipindahkan ke:

```text
/data/adb/QTUN/scripts/webui.sh
```

## Konfigurasi

File config yang terlihat pada module ini:

- `zivpn.json`

Contoh parameter QTUN yang ditunjukkan pada UI:

```json
{
  "server": "isiipserverkamu:6000-19999",
  "obfs": "hu``hqb`c",
  "auth": "password zivpn",
  "worker_count": 8,
  "resolver": "8.8.8.8:53",
  "insecure": true,
  "recvwindowconn": 65536,
  "recvwindow": 262144,
  "disable_mtu_discovery": true
}
```

## Cara Pakai

Setelah WebUI aktif:

1. Login ke panel, wajib restart qtun via web ui dulu.
2. Tambah atau kelola user.
3. Pilih atau edit file config QTUN.
4. Jalankan service dari menu dashboard.
5. Pantau status melalui live log.

## Tombol Kontrol Service

Pada dashboard tersedia kontrol cepat:

- **START**
- **STOP**
- **RESTART**

## Catatan

- Module ini ditujukan untuk penggunaan lokal pada perangkat sendiri.
- Pastikan path dan permission file sesuai dengan environment Magisk.
- Jika dashboard tidak muncul, cek apakah service PHP7 dan script QTUN sudah aktif.

## Credit

- **QTUN WebUI By.E**
- **PHP7 Server by nosignal**
- UI dan integrasi panel: **edoll**
