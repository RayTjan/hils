part of 'pages.dart';

class TimerCount extends StatefulWidget {
  TimerCount({Key key}) : super(key: key);

  @override
  _TimerCountState createState() => _TimerCountState();
}

class _TimerCountState extends State<TimerCount> {
  int minute = 3;
  double percent = 0;
  static int timeInMinut = 3;
  int timeInSec = timeInMinut * 60;

  Timer timer;
  _cancelTimer() {
    print("Cancelled");
    timer.cancel();
  }

  _startTimer() {
    print("STARTING");
    timeInMinut = minute;
    int time = timeInMinut * 60;
    double secPercent = (time / 100);
    new Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (time > 0) {
          print("TIME :" + time.toString());
          time--;
          if (time % 60 == 0) {
            timeInMinut--;
          }
          if (time % secPercent == 0) {
            if (percent < 1) {
              percent += 0.01;
            } else {
              percent = 1;
            }
            print(percent);
          } else {
            percent = 0;
            timeInMinut = minute;
            timer.cancel();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff1542bf), Color(0xff51a8ff)],
                  begin: FractionalOffset(0.5, 1))),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Text("Pomodoro Clock",
                      style: TextStyle(color: Colors.white, fontSize: 20.0))),
              Expanded(
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: percent,
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 250.0,
                  lineWidth: 20.0,
                  progressColor: Colors.white,
                  center: Text(
                    "$timeInMinut",
                    style: TextStyle(color: Colors.white, fontSize: 80.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                    child: Column(children: <Widget>[
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Column(
                            children: <Widget>[
                              Text(
                                "Study Timer",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "25",
                                style: TextStyle(fontSize: 60.0),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: <Widget>[
                              Text(
                                "Pause Timer",
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "5",
                                style: TextStyle(fontSize: 60.0),
                              ),
                            ],
                          ))
                        ],
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: ElevatedButton(
                          onPressed: _startTimer,
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Start Studying",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: ElevatedButton(
                          onPressed: _cancelTimer,
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Stop",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.0),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
