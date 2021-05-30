part of 'widgets.dart';

class ProductCard extends StatefulWidget {
  final Products products;
  ProductCard({this.products});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    Products products = widget.products;

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
            backgroundImage: NetworkImage(products.productImage),
          ),
          title: Text(
            products.productName,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 1,
            softWrap: true,
          ),
          subtitle: Text(
            ActivityServices.toIDR(products.productPrice),
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            maxLines: 1,
            softWrap: true,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(CupertinoIcons.settings),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext ctx) {
                        return Container(
                          height: 120,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(CupertinoIcons.eye_fill),
                                label: Text("Show Data"),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(CupertinoIcons.pencil),
                                label: Text("Edit Data"),
                              ),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  bool result =
                                      await ProductServices.deleteProduct(
                                          products.productId);
                                  if (result) {
                                    ActivityServices.showToast(
                                        "Delete data success", Colors.green);
                                  } else {
                                    ActivityServices.showToast(
                                        "Delete data failed", Colors.red);
                                  }
                                },
                                icon: Icon(CupertinoIcons.delete),
                                label: Text("Data"),
                              )
                            ],
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
