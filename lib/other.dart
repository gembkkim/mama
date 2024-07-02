import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});


  //final myController = TextEditingController();
  //final myController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('다른 페이지'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.all(8.0),
                  child:const TextField(
                    //controller: myController,
                    //inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Zㄱ-ㅎ가-힣]')),],
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '사용자ID',
                    ),
                  ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                child:const TextField(
                  //controller: myController1,
                  obscureText: true,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '비밀번호',
                  ),
                ),
              ),
              // FloatingActionButton(
              //     child:Icon(Icons.print),
              //     onPressed: () => showDialog(
              //         context:context,
              //         builder:(context) {
              //           return AlertDialog(content: Text(myController.text));
              //         }
              //     )
              // ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Go back to Previous Page'),
                onPressed: () {
                  Navigator.pop(context); //이전 페이지로 돌아감
                },
              ),
            ],
          )








        ),
      ),
    );
  }
}