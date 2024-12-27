import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Page',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  double _jackpotProbability = 0.01;
  bool _isJackpot = false;

  void _incrementCounter() {
    if (!_isJackpot) {
      setState(() {
        _counter++;
        if (_counter > 10 && _counter % 2 != 0) {
          _isJackpot = true;
          _showJackpotDialog();
        } else {
          if (_jackpotProbability < 0.05) {
            _jackpotProbability += 0.01;
          }
        }
      });
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _counter = 0;
      _isJackpot = false;
      _jackpotProbability = 0.01;
    });
  }

  void _showJackpotDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selamat!"),
          content: Text("Anda 'Jackpot' pada angka $_counter"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      _counter = 0;
      _isJackpot = false;
      _jackpotProbability = 0.01;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Nilai Counter:',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                ),
              ),
              Text(
                _counter % 2 == 0 ? "Genap" : "Ganjil",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _isJackpot ? null : _incrementCounter,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.white,
                    minimumSize: Size(150, 45)),
                child: Text(
                  'Tambah',
                  style: TextStyle(
                      fontFamily: "Poppins", fontWeight: FontWeight.w600),
                ),
              ),
              ElevatedButton(
                onPressed: _resetGame,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    minimumSize: Size(150, 45)),
                child: Text(
                  'Restart Game',
                  style: TextStyle(
                      fontFamily: "Poppins", fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Probabilitas Jackpot ${(_jackpotProbability * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
