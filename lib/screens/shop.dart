import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:receipts/widgets/c_textfeild.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  bool showQr=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        title:const Center(child: Text('Generate Receipt'))),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 10,),
          
         const SizedBox(
            height: 10,
          ),
          if(showQr==false)
          customTextFeild(50, MediaQuery.of(context).size.width-80, 'Product Name', nameController,
              TextInputType.name, false),
          const SizedBox(
            height: 10,
          ),
          if(showQr==false)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customTextFeild(50, 100, 'Price', priceController,
                  TextInputType.number, false),
              customTextFeild(50, 100, 'number', numberController,
                  TextInputType.number, false),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          if(showQr==false)
          TextButton(
            style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                
              onPressed: () {
                setState(() {
                  showQr=true;
                });
                
                print("{'product_name':'${nameController.text}','price':'${priceController.text}','number':'${numberController.text}'}");
              },
              child: const Text('Save',style: TextStyle(color: Colors.black),)),
              if(showQr==true)
              Center(
                child: QrImage(
            data: '{"product_name":"${nameController.text}","price":"${priceController.text}","number":"${numberController.text}"}',
            size: 200,
            backgroundColor: Colors.white,
            foregroundColor: Colors.pink,
          ),
              ),
        ],
      )),
    );
  }
}
