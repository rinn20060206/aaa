import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'aaa.dart'; // ← DatabaseServiceをインポート

void main() {
  runApp(const syouhi());
}

class syouhi extends StatelessWidget {
  const syouhi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fridge App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _items = [];

  DateTime _registrationDate = DateTime.now();
  DateTime _expiryDate = DateTime.now().add(const Duration(days: 0));

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await _databaseService.getAllTasks();
    setState(() {
      _items = items;
    });
  }

  Future<void> _addItem() async {
    final content = _textController.text.trim();
    final dayText = _dayController.text.trim();
    if (content.isEmpty || dayText.isEmpty) return;

    final day = int.tryParse(dayText) ?? 0;
    await _databaseService.addTask(content, day);
    _textController.clear();
    _dayController.clear();
    _loadItems();
  }

  Future<void> _deleteItem(int id) async {
    await _databaseService.deleteTask(id);
    _loadItems();
  }

  Future<void> _pickDate(BuildContext context, bool isRegistrationDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isRegistrationDate ? _registrationDate : _expiryDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isRegistrationDate) {
          _registrationDate = picked;
        } else {
          _expiryDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedExpDate = DateFormat('yyyy/MM/dd').format(_expiryDate);

    return Scaffold(
      appBar: AppBar(title: const Text("消費期限デフォルト設定")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 商品検索
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: "商品名",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    final name = _searchController.text.trim();
                    if (name.isEmpty) return;

                    final items =
                        await DatabaseService.instance.getItemByName(name);
                    if (items.isNotEmpty) {
                      final item = items.first;
                      final id = item['id'];
                      final day = item['day'];

                      final calculatedExpiry =
                          DateTime.now().add(Duration(days: day));
                      final formatted =
                          DateFormat('yyyy/MM/dd').format(calculatedExpiry);

                      //今日の日付+何日後データ
                      setState(() {
                        _expiryDate = calculatedExpiry;
                      });

                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$name のデータが見つかりません')),
                      );
                    }
                  },
                  child: const Text('消費期限反映'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            //消費期限
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('消費期限: $formattedExpDate'),
                ElevatedButton(
                  onPressed: () => _pickDate(context, false),
                  child: const Text('変更'),
                ),
              ],
            ),
            const SizedBox(height: 6),

            Text('↑食材登録画面一部↑'),
            Text('↓ここから生食材の消費期限デフォルト設定画面'),

            const SizedBox(height: 20),

            // 新規登録
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: "商品名",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _dayController,
              decoration: const InputDecoration(
                labelText: "日数",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),

            // 保存
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.save),
                label: const Text("保存"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const Divider(),

            //リスト
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(item['content']),
                      subtitle: Text('${item['day']}日'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.grey),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("削除の確認"),
                              content: Text("「${item['content']}」を削除しますか？"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text("キャンセル"),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, true),
                                  child: const Text("削除",
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            _deleteItem(item['id']);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
