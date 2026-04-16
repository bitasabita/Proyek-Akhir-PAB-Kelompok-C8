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

# 👥 Identitas Kelompok

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

## 🌟 Gambaran Umum

**Mama Piya Kasir** adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu kegiatan operasional usaha, khususnya dalam proses transaksi penjualan, pengelolaan stok, manajemen produk, pengelolaan akun karyawan, pencatatan riwayat transaksi, serta pemantauan laporan penjualan.

Aplikasi ini dibuat sebagai solusi digital agar proses pencatatan usaha tidak lagi dilakukan secara manual. Dalam kegiatan usaha sehari-hari, sering muncul kendala seperti transaksi yang tidak tercatat rapi, stok yang sulit dipantau, data produk yang berubah-ubah, dan laporan penjualan yang kurang terorganisir. Oleh karena itu, aplikasi ini hadir untuk membantu pemilik usaha maupun karyawan agar dapat bekerja dengan lebih cepat, lebih terstruktur, dan lebih efisien.

Secara fungsi, aplikasi ini tidak hanya berperan sebagai **aplikasi kasir**, tetapi juga sebagai **sistem manajemen usaha sederhana** yang terintegrasi. Seluruh proses, mulai dari input transaksi, penyimpanan bukti pembayaran, pembaruan stok, pencarian riwayat transaksi, hingga pemantauan omzet dan keuntungan, dapat dilakukan dalam satu aplikasi.

Aplikasi ini juga menerapkan **hak akses berdasarkan peran pengguna**, yaitu:

- **Karyawan**, yang memiliki akses ke menu operasional seperti kasir, stok, dan riwayat transaksi
- **Pemilik / Owner**, yang memiliki akses lebih luas, mencakup menu operasional, manajemen karyawan, manajemen produk, serta laporan penjualan

Dengan pembagian hak akses tersebut, sistem menjadi lebih aman, lebih tertata, dan lebih sesuai dengan kebutuhan masing-masing pengguna.

---

# 🎯 Tujuan Pembuatan Aplikasi

Aplikasi ini dibuat dengan tujuan untuk:

- mempermudah proses transaksi pelanggan,
- membantu pencatatan usaha agar lebih rapi dan terdokumentasi,
- mempermudah pengecekan dan pembaruan stok produk,
- menyediakan riwayat transaksi yang mudah dicari,
- membantu pemilik usaha dalam memantau omzet dan keuntungan,
- serta meningkatkan efisiensi kerja owner maupun karyawan.

Dengan adanya aplikasi ini, proses pengelolaan usaha diharapkan menjadi lebih modern, sistematis, dan minim kesalahan.

---

# 🚀 Fitur Aplikasi

<details>
<summary>📦 Klik untuk melihat fitur aplikasi secara lengkap</summary>

<br>

# 1. 🔐 Login Berdasarkan Role Pengguna
Aplikasi menyediakan halaman login yang digunakan sebagai pintu masuk utama ke dalam sistem.  
Setelah pengguna berhasil login, sistem akan menyesuaikan tampilan menu sesuai dengan role akun yang digunakan, yaitu **karyawan** atau **pemilik**.

Fitur ini penting karena menjadi dasar pembagian hak akses di dalam aplikasi.

---

# 2. 👨‍💼 Menu Karyawan
Jika pengguna masuk sebagai **karyawan**, maka akan muncul menu operasional berikut:

- **Kasir**
- **Stok**
- **Riwayat Transaksi**

Menu yang ditampilkan untuk karyawan dibuat fokus pada kebutuhan operasional harian, sehingga penggunaan aplikasi menjadi lebih sederhana dan efisien.

---

# 3. 🧾 Fitur Kasir untuk Karyawan
Pada menu **Kasir**, karyawan dapat melakukan input transaksi pelanggan.  
Alur transaksi yang tersedia meliputi:

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

Ringkasan transaksi ditampilkan seperti struk sederhana, sehingga data pesanan terlihat lebih jelas dan rapi.

---

# 4. 💳 Metode Pembayaran pada Menu Kasir
Aplikasi menyediakan tiga metode pembayaran, yaitu:

- **Tunai**
- **QRIS**
- **Transfer**

Masing-masing metode memiliki alur penggunaan yang menyesuaikan kebutuhan transaksi.

---

# 5. 💵 Alur Transaksi Tunai
Jika karyawan memilih metode pembayaran **tunai**, maka setelah nama pelanggan diisi dan metode pembayaran dipilih, karyawan dapat langsung menambahkan menu makanan ke daftar pesanan.

Setelah item masuk ke ringkasan pesanan, karyawan dapat:

- menambah jumlah item,
- mengurangi jumlah item,
- menghapus item tertentu,
- melihat ringkasan seperti struk,
- dan menyimpan transaksi.

Setelah transaksi disimpan, akan muncul notifikasi bahwa transaksi telah masuk ke **riwayat transaksi** dan **laporan penjualan**.

---

# 6. 📷 Alur Transaksi QRIS
Jika karyawan memilih metode pembayaran **QRIS**, maka setelah data pelanggan dan pesanan selesai diinput, aplikasi akan mengarahkan pengguna ke halaman kamera.

Pada tahap ini, karyawan diminta mengambil foto sebagai **bukti pembayaran QRIS**.  
Setelah foto berhasil diambil, sistem akan menampilkan notifikasi bahwa transaksi telah masuk ke **riwayat transaksi** dan **laporan penjualan**.

Fitur ini membuat transaksi non-tunai menjadi lebih terdokumentasi.

---

# 7. 📷 Alur Transaksi Transfer
Jika karyawan memilih metode pembayaran **transfer**, alurnya hampir sama dengan QRIS.

Setelah data transaksi selesai diinput, pengguna akan diarahkan ke kamera untuk mengambil **foto bukti pembayaran transfer**.  
Setelah bukti pembayaran berhasil disimpan, sistem akan menampilkan notifikasi bahwa transaksi telah masuk ke **riwayat transaksi** dan **laporan penjualan**.

---

# 8. 📦 Menu Stok untuk Karyawan
Pada menu **Stok**, karyawan dapat melakukan pengelolaan stok barang.

Fitur yang tersedia pada halaman ini meliputi:
- melihat **seluruh stok**
- melihat **stok yang menipis**
- melihat **stok yang habis**
- mencari nama produk tertentu melalui fitur **searching**
- melakukan **update stok** pada produk tertentu

Dengan fitur ini, karyawan dapat membantu memantau kondisi persediaan produk secara lebih cepat dan lebih akurat.

---

# 9. 🔄 Update Stok Produk
Setiap produk yang ada pada halaman stok dapat diedit jumlah stoknya.  
Karyawan dapat melakukan pembaruan stok dengan cara memasukkan angka terbaru pada form update stok.

Fitur ini berguna ketika:
- ada barang baru masuk,
- ada koreksi data stok,
- atau ada penyesuaian stok berdasarkan kondisi sebenarnya.

---

# 10. 🕘 Riwayat Transaksi untuk Karyawan
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

---

# 11. 🧾 Tampilan Detail Riwayat Transaksi
Tampilan riwayat transaksi disusun seperti **struk digital**, sehingga informasi transaksi terlihat lengkap dan mudah dibaca.

Informasi yang dapat dilihat pada riwayat transaksi antara lain:
- nama kasir
- waktu transaksi
- total pembayaran
- metode pembayaran
- bukti pembayaran berupa foto

Hal ini membuat riwayat transaksi tidak hanya berfungsi sebagai daftar data, tetapi juga sebagai dokumentasi transaksi yang lengkap.

---

# 12. 👑 Menu Pemilik / Owner
Jika pengguna masuk sebagai **pemilik**, maka menu yang tersedia lebih lengkap dan terbagi menjadi beberapa kelompok, yaitu:

## Menu Operasional
- **Kasir**
- **Stok**
- **Riwayat Transaksi**

## Menu Manajemen
- **Karyawan**
- **Produk**

## Menu Laporan
- **Laporan**

Dengan susunan menu ini, pemilik usaha dapat mengontrol seluruh aktivitas penting usaha dari satu aplikasi.

---

# 13. 🧾 Kasir untuk Pemilik
Jika pemilik memilih menu **Kasir**, maka tampilan dan alur penggunaannya sama seperti menu kasir pada akun karyawan.

Pemilik juga dapat:
- menginput nama pelanggan,
- memilih metode pembayaran,
- menambahkan menu pesanan,
- melihat ringkasan transaksi,
- menyimpan transaksi,
- serta mengunggah bukti pembayaran untuk QRIS dan transfer.

---

# 14. 📦 Stok untuk Pemilik
Jika pemilik memilih menu **Stok**, maka fitur yang tersedia juga sama seperti pada akun karyawan, yaitu:
- melihat semua stok,
- melihat stok menipis,
- melihat stok habis,
- mencari produk,
- dan memperbarui jumlah stok.

Dengan demikian, pemilik tetap bisa memantau dan mengelola persediaan barang secara langsung.

---

# 15. 🕘 Riwayat Transaksi untuk Pemilik
Jika pemilik memilih menu **Riwayat Transaksi**, maka tampilannya secara umum sama seperti pada akun karyawan.

Namun, terdapat perbedaan penting, yaitu:
- **pemilik dapat melihat total omzet**
- sedangkan **karyawan tidak dapat melihat total omzet**

Perbedaan ini menunjukkan bahwa aplikasi telah membedakan informasi yang dapat diakses sesuai dengan level pengguna.

---

# 16. 👥 Manajemen Karyawan
Jika pemilik memilih menu **Karyawan**, maka pemilik dapat:
- menambahkan akun karyawan,
- mengubah data karyawan,
- menghapus akun karyawan

Saat menambahkan akun karyawan, data yang perlu diinput antara lain:
- **nama karyawan**
- **email**
- **password**

Fitur ini memudahkan pemilik dalam mengelola akun pengguna yang terdaftar di dalam sistem.

---

# 17. 🛍️ Manajemen Produk
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

Fitur ini sangat penting karena seluruh transaksi akan menggunakan data produk yang tersimpan pada sistem.

---

# 18. 📊 Menu Laporan
Jika pemilik memilih menu **Laporan**, maka pemilik dapat memantau berbagai informasi penting terkait usaha, yaitu:

- **omzet**
- **keuntungan bersih**
- **produk terlaris**
- **aktivitas**
- **total barang keluar**
- **rincian barang keluar per produk**
- **semua transaksi**
- **grafik keuntungan bersih bulanan berdasarkan transaksi yang tersimpan**

Laporan ini membantu pemilik dalam mengevaluasi performa usaha secara lebih terukur dan berbasis data.

---

# 19. 🏆 Produk Terlaris dan Rincian Penjualan
Pada bagian laporan, pemilik dapat melihat produk terlaris beserta jumlah produk yang paling banyak terjual.

Selain itu, tersedia juga rincian barang keluar per produk, sehingga pemilik dapat mengetahui produk mana yang paling aktif terjual dan berapa jumlah item yang sudah keluar.

---

# 20. 📈 Grafik Keuntungan Bersih Bulanan
Aplikasi juga menyediakan visualisasi data dalam bentuk grafik keuntungan bersih bulanan.  
Grafik ini disusun berdasarkan transaksi yang telah tersimpan di dalam sistem, sehingga pemilik dapat melihat perkembangan keuntungan dari waktu ke waktu secara lebih mudah.

</details>

---

# 🔄 Alur Sistem Aplikasi

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

Dari alur ini terlihat bahwa seluruh fitur dalam aplikasi saling terhubung dan membentuk sistem usaha yang terintegrasi.

---

# 🧠 Use Case 

## 👨‍💼 Karyawan
Karyawan dapat melakukan:
- login ke sistem,
- membuka menu kasir,
- menginput nama pelanggan,
- memilih metode pembayaran,
- menambahkan menu ke pesanan,
- mengelola jumlah item pesanan,
- menyimpan transaksi,
- mengambil foto bukti pembayaran untuk QRIS atau transfer,
- membuka menu stok,
- melihat semua stok,
- melihat stok menipis,
- melihat stok habis,
- mencari produk,
- memperbarui stok,
- membuka riwayat transaksi,
- mencari transaksi berdasarkan pelanggan, kasir, atau pembayaran,
- memfilter transaksi berdasarkan waktu,
- memfilter transaksi berdasarkan metode pembayaran,
- serta logout dari sistem.

## 👑 Pemilik / Owner
Pemilik dapat melakukan:
- login ke sistem,
- menggunakan menu kasir,
- menggunakan menu stok,
- melihat riwayat transaksi,
- melihat total omzet pada riwayat transaksi,
- menambah akun karyawan,
- mengubah akun karyawan,
- menghapus akun karyawan,
- menambah produk,
- mengubah produk,
- menghapus produk,
- mengatur harga jual, harga modal, stok, dan gambar produk,
- melihat laporan omzet,
- melihat keuntungan bersih,
- melihat produk terlaris,
- melihat total barang keluar,
- melihat rincian barang keluar per produk,
- melihat grafik keuntungan bersih bulanan,
- melihat seluruh transaksi,
- serta logout dari sistem.

---

# 🖼️ Dokumentasi Tampilan Aplikasi

> **Catatan:**  
> Pada bagian ini, silakan masukkan screenshot aplikasi sesuai keterangan yang sudah disediakan.  
> Penjelasan di bawah ini sudah disesuaikan dengan alur aplikasi yang kamu jelaskan, jadi nanti kamu tinggal menambahkan foto yang sesuai.

---

<details>
<summary>🔐 1. Tampilan Login Page</summary>

<br>

<div align="center">

<table>
  <tr>
    <td align="center" width="35%">
      <img src="https://github.com/user-attachments/assets/5b590885-9663-4e9e-8e08-5e01bf8fbda7" alt="WhatsApp Image 2026-04-16 at 16 12 39" width="220" />
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

<table>
  <tr>
    <td align="center" width="35%">
      <img src="https://github.com/user-attachments/assets/6e50dbd8-745a-4d1e-bb77-4c2c7ae6617a" alt="WhatsApp Image 2026-04-16 at 16 20 53" width="220" />
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

<div align="center">
  <img src="https://github.com/user-attachments/assets/2a6a1f0c-59be-4799-acfd-6712dfdef4fc" alt="WhatsApp Image 2026-04-16 at 16 12 39 (1)" width="230" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/f3f2674d-e1ba-4e3b-9923-27a9c842b8ec" alt="WhatsApp Image 2026-04-16 at 16 12 40" width="230" />
</div>



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

<div align="center">
  <img src="https://github.com/user-attachments/assets/1f0da350-4971-4e05-9490-1d9385cf89a9" alt="image 1" width="180" />
  &nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/37a18a77-697e-4367-b517-e546ba492f64" alt="image 2" width="180" />
  &nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/9b7c12e4-0d1d-4ecd-815e-5b2549dfdf0f" alt="image 3" width="180" />
</div>

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

<div align="center">
  <img src="https://github.com/user-attachments/assets/6424c5d7-ac4b-4ee8-91c2-35725f1f0e5c" alt="image 1" width="220" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/b369089f-a4cb-450b-b0e7-dd4a0618e3c7" alt="image 2" width="220" />
</div>



<br><br>

<b>Penjelasan:</b><br>
Jika metode pembayaran yang dipilih adalah tunai, maka setelah nama pelanggan dan metode pembayaran diisi, pengguna dapat langsung menambahkan menu ke dalam ringkasan pemesanan.  
Pada ringkasan tersebut, item dapat ditambah, dikurangi, atau dihapus. Setelah transaksi disimpan, sistem akan menampilkan notifikasi bahwa transaksi telah masuk ke riwayat transaksi dan laporan penjualan.

</div>

</details>

---

<details>
<summary>📷 6. Transaksi QRIS</summary>

<br>

<div align="center">

<div align="center">
  <img src="https://github.com/user-attachments/assets/cfc15d26-ad1d-4d47-a721-ea5afe7b88e8" alt="image 1" width="160" />
  &nbsp;
  <img src="https://github.com/user-attachments/assets/7c53a68d-4db2-473c-acc7-c712bacfa6cf" alt="image 2" width="160" />
  &nbsp;
  <img src="https://github.com/user-attachments/assets/63cecc69-01c8-4db5-b96f-39d91991fb37" alt="image 3" width="160" />
  &nbsp;
  <img src="https://github.com/user-attachments/assets/3f5eca5c-ad1c-4844-a814-6a0143fe44ea" alt="image 4" width="160" />
</div>
<br><br>

<b>Penjelasan:</b><br>
Jika metode pembayaran yang dipilih adalah QRIS, maka setelah data pesanan selesai diinput, pengguna akan diarahkan ke kamera untuk mengambil foto bukti pembayaran.  
Setelah bukti pembayaran berhasil diambil, sistem akan menampilkan notifikasi bahwa transaksi telah tersimpan pada riwayat transaksi dan laporan penjualan.

</div>

</details>

---

<details>
<summary>📷 7. Transaksi Transfer</summary>

<br>

<div align="center">

<div align="center">
  <img src="https://github.com/user-attachments/assets/63403ff6-56b3-44c0-9a93-c724f7fa8048" alt="image 1" width="160" />
  &nbsp;
  <img src="https://github.com/user-attachments/assets/84b74e67-e5bd-4ebd-95f8-78ca9a680593" alt="image 2" width="160" />
  &nbsp;
  <img src="https://github.com/user-attachments/assets/5a8e9358-67ee-4446-a71e-9474647e7ba3" alt="image 3" width="160" />
  &nbsp;
  <img src="https://github.com/user-attachments/assets/1c655b65-6af8-440b-a86a-9cbe1cec7f62" alt="image 4" width="160" />
</div>

<br><br>

<b>Penjelasan:</b><br>
Jika metode pembayaran yang dipilih adalah transfer, maka alurnya serupa dengan QRIS.  
Pengguna akan diminta mengambil foto bukti pembayaran sebagai dokumentasi, kemudian transaksi akan disimpan ke dalam sistem.

</div>

</details>

---

<details>
<summary>🧾 8. Ringkasan Pesanan</summary>

<br>

<div align="center">

📸 **Letakkan screenshot ringkasan pesanan / tampilan struk di sini**

<br><br>

<b>Penjelasan:</b><br>
Bagian ini menampilkan ringkasan pemesanan yang berisi nama pelanggan, metode pembayaran, daftar menu yang dipesan, jumlah item, serta total pesanan.  
Tampilannya menyerupai struk digital, sehingga transaksi menjadi lebih mudah dibaca dan dicek kembali sebelum disimpan.

</div>

</details>

---

<details>
<summary>📦 9. Halaman Stok</summary>

<br>

<div align="center">

📸 **Letakkan screenshot halaman stok di sini**

<br><br>

<b>Penjelasan:</b><br>
Halaman stok digunakan untuk memantau persediaan produk.  
Pada halaman ini, pengguna dapat melihat semua stok, stok menipis, dan stok habis, sehingga kondisi barang dapat dipantau dengan lebih jelas.

</div>

</details>

---

<details>
<summary>🔍 10. Fitur Pencarian Produk pada Stok</summary>

<br>

<div align="center">

📸 **Letakkan screenshot fitur pencarian produk di halaman stok di sini**

<br><br>

<b>Penjelasan:</b><br>
Pada menu stok, pengguna juga dapat mencari nama produk tertentu melalui fitur pencarian.  
Fitur ini memudahkan pengguna ketika ingin menemukan produk tertentu tanpa perlu mencari secara manual dari seluruh daftar barang.

</div>

</details>

---

<details>
<summary>🔄 11. Update Stok Produk</summary>

<br>

<div align="center">

📸 **Letakkan screenshot proses update stok di sini**

<br><br>

<b>Penjelasan:</b><br>
Setiap produk pada halaman stok dapat diperbarui jumlah stoknya.  
Pengguna hanya perlu memasukkan angka stok terbaru, lalu sistem akan menyimpan perubahan tersebut.

</div>

</details>

---

<details>
<summary>🕘 12. Riwayat Transaksi Karyawan</summary>

<br>

<div align="center">

📸 **Letakkan screenshot riwayat transaksi pada akun karyawan di sini**

<br><br>

<b>Penjelasan:</b><br>
Pada akun karyawan, halaman riwayat transaksi menampilkan daftar transaksi yang sudah tersimpan.  
Tampilan ini digunakan untuk melihat data transaksi berdasarkan pencarian pelanggan, kasir, atau metode pembayaran.

</div>

</details>

---

<details>
<summary>🔎 13. Filter Riwayat Transaksi</summary>

<br>

<div align="center">

📸 **Letakkan screenshot filter waktu dan metode pembayaran di sini**

<br><br>

<b>Penjelasan:</b><br>
Riwayat transaksi dapat difilter berdasarkan periode waktu seperti semua, hari ini, minggu ini, dan bulan ini.  
Selain itu, transaksi juga dapat difilter berdasarkan metode pembayaran seperti tunai, QRIS, transfer, atau semua metode.

</div>

</details>

---

<details>
<summary>🧾 14. Tampilan Detail Riwayat seperti Struk</summary>

<br>

<div align="center">

📸 **Letakkan screenshot detail transaksi / struk digital di sini**

<br><br>

<b>Penjelasan:</b><br>
Setiap data transaksi ditampilkan dengan format yang menyerupai struk digital.  
Informasi yang dapat dilihat antara lain nama kasir, waktu transaksi, total pembayaran, metode pembayaran, dan bukti pembayaran berupa foto.

</div>

</details>

---

<details>
<summary>💰 15. Riwayat Transaksi Pemilik dengan Total Omzet</summary>

<br>

<div align="center">

📸 **Letakkan screenshot riwayat transaksi pada akun pemilik di sini**

<br><br>

<b>Penjelasan:</b><br>
Pada akun pemilik, tampilan riwayat transaksi secara umum sama seperti pada akun karyawan.  
Namun, pada halaman ini pemilik juga dapat melihat **total omzet**, sedangkan informasi tersebut tidak ditampilkan pada akun karyawan.

</div>

</details>

---

<details>
<summary>👥 16. Halaman Manajemen Karyawan</summary>

<br>

<div align="center">

📸 **Letakkan screenshot halaman manajemen karyawan di sini**

<br><br>

<b>Penjelasan:</b><br>
Halaman ini digunakan oleh pemilik untuk mengelola akun karyawan.  
Pemilik dapat menambahkan, mengubah, dan menghapus akun karyawan sesuai kebutuhan operasional usaha.

</div>

</details>

---

<details>
<summary>➕ 17. Form Tambah Karyawan</summary>

<br>

<div align="center">

📸 **Letakkan screenshot form tambah karyawan di sini**

<br><br>

<b>Penjelasan:</b><br>
Saat menambahkan akun karyawan baru, pemilik diminta mengisi nama karyawan, email, dan password.  
Form ini digunakan untuk membuat akun baru yang nantinya dapat digunakan untuk login ke dalam sistem.

</div>

</details>

---

<details>
<summary>🛍️ 18. Halaman Manajemen Produk</summary>

<br>

<div align="center">

📸 **Letakkan screenshot halaman produk di sini**

<br><br>

<b>Penjelasan:</b><br>
Halaman produk digunakan oleh pemilik untuk mengatur data produk yang dijual.  
Pada halaman ini, pemilik dapat melihat daftar menu, harga, stok, serta gambar produk yang tersedia dalam sistem.

</div>

</details>

---

<details>
<summary>➕ 19. Form Tambah Produk</summary>

<br>

<div align="center">

📸 **Letakkan screenshot form tambah produk di sini**

<br><br>

<b>Penjelasan:</b><br>
Saat menambahkan produk baru, pemilik perlu mengisi gambar produk, nama produk, harga jual, harga modal, dan stok.  
Form ini digunakan untuk menambahkan menu baru agar dapat langsung digunakan pada transaksi penjualan.

</div>

</details>

---

<details>
<summary>✏️ 20. Edit / Hapus Produk</summary>

<br>

<div align="center">

📸 **Letakkan screenshot edit produk atau hapus produk di sini**

<br><br>

<b>Penjelasan:</b><br>
Pemilik dapat memperbarui data produk yang sudah ada maupun menghapus produk yang tidak lagi dijual.  
Fitur ini membuat data produk tetap rapi, relevan, dan sesuai dengan kondisi usaha saat ini.

</div>

</details>

---

<details>
<summary>📊 21. Halaman Laporan</summary>

<br>

<div align="center">

📸 **Letakkan screenshot halaman laporan di sini**

<br><br>

<b>Penjelasan:</b><br>
Halaman laporan digunakan oleh pemilik untuk memantau performa usaha.  
Pada halaman ini, pemilik dapat melihat omzet, keuntungan bersih, total barang keluar, produk terlaris, aktivitas, dan data transaksi secara menyeluruh.

</div>

</details>

---

<details>
<summary>🏆 22. Produk Terlaris dan Rincian Barang Keluar</summary>

<br>

<div align="center">

📸 **Letakkan screenshot produk terlaris dan rincian barang keluar di sini**

<br><br>

<b>Penjelasan:</b><br>
Bagian ini menampilkan produk yang paling banyak terjual beserta jumlah penjualannya.  
Selain itu, ditampilkan juga rincian barang keluar per produk agar pemilik dapat melihat performa masing-masing produk secara lebih detail.

</div>

</details>

---

<details>
<summary>📈 23. Grafik Keuntungan Bersih Bulanan</summary>

<br>

<div align="center">

📸 **Letakkan screenshot grafik keuntungan bersih bulanan di sini**

<br><br>

<b>Penjelasan:</b><br>
Grafik ini menampilkan perkembangan keuntungan bersih bulanan berdasarkan transaksi yang tersimpan di dalam sistem.  
Dengan visualisasi ini, pemilik dapat membaca perkembangan usaha dengan lebih mudah dan lebih cepat.

</div>

</details>

---

# 🧩 Widget yang Digunakan

<details>
<summary>🛠️ Klik untuk melihat widget yang digunakan</summary>

<br>

Berikut adalah widget Flutter yang digunakan atau sangat relevan berdasarkan alur aplikasi:

## 📌 Widget Dasar
- `MaterialApp`
- `Scaffold`
- `SafeArea`
- `AppBar`

Widget dasar ini digunakan sebagai kerangka utama aplikasi.

---

## 📌 Widget Layout
- `Column`
- `Row`
- `Container`
- `Padding`
- `SizedBox`
- `Expanded`
- `Wrap`

Widget layout digunakan untuk menyusun tampilan agar rapi, proporsional, dan mudah dipahami.

---

## 📌 Widget Teks dan Informasi
- `Text`
- `Icon`
- `Card`
- `Divider`
- `Chip`
- `CircleAvatar`

Widget ini digunakan untuk menampilkan judul, label, status stok, informasi menu, dan elemen visual lainnya.

---

## 📌 Widget Form dan Input
- `Form`
- `TextField`
- `TextFormField`
- `DropdownButtonFormField`
- `ElevatedButton`
- `OutlinedButton`
- `TextEditingController`

Widget form digunakan pada login, input transaksi, update stok, tambah karyawan, dan tambah produk.

---

## 📌 Widget List dan Data
- `ListView`
- `ListView.builder`
- `SingleChildScrollView`

Widget ini digunakan untuk menampilkan daftar produk, ringkasan pesanan, stok, riwayat transaksi, dan laporan data.

---

## 📌 Widget Interaksi
- `IconButton`
- `GestureDetector`
- `InkWell`
- `FloatingActionButton`
- `PopupMenuButton`

Widget interaksi memungkinkan pengguna memilih menu, menambah item, mengurangi item, menghapus data, dan menjalankan aksi tertentu.

---

## 📌 Widget Navigasi dan State
- `Navigator.push()`
- `Navigator.pop()`
- `Drawer`
- `StatefulWidget`
- `StatelessWidget`
- `setState()`

Widget dan konsep ini digunakan untuk perpindahan halaman serta pembaruan tampilan secara dinamis.

---

## 📌 Widget Notifikasi dan Feedback
- `SnackBar`
- `AlertDialog`
- `CircularProgressIndicator`

Widget ini digunakan untuk menampilkan notifikasi transaksi berhasil, konfirmasi tindakan, dan proses loading.

---

## 📌 Widget Media
- `Image`
- `Image.network`
- `Image.file`
- `CameraPreview`

Widget media digunakan untuk gambar produk dan pengambilan bukti pembayaran melalui kamera.

---

## 📌 Widget Visualisasi Data
- `LineChart`
- `BarChart`

Widget ini digunakan pada halaman laporan untuk menampilkan grafik keuntungan dan data penjualan.

</details>

---

# 🧱 Struktur Halaman Aplikasi

```bash
lib/
│
├── pages/
│   ├── login_page.dart
│   ├── employee_home_page.dart
│   ├── owner_home_page.dart
│   ├── cashier_page.dart
│   ├── stock_management_page.dart
│   ├── transaction_history_page.dart
│   ├── employee_management_page.dart
│   ├── product_management_page.dart
│   ├── report_page.dart
│   └── camera_capture_page.dart
│
├── models/
│   ├── product_model.dart
│   ├── transaction_model.dart
│   ├── user_model.dart
│   └── order_item_model.dart
│
└── services/
    ├── auth_service.dart
    ├── product_service.dart
    ├── stock_service.dart
    ├── transaction_service.dart
    ├── employee_service.dart
    └── report_service.dart
```

> **Catatan:**  
> Struktur ini merupakan gambaran logis dari fitur aplikasi. Jika struktur project asli kalian berbeda, bagian ini bisa disesuaikan lagi dengan folder yang sebenarnya.

---

# ⚙️ Teknologi dan Package yang Digunakan

Aplikasi ini dikembangkan menggunakan beberapa teknologi berikut:

- **Flutter** → framework utama untuk membangun aplikasi mobile  
- **Dart** → bahasa pemrograman utama  
- **Supabase** → database dan layanan backend  
- **Camera** → untuk pengambilan bukti pembayaran  
- **fl_chart** → untuk visualisasi laporan penjualan  
- **Shared Preferences** → untuk penyimpanan sesi login  
- **HTTP / API Service** → untuk komunikasi data  

Kombinasi teknologi ini membuat aplikasi tidak hanya memiliki tampilan yang baik, tetapi juga mendukung proses pengolahan data usaha secara nyata.

---

# 📦 Contoh Dependency yang Dapat Dicantumkan

```yaml
dependencies:
  flutter:
    sdk: flutter
  supabase_flutter: ^latest_version
  camera: ^latest_version
  image_picker: ^latest_version
  fl_chart: ^latest_version
  shared_preferences: ^latest_version
```

> **Catatan:**  
> Bagian dependency ini dapat disesuaikan lagi dengan isi `pubspec.yaml` project asli kalian.

---

# 📲 Cara Menggunakan Aplikasi

<details>
<summary>✨ Klik untuk melihat langkah penggunaan</summary>

<br>

## Jika Login sebagai Karyawan
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

## Jika Login sebagai Pemilik
1. Buka aplikasi  
2. Login menggunakan akun pemilik  
3. Gunakan menu **Kasir**, **Stok**, **Riwayat Transaksi**, **Karyawan**, **Produk**, atau **Laporan**  
4. Kelola data sesuai kebutuhan usaha  
5. Cek laporan untuk memantau omzet, keuntungan, dan aktivitas penjualan  

</details>

---

# ✅ Kelebihan Aplikasi

Beberapa kelebihan dari aplikasi **Mama Piya Kasir** antara lain:

- memiliki pembagian role yang jelas antara karyawan dan pemilik,
- mendukung transaksi tunai maupun non-tunai,
- menyediakan bukti pembayaran melalui kamera,
- memiliki ringkasan transaksi yang rapi seperti struk digital,
- mendukung pencarian dan filter riwayat transaksi,
- mempermudah pengelolaan stok,
- mendukung manajemen produk dan manajemen karyawan,
- serta menyediakan laporan usaha yang lengkap dan informatif.

---

# 📌 Kesimpulan

Melalui project **Mama Piya Kasir**, kami mempelajari bahwa aplikasi mobile berbasis Flutter dapat digunakan untuk membangun sistem usaha yang cukup lengkap, tidak hanya dari sisi tampilan, tetapi juga dari sisi proses bisnis yang nyata.

Project ini memberikan pengalaman dalam:
- membangun sistem login berbasis role,
- membuat alur transaksi dengan beberapa metode pembayaran,
- menyimpan bukti pembayaran menggunakan kamera,
- mengelola stok dan produk,
- mengelola akun karyawan,
- menyusun riwayat transaksi yang dapat dicari dan difilter,
- serta menampilkan laporan usaha dalam bentuk data dan grafik.

Secara keseluruhan, aplikasi ini menjadi bentuk penerapan pembelajaran Flutter yang terintegrasi, karena menggabungkan antarmuka, manajemen data, alur transaksi, dan fitur laporan ke dalam satu sistem yang saling terhubung.

---

<div align="center">

## ✨ Terima Kasih ✨

Terima kasih telah membaca dokumentasi project kami.  
Semoga aplikasi **Mama Piya Kasir** ini dapat menjadi project yang bermanfaat, menarik, dan dapat terus dikembangkan menjadi sistem yang lebih lengkap di masa mendatang.

**Mama Piya Kasir 💙**  
**Proyek Akhir PAB Kelompok**

</div>
