import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih_2023/Frontend/constant/colors.dart';
import 'package:sih_2023/Frontend/pages/usermodel.dart';
import '../constant/widgets.dart';
import 'firstTab.dart';

TextEditingController _firstNameController = TextEditingController();
TextEditingController _lastNameController = TextEditingController();
TextEditingController _locationController = TextEditingController();
TextEditingController _registerIdController = TextEditingController();
TextEditingController _phoneNameController = TextEditingController();
TextEditingController _typeController = TextEditingController();

class RegisterProvider extends StatefulWidget {
  const RegisterProvider({super.key});

  @override
  State<RegisterProvider> createState() => _RegisterProviderState();
}

class _RegisterProviderState extends State<RegisterProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  customTextWidget(
                      "Register your Profession", 20.0, FontWeight.bold, blue),
                  const SizedBox(
                    height: 30.0,
                  ),
                  myCustomTextfield(
                      controllerName: _firstNameController,
                      hint: "Enter First Name"),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myCustomTextfield(
                      controllerName: _lastNameController,
                      hint: "Enter last Name"),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myCustomTextfield(
                      controllerName: _locationController,
                      hint: "Enter your address"),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myCustomTextfield(
                      controllerName: _typeController,
                      hint: "Enter your Profession type"),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myCustomTextfield(
                    controllerName: _registerIdController,
                    hint: "Enter registeredID",
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  myCustomTextfield(
                    controllerName: _phoneNameController,
                    hint: "Enter mobile Number",
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final firstName = _firstNameController.text;
                      final lastName = _lastNameController.text;
                      final location = _locationController.text;
                      final registerId = _registerIdController.text;
                      final phoneNumber = _phoneNameController.text;
                      final type = _typeController.text;

                      final user = DistributorModel(
                          firstName: firstName,
                          lastName: lastName,
                          location: location,
                          registerId: registerId,
                          phoneNumber: phoneNumber,
                          type: "Distributor");
                      createUser(user);
                      const CircularProgressIndicator();
                      if (firstName != null &&
                          lastName != null &&
                          location != null &&
                          registerId != null &&
                          phoneNumber != null &&
                          type != null) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Register"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Stream<List<DistributorModel>> readUsers() => FirebaseFirestore.instance
    .collection('providers')
    .snapshots()
    .map((snapshot) => snapshot.docs
        .map((doc) => DistributorModel.fromJson(doc.data()))
        .toList());

Future createUser(DistributorModel user) async {
  final docUser = FirebaseFirestore.instance.collection('providers').doc();
  user.id = docUser.id;
  final json = user.toJson();
  await docUser.set(json);
}