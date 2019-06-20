# iSTPay iOS 앱 개발

## 개발 환경
- iOS 10.0 이상 지원
- Swift 4.2
- xCode 10
- CocoaPods 사용

## 프로젝트
### 개요
- 배포 타겟(Deployent Target) : 10.0 이상
- 단말 방향(Orientation) : Only Portrait
- 버전 관리 :  #.#.#

### 구조
MVC 패턴에 따른 폴더구조
- Model        :모델 클래스 폴더
- View        :StoryBoard 파일과 Custom View 폴더
- Controller: ViewController  폴더
- Extension : 기본 클래스의 Extension 폴더
- Server    :  네트워크 통신(API) 폴더
- Util    : 공통으로 사용될 Util 폴더
- Support File: Localizable.string 폴더

### 오픈소스 관리
Cocoapod 사용을 기본으로 한다.
- 주의사항
1. Podfile만 Git 저장소에 Push한다.
2. Podfile에 오픈소스이름과 버전을 반드시 함께 추가한다.

## Git 사용
### 구조
- 총 3개의 브랜치로 구성.
1. developer : 개발 단계에서 사용하는 브랜치
2. master : 마이너 버전에 사용되는 브랜치
3. release : 배포 버전에 사용되는 브랜치

- Commit Comment에는 시간을 입력하지 않으며 작업 또는 수정한 내용을 명확하게 적는다.
- StoryBoard 파일의 충돌을 방지하기 위해 Main.storyboard에서 분기하여 작업한다.

## Coding 가이드
### 명명법
코드의 통일성을 갖추기 위함으로 아래와 같이 명명할 것을 권고한다.
1. Value, Function
- CamelCasing
```Swift
fileprivate func examFuncName() {
    let userName: String?
    let userPwd: String?
}
```

2. Class, Protocol, Struct, Enum
- Pascal Casing
```Swift
public enum ExamEnum {
    case one,
    case two
}
```
```Swift
class MainViewController: UITableViewDelegate {
    struct ExamStruct {
    }
}
```

3. Constant
- GNU Naming Convention + UnderBar
```Swift
let ID_TEST_MAIN         = "idTestMain"
```

### 주석
모든 클래스와 함수, 변수, enum, struct등 주석을 추가하는 것을 원칙으로 한다.
1. 클래스, 변수, enum, struct
- 해당 클래스 및 변수선언 윗줄에 슬러시(/)를 3개 연달아 입력한 후 설명을 적는다.

```Swift
/// 예시 클래스
class examClass {
    /// 예시 변수
    var examValue: String?

    /// 스토리보드 File Name을 가지고 있는 구조체
    struct StoryBoard {
        /// Main.storyboard 파일 이름
        static let main = "Main"
    }
}
```

2. 함수
- 아래 예시를 보고 참고

```Swift
/// 함수에 대한 설명을 적는 곳.
///
/// - parameters:
///    - title: 해당 파라미터(title)에 대한 설명을 적는 곳.
///    - message: 해당 파라미터(message)에 대한 설명을 적는 곳.
/// - returns: 반환값(isSuccess)에 대한 설명을 적는 곳.
func setTitleWithMsg(title: String, message: String) -> Bool {
}
```

[링크](http://jepark-diary.tistory.com/m/11?category=874567)를 클릭하여 위 내용을 xCode에서 편리하게 사용할 수 있다.

3. 주석 종류
- 아래 4가지 종류의 주석들을 사용하여 효과적으로 주석을 적을 수 있다.

    1) MARK:            설명

    2) FIXME:           고쳐야 할 것

    3) TODO:            할 일

    4) –                    구분선 추가
