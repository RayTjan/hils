part of 'services.dart';

class ActivityServices {
  static String dateNow() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    String hasil = formatter.format(now);
    return hasil;
  }

  static int getDateLocation() {
    String dayName = DateFormat('EEEE').format(new DateTime.now());
    for (int i = 0; i < 7; i++) {
      if (dayName == Glovar.days[i]) {
        return i;
      }
    }
    return 0;
  }

  static String getDateName(String format) {
    return DateFormat(format).format(new DateTime.now());
  }

  static String getDayNameBeforeAndAfter(int month, int loc, bool position) {
    int theDay = 0;
    if (position) {
      if (month + loc > 6) {
        theDay = month + loc - 7;
      } else {
        theDay = month + loc;
      }
    } else {
      if (month - loc < 0) {
        theDay = 7 + (month - loc);
      } else {
        theDay = month - loc;
      }
    }
    return Glovar.days[theDay].substring(0, 3);
  }

  static int getDayBeforeAndAfter(int day, int loc, bool position) {
    int theDay = day;
    if (position) {
      if (day + loc > 31) {
        theDay = day + loc - 31;
      } else {
        theDay = day + loc;
      }
    } else {
      if (day - loc <= 0) {
        theDay = 31 + (day - loc);
      } else {
        theDay = day - loc;
      }
    }
    return theDay;
  }

  static void showToast(String msg, Color mycolor) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: mycolor,
        textColor: Colors.white,
        fontSize: 14);
  }

  static Container loadings() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black26,
      child: SpinKitFadingCircle(
        size: 50,
        color: Colors.green[800],
      ),
    );
  }

  static String toIDR(String price) {
    final priceFormat = NumberFormat.currency(locale: 'ID');
    return priceFormat.format(double.parse(price));
  }
}
