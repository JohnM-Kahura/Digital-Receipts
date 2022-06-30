import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receipts/screens/shop.dart';

import '../widgets/c_textfeild.dart';

class ShopAuth extends StatefulWidget {
  const ShopAuth({ Key? key }) : super(key: key);

  @override
  State<ShopAuth> createState() => _ShopAuthState();
}

class _ShopAuthState extends State<ShopAuth> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  Future _signInWithEmailAndPassword() async {
    final User? user = (await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey,

      appBar: AppBar(elevation: 0,title: const  Center(child: Text('Shop Authentication')),),
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
            
            customTextFeild(50, MediaQuery.of(context).size.width-100, 'Password', passwordController,
                TextInputType.visiblePassword, false),
            const SizedBox(
              height: 10,
            ),
            
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                
                onPressed: ()  {

                 _signInWithEmailAndPassword();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const  Shop()));
                },
                child: const Text('Login to shop',style:TextStyle(color:Colors.black))),
            
          ],
        ),
    ),
    );
  }
}