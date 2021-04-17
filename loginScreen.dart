import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flash/AllScreens/mainscreen.dart';
import 'package:flash/AllScreens/registerationScreen.dart';
import 'package:flash/AllWidgets/progressDialog.dart';
import 'package:flash/main.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 2.0,),
              Image(
                image: AssetImage("images/ic_logo.png"),
                width: 450.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(height: 1.0,),
              Text(
                "Đăng nhập để tiếp tục sử dụng FLASH",
                style: TextStyle(fontSize: 20.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Mật Khẩu",
                        labelStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 20.0,),
                    RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Đăng Nhập",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: () {
                        //
                        if (!emailTextEditingController.text.contains("@"))
                        {
                          displayToastMessage("Địa chỉ Email không hợp lệ", context);
                        }
                        else if (passwordTextEditingController.text.isEmpty)
                        {
                          displayToastMessage("Password is mandatory", context);
                        }
                        else
                        {
                          loginAndAuthenticateUser(context);
                        }

                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, RegisterationScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Bạn chưa có tài khoản? Đăng ký ",
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async
  {
    showDialog(
      context: context,
      barrierDismissible:  false,
      builder: (BuildContext context)
      {
        return ProgressDialog(message: "",);
      }
    );
    final User firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errmsg){
      Navigator.pop(context);
      displayToastMessage("Error:" + errmsg.toString() , context);
    })).user;

    if(firebaseUser != null)
    {
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap){
        if(snap.value!=null)
        {
          Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
          displayToastMessage("Đăng ký ngay", context);
        }
        else
        {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage("Tài khoản này chưa được đăng ký, vui lòng tạo tài khoản ạ.", context);
        }
      });
    }
    else
    {
      Navigator.pop(context);
      displayToastMessage("Error", context);
    }
  }
}

