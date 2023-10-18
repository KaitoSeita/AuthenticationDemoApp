# AuthenticationDemo
## 環境
Language：Swift
- Version：5.9
- Xcode：15.0
### ライブラリ
- FirebaseAuth
- R.Swift  
文字列や画像などの静的リソースを型安全で管理するために使用するコード生成ツール
- AlertToast  
ローディング時の表示やエラー時のトースト表示で使用するライブラリ
- Lottie
jsonファイルを使用してアニメーションを表示するライブラリ
## 概要
FirebaseAuthを使用したサインインおよびサインアップのデモアプリです。Email、Google、Appleの3つで登録できるようにしています。
アーキテクチャに基づいたコーディング、非同期処理の実装、ViewModifierの利用、R.SwiftやLottieなどのライブラリの活用をしました。
コードはSourceTreeを使用してGithubと連携して、細かい機能が完成するタイミングでその都度コミットを行うことで、大きなエラーが発生した場合に戻って対処できるように管理しました。
## アーキテクチャ
### VIPER
[VIPER 公式サイト](https://cheesecakelabs.com/blog/ios-project-architecture-using-viper/)
### 概要
VIPERアーキテクチャとは、View、Interactor、Presenter、Entity、Routerの5つから構成される。
- View  
ユーザーのアクションを検知してPresenterに通知し、Presenterからデータを取得する
- Presenter  
Viewから受け取ったイベント通知を元に、RouterやInteractorに対して画面遷移やデータ通信の依頼を行ったり、データに関する処理を行って、結果をViewに返却する
- Interactor  
Presenterから受けたデータ取得依頼に対して、APIを通じてサーバと通信し、結果をPresenterに返す
- Entity  
データの構造を定義する
- Router  
Presenterから受けた依頼に対して画面遷移を実行する
### （正直な感想）
SwiftUIで記述しましたが、ファイルの構造が複雑化しやすく、SwiftUIならばMVVMやMVCといったもう少し簡単なアーキテクチャの方が記述しやすいように感じました。
## 動作例

## コード例
