1)  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void)

  - 요청된 navigationAction에 대해 wkWebView의 기능중 Navigation 기능을 허용할 것인지 말것인지를 결정.
  - 허용을 하게 되면 해당 Request의  url로 navigation 기능을 통한 페이지 로딩이 이뤄진다.
  - 불허용 하게 되면 페이지 이동이 발생하지 않는다.



2) func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void)

  - 네비게이션 Response값이 무엇인지 알게된 후에? navigationResponse에 대해 wkWebView의 기능중 Navigation 기능을 허용할 것인지 말것인지를 결정.
  - 허용을 하게 되면 해당 Response의 값으로 navigation 기능을 통한 페이지 로딩이 이뤄진다.
  - 불허용 하게 되면 페이지 이동이 발생하지 않는다.



3) func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)

  - 네비게이션이 막 시작될때, 즉 웹뷰에서 웹콘텐츠가 로드를 시작할때 호출된다.



4) func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!)

  - webview의 메인에 서버 리다이렉트가 수신되었을때 호출된다.



5) func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error)

  - 로드중에 에러가 발생할때 호출된다.



6) func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!)

  - 웹뷰가 웹 콘텐츠를 수신하기 시작할때 호출된다.



7) func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)

  - 네비게이션이 완전히 끝나면 호출된다.



8) func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)

  - 네비게이션이 동작되는 동안 오류가 발생했을때 호출된다.



9) func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void)

  - 웹뷰가 인증 요청(요구)을 필요로 할때 호출된다.



10) func webViewWebContentProcessDidTerminate(_ webView: WKWebView)

  - 웹뷰의 웹 콘텐츠 프로세스가 종료되었을때 호출된다.
