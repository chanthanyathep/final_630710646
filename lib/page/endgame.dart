
import 'package:final_630710646/page/homepage.dart';
import 'package:flutter/material.dart';

class endgame extends StatelessWidget {
  const endgame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text(
                  'จบเกม',style: TextStyle(
                  fontSize: 40.0,
                ),
                ),
              ),
              Container(
                child: Text(
                  'ทายผิดทั้งหมด ${homepage.invalidanswer.toString()} ครั้ง',style: TextStyle(
                  fontSize: 40.0,
                ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(onPressed: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const homepage())
                  );
                }, child: Text('เริ่มเกมใหม่')),
              )
            ],
          ),
        ],
      ),
    );
  }
}
