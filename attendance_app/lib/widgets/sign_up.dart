// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../theme.dart';
// import 'snackbar.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';


// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);

//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   final FocusNode focusNodePassword = FocusNode();
//   final FocusNode focusNodeConfirmPassword = FocusNode();
//   final FocusNode focusNodeEmail = FocusNode();
//   final FocusNode focusNodeName = FocusNode();
//   final FocusNode focusNodeRegistrationId = FocusNode(); // New FocusNode
//   XFile? _imageFile;
//   final ImagePicker _picker = ImagePicker();
//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);
//     setState(() {
//       _imageFile = pickedFile;
//     });
//   }
//   void _showPicker(context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return SafeArea(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                   leading: Icon(Icons.photo_library, color: Colors.teal[900]),
//                   title: Text('Gallery', style: TextStyle(fontFamily: 'RobotoMono')),
//                   onTap: () {
//                     _pickImage(ImageSource.gallery);
//                     Navigator.of(context).pop();
//                   }),
//               ListTile(
//                 leading: Icon(Icons.camera_alt, color: Colors.teal[900]),
//                 title: Text('Camera', style: TextStyle(fontFamily: 'RobotoMono')),
//                 onTap: () {
//                   _pickImage(ImageSource.camera);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   bool _obscureTextPassword = true;
//   bool _obscureTextConfirmPassword = true;

//   TextEditingController signupEmailController = TextEditingController();
//   TextEditingController signupNameController = TextEditingController();
//   TextEditingController signupPasswordController = TextEditingController();
//   TextEditingController signupConfirmPasswordController = TextEditingController();
//   TextEditingController signupRegistrationIdController = TextEditingController(); // New Controller

//   @override
//   void dispose() {
//     focusNodePassword.dispose();
//     focusNodeConfirmPassword.dispose();
//     focusNodeEmail.dispose();
//     focusNodeName.dispose();
//     focusNodeRegistrationId.dispose(); // Dispose new focus node
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 23.0),
//       child: Column(
//         children: <Widget>[
//           Stack(
//             alignment: Alignment.topCenter,
//             children: <Widget>[
//               Card(
//                 elevation: 2.0,
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: MediaQuery.of(context).size.height * 0.3,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.9),
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 10,
//                             offset: Offset(0, 5),
//                           ),
//                         ],
//                         image: _imageFile != null
//                             ? DecorationImage(
//                                 image: FileImage(
//                                   File(_imageFile!.path),
//                                 ),
//                                 fit: BoxFit.cover,
//                               )
//                             : null,
//                       ),
//                       child: _imageFile == null
//                           ? Icon(
//                               Icons.add_a_photo,
//                               color: Colors.teal[900],
//                               size: 60,
//                             )
//                           : null,
//                     ),
//                     Container(
//                       width: 300.0,
//                       height: 420.0, // Increased height to accommodate new field
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                               child: TextField(
//                                 focusNode: focusNodeName,
//                                 controller: signupNameController,
//                                 keyboardType: TextInputType.text,
//                                 textCapitalization: TextCapitalization.words,
//                                 autocorrect: false,
//                                 style: const TextStyle(
//                                     fontFamily: 'WorkSansSemiBold',
//                                     fontSize: 16.0,
//                                     color: Colors.black),
//                                 decoration: const InputDecoration(
//                                   border: InputBorder.none,
//                                   icon: Icon(
//                                     FontAwesomeIcons.user,
//                                     color: Colors.black,
//                                   ),
//                                   hintText: 'Names',
//                                   hintStyle: TextStyle(
//                                       fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
//                                 ),
//                                 onSubmitted: (_) {
//                                   focusNodeEmail.requestFocus();
//                                 },
//                               ),
//                             ),
//                             Container(
//                               width: 250.0,
//                               height: 1.0,
//                               color: Colors.grey[400],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                               child: TextField(
//                                 focusNode: focusNodeEmail,
//                                 controller: signupEmailController,
//                                 keyboardType: TextInputType.emailAddress,
//                                 autocorrect: false,
//                                 style: const TextStyle(
//                                     fontFamily: 'WorkSansSemiBold',
//                                     fontSize: 16.0,
//                                     color: Colors.black),
//                                 decoration: const InputDecoration(
//                                   border: InputBorder.none,
//                                   icon: Icon(
//                                     FontAwesomeIcons.envelope,
//                                     color: Colors.black,
//                                   ),
//                                   hintText: 'Email Address',
//                                   hintStyle: TextStyle(
//                                       fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
//                                 ),
//                                 onSubmitted: (_) {
//                                   focusNodeRegistrationId.requestFocus(); // Request focus for registration ID
//                                 },
//                               ),
//                             ),
//                             Container(
//                               width: 250.0,
//                               height: 1.0,
//                               color: Colors.grey[400],
//                             ),
//                             // New Registration ID Field
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                               child: TextField(
//                                 focusNode: focusNodeRegistrationId,
//                                 controller: signupRegistrationIdController,
//                                 keyboardType: TextInputType.text,
//                                 autocorrect: false,
//                                 style: const TextStyle(
//                                     fontFamily: 'WorkSansSemiBold',
//                                     fontSize: 16.0,
//                                     color: Colors.black),
//                                 decoration: const InputDecoration(
//                                   border: InputBorder.none,
//                                   icon: Icon(
//                                     FontAwesomeIcons.idCard,
//                                     color: Colors.black,
//                                   ),
//                                   hintText: 'Registration ID',
//                                   hintStyle: TextStyle(
//                                       fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
//                                 ),
//                                 onSubmitted: (_) {
//                                   focusNodePassword.requestFocus(); // Request focus for password after registration ID
//                                 },
//                               ),
//                             ),
//                             Container(
//                               width: 250.0,
//                               height: 1.0,
//                               color: Colors.grey[400],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                               child: TextField(
//                                 focusNode: focusNodePassword,
//                                 controller: signupPasswordController,
//                                 obscureText: _obscureTextPassword,
//                                 autocorrect: false,
//                                 style: const TextStyle(
//                                     fontFamily: 'WorkSansSemiBold',
//                                     fontSize: 16.0,
//                                     color: Colors.black),
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   icon: const Icon(
//                                     FontAwesomeIcons.lock,
//                                     color: Colors.black,
//                                   ),
//                                   hintText: 'Password',
//                                   hintStyle: const TextStyle(
//                                       fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
//                                   suffixIcon: GestureDetector(
//                                     onTap: _toggleSignup,
//                                     child: Icon(
//                                       _obscureTextPassword
//                                           ? FontAwesomeIcons.eye
//                                           : FontAwesomeIcons.eyeSlash,
//                                       size: 15.0,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                                 onSubmitted: (_) {
//                                   focusNodeConfirmPassword.requestFocus();
//                                 },
//                               ),
//                             ),
//                             Container(
//                               width: 250.0,
//                               height: 1.0,
//                               color: Colors.grey[400],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
//                               child: TextField(
//                                 focusNode: focusNodeConfirmPassword,
//                                 controller: signupConfirmPasswordController,
//                                 obscureText: _obscureTextConfirmPassword,
//                                 autocorrect: false,
//                                 style: const TextStyle(
//                                     fontFamily: 'WorkSansSemiBold',
//                                     fontSize: 16.0,
//                                     color: Colors.black),
//                                 decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   icon: const Icon(
//                                     FontAwesomeIcons.lock,
//                                     color: Colors.black,
//                                   ),
//                                   hintText: 'Confirmation',
//                                   hintStyle: const TextStyle(
//                                       fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
//                                   suffixIcon: GestureDetector(
//                                     onTap: _toggleSignupConfirm,
//                                     child: Icon(
//                                       _obscureTextConfirmPassword
//                                           ? FontAwesomeIcons.eye
//                                           : FontAwesomeIcons.eyeSlash,
//                                       size: 15.0,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                                 onSubmitted: (_) {
//                                   _toggleSignUpButton();
//                                 },
//                                 textInputAction: TextInputAction.go,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 400.0), // Adjusted for new field
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                       color: CustomTheme.loginGradientStart,
//                       offset: Offset(1.0, 6.0),
//                       blurRadius: 20.0,
//                     ),
//                     BoxShadow(
//                       color: CustomTheme.loginGradientEnd,
//                       offset: Offset(1.0, 6.0),
//                       blurRadius: 20.0,
//                     ),
//                   ],
//                   gradient: LinearGradient(
//                       colors: <Color>[
//                         CustomTheme.loginGradientEnd,
//                         CustomTheme.loginGradientStart
//                       ],
//                       begin: FractionalOffset(0.2, 0.2),
//                       end: FractionalOffset(1.0, 1.0),
//                       stops: <double>[0.0, 1.0],
//                       tileMode: TileMode.clamp),
//                 ),
//                 child: MaterialButton(
//                   highlightColor: Colors.transparent,
//                   splashColor: CustomTheme.loginGradientEnd,
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(
//                         vertical: 10.0, horizontal: 42.0),
//                     child: Text(
//                       'SIGN UP',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 25.0,
//                           fontFamily: 'WorkSansBold'),
//                     ),
//                   ),
//                   onPressed: () => _toggleSignUpButton(),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void _toggleSignup() {
//     setState(() {
//       _obscureTextPassword = !_obscureTextPassword;
//     });
//   }

//   void _toggleSignupConfirm() {
//     setState(() {
//       _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
//     });
//   }

//   void _toggleSignUpButton() {
//     // Handle signup action
//     CustomSnackBar(context, const Text('SignUp button pressed'));
//   }
// }





import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme.dart';
import 'snackbar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeName = FocusNode();
  final FocusNode focusNodeRegistrationId = FocusNode(); // New FocusNode
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.teal[900]),
                title: Text('Gallery', style: TextStyle(fontFamily: 'RobotoMono')),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                }),
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.teal[900]),
                title: Text('Camera', style: TextStyle(fontFamily: 'RobotoMono')),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController = TextEditingController();
  TextEditingController signupRegistrationIdController = TextEditingController(); // New Controller

  @override
  void dispose() {
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    focusNodeEmail.dispose();
    focusNodeName.dispose();
    focusNodeRegistrationId.dispose(); // Dispose new focus node
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery for dynamic sizing based on device size
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 23.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                      _showPicker(context);
                    },
                        child: Container(
                            width: double.infinity,
                            height: screenHeight * 0.3,  // Make image height responsive
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              image: _imageFile != null
                                  ? DecorationImage(
                                      image: FileImage(
                                        File(_imageFile!.path),
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: _imageFile == null
                                ? Icon(
                                    Icons.add_a_photo,
                                    color: Colors.teal[900],
                                    size: 60,
                                  )
                                : null,
                          ),
                      ),
                        SizedBox(height :10),
                      Card(
                        elevation: 2.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            children: <Widget>[
                              _buildTextField(
                                focusNode: focusNodeName,
                                controller: signupNameController,
                                hintText: "Name",
                                icon: FontAwesomeIcons.user,
                                onSubmitted: (_) => focusNodeEmail.requestFocus(),
                              ),
                              _divider(),
                              _buildTextField(
                                focusNode: focusNodeEmail,
                                controller: signupEmailController,
                                hintText: "Email Address",
                                icon: FontAwesomeIcons.envelope,
                                onSubmitted: (_) => focusNodeRegistrationId.requestFocus(),
                              ),
                              _divider(),
                              _buildTextField(
                                focusNode: focusNodeRegistrationId,
                                controller: signupRegistrationIdController,
                                hintText: "Registration ID",
                                icon: FontAwesomeIcons.idCard,
                                onSubmitted: (_) => focusNodePassword.requestFocus(),
                              ),
                              _divider(),
                              _buildTextField(
                                focusNode: focusNodePassword,
                                controller: signupPasswordController,
                                hintText: "Password",
                                icon: FontAwesomeIcons.lock,
                                obscureText: _obscureTextPassword,
                                togglePassword: _toggleSignup,
                              ),
                              _divider(),
                              _buildTextField(
                                focusNode: focusNodeConfirmPassword,
                                controller: signupConfirmPasswordController,
                                hintText: "Confirm Password",
                                icon: FontAwesomeIcons.lock,
                                obscureText: _obscureTextConfirmPassword,
                                togglePassword: _toggleSignupConfirm,
                                onSubmitted: (_) => _toggleSignUpButton(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: -20.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: CustomTheme.loginGradientStart,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: CustomTheme.loginGradientEnd,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        gradient: LinearGradient(
                            colors: <Color>[
                              CustomTheme.loginGradientEnd,
                              CustomTheme.loginGradientStart
                            ],
                            begin: FractionalOffset(0.2, 0.2),
                            end: FractionalOffset(1.0, 1.0),
                            stops: <double>[0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: CustomTheme.loginGradientEnd,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: 'WorkSansBold'),
                          ),
                        ),
                        onPressed: () => _toggleSignUpButton(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable TextField Widget
  Widget _buildTextField({
    required FocusNode focusNode,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Function()? togglePassword,
    Function(String)? onSubmitted,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText,
        autocorrect: false,
        style: const TextStyle(
            fontFamily: 'WorkSansSemiBold', fontSize: 16.0, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon, color: Colors.black),
          hintText: hintText,
          hintStyle: const TextStyle(
              fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
          suffixIcon: togglePassword != null
              ? GestureDetector(
                  onTap: togglePassword,
                  child: Icon(
                    obscureText
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    size: 15.0,
                    color: Colors.black,
                  ),
                )
              : null,
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }

  // Divider for separating fields
  Widget _divider() {
    return Container(
      width: 250.0,
      height: 1.0,
      color: Colors.grey[400],
    );
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  void _toggleSignUpButton() {
    // Add your sign-up logic here
  }
}
