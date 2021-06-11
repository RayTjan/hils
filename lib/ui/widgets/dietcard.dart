part of 'widgets.dart';

class DietCard extends StatefulWidget {
  final Food food;
  final String date;
  DietCard({this.food, this.date});
  @override
  _DietCardState createState() => _DietCardState();
}

class _DietCardState extends State<DietCard> {
  @override
  Widget build(BuildContext context) {
    Food food = widget.food;
    String date = widget.date;
    // if (products == null) {
    //   return Container();
    // }

    return GestureDetector(
        child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffD7F9DB),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 24.0,
            backgroundImage: NetworkImage(food.images),
          ),
          title: Text(
            food.title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 1,
            softWrap: true,
          ),
          subtitle: Text(
            DateFormat('yMMMMd')
                .format(DateFormat("yyyy-mm-dd").parse(date.substring(0, 10))),
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            maxLines: 1,
            softWrap: true,
          ),
        ),
      ),
    ));
  }
}
