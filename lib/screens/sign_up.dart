import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receipts/screens/login.dart';

import '../widgets/c_textfeild.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController v_passwordController = TextEditingController();
  Future _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )).user ;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey,
      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Create account')),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(
            //   height: 50,
            // ),
            Center(
              child: customTextFeild(50, MediaQuery.of(context).size.width-100, 'email', emailController,
                  TextInputType.emailAddress, false),
            ),
            const SizedBox(
              height: 10,
            ),
           
            const SizedBox(
              height: 10,
            ),
            customTextFeild(50,MediaQuery.of(context).size.width-100 , 'Password', passwordController,
                TextInputType.visiblePassword, false),
            const SizedBox(
              height: 10,
            ),
            
            TextButton(
               style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                onPressed: ()  {
                    _register();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                content: Text("Account created succesfully",style: TextStyle(color:Colors.white),),
                duration: Duration(milliseconds: 300),
              ));
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) 
                   
                    => const Auth()
                  ));
                },
                child: const Text('Create Account',style:TextStyle(color:Colors.black))),
            TextButton(
               style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const Register()));
                },
                child: const Text('login',style:TextStyle(color:Colors.black)))
          ],
        ),
      ),
    );
  }
}
