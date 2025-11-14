import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 左寄せ
          children: const [
            Text('', style: TextStyle(fontSize: 15),),
            Text('利用規約' , style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('この利用規約（以下、「本規約」といいます。）は、FantasticFive（以下、「当社」といいます。）が提供するアプリ「FRIDGE FORCE」（以下、「本アプリ」といいます。）の利用条件を定めるものです。本アプリを利用するすべてのユーザー（以下、「ユーザー」といいます。）は、本規約に同意した上で本アプリを利用するものとします。', style: TextStyle(fontSize: 15)),
            SizedBox(height: 15),
            Text('第1条（適用）', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('本規約は、ユーザーと当社との間の本アプリの利用に関する一切の関係に適用されます。', style: TextStyle(fontSize: 15)),
            SizedBox(height: 10),
            Text('第2条（利用登録）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('1. ユーザーは、本アプリの定める方法により利用登録を行うものとします。', style: TextStyle(fontSize: 15),),
            Text('2. 登録希望者が以下の事由に該当すると当社が判断した場合、登録を拒否することがあります。　(1) 登録内容に虚偽がある場合　(2) 過去に本規約違反等により利用停止処分を受けたことがある場合　(3) その他、当社が不適当と判断した場合', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第3条（利用料金）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('1. 本アプリの一部機能は有料です。', style: TextStyle(fontSize: 15),),
            Text('2. 有料機能の料金・支払方法は、アプリ内または当社が別途定める方法により提示します。', style: TextStyle(fontSize: 15),),
            Text('3. 支払い後の返金は、法令で定める場合を除き行いません。', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第4条（禁止事項）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('ユーザーは、以下の行為を行ってはなりません。', style: TextStyle(fontSize: 15),),
            Text('1. 法令または公序良俗に違反する行為', style: TextStyle(fontSize: 15),),
            Text('2. 本アプリの運営を妨害する行為', style: TextStyle(fontSize: 15),),
            Text('3. 他のユーザーまたは第三者の権利を侵害する行為', style: TextStyle(fontSize: 15),),
            Text('4. 不正アクセス・不正利用', style: TextStyle(fontSize: 15),),
            Text('5. 収集データを無断で商用利用する行為', style: TextStyle(fontSize: 15),),
            Text('6. その他、当社が不適切と判断する行為', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第5条（サービスの提供停止）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('当社は、以下の場合に本アプリの提供を一時的に停止または中断することがあります。', style: TextStyle(fontSize: 15),),
            Text('* システム保守や更新を行う場合', style: TextStyle(fontSize: 15),),
            Text('* 地震、火災、停電等の不可抗力による場合', style: TextStyle(fontSize: 15),),
            Text('* その他、運営上必要と判断した場合', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第6条（免責事項）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('1. 当社は、本アプリに関してユーザーに生じた損害について、一切の責任を負いません。', style: TextStyle(fontSize: 15),),
            Text('2. 本アプリの利用により得られる情報の正確性・安全性を保証するものではありません。', style: TextStyle(fontSize: 15),),
            Text('3. 当社は、ユーザー間または第三者との間で生じたトラブルについて一切責任を負いません。', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第7条（利用停止・登録抹消）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('当社は、ユーザーが本規約に違反した場合、事前通知なく利用を停止または登録を抹消することができます。', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第8条（利用規約の変更）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('当社は、必要に応じて本規約を改定できます。改定後の規約は、本アプリ上または当社ウェブサイト上で告知した時点から効力を生じます。', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第9条（準拠法・管轄）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('本規約の解釈および適用は日本法に準拠し、本アプリに関して生じた紛争は、当社の所在地を管轄する日本の裁判所を第一審の専属的合意管轄裁判所とします。', style: TextStyle(fontSize: 15),),
            SizedBox(height: 30,),
            Text('プライバシーポリシー', style: TextStyle(fontSize: 18),),
            Text('FantasticFive（以下、「当社」といいます。）は、当社が提供するアプリ「FRIDGE FORCE」（以下、「本アプリ」といいます。）におけるユーザーの個人情報の取り扱いについて、以下の通りプライバシーポリシー（以下、「本ポリシー」といいます。）を定めます。', style: TextStyle(fontSize: 15),),
            SizedBox(height: 30,),
            Text('第1条（収集する情報）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('当社は、本アプリの提供にあたり、以下の情報を取得することがあります。', style: TextStyle(fontSize: 15),),
            Text('1. ユーザー登録時の情報（メールアドレス、パスワード、ニックネームなど）', style: TextStyle(fontSize: 15),),
            Text('2. 利用履歴情報（使用日時、操作履歴、保存した食品データなど）', style: TextStyle(fontSize: 15),),
            Text('3. 有料機能の利用に関する決済情報（決済サービスを通じて収集）', style: TextStyle(fontSize: 15),),
            Text('4. デバイス情報（OSバージョン、端末識別情報、アプリバージョンなど）', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第2条（利用目的）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('当社は、収集した情報を以下の目的で利用します。', style: TextStyle(fontSize: 15),),
            Text('* 本アプリの提供および運営のため', style: TextStyle(fontSize: 15),),
            Text('* 利用状況や傾向の分析による機能改善のため', style: TextStyle(fontSize: 15),),
            Text('* お知らせ・サポート対応のため', style: TextStyle(fontSize: 15),),
            Text('* 不正利用防止およびセキュリティ対策のため', style: TextStyle(fontSize: 15),),
            Text('* 有料機能に関する課金・決済処理のため', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第3条（第三者提供）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('当社は、次の場合を除き、ユーザーの個人情報を第三者に提供しません。', style: TextStyle(fontSize: 15),),
            Text('1. ユーザーの同意がある場合', style: TextStyle(fontSize: 15),),
            Text('2. 法令に基づく場合', style: TextStyle(fontSize: 15),),
            Text('3. 業務委託先に処理を委託する場合（委託先には守秘義務を課します）', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第4条（情報の管理）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('当社は、個人情報を安全に管理し、漏洩・滅失・改ざんなどを防止するため、適切なセキュリティ対策を講じます。', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第5条（外部サービスの利用）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('本アプリでは、分析・決済・広告配信等のために以下の外部サービスを利用することがあります。', style: TextStyle(fontSize: 15),),
            Text('* Google Analytics', style: TextStyle(fontSize: 15),),
            Text('* Apple / Google 決済サービス（サービス提供者が定めるプライバシーポリシーに従い、データが処理されます）', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第6条（個人情報の開示・訂正・削除）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('ユーザーは、当社が保有する自己の個人情報について、開示・訂正・削除を求めることができます。その際は、アプリ内またはメールにてお問い合わせください。', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第7条（未成年者の利用）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('18歳未満のユーザーは、保護者の同意を得た上で本アプリを利用してください。', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text('第8条（プライバシーポリシーの変更）', style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Text('当社は、必要に応じて本ポリシーを改定できます。変更内容は本アプリ内または当社ウェブサイト上で告知します。', style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            

          
          ],
        ),
      ),
    );
  }
}
