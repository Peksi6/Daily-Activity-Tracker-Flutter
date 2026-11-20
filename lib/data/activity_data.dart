import '../models/activity_model.dart';

class ActivityData {
  final List<ActivityModel> activities = [
    const ActivityModel(id: 1, name: 'Olahraga Pagi', counter: 3),
    const ActivityModel(id: 2, name: 'Membaca Buku', counter: 5),
    const ActivityModel(id: 3, name: 'Mengerjakan Tugas', counter: 2),
  ];
}
