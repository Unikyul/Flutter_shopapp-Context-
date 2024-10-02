import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShopPage(),
    );
  }
}

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("ShopPage 그림 그려짐");
    return Scaffold(
      appBar: AppBar(title: Text("쇼핑카트")),
      body: Column(
        children: [
          // 1. 이미지, 이미지를 사용해서 사이즈를 맞추러면 AspectRatio 무조건 써야한다.
          Header(),

          // 2. 동그라미 두 개
          _circle(),

          // 3. 텍스트 필드 (아이콘 포함)
          _field(),
        ],
      ),
    );
  }

  //사람아이콘을 특정 위치에 넣고 싶을 때 Stack을 쓴다.
  Stack _field() {
    return Stack(
      children: [
        // 첫 번째 자식: 텍스트 입력 필드
        TextFormField(
          maxLines: 3, // 여러 줄의 입력을 받을 수 있도록 설정
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.person), // 텍스트 필드의 우측에 사람 아이콘을 추가
            enabledBorder: OutlineInputBorder(), // 입력 필드의 외곽선 설정
          ),
        ),
        // 두 번째 자식: 특정 위치에 사람 아이콘을 배치
        Positioned(
          left: 200,
          top: 50,
          child: Icon(Icons.person),
        ),
      ],
    );
  }

  // 동그란 두 개의 컨테이너를 보여주는 위젯
  Container _circle() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white, // 바깥 컨테이너의 배경색
        border: Border.all(), // 바깥 컨테이너의 테두리
        borderRadius: BorderRadius.circular(100),
      ),
      child: Align(
        alignment: Alignment(1.0, 0.0), // -1.0~1.0(가로), -1.0~1.0(세로)
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.deepOrange, // 안쪽 컨테이너의 배경색 (깊은 주황색)
            borderRadius: BorderRadius.circular(75),
          ),
        ),
      ),
    );
  }
}

class Header extends StatefulWidget {
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  // 객체의 상태!
  List<String> imageList = [
    "https://picsum.photos/id/100/200/200",
    "https://picsum.photos/id/101/200/200"
  ];

  // 상태 관리: 현재 선택된 이미지의 인덱스
  int selectedIndex = 0;

  @override
  // build 실행하고 페이지를 다시 그리지 않게 하기 위해 Context를 분리해야 한다.
  // Context를 분리하려면 위젯을 하나 더 만들면 된다.
  // Context를 분리하면 부분 리로딩이 가능하다.
  Widget build(BuildContext context) {
    print("Header 그림 그려짐");
    return Column(
      children: [
        // // 이미지 비율을 유지하기 위한 AspectRatio 사용, 이미지 사용할 때 필수이다!!!
        AspectRatio(
          aspectRatio: 3 / 2,
          child: Image.network(
            imageList[selectedIndex], // 선택된 이미지 URL을 표시
            fit: BoxFit.cover,
          ),
        ),
        Row(
          // 자식 위젯들을 좌우로 고르게 배치
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20), // 버튼 모서리를 둥글게 설정
              ),
              child: IconButton(
                onPressed: () {
                  selectedIndex = 0;
                  print("selectedIndex : $selectedIndex");
                  setState(() {}); // 상태가 변경되었으므로 UI를 다시 그림
                },
                icon: Icon(Icons.account_circle_sharp),
              ),
            ),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                onPressed: () {
                  selectedIndex = 1;
                  print("selectedIndex : $selectedIndex");
                  setState(() {});
                },
                icon: Icon(Icons.access_alarms_sharp), // 상태가 변경되었으므로 UI를 다시 그림
              ),
            ),
          ],
        ),
      ],
    );
  }
}
