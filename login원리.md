# 유효성 검사

- 필요한 목록 
0. Form- 밑에 1~4까지 묶을 위젯
1. Column - 밑에 2~4까지 묶을 위젯. children: [] 으로 묶는다
2. CheckValidate 클래스 - 유효성 검사 담당할 클래스
3. TextFormField 위젯 - 입력창
4. ElevatedButton 위젯 - 버튼
5. final _emailFocus = FocusNode(); 
        ->변수이다. 아이디 입력창에서 focus 맞추는 역할 (여기서는 틀렸을 시)
6. final _passwordFocus = FocusNode(); 
        변수이다. 비밀번호 입력창에서 focus 맞추는 역할 (여기서는 틀렸을 시)
7.  final _formKey = GlobalKey<FormState>(); 
        변수이다 . 버튼의 id - focus 맞추는 역할(여기서는 버튼 클릭시)

# 과정

- 먼저 유효성 검사를 담당할 클래스를 만든다. 반환값이 String 인 method를 만드는데 매개변수로 ({ required String email, required FocusNode focusNode,}) 를 넣는다. 
email은 input에서 입력할 값이고 , focusNode는 포커스를 관리하는 역할이다.
그리고 유효성 검사를 할건데 예시로 아래와 같이 적을거다

```dart
    if (email.isEmpty) {
      // requestFocus() : focus주기
      focusNode.requestFocus();
      return "이메일을 입력해주세요!";
    } else {
      const pattern =
          r"^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";
      // pattern을 컴파일
      var regExp = RegExp(pattern);
      if (!regExp.hasMatch(email)) {
        focusNode.requestFocus();
        return "이메일 형식이 잘못되었습니다";
      }
    }

    return "";
```

- 만약 입력한 값이 비어있다면 해당 TextFormField에 포커스를 맞춰주고 (왜 해당 TextFormField 냐면 이 메서드를 TextFormField의  validator에 쓸 것이기 때문이다) "이메일을 입력해주세요" 라는 문자열을 return한다
- 그리고 아니라면 이메일 양식이 맞는지 유효성 검사를 한다. pattern에 들어간 값을(이메일형식)  var regExp = RegExp(pattern);로 regExp에 컴파일한 값으로 저장하고 이렇게 컴파일한 값이 내가 입력한 이메일하고 일치하지 않는다면`.hasMatch(email)` 포커스를 맞춰주고 `이메일 형식이 잘못되었습니다` 라는 문자열을 반환한다

- 이제 유효성 검사 클래스는 작성이 끝났고 이걸 TextFormField에 적용한다.
- TextFormField에 widget에 validator: 을 넣고 다음과 같이 입력한다
```dart
validator: (value) => CheckValidate().emailCheck(
                        email: value!,
                        focusNode: _emailFocus,
                      ),
```
- 이건 입력한 값을 우리가 만든 클래스의 메서드를 이용해 유효성 검사를 하는 건데
(validator : 입력값의 유효성 검사- 빈칸, 형식)  문자열인 email 은 입력값이고 focusNode는 포커스를 맞추는 값이다.
 value!는 부정이 아니라 nullsafe를 위해 붙인 것이다

- 그리고 버튼 함수를 보면

```dart
  ElevatedButton(
onPressed: () => _formKey.currentState?.validate(),
  )
```

- 이렇게 되어있다. 이건 버튼을 누르면 textformfield의 validator실행한다는 의미이다.

<!-- // 여기서 가져옴 https://github.com/callor/Reference/blob/master/markdown/JS%EC%A0%95%EA%B7%9C%EC%8B%9D.md -->
- 유효성검사는 이상이다. 비밀번호 등도 다음과 같다.  다만 패턴은 가져와야 한다



```dart
ElevatedButton(
onPressed: () async {
                        _formKey.currentState?.validate();
                        var result = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: "ksun0430@naver.com",
                          password: "!korea8080",
                        );
                      },
)
```