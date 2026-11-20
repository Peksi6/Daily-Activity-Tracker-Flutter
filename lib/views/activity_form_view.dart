import 'package:flutter/material.dart';
import '../viewmodels/activity_viewmodel.dart';

class ActivityFormView extends StatefulWidget {
  final ActivityViewModel viewModel;
  final int? activityId;
  const ActivityFormView({super.key, required this.viewModel, this.activityId});

  @override
  State<ActivityFormView> createState() => _ActivityFormViewState();
}

class _ActivityFormViewState extends State<ActivityFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.activityId == null ? '' : widget.viewModel.findById(widget.activityId!)?.name ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final editing = widget.activityId != null;
    final success = editing
        ? widget.viewModel.renameActivity(widget.activityId!, _controller.text)
        : widget.viewModel.addActivity(_controller.text);
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal menyimpan aktivitas.')));
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger.showSnackBar(SnackBar(
      content: Text(editing ? 'Aktivitas berhasil diperbarui' : 'Aktivitas berhasil ditambahkan'),
    ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.activityId == null ? 'Tambah Aktivitas' : 'Edit Aktivitas')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Icon(Icons.edit_note, size: 72, color: Color(0xFFBCA8FF)),
            const SizedBox(height: 18),
            const Text('Nama Aktivitas', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            TextFormField(
              controller: _controller,
              autofocus: true,
              maxLength: 60,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(hintText: 'Contoh: Membaca buku', prefixIcon: Icon(Icons.task_alt)),
              validator: (value) => value == null || value.trim().isEmpty ? 'Nama aktivitas tidak boleh kosong' : null,
              onFieldSubmitted: (_) => _save(),
            ),
            const SizedBox(height: 22),
            ElevatedButton.icon(onPressed: _save, icon: const Icon(Icons.save_outlined), label: const Text('Simpan'), style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(17))),
          ])),
        ),
      );
}
