import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isBlockTurn = true;
  int _total_games = 1;
  int _block_win = 0;
  int _circle_win = 0;

  final List _tictactoe_grid = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];

  final Map<int, List<int>> _tictactoe_map = const {
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

  void addBlock_Circle(int index, String turn) {
    setState(() {
      _tictactoe_grid[_tictactoe_map[index]![0]][_tictactoe_map[index]![1]] =
          turn;
      _isBlockTurn = !_isBlockTurn;
    });
    check_draw();
  }

  bool is_block(String turn) {
    return turn == "X";
  }

  void check_draw() {
    if (!check_win() &&
        _tictactoe_grid.where((element) => element.contains('')).isEmpty) {
      print("DRAW");
    }
  }

  bool check_win() {
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
      return _tictactoe_grid[_possibilities[i][0]] ==
          _tictactoe_grid[_possibilities[i][1]];
    }
    // _possibilities.forEach((element) {
    //  });
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
                        addBlock_Circle(index, "X");
                      } else {
                        addBlock_Circle(index, "0");
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
                      child: _tictactoe_grid[_tictactoe_map[index]![0]]
                                  [_tictactoe_map[index]![1]] !=
                              ""
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(is_block(
                                        _tictactoe_grid[
                                                _tictactoe_map[index]![0]]
                                            [_tictactoe_map[index]![1]])
                                    ? 5
                                    : 100),
                                color: is_block(_tictactoe_grid[
                                            _tictactoe_map[index]![0]]
                                        [_tictactoe_map[index]![1]])
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
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(top: 14),
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
                            _block_win.toString(),
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
                            _total_games.toString(),
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
                            _circle_win.toString(),
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
            )
          ],
        ),
      ),
    );
  }
}
