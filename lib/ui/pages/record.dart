part of 'pages.dart';

class Record extends StatefulWidget {
  Record({Key key}) : super(key: key);

  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection("products");

  Widget buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: productCollection.where('addBy', isEqualTo: uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Failed to load data!");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return ActivityServices.loadings();
          }

          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot doc) {
              Products products;
              //cara 1
              // if (doc.data()['addBy'] == FirebaseAuth.instance.currentUser.uid) {
              products = new Products(
                doc.data()['productId'],
                doc.data()['productName'],
                doc.data()['productDesc'],
                doc.data()['productPrice'],
                doc.data()['productImage'],
                doc.data()['addBy'],
                doc.data()['createdAt'],
                doc.data()['updatedAt'],
              );
              // }
              return ProductCard(products: products);
            }).toList(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Data',
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: buildBody(),
    );
  }
}
