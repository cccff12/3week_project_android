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


# 로그인 완성과 회원가입


- 사용한 것 

1.  login.dart에서는 각 `컨트롤러`와 `포커스`, `input에 임시로 저장할 변수`
// textformfield의 콘트롤러
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  // 콘트롤러
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

// input 박스에 입력해놓을 값을 임시로 저장하는 변수
  String _emailValue = "";
  String _passwordvalue = "";


main.dart에서 밑에 2가지를 사용한다. 특히 updateAuthUser는 자식에게 계속 상속시킨다
```dart
// widget 초기화
  @override
  void initState() {
    super.initState();
    // login된 사용자 정보를 firebaseAuth에게 요청해 _authUser에 담음
    _authUser = FirebaseAuth.instance.currentUser;

// state 변경 함수
  void updateAuthUser(User? user) {
    setState(() {
      _authUser = user;
    });
  }

  }

```


2. 우선 input을 통째로 Widget으로 옮겼다

```dart 
import 'package:flutter/material.dart';

Widget inputFormField({
  required TextEditingController controller,
  String? hintText,
  required Function(String) setValue, //함수
  required Function(String?) validator,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      // value는 입력값
      validator: (value) => validator(value), //validator:입력값의 유효성 검사
      onChanged: (value) => setValue(value),
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
    ),
  );
}
```

- 매서드의 매개변수 3개는 핋수 1개는 선택이다. TextFormField에서 validator: (value)=> validator(value) 이런 구조를 잘 기억해두자 `(value)=>함수이름(value)`


3. 다시 login으로 돌아와서 inputFormField 매서드 매겨변수를 넣는데, 1. 에서 말한 컨트롤러와 임시 저장값, validate 클래스, 힌트 메서드를 넣는다. 그럼 다음과 같다

```dart

 inputFormField(
                          controller: _emailController,
                          setValue: (value) => _emailValue = value,
                          validator: (value) => CheckValidate().emailCheck(
                              email: value!,
                              focusNode: _emailFocus),
                          hintText: "이메일을 입력해 주세요"),
```
- 뒤에 붙은 !는 nullsafe방지용이다. 
1. 컨트롤러는 id라 지정용. 
2. setValue는 입력한 값을 임시 변수에 담고
3. validator 는 유효성 검사에서 했던거 
4. hint는 placeholder다
- 사용방식은 이메일이나 비밀번호나 다 비슷하다.



<!-- 이제 버튼 (2개) -->

```dart

  Widget loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 245, 206, 91),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        // 버튼을 누르면 textformfield의 validator실행
        
        onPressed: () async {
          _formKey.currentState?.validate();
          var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailValue,
            password: _passwordvalue,
          );
// context를 사용하여 현재 화면에 접근하고, result.user != null 조건을 검사
// null이 아니라면 true를 반환
          Navigator.pop(context, result.user != null);
          await widget.updateAuthUser(result.user);
          Navigator.pop(context);
        },
        child: const SizedBox(
          width: double.infinity,
          child: SizedBox(
            width: double.infinity,
            child: Text("로그인",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.black)),
          ),
        ),
      ),
    );
  }

```

- 디자인은 빼고 중요한건 onpressed부터 Navigator.pop(context) 까지다. 168~178열
1.    _formKey.currentState?.validate();는 고정값이다. 위의 final _formKey = GlobalKey<FormState>();를 참고하자
2. result 변수에 firebase의 이메일과 패스워드 값을 저장했고
3. Navigator.pop(context, result.user != null);
          await widget.updateAuthUser(result.user);
          Navigator.pop(context); 는 로그인 값이 있다면 true를 반환하는 것이다. 그럼 pop이 실행된다. 
4. 그리고 state 변경함수를 실행.
5. 그리고  Navigator.pop(context); 으로 이전 화면으로 전환 



- 회원가입 버튼은 그냥 이동용이다 Navigator.of(context).push(MaterialPageRoute(builder: (context) => Join(updateAuthUser: widget.updateAuthUser),)), 으로 이동한다. 
Join(updateAuthUser: widget.updateAuthUser) join뒤에 붙은건 state변경 함수다. 전달할거라서 넣었다. widget.updateAuthUser 이건 앞에 widget.가 붙은 이유가 부모에게 상속받은건 widget.을 붙여야 하기 때문이다.


<!-- join page -->

여기서 필요한건
콘트롤러, 노드포커스, 임시 저장값, 키이다. (길이상 한 개씩만 작성하겠다)
그리고 inputFormField메서드를 가져와 쓰겠다.

```dart
final _emailController = TextEditingController();
final _emailFocus = FocusNode();
String _emailValue = "";
final _formKey = GlobalKey<FormState>();


    inputFormField(
                        controller: _emailController,
                        setValue: (value) => _emailValue = value,
                        hintText: "이메일을 입력해 주세요",
                        validator: (value) => null,
                      ),
```
- 이렇게 input에 각각 맞게 넣어주면 되고

- 버튼이 독특하다

```dart
  Widget joinButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 42, 222, 235),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        // 버튼을 누르면 textformfield의 validator실행

// 여기부터 중요
        
        onPressed: () async {
          _formKey.currentState?.validate();

          try {
            var result =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailValue,
              password: _passwordvalue,
            );
              // 입력한 값에 user를 updateAuthUser 
            widget.updateAuthUser(result.user);
              // 값이 있다면
            if (result.user != null) {
              // firebaseStore에
              await FirebaseFirestore.instance
                  // user 라는 컬렉션을 만들고
                  .collection("users")
                  // document는 uid로 만들어라
                  .doc(result.user!.uid)
                  .set({
                "email": result.user!.email,
                "password": _passwordvalue,
                "name": _namevalue,
                "tel": _phonenumbervalue,
                "nickname": _nicknamevalue,
              });
            }
            // 다른 회원정보는 fireStore에 저장해야한다.
            // 나중에 Dto만들어서 변경

            // firebase에서 에러나면 snackbar로 보여주는 것
          } on FirebaseException catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message!),
              ),
            );
          }

// 여기까지 중요



        },
        child: const SizedBox(
          width: double.infinity,
          child: SizedBox(
            width: double.infinity,
            child: Text("회원가입",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.black)),
          ),
        ),
      ),
    );
  }

```
- 중요한 부분만 설명하자면, 
1. 버튼을 누르면 키를 가져오고 , 예외 방지를 위해 try문을 작성한다 
2. result에 입력한 값을 firebase에 저장한다. 이때 자동으로 유효성검사를 한다 
 email: _emailValue,  이건 입력한 값(_emailValue) 을 FirebaseAuth.instance.createUserWithEmailAndPassword의 이메일에 넣느다는 말이다. 
 3. widget.updateAuthUser(result.user)는 로그인 또는 회원가입이 성공한 후에 Firebase에서 반환된 사용자 정보를 상위 위젯에 전달하기 위한 역할을 합니다.
widget: 이것은 현재 StatefulWidget의 부모 위젯에 대한 참조입니다.
updateAuthUser: 이것은 StatefulWidget에서 정의한 함수로, 사용자 정보를 업데이트하는 역할을 합니다.
result.user: Firebase에서 반환된 사용자 객체입니다.
widget.updateAuthUser(result.user)는 반환된 사용자 정보를 상위 위젯으로 전달하여, 상위 위젯에서 사용자 정보를 관리하거나 화면을 업데이트하는 데 사용될 수 있습니다.
4. 그리고 정보가 있다면 컬렉션을 만들고 Json 타입처럼 데이터를 저장한다.