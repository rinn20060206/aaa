import 'package:flutter/material.dart';
import 'aaa.dart'; // ← DatabaseServiceをインポート

void main() {
  runApp(const SyouhiApp());
}

class SyouhiApp extends StatelessWidget {
  const SyouhiApp({super.key});

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

  // 保持するリスト
  List<Map<String, dynamic>> _savedItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await _databaseService.getAllTasks();
    setState(() {
      _savedItems = items;
    });
  }

  Future<void> _addItem() async {
    final content = _textController.text.trim();
    final dayText = _dayController.text.trim();
    if (content.isEmpty || dayText.isEmpty) return;

    final day = int.tryParse(dayText) ?? 0;
    await _databaseService.addTask(content, day);

    // リスト
    setState(() {
      _savedItems.add({'content': content, 'day': day, 'id': DateTime.now().millisecondsSinceEpoch});
      _textController.clear();
      _dayController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('保存しました')),
    );
  }

  Future<void> _deleteItem(int id) async {
    await _databaseService.deleteTask(id); // DBから削除
    setState(() {
      _savedItems.removeWhere((item) => item['id'] == id); // 画面から削除
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("生食材の消費期限デフォルト設定")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 250), // ←ここで余白を調整
              width: 100, // ボタンの幅
              child: ElevatedButton.icon(
                onPressed: _addItem,
                label: const Text("保存"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 90, 148, 83),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            const Divider(),

            // リスト表示
            Expanded(
              child: _savedItems.isEmpty
                  ? const Center(child: Text("保存したアイテムはありません"))
                  : ListView.builder(
                      itemCount: _savedItems.length,
                      itemBuilder: (context, index) {
                        final item = _savedItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(item['content']),
                            subtitle: Text("${item['day']}日"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Color.fromARGB(255, 54, 54, 54)),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("削除の確認"),
                                    content: Text("「${item['content']}」を削除しますか？"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: const Text("キャンセル"),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, true),
                                        child: const Text("削除", style: TextStyle(color: Colors.red)),
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
