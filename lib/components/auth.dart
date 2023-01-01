import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financially/utils/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Auth extends StatefulWidget {
  String option;
  bool otp;

  Map signin = {
    'type': 'Sign In!',
    'switch_info': 'New to Financially?',
    'switch_type': 'Sign Up',
    'confirm': 'Sign In',
  };
  Map signup = {
    'type': 'Sign Up!',
    'switch_info': 'Already have an account?',
    'switch_type': 'Sign In',
    'confirm': 'Register',
  };

  Auth({super.key, required this.option, this.otp = false});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _pin = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String _verificationId = '';

  @override
  void dispose() {
    _phone.dispose();
    _pin.dispose();
    super.dispose();
  }

  Future<bool> findUser(String phone) async {
    final data = await users.doc('+852$phone').get();
    return data.exists;
  }

  Future<void> createWatchlist(String phone) async {
    await users.doc('+852$phone').set({'watchlist': []});
  }

  Future<void> signup() async {
    if (_phone.text.length < 8) {
      _phone.text = '';
      ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar('Mobile number should consist of 8 digits'));
      return;
    }
    final found = await findUser(_phone.text);
    if (found) {
      _phone.text = '';
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar('User already registered'));
    } else {
      await handleOtp();
    }
  }

  Future<void> signin() async {
    if (_phone.text.length < 8) {
      _phone.text = '';
      ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar('Mobile number should consist of 8 digits'));
      return;
    }
    final found = await findUser(_phone.text);
    if (!found) {
      _phone.text = '';
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar('User not registered'));
    } else {
      await handleOtp();
    }
  }

  Future<void> validateOtp(String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: _pin.text);
      await auth.signInWithCredential(credential);
      final o = widget.option == 'signup' ? 'signup' : 'signin';
      if (o == 'signup') {
        await createWatchlist(_phone.text);
        context.router.popUntil((_) => false);
        context.router.pushNamed('/welcome');
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar('Sign up successfully'));
      } else {
        context.router.popUntil((_) => false);
        context.router.pushNamed('/');
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar('Sign in successfully'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        _pin.text = '';
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar('Invalid verification code'));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleOtp() async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+852 ${_phone.text}',
      timeout: const Duration(minutes: 2),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        final o = widget.option == 'signup' ? 'signup' : 'signin';
        if (o == 'signup') {
          await createWatchlist(_phone.text);
          context.router.replaceNamed('/welcome');
          ScaffoldMessenger.of(context)
              .showSnackBar(showSnackBar('Sign up successfully'));
        } else {
          context.router.replaceNamed('/');
          ScaffoldMessenger.of(context)
              .showSnackBar(showSnackBar('Sign in successfully'));
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
          widget.otp = true;
        });
        _verificationId = verificationId;
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar('Please input OTP!'));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 25),
          Text(
            widget.option == 'signin'
                ? widget.signin['type']
                : widget.signup['type'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 70),
          Container(
            width: 350,
            height: 250,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  offset: Offset(2, 0),
                ),
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  offset: Offset(-2, 0),
                ),
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  offset: Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.otp == false ? 'Enter Mobile Number' : 'Enter OTP',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 10),
                  !widget.otp
                      ? TextField(
                          keyboardType: TextInputType.number,
                          enableSuggestions: false,
                          autocorrect: false,
                          textAlign: TextAlign.center,
                          maxLength: 8,
                          controller: _phone,
                          onChanged: (value) {
                            if (value.length == 8) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            counterText: '',
                          ),
                        )
                      : Pinput(
                          length: 6,
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          controller: _pin,
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
          Text(
            widget.otp
                ? "Didn't receive an OTP?"
                : widget.option == 'signin'
                    ? widget.signin['switch_info']
                    : widget.signup['switch_info'],
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          TextButton(
            onPressed: () async {
              if (widget.otp == false) {
                setState(() {
                  widget.option =
                      widget.option == 'signup' ? 'signin' : 'signup';
                  _phone.text = '';
                });
              } else {
                await handleOtp();
              }
            },
            child: Text(
              widget.otp
                  ? 'Resend OTP'
                  : widget.option == 'signup'
                      ? widget.signup['switch_type']
                      : widget.signin['switch_type'],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 70),
          ElevatedButton(
            onPressed: () async {
              if (widget.otp == true) {
                await validateOtp(_verificationId);
              } else if (widget.option == 'signup') {
                await signup();
              } else {
                await signin();
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(320, 50),
              shape: const StadiumBorder(),
            ),
            child: Text(
              !widget.otp
                  ? 'Submit'
                  : widget.option == 'signup'
                      ? widget.signup['confirm']
                      : widget.signin['confirm'],
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
