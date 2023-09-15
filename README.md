# context

- context 는 위치값이다. 부모의 context는 자식이 물려받는다
- buildcontext 는 retuen되는 scafolld 같은 거의 것이 아니라 build 된 것이다.
- `.of(context)` 는 주어진 context에서 위로 올라가면서 가장 가까운 scaffold를 찾아서 반환하라는 의미이다

# !

느낌표가 뒤에 붙었으면. 값이 null이면 쓰지 말라는 이야기다

https://velog.io/@tygerhwang/Flutter-Firebase-Firestore-Database-%EC%82%AC%EC%9A%A9%ED%95%B4-%EB%B3%B4%EA%B8%B0-1%ED%8E%B8

# 프로젝트 생성

```dart
flutter create --org=com.callor cookver2
```

이렇게 입력하면
package이름: com.callor.cookver2
프로젝트 이름 : cookver2
