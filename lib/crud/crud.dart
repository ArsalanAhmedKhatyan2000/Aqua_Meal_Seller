import 'dart:io';
import 'package:path/path.dart';
import 'package:aqua_meals_seller/helper/preferences.dart';
import 'package:aqua_meals_seller/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CRUD {
  final FirebaseStorage _storageInstance = FirebaseStorage.instance;
  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  signout() async {
    await SharedPreferencesHelper().removeAuthToken();
    await _authInstance.signOut();
  }

  fetchUserCredentials({
    String? userID,
    //  String? password
  }) async {
    DocumentSnapshot<Map<String, dynamic>> _query = await _db
        .collection("users")
        .doc("WvamEGwHsbNkF3KImk2V")
        .collection("sellers")
        .doc(userID)
        .get();
    Map<String, dynamic>? userDataMap = _query.data();
    Users.fromMap(map: userDataMap!);
  }

  Future<void> updateUserProfileImageDataToFirestore(
      {required String? imageURL}) async {
    await _db
        .collection("users")
        .doc("WvamEGwHsbNkF3KImk2V")
        .collection("sellers")
        .doc(Users.getUserId)
        .update({
      "profileImage": imageURL,
    });
  }

  Future<void> updateUserProfileDataFieldToFirestore(
      {required String? fieldName, required String? fieldValue}) async {
    await _db
        .collection("users")
        .doc("WvamEGwHsbNkF3KImk2V")
        .collection("sellers")
        .doc(Users.getUserId)
        .update({
      fieldName!: fieldValue,
    });
  }

  Future<String?> uploadUserImageToStorage({required String? imagePath}) async {
    File imageFile = File(imagePath!);
    String _imageBaseName = basename(imageFile.path);
    Reference imageReference = _storageInstance
        .ref()
        .child("images")
        .child("Sellers")
        .child(Users.getUserId!)
        .child("userProfileImage")
        .child(_imageBaseName);
    await imageReference.putFile(imageFile);
    String getImageUrl = await imageReference.getDownloadURL();
    return getImageUrl;
  }

  Future<void> deleteUserProfileImageFromStorage(
      {required String? imageURL}) async {
    String? imageName = imageURL!.split('2F')[4].split('?alt')[0];
    await _storageInstance
        .ref()
        .child("images")
        .child("Sellers")
        .child(Users.getUserId!)
        .child("userProfileImage")
        .child(imageName)
        .delete();
  }

  Future<void> updatePasswordToAuth({String? newPassword}) async {
    await _authInstance.currentUser!.updatePassword(newPassword!);
  }

  Future<void> reAuthenticateCurrentUser() async {
    await _authInstance.currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
            email: Users.getEmail!, password: Users.getPassword!));
  }

  Future<void> updateEmailToAuth({String? newEmail}) async {
    await _authInstance.currentUser!.updateEmail(newEmail!);
  }

  Future<void> emailVerificationSend({String? newEmail}) async {
    await _authInstance.currentUser!.sendEmailVerification();
  }

  bool isEmailVerified() {
    return _authInstance.currentUser!.emailVerified;
  }

  Future<void> reloadUser() async {
    return await _authInstance.currentUser!.reload();
  }
}
