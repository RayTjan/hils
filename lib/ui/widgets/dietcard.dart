part of 'widgets.dart';

class DietCard extends StatefulWidget {
  final Food food;
  DietCard({this.food});
  @override
  _DietCardState createState() => _DietCardState();
}

class _DietCardState extends State<DietCard> {
  @override
  Widget build(BuildContext context) {
    Food food = widget.food;

    // if (products == null) {
    //   return Container();
    // }

    return GestureDetector(
        child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: Container(
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
            "Total Calories : " + food.calories,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            maxLines: 1,
            softWrap: true,
          ),
        ),
      ),
    ));
  }
}
