# iOS - JavaScript 통신

1. iOS App -> JavaScript 호출

  1) HTML 문서 로드시 JavaScript 함수 호출하기

```swift
let userScript = WKUserScript(source: "callJavaScriptFunction()", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
let contentController = WKUserContentController()
contentController.addUserScript(userScript)
```


  2) iOS에서 evaluateJavaScript 함수를 사용하여 JavaScript 함수 직접 호출

```swift
webView.evaluateJavaScript("callJavaScriptFunction()", completionHandler: {(result, error) in
    if let result = result {
      print(result)
    }
})
```
2. JavaScript -> iOS App 호출

```swift
let contentController = WKUserContentController()
contentController.add(self, name: "callbackHandler")
```

#### iOS

```swift
  import UIKit
  import WebKit
   class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
      // MARK: - Properties
      // MARK: Custom

      var webView: WKWebView?

      // MARK: IBOutlet

      @IBOutlet weak var containerView: UIView!



      // MARK: - Methods
      // MARK: View Life Cycle

      override func loadView() {
          super.loadView()

          // WKUserContentController는 Native에서 JavaScript로 메시지를 보내고 스크립트 삽입을 가능하게 하는 객체다.
          let contentController = WKUserContentController()
          contentController.add(self, name: "callbackHandler") // Message Handler 추가

          // WKWebViewConfiguration은 웹 페이지의 렌더링 속도, 미디어 재생 처리 방법 등 다양한 옵션을 결정할 수 있게 하는 객체다.
          // 또한 처음 생성될 때에만 지정할 수 있으며, 이미 만들어진 WKWebView의 Configuration은 get만 가능하다.
          let configuration = WKWebViewConfiguration()
          configuration.userContentController = contentController // User Content Controller 추가

          // Native에서 JavaScript로 통신하는 방법은 두 가지가 있는데 그 중에서 첫 번째 방법인 이 방법은 HTML 문서가 시작될 때만 가능하다.
          let userScript = WKUserScript(source: "redHeader()", injectionTime: .atDocumentEnd, forMainFrameOnly: true) // atDocumentEnd는 문서가 로드된 후 하위 리소스가 로드되기전 스크립트를 삽입한다.
          contentController.addUserScript(userScript)

          // WKWebView를 미리 지정해둔 Container View의 Bounds에 맞춰 만들고 Configuration을 지정한다.
          self.webView = WKWebView(frame: self.containerView.bounds, configuration: configuration)
          if let webView = self.webView {
              self.containerView.insertSubview(webView, at: 0)

              webView.uiDelegate = self // uiDelegate는 웹 페이지 대신 Native User Interface 요소를 나타내는 메서드를 제공한다.
              webView.navigationDelegate = self // navigationDelegate는 WKWebView가 naviation을 하면서 발생하는 이벤트(탐색 요청 수락, 로드, 완료 등)들을 관리할 수 있게 한다.
          }
      }

      override func viewDidLoad() {
          super.viewDidLoad()

          let url = URL(fileURLWithPath: "your url")
          let myRequest = URLRequest(url: url)
          if let webView = self.webView {
              webView.load(myRequest)
          }
      }

      // MARK: Memory Management

      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
      }

      // MARK: WK Script Message Handler
      // JavaScript -> Native 호출
      func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
          if message.name == "callbackHandler" {
              print("JS -> Native 호출, \(message.body)")
          }
      }

      // MARK: IBACtion
      // Native -> JavaScript 호출 (두번째 방법)
      @IBAction func didTapchangeButton(_ sender: UIButton) {
          if let webView = self.webView {
              webView.evaluateJavaScript("blueHeader()") { (result, error) in
                  if let error = error {
                      print(error)
                  } else if let result = result {
                      print(result)
                  }
              }
          }
      }
  }
```

#### JavaScript

```html
function callNative() {
  webkit.messageHandlers.callbackHandler.postMessage("MessageBody");
}

function callJavaScriptFunction() {
  alert('callJavaScriptFunction Call by iOS App');
}
```
