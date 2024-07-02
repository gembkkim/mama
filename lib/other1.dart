import 'package:flutter/material.dart';

class Other1Page extends StatelessWidget {
  const Other1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout'),
      ),
      body: const Center(
        child: Column(
          children: [
            const Text('레이아웃을 이해하기 위해서는 아래 링크를 참조하세요!.'),
            const Text('https://deku.posstree.com/ko/flutter/layout/'),
          ],
        )
      ),
    );
  }
}