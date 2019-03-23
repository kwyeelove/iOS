# Class vs Struct
----
##### Class (Reference Type)

```Swift
class Point {
  var x: CGFloat
  var y: CGFloat
}

var c1 = Point(x: 0.0, y: 0.0)
var c2 = c1

c2.y = 2.0

// c1.y == 2.0
// c2.y == 2.0
```

구분| Stack |     | heap
---|-------|-----|--
c1 |   ref | ->  | refCount: 1
c2 |   ref | /  | x: 0.0
|||y: 0.0


Reference 타입은 하나의 identiy

변수가 Copy되어도 값이 하나를 향해 같은 값을 가진다.



##### Struct (Value Type)

```Swift
Struct Point {
  var x: CGFloat
  var y: CGFloat
}

var c1 = Point(x: 0.0, y: 0.0)
var c2 = c1

c2.y = 2.0
// c1.y == 0.0
// c2.y == 2.0
```

구분| Stack |
---|-------|
c1 |   x: 0.0
   |   y: 0.0
c2 |   x: 0.0
   |   y: 2.0

Value 타입은 각자의 변수는 Copy되어도 분리되어있다.


-----------

## Value Semantics: '값'에 의해 구분된다.


1. identiy가 아니라 Value가 중요하다.
2. 각 변수는 값(value)에 의해 구분되어야 한다. 동치관계여야 한다.
-> Equatable을 구현하세




출처: https://academy.realm.io/kr
