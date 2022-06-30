import 'package:flutter/material.dart';
import 'package:receipts/screens/login.dart';
import 'package:receipts/screens/shop_auth.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Welcome')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>ShopAuth()));
              },
              child: Text('Go To Shop',style:TextStyle(color:Colors.black)),
             style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow)),
            ),
            const SizedBox(height: 20,),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Auth()));
              },
              style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow)),
              child: Text('View Receipts',style:TextStyle(color:Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
