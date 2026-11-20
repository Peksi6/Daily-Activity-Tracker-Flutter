import '../data/activity_data.dart';
import '../models/activity_model.dart';

class ActivityRepository {
  final ActivityData _data;
  ActivityRepository(this._data);

  List<ActivityModel> getAll() => List.unmodifiable(_data.activities);

  ActivityModel? findById(int id) {
    for (final activity in _data.activities) {
      if (activity.id == id) return activity;
    }
    return null;
  }

  void add(ActivityModel activity) => _data.activities.add(activity);

  bool update(ActivityModel activity) {
    final index = _data.activities.indexWhere((item) => item.id == activity.id);
    if (index == -1) return false;
    _data.activities[index] = activity;
    return true;
  }

  bool delete(int id) {
    final before = _data.activities.length;
    _data.activities.removeWhere((item) => item.id == id);
    return _data.activities.length < before;
  }
}
