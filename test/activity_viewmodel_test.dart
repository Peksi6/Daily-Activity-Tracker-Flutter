import 'package:flutter_test/flutter_test.dart';
import 'package:daily_activity_tracker/data/activity_data.dart';
import 'package:daily_activity_tracker/repositories/activity_repository.dart';
import 'package:daily_activity_tracker/viewmodels/activity_viewmodel.dart';

void main() {
  late ActivityViewModel vm;
  setUp(() => vm = ActivityViewModel(ActivityRepository(ActivityData())));
  tearDown(() => vm.dispose());

  test('Tambah, edit, hapus, validasi input', () {
    expect(vm.addActivity('  '), false);
    expect(vm.addActivity('Belajar Flutter'), true);
    final id = vm.activities.last.id;
    expect(vm.renameActivity(id, 'Belajar Dart'), true);
    expect(vm.findById(id)?.name, 'Belajar Dart');
    expect(vm.deleteActivity(id), true);
    expect(vm.findById(id), isNull);
  });

  test('Counter tidak boleh negatif dan dapat direset', () {
    expect(vm.addActivity('Tes'), true);
    final id = vm.activities.last.id;
    expect(vm.decrement(id), false);
    expect(vm.increment(id), true);
    expect(vm.findById(id)?.counter, 1);
    expect(vm.decrement(id), true);
    expect(vm.findById(id)?.counter, 0);
    expect(vm.increment(id), true);
    expect(vm.reset(id), true);
    expect(vm.findById(id)?.counter, 0);
  });
}
