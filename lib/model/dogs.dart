import '/model/db_helper.dart';
import 'package:intl/intl.dart';

// catsテーブルの定義
class Dogs {
  int? dogid;
  String dogname;
  String doggender;
  String dogbirthday;
  String dogmemo;
  DateTime dogcreatedAt;

  Dogs({
    this.dogid,
    required this.dogname,
    required this.doggender,
    required this.dogbirthday,
    required this.dogmemo,
    required this.dogcreatedAt,
  });

// 更新時のデータを入力項目からコピーする処理
  Dogs copy({
    int? dogid,
    String? dogname,
    String? dogbirthday,
    String? doggender,
    String? dogmemo,
    DateTime? dogcreatedAt,
  }) =>
      Dogs(
        dogid: dogid ?? this.dogid,
        dogname: dogname ?? this.dogname,
        dogbirthday: dogbirthday ?? this.dogbirthday,
        doggender: doggender ?? this.doggender,
        dogmemo: dogmemo ?? this.dogmemo,
        dogcreatedAt: dogcreatedAt ?? this.dogcreatedAt,
      );

  static Dogs fromJson(Map<String, Object?> json) => Dogs(
    dogid: json[columnDogId] as int,
    dogname: json[columnDogName] as String,
    doggender: json[columnDogGender] as String,
    dogbirthday: json[columnDogBirthday] as String,
    dogmemo: json[columnDogMemo] as String,
    dogcreatedAt: DateTime.parse(json[columnDogCreatedAt] as String),
  );

  Map<String, Object> toJson() => {
    columnDogName: dogname,
    columnDogGender: doggender,
    columnDogBirthday: dogbirthday,
    columnDogMemo: dogmemo,
    columnDogCreatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(dogcreatedAt),
  };
}