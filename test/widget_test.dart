import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:daily_activity_tracker/main.dart';

void main() {
  testWidgets(
    'Home menampilkan daftar dan navigasi ke form dan detail',
    (WidgetTester tester) async {
      // 1. Menjalankan aplikasi
      await tester.pumpWidget(const DailyActivityApp());
      await tester.pumpAndSettle();

      // 2. Memastikan halaman Home tampil
      expect(find.text('Daftar Aktivitas'), findsOneWidget);
      expect(find.text('Olahraga Pagi'), findsOneWidget);

      // 3. Membuka halaman Tambah Aktivitas
      await tester.tap(find.text('Tambah Aktivitas'));
      await tester.pumpAndSettle();

      // 4. Memastikan form aktivitas tampil
      expect(find.text('Nama Aktivitas'), findsOneWidget);

      // 5. Mengisi nama aktivitas
      await tester.enterText(
        find.byType(TextFormField),
        'Belajar Flutter',
      );

      // 6. Menyimpan aktivitas
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      // 7. Memastikan aktivitas berhasil ditambahkan
      final aktivitas = find.text('Belajar Flutter');

      expect(aktivitas, findsOneWidget);

      // 8. Menunggu SnackBar menghilang
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      // 9. Memastikan aktivitas terlihat di layar
      await tester.ensureVisible(aktivitas);
      await tester.pumpAndSettle();

      // 10. Membuka halaman Detail Aktivitas
      await tester.tap(aktivitas);
      await tester.pumpAndSettle();

      // 11. Memastikan halaman Detail tampil
      expect(
        find.text('Detail Aktivitas'),
        findsOneWidget,
      );

      // 12. Memastikan tombol Reset tersedia
      expect(
        find.text('Reset Counter'),
        findsOneWidget,
      );

      // 13. Memastikan tombol Hapus tersedia
      expect(
        find.text('Hapus Aktivitas'),
        findsOneWidget,
      );
    },
  );
}
