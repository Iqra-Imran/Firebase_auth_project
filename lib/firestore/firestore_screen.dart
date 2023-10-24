import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_shield/reusable_widgets/reusable_button.dart';
import 'package:login_shield/utensils/utils.dart';
class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}
bool loading = false;
final firestoreFetch = FirebaseFirestore.instance.collection('users').snapshots();
CollectionReference reference = FirebaseFirestore.instance.collection('users');
final updateFeildController = TextEditingController();
class _FireStoreScreenState extends State<FireStoreScreen> {
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance.collection('users');
    final feildController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: TextField(
              maxLines: 4,
              controller: feildController,
              decoration: InputDecoration(
                hintText: 'what in your mind',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10,),
          ReusableButton(title: 'Add', ontap: () {
            setState(() {
              loading = loading;
            });
            String id = DateTime
                .now()
                .millisecondsSinceEpoch
                .toString();
            firestore.doc(id).set({
              'title': feildController.text.toString(),
              'id': id,
            }).then((value) {
              setState(() {
                loading = false;
              });
              Utils().toastMessage('post added');
            }).onError((error, stackTrace) {
              setState(() {
                loading = false;
              });
              Utils().toastMessage(error.toString());
            });
          }),
          StreamBuilder<QuerySnapshot>(
              stream: firestoreFetch,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                if (snapshot.hasError)
                  return Text('some error');
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                snapshot.data!.docs[index]['title'].toString()),
                            subtitle: Text(snapshot.data!.docs[index]['id']
                                .toString()),
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) =>
                              [
                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                       showDialog(
                                           context: context, builder: (BuildContext contex){
                                         return AlertDialog(
                                           title: Text('update'),
                                           actions: [
                                             TextButton(onPressed: (){
                                               Navigator.pop(context);
                                             }, child: Text('cancel')),
                                             TextButton(onPressed: (){
                                               Navigator.pop(context);
                                               reference.doc(snapshot.data!.docs[index]['id'].toString()).update(
                                                   {

                                                   }).then((value) {
                                                    Utils().toastMessage('udated');
                                               }).onError((error, stackTrace) {
                                                 Utils().toastMessage('some error has occured');
                                               });
                                             }, child: Text('update')),
                                           ],
                                           content: Container(
                                             child: TextField(
                                               controller: updateFeildController,
                                               decoration: InputDecoration(
                                                 hintText: 'text here'
                                               ),
                                             ),
                                           ),
                                         );
                                       });
                                      },
                                      leading: Icon(Icons.edit),
                                      title: Text('Edit'),
                                    )
                                ),
                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      leading: Icon(Icons.delete),
                                      title: Text('Delete'),
                                    )
                                )
                              ],
                            ),
                          );
                        }));
              }
          )
        ],
      ),
    );
  }

  Future<void> showMyDialouge(String title, String id) async {
    updateFeildController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text('Cancel')),
              TextButton(onPressed: () {
                Navigator.pop(context);
                reference.doc('id').update({
                  'title': updateFeildController.text.toLowerCase()
                }).then((value) {
                  Utils().toastMessage('Post updated');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              }, child: Text('Update')),
            ],
            content: Container(
              child: TextField(
                controller: updateFeildController,
                decoration: InputDecoration(
                    hintText: 'Edit'
                ),
              ),
            ),
          );
        });
  }
}