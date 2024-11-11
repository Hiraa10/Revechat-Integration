import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_one/visitor_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const platform = MethodChannel('com.example.app/activity');
  Future<void> _openActivity(VisitorModel visitor) async {
    try {
      await platform.invokeMethod('openActivity', visitor.toJson());
    } on PlatformException catch (e) {
      log("Failed to open activity: '${e.message}'.");
    }
  }

  final _formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        const Text("Welcome to the V-Shape",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 50),
                        TextFormField(
                          controller: nameC,
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (value) {
                            return value == null || value.isEmpty
                                ? "Please Enter Name"
                                : null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailC,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (email) {
                            String p =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                            RegExp regExp = RegExp(p);

                            return email == null || email.isEmpty
                                ? "Please Enter Email"
                                : !regExp.hasMatch(email)
                                    ? "Enter a valid email address"
                                    : null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: phoneC,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (value) {
                            return value == null || value.isEmpty
                                ? "Please Enter Phone Number"
                                : null;
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width * .8,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  await _openActivity(VisitorModel(
                                      visitorName: nameC.text,
                                      visitorEmail: emailC.text,
                                      visitorNumber: phoneC.text));
                                }
                              },
                              child: const Text("Go To ChatBot")),
                        )
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
