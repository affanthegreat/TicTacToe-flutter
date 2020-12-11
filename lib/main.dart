import 'package:flutter/material.dart';
import 'package:collection/collection.dart';




Color background  = Colors.grey.shade900;
Color foreground = Colors.white;
String playerOne;
String playerTwo;
int playerOneScore = 0;
int playerTwoScore = 0;

List<int> switches = new List<int>.filled(9, 0);
List<int> playerOneChoices = [];
List<int> playerTwoChoices = [];
int playerChance = 0;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NamePage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {





  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void fun(){
    if(playerOne == null && playerTwo== null) {
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
             NamePage()));
    }
  }



  var winningPositions = [
    [0,1,2],[3,4,5],[6.7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]
  ];
  bool gameOver = false;
  Container box(int index){
    return Container(
      height: MediaQuery.of(context).size.height * 0.22,
      width: MediaQuery.of(context).size.width * 0.32,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade700,width: 1),
        color: Colors.blueGrey.shade900
      ),
      child: Center(
        child: switches[index]==0?Container():switches[index]==1?Text("X",style: TextStyle(color: foreground,fontSize: 35,fontWeight: FontWeight.bold),): Text("O",style: TextStyle(color: foreground,fontSize: 35,fontWeight: FontWeight.bold),),
      ),
    );
  }
  String winner;
  GestureDetector butun(int index){
    return GestureDetector(
      onTap: () {
        if(gameOver == false) {
          print(winningPositions.length);
          if (switches[index] == 0) {
            if (playerChance % 2 == 0) {
              playerOneChoices.add(index);
              setState(() {
                switches[index] = 1;
                playerChance++;
              });
              if (playerOneChoices.length >= 3) {
                for (var i = 0; i < 8; i++) {
                  var ls = new List.filled(3, true);
                  var lw = [];
                  winningPositions[i].forEach((ans) {
                    lw.add(playerOneChoices.contains(ans));
                  });
                  print("player 1 lw : $lw");
                  if (IterableEquality().equals(ls, lw)) {
                    gameOver=true;
                    playerOneScore++;
                    winner=playerOne;
                    break;
                  }
                }
              }
            }
            else if (playerChance % 2 == 1) {
              playerTwoChoices.add(index);
              setState(() {
                switches[index] = 2;
                playerChance++;
              });
              if (playerTwoChoices.length >= 3) {
                for (var i = 0; i < 8; i++) {
                  var ls = new List.filled(3, true);
                  var lw = [];
                  winningPositions[i].forEach((ans) {
                    lw.add(playerTwoChoices.contains(ans));
                  });
                  print("player 2 lw : $lw");
                  if (IterableEquality().equals(ls, lw)) {
                    gameOver=true;
                    playerOneScore++;
                   winner = playerTwo;
                    break;
                  }
                }
              }
            }
          }


          print("index: $index");
          print("index ${switches[index]}");
          print("player chance $playerChance");
        }
      },
      child:box(index) ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: gameOver==false?AppBar(
        automaticallyImplyLeading: false,
        title: Text("Tic Tac Toe",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
      ):AppBar(
        backgroundColor: Colors.black.withOpacity(0.8),
        automaticallyImplyLeading: false,
        title: Text("Tic Tac Toe",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white.withOpacity(0.2)),),
        centerTitle: true,
      ),
      body: Stack(
        children:[ Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Wishing you all the best.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("$playerOne   $playerTwo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12),),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("$playerOne is first to play.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("$playerOneScore        $playerTwoScore",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 17),),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              butun(0),
                butun(1),
                butun(2)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                butun(3),
                butun(4),
                butun(5)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                butun(6),
                butun(7),
                butun(8)
              ],
            ),
            GestureDetector(
              onTap: (){
                for(var i = 0 ; i < switches.length ; i++){
                  setState(() {
                    switches[i] = 0;
                  });
                  playerOneChoices.clear();
                  playerTwoChoices.clear();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade800,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(
                    child: Text("Reset board",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),

                ),
              ),
            ),
            Text("version 1 beta",style: TextStyle(color: Colors.grey.shade500,fontSize: 12),)
          ],
          ),
        ),
          gameOver?Container(
            height: MediaQuery.of(context).size.height * 0.95,
            width: MediaQuery.of(context).size.width * 0.99,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8)
            ),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Game Over!\n$winner has Won.\n",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
                ),
                GestureDetector(
                  onTap: (){
                    for(var i = 0 ; i < switches.length ; i++){
                      setState(() {
                        switches[i] = 0;
                        gameOver = false;
                      });
                      playerOneChoices.clear();
                      playerTwoChoices.clear();
                    }
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName("/Page1"));

                  },

                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width* 0.5,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.grey.shade600,width: 1)
                    ),
                    child: Center(
                      child: Text("New Game"),
                    ),
                  ),
                )
              ],
            ),
          ):Container(),
     ]),
    );
  }
}


class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  Color background = Colors.grey.shade900;
  Color foreground = Colors.white;
  TextStyle sty = TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: foreground),
        backgroundColor: background,
        title: Text("Tic Tac Toe",style:TextStyle(color: foreground,fontSize: 15,fontWeight: FontWeight.w900) ,),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        height: MediaQuery.of(context).size.height * 0.55,
        width: MediaQuery.of(context).size.width * 99,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight:Radius.circular(40))
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text("Welcome to Two-Player Tic Tac Toe. \nSay your Names to get started.",style:TextStyle(color: foreground,fontSize: 16,fontWeight: FontWeight.w500),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value){
                    playerOne = value;
                  },
                  style: sty,
                  decoration: new InputDecoration(
                      hintStyle:sty,
                      labelStyle:sty,
                      labelText: 'Player One Name',

                      enabledBorder: new OutlineInputBorder(
                          borderSide:
                          new BorderSide(color: Colors.greenAccent)),
                      disabledBorder:new OutlineInputBorder(
                          borderSide:
                          new BorderSide(color: Colors.greenAccent)) ,
                      border: new OutlineInputBorder(
                          borderSide:
                          new BorderSide(color: Colors.greenAccent))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value){
                    playerTwo = value;
                  },
                  style: sty,
                  decoration: new InputDecoration(
                      hintStyle:sty,
                      labelStyle:sty,
                      labelText: 'Player Two Name',
                      enabledBorder: new OutlineInputBorder(
                          borderSide:
                          new BorderSide(color: Colors.greenAccent)),
                      disabledBorder:new OutlineInputBorder(
                          borderSide:
                          new BorderSide(color: Colors.greenAccent)) ,
                      border: new OutlineInputBorder(
                          borderSide:
                          new BorderSide(color: Colors.greenAccent))),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      settings: RouteSettings(name: "/Page1"),
                      builder: (context) => MainPage(),
                    ),
                  );


                },
                child: Padding(
                  padding: const EdgeInsets.only(top:40.0,left: 20,right: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width *0.6,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: Text(
                        "Let's Go!",
                        style: TextStyle(color: Colors.black,fontFamily: "Roboto",fontSize: 16,fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Divider(color: Colors.grey.shade600,thickness: 1,),
              )
            ],
          ),
        )
        ,
      ),
    );
  }
}
