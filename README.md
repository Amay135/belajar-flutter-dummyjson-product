# 📱 Aplikasi Katalog Produk Flutter

Halo! 👋 Selamat datang di repository ini. 

Ini adalah aplikasi mobile sederhana yang dibuat menggunakan **Flutter**. Aplikasi ini berfungsi untuk menampilkan daftar produk layaknya sebuah toko online. Datanya tidak diketik manual, melainkan diambil secara langsung dari internet menggunakan REST API dari [DummyJSON](https://dummyjson.com/).

Proyek ini saya buat sebagai bagian dari proses belajar *coding* dan tugas kuliah. Sangat cocok buat kamu yang juga sedang belajar tentang cara menghubungkan Flutter dengan internet!

## ✨ Fitur Aplikasi

* **Tampil Daftar Produk:** Menampilkan barang-barang beserta gambar, nama, harga, dan rating.
* **Detail Produk:** Bisa di-klik untuk melihat detail produk yang dipilih (gambar lebih besar, dsb).
* **Loading & Error State:** Ada animasi *loading* (muter-muter) saat data sedang dimuat, dan pesan *error* lengkap dengan tombol "Retry" kalau koneksi internet gagal.

## 🛠️ Teknologi yang Digunakan

Aplikasi ini dibangun menggunakan beberapa ilmu dan *package* dasar Flutter:
* **[Flutter & Dart](https://flutter.dev/):** Pondasi utama untuk membuat tampilan aplikasinya.
* **[http](https://pub.dev/packages/http):** Digunakan untuk mengambil data dari internet (API HTTP Request).
* **[provider](https://pub.dev/packages/provider):** Digunakan untuk mengatur lalu lintas data di dalam aplikasi (*State Management*), supaya kodingan lebih rapi dan layar otomatis *update* saat data berubah.

## 🚀 Cara Menjalankan Aplikasi

Kalau kamu mau mencoba menjalankan kode ini di laptop kamu, ikuti langkah-langkah berikut:

1.  **Pastikan Flutter sudah ter-install:** Kalau belum, bisa ikuti panduannya di [website resmi Flutter](https://docs.flutter.dev/get-started/install).
2.  **Clone repository ini:**
    Buka terminal/CMD dan ketik:
    ```bash
    git clone https://github.com/Amay135/belajar-flutter-dummyjson-product.git
    ```
    *(Jangan lupa ganti URL di atas dengan link repo GitHub kamu ya!)*
3.  **Masuk ke folder proyek:**
    ```bash
    cd NAMA_REPO_KAMU
    ```
4.  **Download semua *package* yang dibutuhkan:**
    ```bash
    flutter pub get
    ```
5.  **Jalankan aplikasinya:**
    Kamu bisa jalankan di emulator Android/iOS atau langsung di HP kamu.
    ```bash
    flutter run
    ```

## 📚 Catatan Belajar

Kodingan ini membagi struktur menjadi beberapa bagian penting supaya gampang dibaca:
* `Data Models`: Menerjemahkan data mentah dari internet (JSON) menjadi objek yang dikenali oleh Dart.
* `API Services`: Bagian khusus yang bertugas "mengetuk pintu" server internet untuk minta data.
* `Providers`: Pengatur logika dan jembatan antara layar tampilan (UI) dengan data dari API.
* `Screens/UI`: Tampilan yang dilihat langsung oleh pengguna di layar HP.

---
*Dibuat dengan semangat belajar 💻☕*
