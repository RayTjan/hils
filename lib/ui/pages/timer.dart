part of 'pages.dart';

class TimerCount extends StatefulWidget {
  TimerCount({Key key}) : super(key: key);

  @override
  _TimerCountState createState() => _TimerCountState();
}

class _TimerCountState extends State<TimerCount> {
  int minute = 3;
  double percent = 1;
  int timeInMinut = 3;
  String displayTime = "3m";
  int time = 0;
  Timer timer;
  bool btnState = false;
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
      minute++;
      displayTime = timeInMinut.toString() + "m";
    } else {
      if (timeInMinut > 1) {
        timeInMinut--;
        minute--;

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 100.0),
              ),
              Text(
                "TIMER",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
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
                height: 50.0,
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              size: 50.0,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          ),
                          SizedBox(
                            width: 60,
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
                              size: 50.0,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          ),
                        ],
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              btnState ? _cancelTimer() : _startTimer();
                              if (btnState == true) {
                                btnState = false;
                              } else {
                                btnState = true;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff70b84d),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 80, right: 80, top: 10, bottom: 10),
                            child: Text(
                              btnState ? "Stop" : "Start",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
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
