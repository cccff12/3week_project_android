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
  List<Map<String, dynamic>> recipes = []; // 레시피 데이터를 저장할 리스트

  @override
  void initState() {
    super.initState();
    fetchData();
  }

// 배경
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
                            if (recipes.isNotEmpty) ...[
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

// 화면에 표시될 목록
  Widget _buildRecipeList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2.0,
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            title: Text('메뉴: ${recipes[index]['category']}'),
            subtitle: Text('목록: ${recipes[index]['oneword']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditDialog(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteDialog(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// dialog를 보여주는 메서드
  void _showEditDialog(int index) {
    TextEditingController categoryController =
        TextEditingController(text: recipes[index]['category']);
    TextEditingController onewordController =
        TextEditingController(text: recipes[index]['oneword']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('레시피 수정'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField('메뉴', categoryController),
                _buildTextField('목록', onewordController),
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

  void _showDeleteDialog(int index) {
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
          .doc(recipes[index]['id'])
          .delete();

      // Firestore에서 삭제된 데이터를 제외하고 데이터를 다시 가져와 화면 업데이트
      fetchData();
    } catch (e) {
      print('Error deleting recipe: $e');
      // 삭제 중 오류 발생 시 사용자에게 알림을 표시하는 등의 처리를 추가
    }
  }

  void _updateRecipe(int index, String category, String oneword) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('recipes')
          .doc(recipes[index]['id'])
          .update({
        'category': category,
        'oneword': oneword,
      });

      // Firestore에서 수정된 데이터를 반영하고 화면 업데이트
      fetchData();
    } catch (e) {
      print('Error updating recipe: $e');
    }
  }

  Widget _buildTextField(String label, TextEditingController controller) {
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
    List<Map<String, dynamic>> tempRecipes = [];

    for (var doc in recipeDocuments.docs) {
      tempRecipes.add({
        'id': doc.id,
        'category': doc['category'],
        'oneword': doc['oneword'],
      });
    }

    // 데이터를 화면에 표시
    setState(() {
      recipes = tempRecipes;
    });
  }
}
