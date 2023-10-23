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
![VIPER](https://github.com/KaitoSeita/AuthenticationDemoApp/assets/113151647/c8d9cac7-6161-4cae-99af-9ec45b10d091)
[VIPER 公式サイト](https://cheesecakelabs.com/blog/ios-project-architecture-using-viper/)から引用
### 概要
VIPERアーキテクチャとは、View、Interactor、Presenter、Entity、Routerの5つから構成されます。
- **View**  
ユーザーのアクションを検知してPresenterに通知し、Presenterからデータを取得する
- **Interactor**  
Presenterから受けたデータ取得依頼に対して、APIを通じてサーバと通信し、結果をPresenterに返す
```
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
非同期での通信処理においてdo-catch文でエラー処理を記述し、Result型でPresenterに通知します。
- **Presenter**  
Viewから受け取ったイベント通知を元に、RouterやInteractorに対して画面遷移やデータ通信の依頼を行ったり、データに関する処理を行って、結果をViewに返却する
```
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
Viewで呼び出されるメソッドはViewにおけるイベントに対応した命名をし、Interactorへのデータ取得依頼に関するメソッドはprivateで通信処理に対応する命名をします。
- **Router**  
Presenterから受けた依頼に対して画面遷移を実行する
```
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
サインアップ画面ではステップインジケーターを導入するために、NavigationStackの採用を見送り、独自で画面が切り替わるように記述しました。この画面に移る際とサインアップの成功画面へ移る際の画面遷移ではNavigationStackを使用しています。
#### サインアップ画面で画面の切り替えを行うView(SignUpWithEmailView)
```
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
Viewではステップインジケーターと画面をZStackで構成しており、各Viewには自然な画面の切り替わりをさせるためにtransitionを採用しています。また、Viewの切り替わりのタイミングでAnimationを適用させたいのでVIPERアーキテクチャの概要で示したようなRouterはあえて使用しませんでした。
各Viewからメールアドレスやパスワード、ユーザーネーム、誕生日などに対して参照したり書き込みを行う際に、@EnvironmentObjectを使用すればいいと当初は考えていましたが、このViewはswitchの切り替わりによってView自体が再描画されるようになっているため、
再描画の度に保持していた値がリセットされてしまうことがわかったので、@StateObjectとして初回表示の際のみの初期化とすることで画面遷移が発生しても値を保持することができるようになりました。
#### 
