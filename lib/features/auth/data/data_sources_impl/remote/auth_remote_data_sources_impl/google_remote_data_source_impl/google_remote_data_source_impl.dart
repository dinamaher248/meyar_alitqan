import 'package:either_dart/either.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/api/api_constants.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../core/helper/network_validation.dart';
import '../../../../../domain/entities/auth/auth_user_entity/auth_user_entity.dart';
import '../../../../data_sources/remote/auth_remote_data_sources/google_remote_data_source/google_remote_data_source.dart';

@Injectable(as: GoogleRemoteDataSource)
class GoogleRemoteDataSourceImpl implements GoogleRemoteDataSource {
  GoogleSignIn? _googleSignIn;

  GoogleRemoteDataSourceImpl() {
    /// 🔹 Mobile only
    if (!kIsWeb) {
      _googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
        serverClientId: ApiConstants.serverClientId,
      );
    }
  }

  @override
  Future<Either<Failures, AuthUserEntity>> signInWithGoogle() async {
    try {
      debugPrint('🟢 GOOGLE SIGN IN START');

      /// 🌐 Check internet
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      /// ===============================
      /// 🌐 WEB LOGIN
      /// ===============================
      if (kIsWeb) {
        await Supabase.instance.client.auth.signInWithOAuth(
          OAuthProvider.google,
          redirectTo: Uri.base.origin,
        );

        /// ⛔ هنا مفيش user لسه (redirect هيحصل)
        return Left(ServerFailure('REDIRECTING'));
      }

      /// ===============================
      /// 📱 MOBILE LOGIN
      /// ===============================

      String? fcmToken = await FirebaseMessaging.instance.getToken();

      /// force account chooser
      await _googleSignIn!.signOut();

      final googleUser = await _googleSignIn!.signIn();

      if (googleUser == null) {
        return Left(ServerFailure('GOOGLE_SIGN_IN_CANCELLED'));
      }

      final googleAuth = await googleUser.authentication;

      if (googleAuth.idToken == null) {
        return Left(ServerFailure('GOOGLE_TOKEN_NULL'));
      }

      /// 🔐 login to Supabase
      final authResponse =
      await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken,
      );

      final user = authResponse.user;

      if (user == null) {
        return Left(ServerFailure('SUPABASE_AUTH_FAILED'));
      }

      /// 🔥 call edge function
      await Supabase.instance.client.functions.invoke(
        'google_auth',
        body: {
          'role': 'customer',
          'fcm_token': fcmToken,
          'platform': 'android',
        },
      );

      debugPrint('🎉 GOOGLE SIGN IN SUCCESS (MOBILE)');

      return Right(
        AuthUserEntity(
          id: user.id,
          email: user.email ?? '',
          role: 'customer',
        ),
      );
    } catch (e, s) {
      debugPrint('🔥 GOOGLE SIGN IN ERROR');
      debugPrint(e.toString());
      debugPrint(s.toString());

      return Left(ServerFailure(e.toString()));
    }
  }
}