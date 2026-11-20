import 'package:flutter/material.dart';
import '../viewmodels/activity_viewmodel.dart';
import 'activity_form_view.dart';

class ActivityDetailView extends StatelessWidget {
  final ActivityViewModel viewModel;
  final int activityId;

  const ActivityDetailView({
    super.key,
    required this.viewModel,
    required this.activityId,
  });

  // Menampilkan SnackBar
  void _message(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Dialog konfirmasi
  Future<bool> _confirm(
    BuildContext context,
    String title,
    String message,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Ya, Lanjutkan'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Aktivitas'),
        actions: [
          IconButton(
            tooltip: 'Edit nama aktivitas',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ActivityFormView(
                    viewModel: viewModel,
                    activityId: activityId,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      // Memperbarui tampilan ketika data berubah
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, _) {
          final activity = viewModel.findById(activityId);

          if (activity == null) {
            return const Center(
              child: Text('Aktivitas tidak ditemukan'),
            );
          }

          // Memungkinkan halaman digulir
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),

                    // Ikon aktivitas
                    const Icon(
                      Icons.track_changes,
                      color: Color(0xFFBCA8FF),
                      size: 75,
                    ),

                    const SizedBox(height: 16),

                    // Nama aktivitas
                    Text(
                      activity.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Kotak nilai counter
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF242239),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Nilai Counter',
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Menampilkan nilai counter
                          Text(
                            '${activity.counter}',
                            style: const TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFBCA8FF),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Tombol tambah dan kurang
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Tombol kurang (-)
                              IconButton.filledTonal(
                                tooltip: 'Kurangi counter',
                                onPressed: activity.counter == 0
                                    ? null
                                    : () {
                                        if (viewModel.decrement(
                                          activityId,
                                        )) {
                                          final updated = viewModel.findById(
                                            activityId,
                                          );

                                          if (updated != null) {
                                            _message(
                                              context,
                                              'Counter berkurang menjadi ${updated.counter}',
                                            );
                                          }
                                        }
                                      },
                                icon: const Icon(Icons.remove),
                                iconSize: 32,
                              ),

                              const SizedBox(width: 32),

                              // Tombol tambah (+)
                              IconButton.filled(
                                tooltip: 'Tambah counter',
                                onPressed: () {
                                  if (viewModel.increment(
                                    activityId,
                                  )) {
                                    final updated = viewModel.findById(
                                      activityId,
                                    );

                                    if (updated != null) {
                                      _message(
                                        context,
                                        'Counter bertambah menjadi ${updated.counter}',
                                      );
                                    }
                                  }
                                },
                                icon: const Icon(Icons.add),
                                iconSize: 32,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 26),

                    // Tombol Reset Counter
                    ElevatedButton.icon(
                      onPressed: () async {
                        final approved = await _confirm(
                          context,
                          'Reset Counter?',
                          'Nilai counter akan dikembalikan ke 0.',
                        );

                        if (!context.mounted || !approved) {
                          return;
                        }

                        if (viewModel.reset(activityId)) {
                          _message(
                            context,
                            'Counter berhasil di-reset ke 0',
                          );
                        }
                      },
import 'package:flutter/material.dart';
import '../viewmodels/activity_viewmodel.dart';
import 'activity_form_view.dart';

class ActivityDetailView extends StatelessWidget {
  final ActivityViewModel viewModel;
  final int activityId;

  const ActivityDetailView({
    super.key,
    required this.viewModel,
    required this.activityId,
  });

  // Menampilkan SnackBar
  void _message(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Dialog konfirmasi
  Future<bool> _confirm(
    BuildContext context,
    String title,
    String message,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(dialogContext, true),
            child: const Text('Ya, Lanjutkan'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F0D5),

      appBar: AppBar(
        title: const Text('Detail Aktivitas'),
        backgroundColor: const Color(0xFFE0F0D5),
        foregroundColor: const Color(0xFF253D1D),
        actions: [
          IconButton(
            tooltip: 'Edit nama aktivitas',
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
                    activityId: activityId,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      // Memperbarui tampilan ketika data berubah
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, _) {
          final activity = viewModel.findById(activityId);

          if (activity == null) {
            return const Center(
              child: Text('Aktivitas tidak ditemukan'),
            );
          }

          // Scroll agar tidak terjadi overflow
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),

                    // Ikon aktivitas
                    const Icon(
                      Icons.track_changes,
                      color: Color(0xFF54862D),
                      size: 75,
                    ),

                    const SizedBox(height: 16),

                    // Nama aktivitas
                    Text(
                      activity.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF253D1D),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Kotak nilai counter hijau pastel
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC5E3AF),
                        borderRadius:
                            BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFF9AC47C),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Nilai Counter',
                            style: TextStyle(
                              color: Color(0xFF506B43),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Menampilkan nilai counter
                          Text(
                            '${activity.counter}',
                            style: const TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF253D1D),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Tombol tambah dan kurang
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              // Tombol kurang (-)
                              IconButton(
                                tooltip: 'Kurangi counter',
                                onPressed:
                                    activity.counter == 0
                                        ? null
                                        : () {
                                            if (viewModel
                                                .decrement(
                                              activityId,
                                            )) {
                                              final updated =
                                                  viewModel
                                                      .findById(
                                                activityId,
                                              );

                                              if (updated !=
                                                  null) {
                                                _message(
                                                  context,
                                                  'Counter berkurang menjadi ${updated.counter}',
                                                );
                                              }
                                            }
                                          },
                                icon: const Icon(
                                  Icons.remove,
                                  size: 32,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor:
                                      const Color(
                                    0xFFE0F0D5,
                                  ),
                                  foregroundColor:
                                      const Color(
                                    0xFF54862D,
                                  ),
                                  disabledBackgroundColor:
                                      const Color(
                                    0xFFE0F0D5,
                                  ),
                                  disabledForegroundColor:
                                      const Color(
                                    0xFF9AC47C,
                                  ),
                                  minimumSize:
                                      const Size(60, 60),
                                ),
                              ),

                              const SizedBox(width: 32),

                              // Tombol tambah (+)
                              IconButton(
                                tooltip: 'Tambah counter',
                                onPressed: () {
                                  if (viewModel.increment(
                                    activityId,
                                  )) {
                                    final updated =
                                        viewModel.findById(
                                      activityId,
                                    );

                                    if (updated != null) {
                                      _message(
                                        context,
                                        'Counter bertambah menjadi ${updated.counter}',
                                      );
                                    }
                                  }
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 32,
                                  color: Colors.white,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor:
                                      const Color(
                                    0xFF54862D,
                                  ),
                                  foregroundColor:
                                      Colors.white,
                                  minimumSize:
                                      const Size(60, 60),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 26),

                    // Tombol Reset Counter
                    ElevatedButton.icon(
                      onPressed: () async {
                        final approved = await _confirm(
                          context,
                          'Reset Counter?',
                          'Nilai counter akan dikembalikan ke 0.',
                        );

                        if (!context.mounted || !approved) {
                          return;
                        }

                        if (viewModel.reset(activityId)) {
                          _message(
                            context,
                            'Counter berhasil di-reset ke 0',
                          );
                        }
                      },
                      icon: const Icon(Icons.restart_alt),
                      label: const Text('Reset Counter'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF9AC47C),
                        foregroundColor:
                            const Color(0xFF253D1D),
                        padding:
                            const EdgeInsets.all(16),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Tombol Hapus Aktivitas
                    OutlinedButton.icon(
                      onPressed: () async {
                        final approved = await _confirm(
                          context,
                          'Hapus Aktivitas?',
                          'Aktivitas "${activity.name}" akan dihapus dari daftar.',
                        );

                        if (!context.mounted || !approved) {
                          return;
                        }

                        if (viewModel.deleteActivity(
                          activityId,
                        )) {
                          final messenger =
                              ScaffoldMessenger.of(
                            context,
                          );

                          messenger.hideCurrentSnackBar();

                          Navigator.pop(context);

                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Aktivitas berhasil dihapus',
                              ),
                              duration:
                                  Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                      ),
                      label: const Text('Hapus Aktivitas'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        side: const BorderSide(
                          color: Color(0xFF9AC47C),
                        ),
                        padding:
                            const EdgeInsets.all(16),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

                      icon: const Icon(Icons.restart_alt),
                      label: const Text('Reset Counter'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Tombol Hapus Aktivitas
                    OutlinedButton.icon(
                      onPressed: () async {
                        final approved = await _confirm(
                          context,
                          'Hapus Aktivitas?',
                          'Aktivitas "${activity.name}" akan dihapus dari daftar.',
                        );

                        if (!context.mounted || !approved) {
                          return;
                        }

                        if (viewModel.deleteActivity(
                          activityId,
                        )) {
                          final messenger = ScaffoldMessenger.of(
                            context,
                          );

                          messenger.hideCurrentSnackBar();

                          Navigator.pop(context);

                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Aktivitas berhasil dihapus',
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Hapus Aktivitas'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        padding: const EdgeInsets.all(16),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
