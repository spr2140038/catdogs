import 'package:flutter/material.dart';
import '/model/dogs.dart';
import '/model/db_helper.dart';

class DogDetailEdit extends StatefulWidget {
  final Dogs? dogs;

  const DogDetailEdit({Key? key, this.dogs}) : super(key: key);

  @override
  _DogDetailEditState createState() => _DogDetailEditState();
}

class _DogDetailEditState extends State<DogDetailEdit> {
  late int dogid;
  late String dogname;
  late String dogbirthday;
  late String doggender;
  late String dogmemo;
  late DateTime dogcreatedAt;
  final List<String> _list = <String>['男の子', '女の子', '不明']; // 性別のDropdownの項目を設定
  late String _selected; // Dropdownの選択値を格納するエリア
  String value = '不明'; // Dropdownの初期値
  static const int textExpandedFlex = 1; // 見出しのexpaded flexの比率
  static const int dataExpandedFlex = 4; // 項目のexpanede flexの比率

// Stateのサブクラスを作成し、initStateをオーバーライドすると、wedgit作成時に処理を動かすことができる。
// ここでは、各項目の初期値を設定する
  @override
  void initState() {
    super.initState();
    dogid = widget.dogs?.dogid ?? 0;
    dogname = widget.dogs?.dogname ?? '';
    dogbirthday = widget.dogs?.dogbirthday ?? '';
    doggender = widget.dogs?.doggender ?? '';
    _selected = widget.dogs?.doggender ?? '不明';
    dogmemo = widget.dogs?.dogmemo ?? '';
    dogcreatedAt = widget.dogs?.dogcreatedAt ?? DateTime.now();
  }

// Dropdownの値の変更を行う
  void _onChanged(String? value) {
    setState(() {
      _selected = value!;
      doggender = _selected;
    });
  }

// 詳細編集画面を表示する
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('犬編集'),
        actions: [
          buildSaveButton(), // 保存ボタンを表示する
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Row(children: [
            // 名前の行の設定
            const Expanded(                   // 見出し（名前）
              flex: textExpandedFlex,
              child: Text('名前',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(                         // 名前入力エリアの設定
              flex: dataExpandedFlex,
              child: TextFormField(
                maxLines: 1,
                initialValue: dogname,
                decoration: const InputDecoration(
                  hintText: '名前を入力してください',
                ),
                validator: (dogname) => dogname != null && dogname.isEmpty
                    ? '名前は必ず入れてね'
                    : null, // validateを設定
                onChanged: (dogname) => setState(() => this.dogname = dogname),
              ),
            ),
          ]),
          // 性別の行の設定
          Row(children: [
            const Expanded(                     // 見出し（性別）
              flex: textExpandedFlex,
              child: Text('性別',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(                           // 性別をドロップダウンで設定
              flex: dataExpandedFlex,
              child: DropdownButton(
                items: _list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: _selected,
                onChanged: _onChanged,
              ),
            ),
          ]),
          Row(children: [
            const Expanded(                 // 見出し（誕生日）
              flex: textExpandedFlex,
              child: Text('誕生日',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(                     // 誕生日入力エリアの設定
              flex: dataExpandedFlex,
              child: TextFormField(
                maxLines: 1,
                initialValue: dogbirthday,
                decoration: const InputDecoration(
                  hintText: '誕生日を入力してください',
                ),
                onChanged: (dogbirthday) =>
                    setState(() => this.dogbirthday = dogbirthday),
              ),
            ),
          ]),
          Row(children: [
            const Expanded(                     // 見出し（メモ）
                flex: textExpandedFlex,
                child: Text('メモ',
                  textAlign: TextAlign.center,
                )
            ),
            Expanded(                           // メモ入力エリアの設定
              flex: dataExpandedFlex,
              child: TextFormField(
                maxLines: 1,
                initialValue: dogmemo,
                decoration: const InputDecoration(
                  hintText: 'メモを入力してください',
                ),
                onChanged: (dogmemo) => setState(() => this.dogmemo = dogmemo),
              ),
            ),
          ]),
        ]),
      ),
    );
  }

// 保存ボタンの設定
  Widget buildSaveButton() {
    final isFormValid = dogname.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        child: const Text('保存'),
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? Colors.redAccent : Colors.grey.shade700,
        ),
        onPressed: createOrUpdateDog, // 保存ボタンを押したら実行する処理を指定する
      ),
    );
  }

// 保存ボタンを押したとき実行する処理
  void createOrUpdateDog() async {
    final isUpdate = (widget.dogs != null);     // 画面が空でなかったら

    if (isUpdate) {
      await updateDog();                        // updateの処理
    } else {
      await createDog();                        // insertの処理
    }

    Navigator.of(context).pop();                // 前の画面に戻る
  }

  // 更新処理の呼び出し
  Future updateDog() async {
    final dog = widget.dogs!.copy(              // 画面の内容をcatにセット
      dogname: dogname,
      dogbirthday: dogbirthday,
      doggender: doggender,
      dogmemo: dogmemo,
    );

    await DbHelper.instance.dogupdate(dog);        // catの内容で更新する
  }

  // 追加処理の呼び出し
  Future createDog() async {
    final dog = Dogs(                           // 入力された内容をcatにセット
      dogname: dogname,
      dogbirthday: dogbirthday,
      doggender: doggender,
      dogmemo: dogmemo,
      dogcreatedAt: dogcreatedAt,
    );
    await DbHelper.instance.doginsert(dog);        // catの内容で追加する
  }
}