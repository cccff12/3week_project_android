import 'package:cloud_firestore/cloud_firestore.dart';

class _FeedModel {
  final String uid;
  final String docId;
  final String image;
  final String path;
  final Timestamp dateTime;

  const _FeedModel({
    required this.uid,
    required this.docId,
    required this.image,
    required this.path,
    required this.dateTime,
  });
  factory _FeedModel.fromFirestore(Map<String, dynamic> json) {
    return _FeedModel(
      uid: json["uid"],
      docId: json["docId"],
      image: json["image"],
      path: json["path"],
      dateTime: json["dateTime"],
    );
  }
  Map<String, dynamic> toFirestore() => {
        "uid": uid,
        "docId": docId,
        "image": image,
        "path": path,
        "dateTime": dateTime,
      };
}
