import 'package:flutter/foundation.dart';
import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _repository;
  ActivityViewModel(this._repository);

  List<ActivityModel> get activities => _repository.getAll();
  ActivityModel? findById(int id) => _repository.findById(id);

  bool addActivity(String name) {
    final cleaned = name.trim();
    if (cleaned.isEmpty) return false;
    final nextId = activities.fold<int>(0, (maxId, item) => item.id > maxId ? item.id : maxId) + 1;
    _repository.add(ActivityModel(id: nextId, name: cleaned));
    notifyListeners();
    return true;
  }

  bool renameActivity(int id, String name) {
    final cleaned = name.trim();
    final old = findById(id);
    if (cleaned.isEmpty || old == null) return false;
    _repository.update(old.copyWith(name: cleaned));
    notifyListeners();
    return true;
  }

  bool deleteActivity(int id) {
    final deleted = _repository.delete(id);
    if (deleted) notifyListeners();
    return deleted;
  }

  bool increment(int id) => _setCounter(id, (findById(id)?.counter ?? 0) + 1);

  bool decrement(int id) {
    final old = findById(id);
    if (old == null || old.counter == 0) return false;
    return _setCounter(id, old.counter - 1);
  }

  bool reset(int id) => _setCounter(id, 0);

  bool _setCounter(int id, int value) {
    final old = findById(id);
    if (old == null || value < 0) return false;
    _repository.update(old.copyWith(counter: value));
    notifyListeners();
    return true;
  }
}
