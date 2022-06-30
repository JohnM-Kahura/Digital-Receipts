
import 'package:flutter/material.dart';
import 'package:receipts/screens/scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream<QuerySnapshot> receipt =
      FirebaseFirestore.instance.collection('receipts').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(elevation: 0,title:const  Center(child: Text('Receipts')),),
    body: StreamBuilder<QuerySnapshot>(stream: receipt,builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
      if(snapshot.hasError){
          return const  Text('An error occured during data retrieval from firebase');
        }
        if(snapshot.connectionState==ConnectionState.waiting){
            return const  Center(child: CircularProgressIndicator() ,);
          }
          final receipts=snapshot.requireData;
      
      return ListView.builder(
        itemCount:receipts.docs.length,
        itemBuilder: (BuildContext context, index) {
    return Container(
      margin: const EdgeInsets.all(8) ,
      // height: 100,
      width: double.infinity,
      decoration: BoxDecoration(

      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      ),

      child: Column(children: [

        Container(
          margin:const EdgeInsets.only(top:15,left:15,right: 15,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
            Padding(
              padding:EdgeInsets.only(left:8.0),
              child: Text(receipts.docs[index]['product_name'],style: TextStyle(fontWeight: FontWeight.w700,fontSize:20,)),
            ),
            Text('\$'+receipts.docs[index]['price'],style:TextStyle(fontWeight:FontWeight.bold,fontSize: 25)),
          ],),
        ),
        Container(
          margin:const EdgeInsets.only(left:15,right:15),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
           const  Padding(
              padding: const EdgeInsets.only(left:8.0),
              child:  Text('Number : ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
            ),
            Text(receipts.docs[index]['number'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500))
          ],),
        ),
        Container(
          margin:const EdgeInsets.only(left:15,right:15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child:  Text(receipts.docs[index]['date'].toDate().toString(),),
            ),
            IconButton(onPressed: ()
          =>  Share.share("""
Product Name : ${receipts.docs[index]['product_name']} 
Price : ${receipts.docs[index]['price']}
Number : ${receipts.docs[index]['number']},
Date : ${receipts.docs[index]['date'].toDate().toString()}
""")
              
           
          , icon:const  Icon(Icons.share,color: Colors.black,))
          ],),
        ),
        
      
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
        ],),
      ],),

    );
   },);
    },),
   floatingActionButton: FloatingActionButton(onPressed: (){
     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> const Scan()));
  
   },child: Icon(Icons.qr_code_2),),
    );
  }
}