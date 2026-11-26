import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'data/db_repository.dart';

// ---------- Tiêm Database Repository ----------
final repositoryProvider = Provider<DBRepository>(
  (ref) => throw UnimplementedError('Phải override trong main()'),
);

final bookmarksProvider = StreamProvider<List<Bookmark>>(
  (ref) => ref.watch(repositoryProvider).watchBookmarks(),
);

final ingredientsProvider = StreamProvider<List<Ingredient>>(
  (ref) => ref.watch(repositoryProvider).watchIngredients(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = DBRepository();
  await repository.init();
  runApp(
    ProviderScope(
      overrides: [repositoryProvider.overrideWith((ref) => repository)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Saving Data Locally',
        theme: ThemeData(colorSchemeSeed: Colors.deepOrange, useMaterial3: true),
        home: const HomePage(),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Demo: Saving Data Locally'),
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.bookmark), text: 'Bookmark'),
              Tab(icon: Icon(Icons.shopping_cart), text: 'Mua sắm'),
            ]),
          ),
          body: const Column(
            children: [
              _Hint(),
              Expanded(
                child: TabBarView(children: [BookmarksTab(), ShoppingTab()]),
              ),
            ],
          ),
        ),
      );
}

class _Hint extends StatelessWidget {
  const _Hint();
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        color: Colors.amber.shade100,
        padding: const EdgeInsets.all(8),
        child: const Text(
          'Thử: lưu dữ liệu → tắt hẳn app → mở lại. Dữ liệu vẫn còn!',
          textAlign: TextAlign.center,
        ),
      );
}

String categoryLabel(BookmarkCategory c) => switch (c) {
      BookmarkCategory.food => 'Ăn uống',
      BookmarkCategory.travel => 'Du lịch',
      BookmarkCategory.study => 'Học tập',
      BookmarkCategory.other => 'Khác',
    };

// =====================================================================
// TAB 1: BOOKMARK (tự nhập, nhiều kiểu dữ liệu, không cho trùng)
// =====================================================================
class BookmarksTab extends ConsumerWidget {
  const BookmarksTab({super.key});

  Future<void> _openAddForm(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(repositoryProvider);
    final messenger = ScaffoldMessenger.of(context);

    final draft = await showModalBottomSheet<Bookmark>(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 640),
      builder: (_) => const BookmarkForm(),
    );
    if (draft == null) return;

    try {
      final isNew = await repo.addBookmark(draft);
      messenger.clearSnackBars();
      messenger.showSnackBar(SnackBar(
        content: Text(isNew
            ? 'Đã lưu bookmark "${draft.title}"'
            : 'Bookmark "${draft.title}" đã được lưu rồi'),
      ));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('Lỗi lưu DB: $e')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddForm(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Thêm bookmark'),
      ),
      body: bookmarks.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
        data: (list) => list.isEmpty
            ? const Center(child: Text('Chưa có bookmark. Bấm "Thêm bookmark"!'))
            : ListView.separated(
                padding: const EdgeInsets.only(bottom: 88),
                itemCount: list.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, i) => _BookmarkTile(bookmark: list[i]),
              ),
      ),
    );
  }
}

class _BookmarkTile extends ConsumerWidget {
  const _BookmarkTile({required this.bookmark});
  final Bookmark bookmark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = bookmark;
    final repo = ref.read(repositoryProvider);

    final info = <String>[
      if (b.category != null) categoryLabel(b.category!),
      if (b.rating != null) '★ ${b.rating}/5',
      if (b.price != null) '${NumberFormat.decimalPattern().format(b.price)} đ',
      if (b.savedDate != null) DateFormat('dd/MM/yyyy').format(b.savedDate!),
    ];

    final hasImage = b.imagePath != null && File(b.imagePath!).existsSync();

    return ListTile(
      isThreeLine: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 56,
          height: 56,
          child: hasImage
              ? Image.file(File(b.imagePath!), fit: BoxFit.cover)
              : const ColoredBox(
                  color: Color(0x22000000), child: Icon(Icons.image_outlined)),
        ),
      ),
      title: Text(b.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (b.note != null && b.note!.isNotEmpty)
            Text(b.note!, maxLines: 2, overflow: TextOverflow.ellipsis),
          if (info.isNotEmpty) Text(info.join(' • ')),
          if (b.tags.isNotEmpty) Text(b.tags.map((t) => '#$t').join(' ')),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Yêu thích',
            icon: Icon(b.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: b.isFavorite ? Colors.red : null),
            onPressed: () => repo.setFavorite(b, !b.isFavorite),
          ),
          IconButton(
            tooltip: 'Xóa',
            icon: const Icon(Icons.delete_outline),
            onPressed: () => repo.removeBookmark(b),
          ),
        ],
      ),
    );
  }
}

// ---------- Form thêm bookmark ----------
class BookmarkForm extends StatefulWidget {
  const BookmarkForm({super.key});
  @override
  State<BookmarkForm> createState() => _BookmarkFormState();
}

class _BookmarkFormState extends State<BookmarkForm> {
  final _titleCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  final _ratingCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _tagsCtrl = TextEditingController();

  DateTime? _savedDate;
  BookmarkCategory? _category;
  bool _isFavorite = false;
  String? _imagePath; // đường dẫn ảnh vừa chọn (chưa copy)
  String? _error;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    final path = result?.files.single.path;
    if (path != null) setState(() => _imagePath = path);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _savedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _savedDate = picked);
  }

  void _submit() {
    final title = _titleCtrl.text.trim();
    if (title.isEmpty) {
      setState(() => _error = 'Vui lòng nhập tiêu đề');
      return;
    }
    final rating = int.tryParse(_ratingCtrl.text.trim());
    if (rating != null && (rating < 1 || rating > 5)) {
      setState(() => _error = 'Đánh giá phải từ 1 đến 5');
      return;
    }
    Navigator.pop(
      context,
      Bookmark(
        title: title,
        note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
        rating: rating,
        price: double.tryParse(_priceCtrl.text.trim().replaceAll(',', '.')),
        isFavorite: _isFavorite,
        savedDate: _savedDate,
        category: _category,
        tags: _tagsCtrl.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        imagePath: _imagePath,
      ),
    );
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _noteCtrl.dispose();
    _ratingCtrl.dispose();
    _priceCtrl.dispose();
    _tagsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = _imagePath != null;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Thêm bookmark', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: hasImage
                        ? Image.file(File(_imagePath!), fit: BoxFit.cover)
                        : const ColoredBox(
                            color: Color(0x22000000),
                            child: Icon(Icons.add_a_photo, size: 32)),
                  ),
                ),
              ),
            ),
            const Center(child: Text('Ảnh (lưu đường dẫn)')),
            const SizedBox(height: 12),
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                  labelText: 'Tiêu đề (String) *', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                  labelText: 'Ghi chú (String)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: TextField(
                  controller: _ratingCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Đánh giá 1-5 (int)',
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _priceCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      labelText: 'Giá tiền (double)',
                      border: OutlineInputBorder()),
                ),
              ),
            ]),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.event),
              label: Text(_savedDate == null
                  ? 'Chọn ngày (DateTime)'
                  : 'Ngày: ${DateFormat('dd/MM/yyyy').format(_savedDate!)}'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<BookmarkCategory>(
              value: _category,
              decoration: const InputDecoration(
                  labelText: 'Danh mục (enum)', border: OutlineInputBorder()),
              items: [
                for (final c in BookmarkCategory.values)
                  DropdownMenuItem(value: c, child: Text(categoryLabel(c))),
              ],
              onChanged: (v) => setState(() => _category = v),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _tagsCtrl,
              decoration: const InputDecoration(
                  labelText: 'Tags (List<String>, cách nhau bằng dấu phẩy)',
                  border: OutlineInputBorder()),
            ),
            SwitchListTile(
              title: const Text('Yêu thích (bool)'),
              value: _isFavorite,
              onChanged: (v) => setState(() => _isFavorite = v),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(_error!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.save),
              label: const Text('Lưu bookmark'),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// TAB 2: MUA SẮM
// =====================================================================
class ShoppingTab extends ConsumerStatefulWidget {
  const ShoppingTab({super.key});
  @override
  ConsumerState<ShoppingTab> createState() => _ShoppingTabState();
}

class _ShoppingTabState extends ConsumerState<ShoppingTab> {
  final _controller = TextEditingController();

  Future<void> _add() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    try {
      await ref.read(repositoryProvider).addIngredient(text, 1);
      _controller.clear();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Lỗi lưu DB: $e')));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(ingredientsProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                    labelText: 'Nguyên liệu', border: OutlineInputBorder()),
                onSubmitted: (_) => _add(),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(onPressed: _add, child: const Text('Thêm')),
          ]),
        ),
        Expanded(
          child: items.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Lỗi: $e')),
            data: (list) => list.isEmpty
                ? const Center(child: Text('Danh sách trống'))
                : ListView(children: [
                    for (final i in list)
                      ListTile(
                        title: Text(i.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => ref
                              .read(repositoryProvider)
                              .removeIngredient(i.id),
                        ),
                      ),
                  ]),
          ),
        ),
      ],
    );
  }
}