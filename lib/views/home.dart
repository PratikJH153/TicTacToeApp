import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isBlockTurn = true;
  int _totalGames = 0;
  int _blockWin = 0;
  int _circleWin = 0;
  bool _gameOver = false;

  List _tictactoeGrid = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];

  final Map<int, List<int>> _tictactoeMap = const {
    0: [0, 0],
    1: [0, 1],
    2: [0, 2],
    3: [1, 0],
    4: [1, 1],
    5: [1, 2],
    6: [2, 0],
    7: [2, 1],
    8: [2, 2],
  };

  void addBlockCircle(int index, String turn) {
    if (!_gameOver) {
      setState(() {
        _tictactoeGrid[_tictactoeMap[index]![0]][_tictactoeMap[index]![1]] =
            turn;
        _isBlockTurn = !_isBlockTurn;
      });
      checkDraw();
    }
  }

  bool isBlock(String turn) {
    return turn == "X";
  }

  void checkDraw() {
    if (!checkWin() &&
        _tictactoeGrid.where((element) => element.contains('')).isEmpty) {
      setState(() {
        _gameOver = !_gameOver;
      });
    }
  }

  void _playAgain() {
    setState(() {
      _gameOver = !_gameOver;
      _tictactoeGrid = [
        ['', '', ''],
        ['', '', ''],
        ['', '', ''],
      ];
    });
  }

  bool checkWin() {
    const List<List<int>> _possibilities = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 4, 8],
      [2, 4, 6],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
    ];

    for (int i = 0; i < _possibilities.length; i++) {
      var x = _tictactoeGrid[_tictactoeMap[_possibilities[i][0]]![0]]
          [_tictactoeMap[_possibilities[i][0]]![1]];
      var y = _tictactoeGrid[_tictactoeMap[_possibilities[i][1]]![0]]
          [_tictactoeMap[_possibilities[i][1]]![1]];
      var z = _tictactoeGrid[_tictactoeMap[_possibilities[i][2]]![0]]
          [_tictactoeMap[_possibilities[i][2]]![1]];
      if (x == "X" && y == "X" && z == "X") {
        setState(() {
          _gameOver = !_gameOver;
          _blockWin += 1;
          _totalGames += 1;
        });
      } else if (x == "0" && y == "0" && z == "0") {
        setState(() {
          _gameOver = !_gameOver;
          _circleWin += 1;
          _totalGames += 1;
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF25282d),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.clear),
          iconSize: 30,
          onPressed: () {},
        ),
        title: _isBlockTurn
            ? const Text("block's turn")
            : const Text("circle's turn"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 50,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      if (_isBlockTurn) {
                        addBlockCircle(index, "X");
                      } else {
                        addBlockCircle(index, "0");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: const Color(0xFF25282d),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF1b1b1b),
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: _tictactoeGrid[_tictactoeMap[index]![0]]
                                  [_tictactoeMap[index]![1]] !=
                              ""
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(isBlock(
                                        _tictactoeGrid[_tictactoeMap[index]![0]]
                                            [_tictactoeMap[index]![1]])
                                    ? 5
                                    : 100),
                                color: isBlock(
                                        _tictactoeGrid[_tictactoeMap[index]![0]]
                                            [_tictactoeMap[index]![1]])
                                    ? Colors.deepPurple
                                    : Colors.pink,
                              ),
                            )
                          : Container(),
                    ),
                  );
                },
                itemCount: 9,
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 14, bottom: 10),
                  color: const Color(0xFF25282d),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: [
                            Text(
                              "block",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              _blockWin.toString(),
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 36,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: [
                            Text(
                              "games",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              _totalGames.toString(),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 3,
                              width: 40,
                              color: Colors.grey[600],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: [
                            Text(
                              "circle",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              _circleWin.toString(),
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 36,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (_gameOver)
                  InkWell(
                    onTap: () {
                      _playAgain();
                    },
                    child: Container(
                      width: double.infinity,
                      color: Colors.blue,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(15),
                      child: const Text(
                        "Play Again?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
