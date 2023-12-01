import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var hasil;
  String oprasi = '';
  int bilangan = 0;
  int numberDot = 0;
  double paddingSize = 0.0;
  bool heightBannerTop = false;
  bool selected = true;
  String TextMe = "text";
  int _mainColor = 0xFF30314D;
  var inputUser = ['', '0'];
  var bilPertama = null;
  var bilKedua = null;
  List<dynamic> historyNum = [];
  List<String> allHistory = [];
  int numberOfOperation = 0;
  List<dynamic> countMore = [];

  @override
  Widget build(BuildContext context) {
    double HeightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    final ButtonStyle BtnStyle = ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Color(_mainColor),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))));

    final TextStyle txtStyle = TextStyle(
        fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white);

    final List<dynamic> buttons = [
      'C',
      '+/-',
      '%',
      'DEL',
      7,
      8,
      9,
      '/',
      4,
      5,
      6,
      'x',
      1,
      2,
      3,
      '-',
      0,
      '.',
      '=',
      '+',
    ];

    void clearInput() {
      inputUser.clear();
      inputUser.add('');
      inputUser.add('0');
    }

    void clearBilangan() {
      bilPertama = null;
      bilKedua = null;
    }

    // KeyPad
    Widget keyPadCalculator() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: HeightScreen * 0.70,
          child: AspectRatio(
            aspectRatio: 0.9,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: buttons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        child: ElevatedButton(
                          onPressed: () {
                            // ControlInput
                            setState(() {
                              if (hasil != null) {
                                hasil = null;
                              }
                              switch (buttons[index]) {
                                case 'C':
                                  {
                                    bilangan = 0;
                                    clearBilangan();
                                    clearInput();
                                    historyNum.clear();
                                    oprasi = '';
                                    countMore.clear();
                                  }
                                  break;
                                case '+/-':
                                  {
                                    if (inputUser.length > 1 &&
                                        inputUser[1] != '0') {
                                      String bilJoin = inputUser.join('');
                                      int bilangan = int.parse(bilJoin);
                                      if (bilangan.isNegative) {
                                        inputUser[0] = '';
                                      } else {
                                        inputUser[0] = '-';
                                      }
                                      print(inputUser);
                                    }
                                  }
                                  break;
                                case '%':
                                  {}
                                  break;
                                case 'DEL':
                                  {
                                    if (inputUser.length > 2) {
                                      inputUser.removeLast();
                                      print(inputUser);
                                    }
                                    if (inputUser.length == 2) {
                                      inputUser[1] = '0';
                                      inputUser[0] = '';
                                    }
                                  }
                                  break;
                                case '/':
                                  {}
                                  break;
                                case 'x':
                                  {}
                                  break;
                                case '-':
                                  {}
                                  break;
                                case '+':
                                  {
                                    if (countMore.length > 3) {
                                      bilPertama =
                                          countMore[countMore.length - 2];
                                      String bilJoin = inputUser.join('');
                                      bilKedua = int.parse(bilJoin);
                                      hasil = addOpration(bilPertama, bilKedua);
                                      countMore.addAll([hasil, oprasi]);
                                      historyNum.addAll([bilKedua, oprasi]);
                                      clearInput();
                                    } else {
                                      String bilJoin = inputUser.join('');
                                      bilPertama = int.parse(bilJoin);
                                      oprasi = '+';

                                      if (countMore.length >= 2 &&
                                          countMore.length < 3) {
                                        hasil = addOpration(
                                            countMore[countMore.length - 2],
                                            bilPertama);
                                        countMore.addAll([hasil, oprasi]);
                                        historyNum.addAll([bilPertama, oprasi]);
                                      } else {
                                        countMore.addAll([bilPertama, oprasi]);
                                        historyNum.addAll([bilPertama, oprasi]);
                                      }

                                      // countMore.addAll([hasil, oprasi]);
                                      clearInput();
                                    }
                                  }
                                  break;
                                case '=':
                                  {
                                    if (oprasi != '' && bilPertama != null) {
                                      switch (oprasi) {
                                        case '+':
                                          {
                                            String bilJoin = inputUser.join('');
                                            bilKedua = int.parse(bilJoin);

                                            if (countMore.isNotEmpty) {
                                              hasil = addOpration(countMore[countMore.length - 2],bilKedua);
                                              historyNum.addAll([bilKedua, '\n= ', hasil]);
                                              allHistory.add(historyNum.toString());
                                              historyNum.clear();
                                              countMore.clear();
                                              numberOfOperation = 0;

                                            } else {
                                              hasil = addOpration(
                                                  bilPertama, bilKedua);
                                              clearInput();
                                              clearBilangan();
                                              numberOfOperation = 0;
                                            }
                                          }
                                          break;
                                        default:
                                      }
                                    }
                                  }
                                  break;
                                case '.':
                                  {}
                                  break;
                                case 9:
                                  {
                                    if (inputUser[1] == '0') {
                                      inputUser[1] = '9';
                                    } else {
                                      inputUser.add('9');
                                    }
                                  }
                                  break;
                                case 8:
                                  {
                                    if (inputUser[1] == '0') {
                                      inputUser[1] = '8';
                                    } else {
                                      inputUser.add('8');
                                    }
                                  }
                                  break;
                                case 7:
                                  {
                                    if (inputUser[1] == '0') {
                                      inputUser[1] = '7';
                                    } else {
                                      inputUser.add('7');
                                    }
                                  }
                                  break;
                                case 6:
                                  {
                                    if (inputUser[1] == '0') {
                                      inputUser[1] = '6';
                                    } else {
                                      inputUser.add('6');
                                    }
                                  }
                                  break;
                                case 5:
                                  {
                                    if (inputUser[1] == '0') {
                                      inputUser[1] = '5';
                                    } else {
                                      inputUser.add('5');
                                    }
                                  }
                                  break;
                                case 4:
                                  {
                                    if (inputUser[1] == '0') {
                                      inputUser[1] = '4';
                                    } else {
                                      inputUser.add('4');
                                    }
                                  }
                                  break;
                                case 3:
                                  {
                                    if (inputUser[1] == '0') {
                                      inputUser[1] = '3';
                                    } else {
                                      inputUser.add('3');
                                    }
                                  }
                                  break;
                                case 2:
                                  {
                                    if (inputUser[1] == '0') {
                                      inputUser[1] = '2';
                                    } else {
                                      inputUser.add('2');
                                    }
                                  }
                                  break;
                                case 1:
                                  {
                                    if (inputUser[1] == '0') {
                                      inputUser[1] = '1';
                                    } else {
                                      inputUser.add('1');
                                    }
                                  }
                                  break;
                                case 0:
                                  {
                                    if (inputUser[1] != 0 &&
                                        inputUser.length > 2) {
                                      inputUser.add('0');
                                    }
                                    print(inputUser);
                                  }
                                  break;
                              }
                            });
                          },
                          child: Text(
                            buttons[index].toString(),
                            style: txtStyle,
                          ),
                          style: BtnStyle,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget showNumberWhenMiniSlide() {
      return Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                historyNum.isNotEmpty
                    ? historyNum
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(',', ' ')
                        .replaceAll(']', '')
                    : '',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(150, 255, 255, 255)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              hasil == null
                  ? inputUser
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', '')
                      .replaceAll(',', '')
                      .replaceAll(' ', '')
                  : hasil.toString(),
              style: txtStyle,
            ),
          ],
        ),
      );
    }

    Widget showNumberWhenFullSlide() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: allHistory.length,
              itemBuilder: (BuildContext context, int index) {
                int num = index;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: widthScreen -10,
                      decoration: BoxDecoration(
                      color: Color(0xFF4f8182),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            print(allHistory[num].replaceAll('[', '').replaceAll(']', ''));
                            print(allHistory[num].length);
                            for (var i = 0; i == allHistory[num].length; i++) {
                              print(allHistory[num]);
                            }
                            // historyNum.add(allHistory[num].replaceAll('[', '').replaceAll(']', ''));
                          },
                          child: Text(
                            allHistory.length >= 1
                                ? allHistory[num].replaceAll('[', '')
                              .replaceAll(']', '')
                              .replaceAll(',', '')
                              .replaceAll(' ', '')
                                : '',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(76, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                );
              },
            ),
          ),
          Text(
            hasil == null
                ? inputUser
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', '')
                    .replaceAll(',', '')
                    .replaceAll(' ', '')
                : hasil.toString(),
            style: txtStyle,
          ),
        ],
      );
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          print('History Num : ' + historyNum.toString());
          print('bil 1 : ' + bilPertama.toString());
          print('bil 2 : ' + bilKedua.toString());
          print('counte more : ' + countMore.toString());

          print('all History : ' + allHistory.toString());
        }),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: widthScreen,
            height: HeightScreen - MediaQuery.of(context).padding.top,
            child: Stack(
              children: [
                Container(
                    alignment: Alignment.bottomCenter,
                    color: Color(_mainColor)),
                selected ? keyPadCalculator() : Container(),
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    int sensitivity = 8;
                    if (details.delta.dy > sensitivity) {
                      setState(() {
                        heightBannerTop = true;
                      });
                      // Down Swipe
                    } else if (details.delta.dy < -sensitivity) {
                      // Up Swipe
                      setState(() {
                        heightBannerTop = false;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.linearToEaseOut,
                    width: widthScreen,
                    height: heightBannerTop
                        ? HeightScreen * 0.8
                        : HeightScreen * 0.3,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF4f8182), Color(0xFF373a5d)]),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(0, 5))
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        )),
                    // Top
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                    child: heightBannerTop
                                        ? showNumberWhenFullSlide()
                                        : showNumberWhenMiniSlide())),
                          ),
                          Column(
                            children: [
                              Expanded(
                                  child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: widthScreen,
                                  height: HeightScreen * 0.4 * 0.15,
                                  // color: Colors.blue,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: GestureDetector(
                                            onTap: () {
                                              // Print Test
                                              print('Imput User : ' +
                                                  inputUser.toString() +
                                                  '\nBil pertama :' +
                                                  bilPertama.toString() +
                                                  '\nBilangan : ' +
                                                  bilangan.toString() +
                                                  '\nBilangan Kedua : ' +
                                                  bilKedua.toString());
                                            },
                                            child: Icon(
                                              Icons.workspaces_filled,
                                              color: Colors.white,
                                            )),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selected = !selected;
                                          });
                                        },
                                        child: Container(
                                          height: HeightScreen * 0.4 * 0.15 - 8,
                                          width: widthScreen * 0.7,
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: widthScreen * 0.7,
                                                height:
                                                    HeightScreen * 0.4 * 0.15 -
                                                        8,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF466671),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width:
                                                          widthScreen * 0.7 / 2,
                                                      child: Center(
                                                        child: Text(
                                                          selected
                                                              ? ''
                                                              : 'Calculator',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFFE9EAEC),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          widthScreen * 0.7 / 2,
                                                      child: Center(
                                                        child: Text(
                                                          selected
                                                              ? 'Convert'
                                                              : '',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFFE9EAEC),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.fastOutSlowIn,
                                                padding: EdgeInsets.only(
                                                    left: selected
                                                        ? 0
                                                        : widthScreen *
                                                            0.7 /
                                                            2),
                                                child: Container(
                                                  width: widthScreen * 0.7 / 2,
                                                  height: HeightScreen *
                                                          0.4 *
                                                          0.15 -
                                                      8,
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .bottomLeft,
                                                          end: Alignment
                                                              .topRight,
                                                          colors: [
                                                            Color(0xFF4eb38b)
                                                                .withOpacity(
                                                                    0.7),
                                                            Color(0xFF4eb38b)
                                                                .withOpacity(
                                                                    0.8),
                                                            Color(0xFF4eb38b)
                                                                .withOpacity(
                                                                    0.9),
                                                            Color(0xFF4eb38b)
                                                                .withOpacity(1)
                                                          ]),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 2,
                                                            blurRadius: 3,
                                                            offset:
                                                                Offset(0, 0.5))
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Center(
                                                    child: Text(
                                                      selected
                                                          ? 'Calculator'
                                                          : 'Convert',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFE9EAEC),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 5,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF23283f),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  num addOpration(int nilai1, nilai2) {
    var jumlah = nilai1 + nilai2;
    return jumlah;
  }
}


/*  

- ketika klik salah satu history di slide masukan ke history num
- dapat mengubah angka di history num

*/