part of 'widgets.dart';

class FoodCard extends StatefulWidget {
  final Food food;
  FoodCard({this.food});
  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    Food food = widget.food;

    // if (products == null) {
    //   return Container();
    // }

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            radius: 24.0,
            backgroundImage: NetworkImage(food.image),
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
            food.imageType,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            maxLines: 1,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
