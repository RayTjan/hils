part of 'pages.dart';

class TimerCount extends StatefulWidget {
  TimerCount({Key key}) : super(key: key);

  @override
  _TimerCountState createState() => _TimerCountState();
}

class _TimerCountState extends State<TimerCount> {
  int minute = 3;
  double percent = 1;
  static int timeInMinut = 3;
  static String displayTime = timeInMinut.toString() + "m";
  int timeInSec = timeInMinut * 60;
  int time = 0;
  Timer timer;
  _cancelTimer() {
    print({"CANCEL"});
    percent = 1;
    timeInMinut = minute;
    displayTime = timeInMinut.toString() + "m";
    timer.cancel();
  }

  _changeTimer(bool direction) {
    if (direction) {
      timeInMinut++;
      displayTime = timeInMinut.toString() + "m";
    } else {
      if (timeInMinut >= 1) {
        timeInMinut--;
        displayTime = timeInMinut.toString() + "m";
      }
    }
  }

  _startTimer() {
    print("STARTING");
    timeInMinut = minute;
    displayTime = minute.toString() + "m";
    time = timeInMinut * 60;
    int secPercent = time;
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        if (time > 0) {
          print("TIME :" + time.toString());
          time--;
          if (timeInMinut > 1) {
            if (time % 60 == 0) {
              //timeInMinut--;
              timeInMinut--;
              displayTime = timeInMinut.toString() + "m";
            }
          } else {
            displayTime = time.toString() + "s";
            print("update");
          }
          if ((time * 100) % secPercent == 0) {
            if (percent > 0) {
              percent -= 0.01;
            } else {
              percent = 0;
            }
            print("Tarnation" + percent.toString());
            print(percent);
          }
        } else {
          percent = 1;
          timeInMinut = minute;
          displayTime = minute.toString() + "m";
          timer.cancel();
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
                  colors: [Color(0xff59953c), Color(0xff70b84d)],
                  begin: FractionalOffset(0.5, 1))),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50.0),
              ),
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
                    "$displayTime",
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
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                _changeTimer(true);
                              });
                            },
                            elevation: 2.0,
                            fillColor: Color(0xff70b84d),
                            child: Icon(
                              Icons.arrow_drop_up_outlined,
                              size: 75.0,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                _changeTimer(false);
                              });
                            },
                            elevation: 2.0,
                            fillColor: Color(0xff70b84d),
                            child: Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 75.0,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          ),
                        ],
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: ElevatedButton(
                          onPressed: _startTimer,
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Start",
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

  int getTime() {
    if (timeInMinut == 1) {
      return time;
    } else {
      return timeInMinut;
    }
  }
}
