import 'package:flutter/foundation.dart';
import '../requests/auth.dart';
import '../services/http_exception.dart';

class AuthData with ChangeNotifier {
    String _token;
    String _userId;
    DateTime _expiryDate;

    /// Check if the user is authenticated or not
    bool get isAuth {
        /// if we have a token and the token isn't expired then return true else return false
        return token != null;
    }

    /// Token getter
    String get token{
        if(_expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token != null) {
            return _token;
        }

        return null;
    }

    /// Sign user up
    Future<void> signUp ({ String email, String password }) async {
        try{
           Map<dynamic,dynamic> result =  await AuthRequest.signUp(email: email, password: password);

           _token = result['token'];
           _expiryDate = result['expiryDate'];
           _userId = result['userId'];

           notifyListeners();

        }catch(error){
            print(error.toString());
            throw HttpException(message: error.message);
        }
    }

    /// Sign user in
    Future<void> signIn ({ String email, String password }) async {
        try{
           Map<dynamic, dynamic> result = await AuthRequest.signIn(email: email, password: password);

            _token = result['token'];
            _expiryDate = result['expiryDate'];
            _userId = result['userId'];

            notifyListeners();

        }catch(error){
            throw HttpException(message: error.toString());
        }
    }
}