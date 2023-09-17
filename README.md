# AuthenticationDemo
## 環境
Language：Swift
- Version：5.8.1
- Xcode：14.3.1
### ライブラリ
- FirebaseAuth
- R.Swift
## 概要
FirebaseAuthを使用したサインインおよびサインアップのデモアプリです。このアプリではVIPERアーキテクチャを採用しており、ViewがPresenterに対してイベント通知を行い、InteractorはPresenterに依頼されたデータ取得の完了を通知してデータの処理を行うようにしています。R.Swiftを採用することで、文字列や画像といった静的リソースを型安全で管理できるようにしています。
## 主な機能
- サインイン / サインアップ
  - メールアドレス
  - Apple
  - Google
## 使用した技術
### Swift Concurrency
- 使用したコード
- コードの概要
- 実際の挙動
