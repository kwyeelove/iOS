
```Objective-C
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
[webView evaluateJavaScript:@"document.body.style.webkitTouchCallout='none';" completionHandler:nil];

    if (@available(iOS 11.0, *)) {
        // Step 1: Find the WKScrollView - it's a subclass of UIScrollView
        UIView *webScrollView = nil;

        for (UIView *subview in webView.subviews) {
            if ([subview isKindOfClass:[UIScrollView class]]) {
                webScrollView = subview;
                break;
            }
        }

        if (webScrollView) {
            // Step 2: Find the WKContentView
            UIView *contentView = nil;

            // We don't want to trigger any private API usage warnings, so instead of checking
            // for the subview's type, we simply look for the one that has two "interactions" (drag and drop)
            for (UIView *subview in webScrollView.subviews) {
                if ([subview.gestureRecognizers count] > 1) {
                    for (UILongPressGestureRecognizer * gesture in subview.gestureRecognizers) {
                        if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
                            ((UILongPressGestureRecognizer *) gesture).enabled = NO;
                        }
                    }
                }
            }

            if (contentView) {
                // Step 3: Find and disable the drag interaction
                for (UILongPressGestureRecognizer * gesture in contentView.gestureRecognizers) {
                    if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
                        ((UILongPressGestureRecognizer *) gesture).enabled = NO;
                        break;
                    }
                }
            }
        }
    }
  }
```
