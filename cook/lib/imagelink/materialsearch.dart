import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook/bagick/myappbar.dart';
import 'package:cook/bagick/mybackground.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MaterialSearch extends StatefulWidget {
  const MaterialSearch({super.key});

  @override
  State<MaterialSearch> createState() => _MaterialSearchState();
}

class _MaterialSearchState extends State<MaterialSearch> {
  User? user = FirebaseAuth.instance.currentUser;
  String? email;
  String? name;
  String? nickname;
  String? password;
  String? tel;
  List<String> categories = [];
  List<String> cookingMethods = [];
  List<String> introductions = [];
  List<String> materials = [];
  List<int> nums = [];
  List<String> onewords = [];
  List<String> uids = [];
  List<String> recipeIDs = [];
  bool dataVisible = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        decoration: myBackgroundColor(),
        child: SizedBox(
          width: 1000,
          height: 1000,
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            // Firestore에서 가져온 데이터를 화면에 표시
                            if (dataVisible) ...[
                              // if (email != null) Text('이메일: $email'),
                              // if (name != null) Text('이름: $name'),
                              // if (nickname != null) Text('닉네임: $nickname'),
                              // if (password != null) Text('비밀번호: $password'),
                              // if (tel != null) Text('전화번호: $tel'),
                              _buildRecipeList(),
                            ],
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2.0,
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            title: Text('카테고리: ${categories[index]}'),
            subtitle: Text('조리 방법: ${cookingMethods[index]}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditRecipeDialog(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteRecipeDialog(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteRecipeDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('레시피 삭제'),
          content: const Text('정말로 이 레시피를 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // Firestore에서 해당 레시피 삭제
                _deleteRecipe(index);

                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );
  }

  void _deleteRecipe(int index) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('recipes')
          .doc(recipeIDs[index])
          .delete();

      // Firestore에서 삭제된 데이터를 제외하고 데이터를 다시 가져와 화면 업데이트
      fetchData();
    } catch (e) {
      print('Error deleting recipe: $e');
      // 삭제 중 오류 발생 시 사용자에게 알림을 표시하는 등의 처리를 추가할 수 있습니다.
    }
  }

  void _showEditRecipeDialog(int index) {
    final TextEditingController categoryController =
        TextEditingController(text: categories[index]);
    final TextEditingController cookingMethodController =
        TextEditingController(text: cookingMethods[index]);
    final TextEditingController introductionController =
        TextEditingController(text: introductions[index]);
    final TextEditingController materialController =
        TextEditingController(text: materials[index]);
    final TextEditingController numController =
        TextEditingController(text: nums[index].toString());
    final TextEditingController onewordController =
        TextEditingController(text: onewords[index]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('레시피 수정'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEditTextField('카테고리', categoryController),
                _buildEditTextField('조리 방법', cookingMethodController),
                _buildEditTextField('소개', introductionController),
                _buildEditTextField('재료', materialController),
                _buildEditTextField('숫자', numController),
                _buildEditTextField('한마디', onewordController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 수정된 데이터를 Firestore에 업데이트
                _updateRecipe(
                  index,
                  categoryController.text,
                  cookingMethodController.text,
                  introductionController.text,
                  materialController.text,
                  int.parse(numController.text),
                  onewordController.text,
                );

                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text('저장'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          TextField(
            controller: controller,
          ),
        ],
      ),
    );
  }

  void _updateRecipe(
    int index,
    String category,
    String cookingMethod,
    String introduction,
    String material,
    int num,
    String oneword,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('recipes')
          .doc(recipeIDs[index])
          .update({
        'category': category,
        'cookingmethod': cookingMethod,
        'introduction': introduction,
        'material': material,
        'num': num,
        'oneword': oneword,
      });

      // Firestore에서 수정된 데이터를 반영하고 화면 업데이트
      fetchData();
    } catch (e) {
      print('Error updating recipe: $e');
      // 수정 중 오류 발생 시 사용자에게 알림을 표시하는 등의 처리를 추가할 수 있습니다.
    }
  }

  // 데이터를 불러와 화면에 표시하는 함수
  Future<void> fetchData() async {
    // Firestore에서 사용자 문서를 가져오기
    DocumentSnapshot userDocument = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    Map<String, dynamic>? userData =
        userDocument.data() as Map<String, dynamic>?;

    // "recipes" 컬렉션의 문서 가져오기
    QuerySnapshot recipeDocuments = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('recipes')
        .get();

    // 필요한 필드를 읽어오기
    categories.clear();
    cookingMethods.clear();
    introductions.clear();
    materials.clear();
    nums.clear();
    onewords.clear();
    recipeIDs.clear();

    for (var doc in recipeDocuments.docs) {
      categories.add(doc['category']);
      cookingMethods.add(doc['cookingmethod']);
      introductions.add(doc['introduction']);
      materials.add(doc['material']);
      nums.add(doc['num']);
      onewords.add(doc['oneword']);
      recipeIDs.add(doc.id);
    }

    // 데이터를 화면에 표시
    setState(() {
      email = userData?['email'];
      name = userData?['name'];
      nickname = userData?['nickname'];
      password = userData?['password'];
      tel = userData?['tel'];
    });
  }
}
