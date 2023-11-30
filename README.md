# AuthenticationDemo
## 環境
Language：Swift
- Version：5.9
- Xcode：15.0
### ライブラリ
- FirebaseAuth
- R.Swift  
文字列や画像などの静的リソースを型安全で管理するために使用するコード生成ツール    
導入方法についてQiitaに掲載しています    
[【SwiftUI】画像や文字列を型安全で管理するライブラリのR.Swiftを使ってみる](https://qiita.com/kaito-seita/items/97c656b2daf2c0e1b4be)
- AlertToast  
ローディング時の表示やエラー時のトースト表示で使用するライブラリ
- Lottie  
jsonファイルを使用してアニメーションを表示するライブラリ    
導入方法についてQiitaに掲載しています    
[【SwiftUI】Lottieを使ってアニメーションを簡単に実装してみた](https://qiita.com/kaito-seita/items/f0327faa5d649da44249)
## 概要
FirebaseAuthを使用したサインインおよびサインアップのデモアプリです。Email、Google、Appleの3つで登録できるようにしています。
アーキテクチャに基づいたコーディング、非同期処理の実装、ViewModifierの利用、R.SwiftやLottieなどのライブラリの活用をしました。
コードはSourceTreeを使用してGithubと連携して、細かい機能が完成するタイミングでその都度コミットを行うことで、大きなエラーが発生した場合に戻って対処できるように管理しました。
## 開発の背景
就業型のインターンシップに参加させていただいた際に学ばせていただいたことを[以前に開発していた認証アプリ](https://github.com/KaitoSeita/AuthDemoApp)に導入してすぐにアウトプットしてみたいということで開発しました。    
テストコードなどを導入することができていませんが、今後学習を進めて導入したいと考えています。    
また、このアプリで一貫して大切にしていることとして、ユーザー認証画面はインストールして初めに触れる画面なので、そのアプリ自体の第一印象になりかねないという側面を持つと考えています。    
なので、デザインやアニメーション、わかりやすい誘導にこだわり、これから使っていくにあたってワクワクできるように意識して制作しました。

## アーキテクチャ
### VIPER
![VIPER](https://github.com/KaitoSeita/AuthenticationDemoApp/assets/113151647/c8d9cac7-6161-4cae-99af-9ec45b10d091)
[VIPER 公式サイト](https://cheesecakelabs.com/blog/ios-project-architecture-using-viper/)から引用
### アーキテクチャの概要
VIPERアーキテクチャとは、`View`、`Interactor`、`Presenter`、`Entity`、`Router`の5つから構成されます。
- **View**  
ユーザーのアクションを検知して`Presenter`に通知し、`Presenter`からデータを取得する
- **Interactor**  
`Presenter`から受けたデータ取得依頼に対して、APIを通じてサーバと通信し、結果を`Presenter`に返す
```Swift
protocol SignInWithEmailInteractorProtocol {
    func fetchUserInfo(email: String, password: String) async -> Result<User, Error>
}

final class SignInWithEmailInteractor: SignInWithEmailInteractorProtocol {
    
    func fetchUserInfo(email: String, password: String) async -> Result<User, Error> {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let userInfo = User(id: result.user.uid,
                                displayName: result.user.displayName ?? "",
                                email: result.user.email ?? "")
            return .success(userInfo)
        } catch {
            return .failure(error)
        }
    }
}
```
※一部抜粋しています  
非同期での通信処理において`do-catch文`でエラー処理を記述し、`Result型`で`Presenter`に通知します。
- **Presenter**  
`View`から受け取ったイベント通知を元に、`Router`や`Interactor`に対して画面遷移やデータ通信の依頼を行ったり、データに関する処理を行って、結果をViewに返却する
```Swift
final class SignInWithEmailPresenter: ObservableObject {
    @Published var errorMessage: String
    @Published var isShowingSuccessView: Bool
    @Published var isShowingErrorMessage: Bool
    @Published var isShowingLoadingToast: Bool
    
    private let interactor: SignInWithEmailInteractor
    
    init(interactor: SignInWithEmailInteractor) {
        errorMessage = ""
        isShowingSuccessView = false
        isShowingErrorMessage = false
        isShowingLoadingToast = false
        self.interactor = interactor
    }
}

extension SignInWithEmailPresenter {

    func onTapSignInButton(email: String, password: String) {
        isShowingLoadingToast = true
        Task { @MainActor in
            let result = await signInWithEmailPassword(email: email, password: password)
            isShowingLoadingToast = false
            switch result {
            case .success(_):
                isShowingSuccessView = true
            case .failure(let error):
                setErrorMessage(error: error)
                isShowingErrorMessage = true
            }
        }
    }

    private func signInWithEmailPassword(email: String, password: String) async -> Result<User, Error> {
        return await interactor.fetchUserInfo(email: email, password: password)
    }
}
```
※一部抜粋しています  
`View`で呼び出されるメソッドはViewにおけるイベントに対応した命名をし、`Interactor`へのデータ取得依頼に関するメソッドは`private`で通信処理に対応する命名をします。
- **Router**  
Presenterから受けた依頼に対して画面遷移を実行する
```Swift
struct AuthenticationTopRouter {

    func setDestination(selection: AuthenticationTopSelection) -> AnyView? {
        switch selection {
        case .signIn:
            return AnyView(SignInTopView())
        case .signUp:
            return AnyView(SignUpTopView())
        }
    }
}
```
- **Entity**  
データの構造を定義する
### （正直な感想）
SwiftUIで記述しましたが、ファイルの構造が複雑化しやすく、SwiftUIならばMVVMやMVCといったもう少し簡単なアーキテクチャの方が記述しやすいように感じました。
一方で、役割を分割して小さくすることで不具合の把握や修正などがしやすいという印象も受けました。
## 動作フロー図
![FlowImage](https://github.com/KaitoSeita/AuthenticationDemoApp/assets/113151647/6d4ca559-f29e-46ec-af81-a6caa69f3472)
※GoogleおよびAppleの画面はUI作成にほとんど関係しないため省略していますが、実際に動作するコードは記述してあります。
## 具体的な動作とそのコードについて
### サインアップ画面の画面遷移
![SignUpWithEmailView](https://github.com/KaitoSeita/AuthenticationDemoApp/assets/113151647/05f21b28-eeba-4fc9-b1ff-e88600ce02dd)  
サインアップ画面ではステップインジケーターを導入するために、`NavigationStack`の採用を見送り、独自で画面が切り替わるように記述しました。この画面に移る際とサインアップの成功画面へ移る際の画面遷移では`NavigationStack`を使用しています。
#### サインアップ画面で画面の切り替えを行うViewのコード
```Swift
struct SignUpWithEmailView: View {
    @ObservedObject private var presenter: SignUpWithEmailPresenter
    @ObservedObject private var indicatorPresenter: SignUpWithEmailStepIndicatorPresenter
    
    @StateObject var user: SignUpUser = SignUpUser()
    
    @State private var selection: SignUpSelection = .email
    
    let interactor: SignUpWithEmailInteractor

    init(interactor: SignUpWithEmailInteractor) {
        self.interactor = interactor
        _presenter = ObservedObject(wrappedValue: SignUpWithEmailPresenter(interactor: interactor))
        _indicatorPresenter = ObservedObject(wrappedValue: SignUpWithEmailStepIndicatorPresenter())
    }
    
    var body: some View {
        ZStack {
            SignUpWithEmailStepIndicatorView(presenter: indicatorPresenter)
            
            switch selection {
            case .email:
                SignUpEmailForm(user: user, selection: $selection, presenter: presenter, indicatorPresenter: indicatorPresenter)
                    .transition(presenter.transition)
            case .userInfomation:
                SignUpUserInfomationForm(user: user, selection: $selection, presenter: presenter, indicatorPresenter: indicatorPresenter)
                    .transition(presenter.transition)
            case .confirmation:
                SignUpConfirmation(presenter: presenter, user: user, selection: $selection, indicatorPresenter: indicatorPresenter)
                    .transition(presenter.transition)
            }
        }
    }
}
```
`View`ではステップインジケーターと画面を`ZStack`で構成しており、各Viewには自然な画面の切り替わりをさせるために`transition`を採用しています。また、Viewの切り替わりのタイミングでAnimationを適用させたいのでVIPERアーキテクチャの概要で示したようなRouterはあえて使用しませんでした。
各Viewからメールアドレスやパスワード、ユーザーネーム、誕生日などに対して参照したり書き込みを行う際に、`@EnvironmentObject`を使用すればいいと当初は考えていましたが、このViewは`switch`の切り替わりによってView自体が再描画されるようになっているため、
再描画の度に保持していた値がリセットされてしまうことがわかったので、`@StateObject`として初回表示の際のみの初期化とすることで画面遷移が発生しても値を保持することができるようになりました。
### ステップインジケーター(SignUpWithEmailStepIndicatorView)
各画面をenumでcaseとして保持し、そのcaseに応じたColorの構造体配列を返すというメソッドをPresenterで作成し、画面遷移のたびに呼び出すという仕組みにしています。  
  
![StepIndicator](https://github.com/KaitoSeita/AuthenticationDemoApp/assets/113151647/05b18897-e09f-489a-9ca3-851fa867438a)
#### インジケーターのコード
##### View
```Swift
struct SignUpWithEmailStepIndicatorView: View {
    @ObservedObject var presenter: SignUpWithEmailStepIndicatorPresenter

    var body: some View {
        VStack {
            HeightSpacer(height: 25)
            HStack {
                ForEach(presenter.colorItems){ color in
                    Circle()
                        .frame(width: 15, height: 10)
                        .foregroundColor(color.color.opacity(0.85))
                        .grayShadow()
                }
            }
            Spacer()
        }
    }
}
```
`ForEach`で配列が保持している`Color`を取り出し、`Circle`を表示して色を指定するようにしています。
##### Presenter
```Swift
final class SignUpWithEmailStepIndicatorPresenter: ObservableObject {
    @Published var colorItems: [ColorModel] = []
    
    init() {
        colorSelecter(selection: .email)
    }
    
    func colorSelecter(selection: SignUpSelection)　{
        switch selection {
        case .email:
            colorItems = [ColorModel(color: .black), ColorModel(color: .gray), ColorModel(color: .gray)]
        case .userInfomation:
            colorItems = [ColorModel(color: .black), ColorModel(color: .black), ColorModel(color: .gray)]
        case .confirmation:
            colorItems = [ColorModel(color: .black), ColorModel(color: .black), ColorModel(color: .black)]
        }
    }
}
```
`Presenter`に`Color`を設定するメソッドを用意して、画面遷移が発生するタイミング(Continueボタンをタップするときや戻るボタンをタップするとき)でメソッドを呼び出し、`@Published`でラップされた変数を更新しています。
### データ通信処理の際のUI
|成功時|エラー時|
|:-:|:-:|
|![SignInSuccess](https://github.com/KaitoSeita/AuthenticationDemoApp/assets/113151647/bedc254f-86b9-4aae-972b-93f5266b71d5)|![SignInError](https://github.com/KaitoSeita/AuthenticationDemoApp/assets/113151647/980a50d3-3e12-44cc-8187-e0c35e2a1c0a)|  

サインインボタンをタップすることで`onTapSignInButton`というメソッドが呼ばれ、通信処理の成功/失敗によってUIに変更を加える仕様となっています。
非同期処理はSwiftConcurrencyのasync/awaitで記述しています。
#### 非同期処理を含む通信処理部分のコード
##### Presenter
```Swift
extension SignInWithEmailPresenter {

    func onTapSignInButton(email: String, password: String) {
        isShowingLoadingToast = true
        Task { @MainActor in
            let result = await signInWithEmailPassword(email: email, password: password)
            isShowingLoadingToast = false
            switch result {
            case .success(_):
                isShowingSuccessView = true
            case .failure(let error):
                setErrorMessage(error: error)
                isShowingErrorMessage = true
            }
        }
    }
}
```
`Interactor`で記述した非同期処理の通信に関するメソッドを呼び出して、返却された結果からUIに対する操作などを行うようにしています。UI処理を含んでいるので、`Task`に対して`MainActor`を付与してメインスレッドでUIの変更が行えるようにしています。
##### Interactor
```Swift
protocol SignInWithEmailInteractorProtocol {
    func fetchUserInfo(email: String, password: String) async -> Result<User, Error>
    func resetPassword(email: String) async -> Result<String, Error>
}

final class SignInWithEmailInteractor: SignInWithEmailInteractorProtocol {
    
    func fetchUserInfo(email: String, password: String) async -> Result<User, Error> {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let userInfo = User(id: result.user.uid,
                                displayName: result.user.displayName ?? "",
                                email: result.user.email ?? "")
            return .success(userInfo)
        } catch {
            return .failure(error)
        }
    }
}
```
`Presenter`にて成功/失敗で場合分けできるように`Result型`で結果を返却する。エラー処理は`do-catch文`で記述することで比較的整然としたコードとなりました。
### extension
`extension`を使用することで共通で使用しているコードを簡素化することができるため、積極的に活用しています。
#### NavigationStackにおける戻るボタン
```Swift
struct CustomBackwardButton: ViewModifier {
    
    @Environment(\.dismiss) var dismiss

    private let edgeWidth: Double = 30
    private let baseDragWidth: Double = 30    

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action: {
                            dismiss()
                        }, label: {
                            Image(systemName: String(resource: R.string.localizable.backwardSymbol))
                        }
                    ).tint(.black)
                }
            }
            .gesture (
                DragGesture().onChanged { value in
                    if value.startLocation.x < edgeWidth && value.translation.width > baseDragWidth {
                        dismiss()
                    }
                }
            )
    }
}

extension View {
    
    func customBackwardButton() -> some View {
        self.modifier(CustomBackwardButton())
    }
}
```
`Modifier`として記述することで、`.customBackwardButton`と1行追加するだけでUIを変更できるようにしました。
`DragGesture`を追加してエッジスワイプを導入しました。`NavigationStack`は標準でエッジスワイプがありますが、`.navigationBarBackButtonHidden(true)`を記述してしまうとその機能が失われてしまうので、この機能をできるだけ再現してUXを向上させるために導入しました。
これについてはQiitaの記事で詳しくまとめているのでご参照いただけると幸いです。

https://qiita.com/kaito-seita/items/5c847be63fd4748b58e3    
https://qiita.com/kaito-seita/items/083831ff99b69a6af207

また、`frame`と`contentShape`を指定して`VStack`の大きさを画面全体に拡大して、`Gesture`が画面全体で検知できるようにしています。
