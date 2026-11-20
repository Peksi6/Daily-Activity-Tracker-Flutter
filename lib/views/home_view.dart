import 'package:flutter/material.dart';
import '../viewmodels/activity_viewmodel.dart';
import 'activity_form_view.dart';
import 'activity_detail_view.dart';

class HomeView extends StatelessWidget {
  final ActivityViewModel viewModel;

  const HomeView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F0D5),

      appBar: AppBar(
        title: const Text(
          'Daily Activity Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF253D1D),
          ),
        ),
        backgroundColor: const Color(0xFFE0F0D5),
        foregroundColor: const Color(0xFF253D1D),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, _) {
          final activities = viewModel.activities;

          final total = activities.fold<int>(
            0,
            (sum, activity) => sum + activity.counter,
          );

          return Column(
            children: [
              // Banner ringkasan aktivitas
              Container(
                margin: const EdgeInsets.fromLTRB(
                  18,
                  12,
                  18,
                  18,
                ),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF9AC47C),
                      Color(0xFF72A24E),
                      Color(0xFF54862D),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aktivitas Hari Ini',
                            style: TextStyle(
                              color: Color(0xFF253D1D),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Terus tingkatkan produktivitasmu!',
                            style: TextStyle(
                              color: Color(0xFF253D1D),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      children: [
                        Text(
                          '$total',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Total Counter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Judul daftar aktivitas
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Daftar Aktivitas',
                        style: TextStyle(
                          color: Color(0xFF253D1D),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${activities.length} aktivitas',
                      style: const TextStyle(
                        color: Color(0xFF54862D),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Daftar aktivitas
              Expanded(
                child: activities.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada aktivitas. Tekan + untuk menambahkan.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF506B43),
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        itemCount: activities.length,
                        itemBuilder: (context, index) {
                          final activity = activities[index];

                          return Card(
                            color: const Color(0xFFF7FBF3),
                            elevation: 0,
                            margin: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                color: Color(0xFFC5E3AF),
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 9,
                              ),

                              // Ikon aktivitas
                              leading: const CircleAvatar(
                                backgroundColor: Color(0xFFC5E3AF),
                                child: Icon(
                                  Icons.task_alt,
                                  color: Color(0xFF54862D),
                                ),
                              ),

                              // Nama aktivitas
                              title: Text(
                                activity.name,
                                style: const TextStyle(
                                  color: Color(0xFF253D1D),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),

                              // Nilai counter
                              subtitle: Text(
                                'Counter: ${activity.counter}',
                                style: const TextStyle(
                                  color: Color(0xFF648257),
                                  fontSize: 14,
                                ),
                              ),

                              // Tombol edit aktivitas
                              trailing: IconButton(
                                tooltip: 'Edit aktivitas',
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  color: Color(0xFF54862D),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ActivityFormView(
                                        viewModel: viewModel,
                                        activityId: activity.id,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // Navigasi ke halaman detail
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ActivityDetailView(
                                      viewModel: viewModel,
                                      activityId: activity.id,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),

      // Tombol tambah aktivitas
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFC5E3AF),
        foregroundColor: const Color(0xFF253D1D),
        elevation: 2,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ActivityFormView(
                viewModel: viewModel,
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'Tambah Aktivitas',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
