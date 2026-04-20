<<<<<<< HEAD
# cireng_mama_piya

A new Flutter project.
=======
<div align="center">

# 🧾 Proyek Akhir PAB  
### 🍽️ Mama Piya Kasir  
### 📱 Aplikasi Mobile Sistem Kasir dan Manajemen Penjualan

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:F59E0B,100:DC2626&height=190&section=header&text=Mama%20Piya%20Kasir&fontSize=30&fontColor=ffffff" />

<br>

![Flutter](https://img.shields.io/badge/Framework-Flutter-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Language-Dart-0175C2?style=for-the-badge&logo=dart)
![Database](https://img.shields.io/badge/Database-Supabase-3ECF8E?style=for-the-badge&logo=supabase)
![Fitur](https://img.shields.io/badge/Fitur-Kamera-orange?style=for-the-badge&logo=googlecamera)

</div>

---

# 👥 Identitas Kelompok C8

<div align="center">

| No | Nama Anggota | NIM | Kelas |
|----|--------------|-----|-------|
| 1 | Nova Rasyadina Anwar | 2409116092 | Sistem Informasi C |
| 2 | Dafa Firdaus | 2409116093 | Sistem Informasi C |
| 3 | Tsabitah Kawiswara | 2409116099 | Sistem Informasi C |
| 4 | Ahmad Samsul Arifin | 2409116113 | Sistem Informasi C |

</div>

---

# 📌 Deskripsi Aplikasi

<details>
<summary>🌟 Gambaran Umum</summary>

<br>

**Mama Piya Kasir** adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu kegiatan operasional usaha, khususnya dalam proses transaksi penjualan, pengelolaan stok, manajemen produk, pengelolaan akun karyawan, pencatatan riwayat transaksi, serta pemantauan laporan penjualan.

Aplikasi ini dibuat sebagai solusi digital agar proses pencatatan usaha tidak lagi dilakukan secara manual. Dalam kegiatan usaha sehari-hari, sering muncul kendala seperti transaksi yang tidak tercatat rapi, stok yang sulit dipantau, data produk yang berubah-ubah, dan laporan penjualan yang kurang terorganisir. Oleh karena itu, aplikasi ini hadir untuk membantu pemilik usaha maupun karyawan agar dapat bekerja dengan lebih cepat dan terstruktur.

Secara fungsi, aplikasi ini tidak hanya berperan sebagai **aplikasi kasir**, tetapi juga sebagai **sistem manajemen usaha sederhana**. Seluruh proses, mulai dari input transaksi, penyimpanan bukti pembayaran, pembaruan stok, pencarian riwayat transaksi, hingga pemantauan omzet dan keuntungan, dapat dilakukan dalam satu aplikasi.

Aplikasi ini juga menerapkan **hak akses berdasarkan peran pengguna**, yaitu:

- **Karyawan**, yang memiliki akses ke menu operasional seperti kasir, stok, dan riwayat transaksi
- **Pemilik / Owner**, yang memiliki akses lebih luas, mencakup menu operasional, manajemen karyawan, manajemen produk, serta laporan penjualan

Dengan pembagian hak akses tersebut, sistem menjadi lebih aman, lebih tertata, dan lebih sesuai dengan kebutuhan masing-masing pengguna.

</details>

<details>
<summary>🎯 Tujuan Pembuatan Aplikasi</summary>

<br>

Aplikasi ini dibuat dengan tujuan untuk:

- mempermudah proses transaksi pelanggan
- membantu pencatatan usaha agar lebih rapi dan terdokumentasi
- mempermudah pengecekan dan pembaruan stok produk
- menyediakan riwayat transaksi yang mudah dicari
- membantu pemilik usaha dalam memantau omzet dan keuntungan
- meningkatkan efisiensi kerja owner maupun karyawan

Dengan adanya aplikasi ini, proses pengelolaan usaha diharapkan menjadi lebih modern, sistematis, dan minim kesalahan.

</details>

---

# 🚀 Fitur Aplikasi

<details>
<summary>🔐 1. Login Berdasarkan Role Pengguna</summary>

<br>

Aplikasi menyediakan halaman login yang digunakan sebagai pintu masuk utama ke dalam sistem. Setelah pengguna berhasil login, sistem akan menyesuaikan tampilan menu sesuai dengan role akun yang digunakan, yaitu **karyawan** atau **pemilik**.

Akun karyawan tidak bisa dibuat sendiri. Akun akan dibuat oleh pemilik, lalu pemilik akan memberikan email dan password yang digunakan karyawan untuk login ke aplikasi.

</details>

<details>
<summary>👨‍💼 2. Menu Karyawan</summary>

<br>

Jika pengguna masuk sebagai **karyawan**, maka akan muncul menu operasional berikut:

- **Kasir**
- **Stok**
- **Riwayat Transaksi**

Menu ini dibuat fokus pada kebutuhan operasional harian agar penggunaan aplikasi menjadi lebih sederhana dan efisien.

</details>

<details>
<summary>🧾 3. Fitur Kasir untuk Karyawan</summary>

<br>

Pada menu **Kasir**, karyawan dapat melakukan input transaksi pelanggan, meliputi:

- menginput **nama pelanggan**
- memilih **metode pembayaran**
- menambahkan **menu makanan** ke daftar pesanan
- melihat **ringkasan pemesanan**
- melihat **jumlah item**
- menambah, mengurangi, atau menghapus item
- melihat **nama pelanggan**
- melihat **metode pembayaran**
- melihat **total pesanan**
- menyimpan transaksi

Ringkasan transaksi ditampilkan seperti struk sederhana agar data pesanan terlihat lebih jelas dan rapi.

</details>

<details>
<summary>💳 4. Metode Pembayaran pada Menu Kasir</summary>

<br>

Aplikasi menyediakan tiga metode pembayaran, yaitu:

- **Tunai**
- **QRIS**
- **Transfer**

Masing-masing metode memiliki alur penggunaan yang menyesuaikan kebutuhan transaksi.

</details>

<details>
<summary>💵 5. Alur Transaksi Tunai</summary>

<br>

Jika karyawan memilih metode pembayaran **tunai**, maka setelah nama pelanggan diisi dan metode pembayaran dipilih, karyawan dapat langsung menambahkan menu makanan ke daftar pesanan.

Setelah item masuk ke ringkasan pesanan, karyawan dapat:

- menambah jumlah item
- mengurangi jumlah item
- menghapus item tertentu
- melihat ringkasan seperti struk
- menyimpan transaksi

Setelah transaksi disimpan, akan muncul notifikasi bahwa transaksi telah masuk ke **riwayat transaksi** dan **laporan penjualan**.

</details>

<details>
<summary>📷 6. Alur Transaksi QRIS</summary>

<br>

Jika karyawan memilih metode pembayaran **QRIS**, maka setelah data pelanggan dan pesanan selesai diinput, aplikasi akan mengarahkan pengguna ke halaman kamera.

Pada tahap ini, karyawan diminta mengambil foto sebagai **bukti pembayaran QRIS**. Setelah foto berhasil diambil, sistem akan menampilkan notifikasi bahwa transaksi telah masuk ke **riwayat transaksi** dan **laporan penjualan**.

</details>

<details>
<summary>📷 7. Alur Transaksi Transfer</summary>

<br>

Jika karyawan memilih metode pembayaran **transfer**, alurnya hampir sama dengan QRIS.

Setelah data transaksi selesai diinput, pengguna akan diarahkan ke kamera untuk mengambil **foto bukti pembayaran transfer**. Setelah bukti pembayaran berhasil disimpan, sistem akan menampilkan notifikasi bahwa transaksi telah masuk ke **riwayat transaksi** dan **laporan penjualan**.

</details>

<details>
<summary>📦 8. Menu Stok untuk Karyawan</summary>

<br>

Pada menu **Stok**, karyawan dapat melakukan pengelolaan stok barang.

Fitur yang tersedia pada halaman ini meliputi:

- melihat **seluruh stok**
- melihat **stok yang menipis**
- melihat **stok yang habis**
- mencari nama produk tertentu melalui fitur **searching**
- melakukan **update stok** pada produk tertentu

Dengan fitur ini, karyawan dapat membantu memantau kondisi persediaan produk secara lebih cepat dan lebih akurat.

</details>

<details>
<summary>🔄 9. Update Stok Produk</summary>

<br>

Setiap produk yang ada pada halaman stok dapat diedit jumlah stoknya. Karyawan dapat melakukan pembaruan stok dengan cara memasukkan angka terbaru pada form update stok.

Fitur ini berguna ketika:

- ada barang baru masuk
- ada koreksi data stok
- ada penyesuaian stok berdasarkan kondisi sebenarnya

</details>

<details>
<summary>🕘 10. Riwayat Transaksi untuk Karyawan</summary>

<br>

Pada menu **Riwayat Transaksi**, karyawan dapat melihat daftar transaksi yang sudah tersimpan.

Data transaksi dapat dicari berdasarkan:

- **nama pelanggan**
- **nama kasir**
- **metode pembayaran**

Selain itu, transaksi juga dapat difilter berdasarkan periode waktu:

- **semua**
- **hari ini**
- **minggu ini**
- **bulan ini**

Karyawan juga dapat memfilter transaksi berdasarkan metode pembayaran:

- **semua**
- **tunai**
- **QRIS**
- **transfer**

</details>

<details>
<summary>🧾 11. Tampilan Detail Riwayat Transaksi</summary>

<br>

Tampilan riwayat transaksi disusun seperti **struk digital**, sehingga informasi transaksi terlihat lengkap dan mudah dibaca.

Informasi yang dapat dilihat pada riwayat transaksi antara lain:

- nama kasir
- waktu transaksi
- total pembayaran
- metode pembayaran
- bukti pembayaran berupa foto

</details>

<details>
<summary>👑 12. Menu Pemilik / Owner</summary>

<br>

Jika pengguna masuk sebagai **pemilik**, maka menu yang tersedia lebih lengkap dan terbagi menjadi beberapa kelompok, yaitu:

### Menu Operasional
- **Kasir**
- **Stok**
- **Riwayat Transaksi**

### Menu Manajemen
- **Karyawan**
- **Produk**

### Menu Laporan
- **Laporan**

Dengan susunan menu ini, pemilik usaha dapat mengontrol seluruh aktivitas penting usaha dari satu aplikasi.

</details>

<details>
<summary>🧾 13. Kasir untuk Pemilik</summary>

<br>

Jika pemilik memilih menu **Kasir**, maka tampilan dan alur penggunaannya sama seperti menu kasir pada akun karyawan.

Pemilik juga dapat:

- menginput nama pelanggan
- memilih metode pembayaran
- menambahkan menu pesanan
- melihat ringkasan transaksi
- menyimpan transaksi
- mengunggah bukti pembayaran untuk QRIS dan transfer

</details>

<details>
<summary>📦 14. Stok untuk Pemilik</summary>

<br>

Jika pemilik memilih menu **Stok**, maka fitur yang tersedia juga sama seperti pada akun karyawan, yaitu:

- melihat semua stok
- melihat stok menipis
- melihat stok habis
- mencari produk
- memperbarui jumlah stok

Dengan demikian, pemilik tetap bisa memantau dan mengelola persediaan barang secara langsung.

</details>

<details>
<summary>🕘 15. Riwayat Transaksi untuk Pemilik</summary>

<br>

Jika pemilik memilih menu **Riwayat Transaksi**, maka tampilannya secara umum sama seperti pada akun karyawan.

Namun, terdapat perbedaan penting, yaitu:

- **pemilik dapat melihat total omzet**
- **karyawan tidak dapat melihat total omzet**

</details>

<details>
<summary>👥 16. Manajemen Karyawan</summary>

<br>

Jika pemilik memilih menu **Karyawan**, maka pemilik dapat:

- menambahkan akun karyawan
- mengubah data karyawan
- menghapus akun karyawan

Saat menambahkan akun karyawan, data yang perlu diinput antara lain:

- **nama karyawan**
- **email**
- **password**

</details>

<details>
<summary>🛍️ 17. Manajemen Produk</summary>

<br>

Jika pemilik memilih menu **Produk**, maka pemilik dapat:

- menambahkan produk
- mengubah data produk
- menghapus produk
- mengatur menu
- mengatur harga jual
- mengatur harga modal
- mengatur stok
- menambahkan gambar produk

Saat menambahkan produk, data yang perlu diinput antara lain:

- **gambar produk**
- **nama produk**
- **harga jual**
- **harga modal**
- **stok**

</details>

<details>
<summary>📊 18. Menu Laporan</summary>

<br>

Jika pemilik memilih menu **Laporan**, maka pemilik dapat memantau berbagai informasi penting terkait usaha, yaitu:

- **omzet**
- **keuntungan bersih**
- **produk terlaris**
- **aktivitas**
- **total barang keluar**
- **rincian barang keluar per produk**
- **semua transaksi**
- **grafik keuntungan bersih bulanan berdasarkan transaksi yang tersimpan**

</details>

<details>
<summary>🏆 19. Produk Terlaris dan Rincian Penjualan</summary>

<br>

Pada bagian laporan, pemilik dapat melihat produk terlaris beserta jumlah produk yang paling banyak terjual.

Selain itu, tersedia juga rincian barang keluar per produk, sehingga pemilik dapat mengetahui produk mana yang paling aktif terjual dan berapa jumlah item yang sudah keluar.

</details>

<details>
<summary>📈 20. Grafik Keuntungan Bersih Bulanan</summary>

<br>

Aplikasi juga menyediakan visualisasi data dalam bentuk grafik keuntungan bersih bulanan. Grafik ini disusun berdasarkan transaksi yang telah tersimpan di dalam sistem, sehingga pemilik dapat melihat perkembangan keuntungan dari waktu ke waktu secara lebih mudah.

</details>

---

# 🔄 Alur Sistem Aplikasi

<details>
<summary>📌 Klik untuk melihat alur sistem aplikasi</summary>

<br>

Berikut gambaran alur kerja aplikasi secara umum:

1. Pengguna membuka aplikasi
2. Pengguna login ke dalam sistem
3. Sistem mengenali role pengguna, apakah sebagai karyawan atau pemilik
4. Jika login sebagai karyawan, sistem menampilkan menu kasir, stok, dan riwayat transaksi
5. Jika login sebagai pemilik, sistem menampilkan menu kasir, stok, riwayat transaksi, karyawan, produk, dan laporan
6. Pengguna dapat melakukan transaksi melalui menu kasir
7. Jika metode pembayaran tunai, transaksi dapat langsung disimpan
8. Jika metode pembayaran QRIS atau transfer, pengguna diminta mengunggah bukti pembayaran melalui kamera
9. Data transaksi akan masuk ke riwayat transaksi dan laporan penjualan
10. Data stok dapat diperbarui melalui menu stok
11. Pemilik dapat mengelola data karyawan dan produk
12. Pemilik dapat memantau omzet, keuntungan, dan aktivitas penjualan melalui menu laporan



</details>

---

# 🧠 Use Case

<details>
<summary>👨‍💼 Use Case Karyawan</summary>

<br>

Karyawan dapat melakukan:

- login ke sistem
- membuka menu kasir
- menginput nama pelanggan
- memilih metode pembayaran
- menambahkan menu ke pesanan
- mengelola jumlah item pesanan
- menyimpan transaksi
- mengambil foto bukti pembayaran untuk QRIS atau transfer
- membuka menu stok
- melihat semua stok
- melihat stok menipis
- melihat stok habis
- mencari produk
- memperbarui stok
- membuka riwayat transaksi
- mencari transaksi berdasarkan pelanggan, kasir, atau pembayaran
- memfilter transaksi berdasarkan waktu
- memfilter transaksi berdasarkan metode pembayaran
- logout dari sistem

</details>

<details>
<summary>👑 Use Case Pemilik / Owner</summary>

<br>

Pemilik dapat melakukan:

- login ke sistem
- menggunakan menu kasir
- menggunakan menu stok
- melihat riwayat transaksi
- melihat total omzet pada riwayat transaksi
- menambah akun karyawan
- mengubah akun karyawan
- menghapus akun karyawan
- menambah produk
- mengubah produk
- menghapus produk
- mengatur harga jual, harga modal, stok, dan gambar produk
- melihat laporan omzet
- melihat keuntungan bersih
- melihat produk terlaris
- melihat total barang keluar
- melihat rincian barang keluar per produk
- melihat grafik keuntungan bersih bulanan
- melihat seluruh transaksi
- logout dari sistem

</details>

---

# 🖼️ Dokumentasi Tampilan Aplikasi

---

<details>
<summary>🔐 1. Tampilan Login Page</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/5d5aa168-ca41-4105-b828-29c04b98ecee"
        alt="Login Page"
        width="250"
      />
    </td>
    <td width="65%" valign="top">

### Login Page
Halaman login merupakan halaman awal yang digunakan pengguna untuk masuk ke dalam sistem.  
Pada halaman ini, pengguna diminta mengisi email dan password. Setelah login berhasil, sistem akan menyesuaikan tampilan berdasarkan role pengguna, yaitu karyawan atau pemilik.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>👨‍💼 2. Dashboard Karyawan</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/6e50dbd8-745a-4d1e-bb77-4c2c7ae6617a"
        alt="Dashboard Karyawan"
        width="220"
      />
    </td>
    <td width="65%" valign="top">

### Dashboard Karyawan
Jika pengguna masuk sebagai karyawan, maka akan ditampilkan menu operasional yang terdiri dari **Kasir**, **Stok**, dan **Riwayat Transaksi**.  
Tampilan ini dibuat lebih fokus pada kebutuhan operasional harian agar penggunaan aplikasi menjadi lebih efisien.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>👑 3. Dashboard Pemilik / Owner</summary>

<br>

<div align="center">

<table align="center">
  <tr>
    <td align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/d382c6eb-358e-443f-8f5a-ed3d52b74158"
        alt="Dashboard Pemilik 1"
        width="220"
      />
    </td>
    <td width="20"></td>
    <td align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/a41b6621-0e9b-4657-bc60-584530fcde6c"
        alt="Dashboard Pemilik 2"
        width="220"
      />
    </td>
  </tr>
</table>

<br><br>

<b>Dashboard Pemilik:</b><br>
Jika pengguna masuk sebagai pemilik, maka akan muncul menu yang lebih lengkap, yaitu menu **Operasional**, **Manajemen**, dan **Laporan**.  
Pada role ini, pemilik dapat mengakses kasir, stok, riwayat transaksi, manajemen karyawan, manajemen produk, dan laporan usaha.

</div>

</details>

---

<details>
<summary>🧾 4. Halaman Kasir</summary>

<br>

<div align="center">

<table align="center">
  <tr>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/1f0da350-4971-4e05-9490-1d9385cf89a9" alt="Halaman Kasir 1" width="180" />
    </td>
    <td width="16"></td>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/37a18a77-697e-4367-b517-e546ba492f64" alt="Halaman Kasir 2" width="180" />
    </td>
    <td width="16"></td>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/9b7c12e4-0d1d-4ecd-815e-5b2549dfdf0f" alt="Halaman Kasir 3" width="180" />
    </td>
  </tr>
</table>

<br><br>

<b>Halaman Kasir:</b><br>
Halaman kasir digunakan untuk melakukan input transaksi pelanggan.  
Pada halaman ini, pengguna dapat menginput nama pelanggan, memilih metode pembayaran, menambahkan menu makanan ke pesanan, serta melihat ringkasan transaksi sebelum disimpan.

</div>

</details>

---

<details>
<summary>💵 5. Transaksi Tunai</summary>

<br>

<div align="center">

<table align="center">
  <tr>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/6424c5d7-ac4b-4ee8-91c2-35725f1f0e5c" alt="Transaksi Tunai 1" width="220" />
    </td>
    <td width="20"></td>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/b369089f-a4cb-450b-b0e7-dd4a0618e3c7" alt="Transaksi Tunai 2" width="220" />
    </td>
  </tr>
</table>

<br><br>

<b>Tampilan Transaksi Tunai:</b><br>
Jika metode pembayaran yang dipilih adalah tunai, maka setelah nama pelanggan dan metode pembayaran diisi, pengguna dapat langsung menambahkan menu ke dalam ringkasan pemesanan.  
Pada ringkasan tersebut, item dapat ditambah, dikurangi, atau dihapus. Setelah transaksi disimpan, sistem akan menampilkan notifikasi bahwa transaksi telah masuk ke riwayat transaksi dan laporan penjualan.

</div>

</details>

---

<details>
<summary>📷 6. Transaksi QRIS</summary>

<br>

<div align="center">

<table align="center">
  <tr>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/cfc15d26-ad1d-4d47-a721-ea5afe7b88e8" alt="Transaksi QRIS 1" width="160" />
    </td>
    <td width="12"></td>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/7c53a68d-4db2-473c-acc7-c712bacfa6cf" alt="Transaksi QRIS 2" width="160" />
    </td>
    <td width="12"></td>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/63cecc69-01c8-4db5-b96f-39d91991fb37" alt="Transaksi QRIS 3" width="160" />
    </td>
    <td width="12"></td>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/3f5eca5c-ad1c-4844-a814-6a0143fe44ea" alt="Transaksi QRIS 4" width="160" />
    </td>
  </tr>
</table>

<br><br>

<b>Transaksi QRIS:</b><br>
Jika metode pembayaran yang dipilih adalah QRIS, maka setelah data pesanan selesai diinput, pengguna akan diarahkan ke kamera untuk mengambil foto bukti pembayaran.  
Setelah bukti pembayaran berhasil diambil, sistem akan menampilkan notifikasi bahwa transaksi telah tersimpan pada riwayat transaksi dan laporan penjualan.

</div>

</details>

---

<details>
<summary>📷 7. Transaksi Transfer</summary>

<br>

<div align="center">

<table align="center">
  <tr>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/63403ff6-56b3-44c0-9a93-c724f7fa8048" alt="Transaksi Transfer 1" width="160" />
    </td>
    <td width="12"></td>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/84b74e67-e5bd-4ebd-95f8-78ca9a680593" alt="Transaksi Transfer 2" width="160" />
    </td>
    <td width="12"></td>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/5a8e9358-67ee-4446-a71e-9474647e7ba3" alt="Transaksi Transfer 3" width="160" />
    </td>
    <td width="12"></td>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/1c655b65-6af8-440b-a86a-9cbe1cec7f62" alt="Transaksi Transfer 4" width="160" />
    </td>
  </tr>
</table>

<br><br>

<b>Transaksi Transfer:</b><br>
Jika metode pembayaran yang dipilih adalah transfer, maka alurnya serupa dengan QRIS.  
Pengguna akan diminta mengambil foto bukti pembayaran sebagai dokumentasi, kemudian transaksi akan disimpan ke dalam sistem.

</div>

</details>

---

<details>
<summary>🧾 8. Ringkasan Pesanan</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/fd87e089-a31a-4718-8962-d08227d48ed9"
        alt="Ringkasan Pesanan"
        width="260"
      />
    </td>
    <td width="65%" valign="top">

### Ringkasan Pesanan
Bagian ini menampilkan ringkasan transaksi sebelum pesanan disimpan.  
Pengguna dapat melihat nama pelanggan, metode pembayaran, daftar item yang dipesan, jumlah item, serta total pembayaran. Pada bagian ini juga tersedia fitur untuk menambah, mengurangi, atau menghapus item pesanan.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>📦 9. Halaman Stok</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/90bb0544-f91d-496e-9881-c74bb6ca4d3a"
        alt="Halaman Stok"
        width="220"
      />
    </td>
    <td width="65%" valign="top">

### Halaman Stok
Halaman stok digunakan untuk memantau persediaan produk.  
Pada halaman ini, pengguna dapat melihat semua stok, stok menipis, dan stok habis, sehingga kondisi barang dapat dipantau dengan lebih jelas.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>🔍 10. Fitur Pencarian Produk pada Stok</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/6bb32937-7df2-41f5-942a-e926da13e7d4"
        alt="Pencarian Produk"
        width="220"
      />
    </td>
    <td width="65%" valign="top">

### Fitur Pencarian Produk
Pada menu stok, pengguna juga dapat mencari nama produk tertentu melalui fitur pencarian.  
Fitur ini memudahkan pengguna ketika ingin menemukan produk tertentu tanpa perlu mencari secara manual dari seluruh daftar barang.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>🔄 11. Update Stok Produk</summary>

<br>

<div align="center">

<table align="center">
  <tr>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/999df565-57f8-4442-b028-344f5ed9dd24" alt="Update Stok 1" width="220" />
    </td>
    <td width="20"></td>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/644a54ac-e4e6-4c23-8f7f-577b57819989" alt="Update Stok 2" width="220" />
    </td>
  </tr>
</table>

<br><br>

<b>Tampilan Update Stok Produk:</b><br>
Setiap produk pada halaman stok dapat diperbarui jumlah stoknya.  
Pengguna hanya perlu memasukkan angka stok terbaru, lalu sistem akan menyimpan perubahan tersebut.

</div>

</details>

---

<details>
<summary>🕘 12. Riwayat Transaksi Karyawan</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/d87cae4b-c0b5-4478-8208-947c0f29527f" alt="Riwayat Transaksi Karyawan 1" width="220" />
    </td>
    <td width="65%" valign="top">

### Halaman Riwayat Transaksi
Gambar ini menampilkan **halaman riwayat transaksi** pada akun karyawan.  
Pada halaman ini, karyawan dapat melihat daftar transaksi yang telah tersimpan di dalam sistem.

   </td>
  </tr>

  <tr>
    <td width="35%" align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/f9fc5a01-1325-4a7a-abba-f4a46faaec74" alt="Riwayat Transaksi Karyawan 2" width="220" />
    </td>
    <td width="65%" valign="top">

### Riwayat Transaksi
Gambar ini menunjukkan **tampilan riwayat transaksi yang sudah tersimpan**.  
Data transaksi ditampilkan secara rapi sehingga pengguna dapat melihat informasi transaksi yang telah berhasil masuk ke sistem.

   </td>
  </tr>

  <tr>
    <td width="35%" align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/9de67ff5-58e4-4083-b5e8-212f2042454b" alt="Pencarian berdasarkan nama" width="220" />
    </td>
    <td width="65%" valign="top">

### Fitur Pencarian berdasarkan Nama
Gambar ini menunjukkan fitur pencarian transaksi berdasarkan **nama pelanggan** atau **nama kasir**.  
Fitur ini memudahkan pengguna ketika ingin mencari data transaksi tertentu tanpa perlu melihat seluruh daftar transaksi secara manual.

   </td>
  </tr>

  <tr>
    <td width="35%" align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/85ddac20-efc7-4f1c-8097-1120c806c6d9" alt="Pencarian berdasarkan metode pembayaran" width="220" />
    </td>
    <td width="65%" valign="top">

### Fitur Pencarian berdasarkan Metode Pembayaran
Gambar ini menunjukkan hasil pencarian transaksi berdasarkan **metode pembayaran**.  
Ketika pengguna memilih metode pembayaran tertentu, maka jumlah transaksi yang ditampilkan akan menyesuaikan dengan filter yang dipilih, misalnya tunai, QRIS, atau transfer.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>🔎 13. Filter Riwayat Transaksi</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/e7961f8c-aba9-428d-946f-3a688b8f0092" alt="Filter Semua" width="220" />
    </td>
    <td width="65%" valign="top">

### Filter "Semua"
Gambar ini menunjukkan filter untuk melihat **semua riwayat pembayaran** yang tersimpan di dalam sistem.  
Dengan filter ini, pengguna dapat menampilkan seluruh data transaksi tanpa batasan waktu maupun metode pembayaran tertentu.

   </td>
  </tr>

  <tr>
    <td width="35%" align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/47235370-2bc3-4f07-89dc-28e88c0d0064" alt="Filter Hari Ini" width="220" />
    </td>
    <td width="65%" valign="top">

### Filter "Hari ini"
Gambar ini menunjukkan filter untuk melihat transaksi **hari ini**.  
Fitur ini membantu pengguna ketika ingin memantau transaksi yang terjadi pada hari yang sama secara lebih cepat dan spesifik.

   </td>
  </tr>

  <tr>
    <td width="35%" align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/340d1c65-cac9-4bfb-b228-32e7350aa43b" alt="Filter Minggu Ini" width="220" />
    </td>
    <td width="65%" valign="top">

### Filter "Minggu ini"
Gambar ini menunjukkan filter untuk melihat transaksi pada **minggu ini**.  
Dengan filter ini, pengguna dapat memantau seluruh transaksi yang terjadi dalam satu minggu terakhir.

   </td>
  </tr>

  <tr>
    <td width="35%" align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/64178f2b-bb8a-470a-bd58-54e7c1907c9e" alt="Filter Bulan Ini" width="220" />
    </td>
    <td width="65%" valign="top">

### Filter "Bulan ini"
Gambar ini menunjukkan filter untuk melihat transaksi pada **bulan ini**.  
Fitur ini memudahkan pengguna dalam melihat ringkasan transaksi bulanan tanpa perlu mencari data satu per satu.

   </td>
  </tr>

  <tr>
    <td width="35%" align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/004472c8-c8f0-4845-9062-cdec001d9097" alt="Filter Metode Pembayaran" width="220" />
    </td>
    <td width="65%" valign="top">

### Filter Metode Pembayaran
Gambar ini menunjukkan filter berdasarkan **metode pembayaran**.  
Melalui filter ini, pengguna dapat menampilkan transaksi sesuai metode pembayaran yang dipilih, seperti tunai, QRIS, atau transfer.

   </td>
  </tr>
</table>

<br><br>

<b>Filter untuk melihat riwayat pembayaran:</b><br>
Riwayat transaksi dapat difilter berdasarkan periode waktu seperti semua, hari ini, minggu ini, dan bulan ini.  
Selain itu, transaksi juga dapat difilter berdasarkan metode pembayaran seperti tunai, QRIS, transfer.

</div>

</details>

---

<details>
<summary>🧾 14. Tampilan Detail Riwayat seperti Struk</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/eeeecb92-1c16-423f-8a1a-950731a1828c"
        alt="Detail Riwayat Transaksi"
        width="220"
      />
    </td>
    <td width="65%" valign="top">

### Tampilan Detail Riwayat Transaksi
Setiap data transaksi ditampilkan dengan format yang menyerupai struk digital.  
Informasi yang dapat dilihat antara lain nama kasir, waktu transaksi, total pembayaran, metode pembayaran, dan bukti pembayaran berupa foto.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>💰 15. Riwayat Transaksi Pemilik dengan Total Omzet</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/bfa4ddfd-d829-41d4-ba00-ae39defb8cec"
        alt="Riwayat Transaksi Pemilik"
        width="220"
      />
    </td>
    <td width="65%" valign="top">

### Tampilan Halaman Riwayat Transaksi pada Akun Pemilik
Pada akun pemilik, tampilan riwayat transaksi secara umum sama seperti pada akun karyawan.  
Namun, pada halaman ini pemilik juga dapat melihat **total omzet**, sedangkan informasi tersebut tidak ditampilkan pada akun karyawan.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>👥 16. Halaman Manajemen Karyawan</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/2ce9faad-5f3b-46cd-9033-ecb8c8a6b752"
        alt="Halaman Manajemen Karyawan"
        width="220"
      />
    </td>
    <td width="65%" valign="top">

### Halaman Manajemen Karyawan
Halaman ini digunakan oleh pemilik untuk mengelola akun karyawan.  
Pemilik dapat menambahkan, mengubah, dan menghapus akun karyawan sesuai kebutuhan operasional usaha.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>➕ 17. Form Tambah Karyawan</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/4b2f7296-9ce8-427d-8889-13849ba39037"
        alt="Form Tambah Karyawan"
        width="220"
      />
    </td>
    <td width="65%" valign="top">

### Tampilan saat Tambah Karyawan
Saat menambahkan akun karyawan baru, pemilik diminta mengisi nama karyawan, email, dan password.  
Form ini digunakan untuk membuat akun baru yang nantinya dapat digunakan untuk login ke dalam sistem.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>🛍️ 18. Halaman Manajemen Produk</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/04b4bd69-fb06-4868-901a-89123c299c3d"
        alt="Halaman Manajemen Produk"
        width="220"
      />
    </td>
    <td width="65%" valign="top">

### Tampilan Manajemen Produk
Halaman produk digunakan oleh pemilik untuk mengatur data produk yang dijual.  
Pada halaman ini, pemilik dapat melihat daftar menu, harga, stok, serta gambar produk yang tersedia dalam sistem.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>➕ 19. Form Tambah Produk</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/5e8b0728-ccaf-4b74-a5bb-efa0bd99d211"
        alt="Form Tambah Produk"
        width="220"
      />
    </td>
    <td width="65%" valign="top">

### Tampilan saat Menambah Produk
Saat menambahkan produk baru, pemilik perlu mengisi gambar produk, nama produk, harga jual, harga modal, dan stok.  
Form ini digunakan untuk menambahkan menu baru agar dapat langsung digunakan pada transaksi penjualan.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>✏️ 20. Edit / Hapus Produk</summary>

<br>

<div align="center">

<table align="center">
  <tr>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/c13f0065-0672-494c-a20e-5cdd62867929" alt="Edit Produk" width="220" />
    </td>
    <td width="20"></td>
    <td align="center" valign="top">
      <img src="https://github.com/user-attachments/assets/401e52f2-b64f-4e29-96a0-112feaae9232" alt="Hapus Produk" width="220" />
    </td>
  </tr>
</table>

<br>

<div align="center">
  <b>Kiri:</b> Tampilan untuk memperbarui data produk yang sudah ada.  
  <br />
  <b>Kanan:</b> Tampilan untuk menghapus produk yang tidak lagi dijual.
</div>

<br><br>

<b>Tampilan saat mengedit atau menghapus produk:</b><br>
Pemilik dapat memperbarui data produk yang sudah ada maupun menghapus produk yang tidak lagi dijual.  
Fitur ini membuat data produk tetap rapi, relevan, dan sesuai dengan kondisi usaha saat ini.

</div>

</details>

---

<details>
<summary>📊 21. Halaman Laporan</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/b12360f3-9236-4db9-bbf5-28f92cf3eedc"
        alt="Halaman Laporan"
        width="220"
      />
    </td>
    <td width="65%" valign="top">

### Halaman Laporan pada Akun Pemilik
Halaman laporan digunakan oleh pemilik untuk memantau performa usaha.  
Pada halaman ini, pemilik dapat melihat omzet, keuntungan bersih, total barang keluar, produk terlaris, aktivitas, dan data transaksi secara menyeluruh.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>🏆 22. Produk Terlaris dan Rincian Barang Keluar</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/b1815e62-5695-423c-ba58-56800373560b"
        alt="Produk Terlaris dan Rincian Barang Keluar"
        width="280"
      />
    </td>
    <td width="65%" valign="top">

### Tampilan Produk Terlaris dan Rincian Barang Keluar
Bagian ini menampilkan produk yang paling banyak terjual beserta jumlah penjualannya.  
Selain itu, ditampilkan juga rincian barang keluar per produk agar pemilik dapat melihat performa masing-masing produk secara lebih detail.

   </td>
  </tr>
</table>

</div>

</details>

---

<details>
<summary>📈 23. Grafik Keuntungan Bersih Bulanan</summary>

<br>

<div align="center">

<table>
  <tr>
    <td width="35%" align="center" valign="top">
      <img
        src="https://github.com/user-attachments/assets/2da24db6-d3f4-4ee8-97b1-6e6bc28aa6d8"
        alt="Grafik Keuntungan Bersih Bulanan"
        width="280"
      />
    </td>
    <td width="65%" valign="top">

### Grafik Keuntungan Bersih Bulanan
Grafik ini menampilkan perkembangan keuntungan bersih bulanan berdasarkan transaksi yang tersimpan di dalam sistem.  
Dengan visualisasi ini, pemilik dapat membaca perkembangan usaha dengan lebih mudah dan lebih cepat.

   </td>
  </tr>
</table>

</div>

</details>

---

# 🧩 Widget yang Digunakan

<details>
<summary>📌 Widget Dasar</summary>

<br>

- `MaterialApp`
- `Scaffold`
- `SafeArea`
- `AppBar`

Widget dasar ini digunakan sebagai kerangka utama aplikasi.

</details>

<details>
<summary>📐 Widget Layout</summary>

<br>

- `Column`
- `Row`
- `Container`
- `Padding`
- `SizedBox`
- `Expanded`
- `Wrap`

Widget layout digunakan untuk menyusun tampilan agar rapi, proporsional, dan mudah dipahami.

</details>

<details>
<summary>📝 Widget Teks dan Informasi</summary>

<br>

- `Text`
- `Icon`
- `Card`
- `Divider`
- `Chip`
- `CircleAvatar`

Widget ini digunakan untuk menampilkan judul, label, status stok, informasi menu, dan elemen visual lainnya.

</details>

<details>
<summary>⌨️ Widget Form dan Input</summary>

<br>

- `Form`
- `TextField`
- `TextFormField`
- `DropdownButtonFormField`
- `ElevatedButton`
- `OutlinedButton`
- `TextEditingController`

Widget form digunakan pada login, input transaksi, update stok, tambah karyawan, dan tambah produk.

</details>

<details>
<summary>📋 Widget List dan Data</summary>

<br>

- `ListView`
- `ListView.builder`
- `SingleChildScrollView`

Widget ini digunakan untuk menampilkan daftar produk, ringkasan pesanan, stok, riwayat transaksi, dan laporan data.

</details>

<details>
<summary>🖱️ Widget Interaksi</summary>

<br>

- `IconButton`
- `GestureDetector`
- `InkWell`
- `FloatingActionButton`
- `PopupMenuButton`

Widget interaksi memungkinkan pengguna memilih menu, menambah item, mengurangi item, menghapus data, dan menjalankan aksi tertentu.

</details>

<details>
<summary>🧭 Widget Navigasi dan State</summary>

<br>

- `Navigator.push()`
- `Navigator.pop()`
- `Drawer`
- `StatefulWidget`
- `StatelessWidget`
- `setState()`

Widget dan konsep ini digunakan untuk perpindahan halaman serta pembaruan tampilan secara dinamis.

</details>

<details>
<summary>🔔 Widget Notifikasi dan Feedback</summary>

<br>

- `SnackBar`
- `AlertDialog`
- `CircularProgressIndicator`

Widget ini digunakan untuk menampilkan notifikasi transaksi berhasil, konfirmasi tindakan, dan proses loading.

</details>

<details>
<summary>🖼️ Widget Media</summary>

<br>

- `Image`
- `Image.network`
- `Image.file`
- `CameraPreview`

Widget media digunakan untuk gambar produk dan pengambilan bukti pembayaran melalui kamera.

</details>

<details>
<summary>📊 Widget Visualisasi Data</summary>

<br>

- `LineChart`
- `BarChart`

Widget ini digunakan pada halaman laporan untuk menampilkan grafik keuntungan dan data penjualan.

</details>

---

# 🧱 Struktur Halaman Aplikasi

<details>
<summary>📁 Lihat struktur folder aplikasi</summary>

<br>

```bash
lib/
├── models/
│   ├── app_user_model.dart
│   ├── order_item_model.dart
│   └── product_model.dart
├── pages/
│   ├── add_employee_page.dart
│   ├── camera_capture_page.dart
│   ├── cashier_page.dart
│   ├── employee_home_page.dart
│   ├── login_page.dart
│   ├── owner_home_page.dart
│   ├── product_management_page.dart
│   ├── sales_report_page.dart
│   ├── stock_management_page.dart
│   ├── transaction_history_page.dart
│   └── user_management_page.dart
├── services/
│   ├── auth_service.dart
│   ├── employee_service.dart
│   ├── order_service.dart
│   ├── payment_proof_service.dart
│   ├── product_service.dart
│   ├── report_service.dart
│   └── user_service.dart
├── theme/
│   ├── app_colors.dart
│   └── app_theme.dart
├── utils/
│   ├── currency_formatter.dart
│   └── input_validators.dart
└── main.dart
```

</details>

<details>
<summary>🧩 Penjelasan folder <code>models/</code></summary>

<br>

Folder ini berisi model data yang digunakan dalam aplikasi. Model berfungsi untuk merepresentasikan data agar lebih mudah dikelola di dalam program.

- `app_user_model.dart` → model data pengguna aplikasi
- `order_item_model.dart` → model data item pesanan
- `product_model.dart` → model data produk

</details>

<details>
<summary>🖥️ Penjelasan folder <code>pages/</code></summary>

<br>

Folder ini berisi halaman-halaman antarmuka (UI) pada aplikasi.

- `add_employee_page.dart` → halaman untuk menambahkan akun karyawan
- `camera_capture_page.dart` → halaman untuk mengambil gambar menggunakan kamera
- `cashier_page.dart` → halaman kasir untuk proses transaksi
- `employee_home_page.dart` → halaman utama untuk karyawan
- `login_page.dart` → halaman login aplikasi
- `owner_home_page.dart` → halaman utama untuk pemilik
- `product_management_page.dart` → halaman untuk mengelola data produk
- `sales_report_page.dart` → halaman untuk melihat laporan penjualan
- `stock_management_page.dart` → halaman untuk mengelola stok barang
- `transaction_history_page.dart` → halaman untuk melihat riwayat transaksi
- `user_management_page.dart` → halaman untuk mengelola data pengguna

</details>

<details>
<summary>⚙️ Penjelasan folder <code>services/</code></summary>

<br>

Folder ini berisi layanan atau logika proses aplikasi, terutama yang berhubungan dengan pengolahan data dan fitur utama sistem.

- `auth_service.dart` → menangani proses autentikasi/login
- `employee_service.dart` → menangani data dan proses yang berkaitan dengan karyawan
- `order_service.dart` → menangani proses pemesanan atau transaksi
- `payment_proof_service.dart` → menangani data bukti pembayaran
- `product_service.dart` → menangani data produk
- `report_service.dart` → menangani pembuatan dan pengolahan laporan
- `user_service.dart` → menangani data pengguna

</details>

<details>
<summary>🎨 Penjelasan folder <code>theme/</code></summary>

<br>

Folder ini berisi pengaturan tampilan aplikasi, seperti warna dan tema.

- `app_colors.dart` → berisi daftar warna yang digunakan pada aplikasi
- `app_theme.dart` → berisi konfigurasi tema aplikasi

</details>

<details>
<summary>🛠️ Penjelasan folder <code>utils/</code></summary>

<br>

Folder ini berisi fungsi bantu yang digunakan untuk mendukung proses dalam aplikasi.

- `currency_formatter.dart` → digunakan untuk memformat nilai mata uang
- `input_validators.dart` → digunakan untuk memvalidasi input dari pengguna

</details>

<details>
<summary>🚀 Penjelasan file <code>main.dart</code></summary>

<br>

File utama yang digunakan sebagai titik awal saat aplikasi dijalankan.

</details>

---

# ⚙️ Teknologi dan Package yang Digunakan

<details>
<summary>📦 Klik untuk melihat teknologi dan package</summary>

<br>

Aplikasi ini dikembangkan menggunakan beberapa teknologi berikut:

- **Flutter** → framework utama untuk membangun aplikasi mobile
- **Dart** → bahasa pemrograman utama
- **Supabase** → database dan layanan backend
- **Camera** → untuk pengambilan bukti pembayaran
- **fl_chart** → untuk visualisasi laporan penjualan
- **Shared Preferences** → untuk penyimpanan sesi login
- **HTTP / API Service** → untuk komunikasi data

</details>

---

# 📲 Cara Menggunakan Aplikasi

<details>
<summary>👨‍💼 Jika Login sebagai Karyawan</summary>

<br>

1. Buka aplikasi
2. Login menggunakan akun karyawan
3. Pilih menu **Kasir**, **Stok**, atau **Riwayat Transaksi**
4. Jika membuka Kasir, input nama pelanggan
5. Pilih metode pembayaran
6. Tambahkan menu ke daftar pesanan
7. Atur jumlah item sesuai kebutuhan
8. Jika pembayaran tunai, simpan transaksi
9. Jika pembayaran QRIS atau transfer, ambil foto bukti pembayaran
10. Cek riwayat transaksi yang sudah tersimpan

</details>

<details>
<summary>👑 Jika Login sebagai Pemilik</summary>

<br>

1. Buka aplikasi
2. Login menggunakan akun pemilik
3. Gunakan menu **Kasir**, **Stok**, **Riwayat Transaksi**, **Karyawan**, **Produk**, atau **Laporan**
4. Kelola data sesuai kebutuhan usaha
5. Cek laporan untuk memantau omzet, keuntungan, dan aktivitas penjualan

</details>

---

# ✅ Kelebihan Aplikasi

<details>
<summary>✨ Klik untuk melihat kelebihan aplikasi</summary>

<br>

Beberapa kelebihan dari aplikasi **Mama Piya Kasir** antara lain:

- memiliki pembagian role yang jelas antara karyawan dan pemilik
- mendukung transaksi tunai maupun non-tunai
- menyediakan bukti pembayaran melalui kamera
- memiliki ringkasan transaksi yang rapi seperti struk digital
- mendukung pencarian dan filter riwayat transaksi
- mempermudah pengelolaan stok
- mendukung manajemen produk dan manajemen karyawan
- menyediakan laporan usaha yang lengkap dan informatif

</details>

---

<div align="center">

## ✨ Terima Kasih ✨

Terima kasih telah membaca dokumentasi project kami.  

**Mama Piya Kasir 💙**  
**Proyek Akhir PAB Kelompok C8**

</div>
>>>>>>> b9b512b8f1b43bb6249616e134202a42d2922b92
