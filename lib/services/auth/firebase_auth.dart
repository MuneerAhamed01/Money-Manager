import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:money_manager/models/user.dart';

class AuthService {
  static AuthService instance = AuthService._();

  FirebaseAuth get _auth => FirebaseAuth.instance;

  AuthService._();

  UserEntity? _user;

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  // Create a user with email and password
  Future<Either<String, UserCredential>> createUserWithEmail(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Right(userCredential);
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Sign in with email and password
  Future<Either<String, UserCredential>> signInWithEmail(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Something went wrong');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> storeUserDetails(
      String uid, String name, String email) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Send OTP (password reset email)
  Future<Either<String, void>> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Delete the user account
  Future<Either<String, void>> deleteUser() async {
    try {
      await _auth.currentUser?.delete();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserEntity?>> getCurrentUserDetails() async {
    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();

      if (user.exists) {
        _user = UserEntity.fromJson(user.data()!);
        return Right(UserEntity.fromJson(user.data()!));
      } else {
        return const Right(null);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Sign out
  Future<Either<String, void>> signOut() async {
    try {
      await _auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}

extension User on GetInterface {
  UserEntity? get user => AuthService.instance._user;
}
