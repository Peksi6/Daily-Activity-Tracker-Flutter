# Daily Activity Tracker — UTS Pemrograman Mobile

Aplikasi Flutter/Dart dengan **tiga halaman berbeda**:

1. `lib/views/home_view.dart` — daftar aktivitas, counter, tombol tambah dan edit.
2. `lib/views/activity_form_view.dart` — halaman tambah/edit dengan `TextFormField`, validasi, tombol Simpan.
3. `lib/views/activity_detail_view.dart` — detail counter (+/-), reset dan hapus dengan konfirmasi.

## Arsitektur

- `lib/models/activity_model.dart`: model ID, nama, counter.
- `lib/data/activity_data.dart`: penyimpanan sementara dalam `List`.
- `lib/repositories/activity_repository.dart`: operasi baca/tambah/edit/hapus.
- `lib/viewmodels/activity_viewmodel.dart`: logika, `ChangeNotifier`, `notifyListeners`.
- `lib/views/`: tiga halaman UI; navigasi dengan `Navigator.push`.
- `lib/main.dart`: entry point dan konfigurasi tema.

**Data tidak permanen**: ketika aplikasi ditutup/restart, data kembali ke data awal. Tidak memakai database atau API.

## Jalankan di Windows (CMD)

Masuk ke folder `daily_activity_tracker` yang berisi `pubspec.yaml`:

```cmd
flutter create --platforms=android,web .
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

**Penting:** File `test/widget_test.dart` sudah disediakan dan memanggil `DailyActivityApp`, bukan `MyApp`. Jika Flutter membuat test bawaan baru, gunakan file dari ZIP ini.

## Uji manual tiga halaman

1. Di Home, tekan **Tambah Aktivitas** untuk membuka halaman Form; isi nama lalu Simpan.
2. Tekan salah satu aktivitas di Home untuk membuka halaman Detail; coba tombol +, -, Reset, dan Hapus.
3. Tekan ikon edit di Home atau Detail untuk membuka Form dalam mode Edit.
4. Periksa SnackBar, AlertDialog, dan pembaruan counter di Home.

## Pengumpulan

Buat screenshot Home, Tambah/Edit, Detail; rekam video demo 2–3 menit; unggah ZIP, screenshot, dan video ke GitHub lalu kirim tautannya sesuai petunjuk dosen.
