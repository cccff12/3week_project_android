firebase 는 데이터 안에 또 데이터가 저장되는 방식이다.

컬렉션- 문서- 필드 순서다

# 레시피 입력창
- 만약 아이디를 가지고 있으면 그 아이디 안에 레시피에 들어갈 내용을(ex: 한마디, 재료 , ...) 등을 요소로 저장. 이 방식은 회원가입과 유사함
데이터 입력도 회원가입과 유사하게 가지만 . 데이터 안에 또 데이터를 저장하는 건 다를거다. 이부분은 검색 필요
- 그리고 레시피 번호도 입력해야 하는데 이 부분은 작성자가 넣지 않고 자동입력. (변수를 하나 빈칸으로 만들어 누적하는 방식으로 가야할듯 

-그리고 이 변수도 db에 저장해서 꺼내 쓸수도 있으면 좋고(꺼내서 레시피 등록할때마다 ++) 아니면 코드에만 저장하고 누적 가능한지 테스트)

# 제일 최신 레시피
 모든 아이디의 필드중에 레시피 번호가 가장 높은 순서대로 나열