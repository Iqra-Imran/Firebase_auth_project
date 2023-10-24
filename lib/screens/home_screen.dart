import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:login_shield/reusable_widgets/reusable_button.dart';
import 'package:login_shield/screens/login_screen.dart';
import 'package:login_shield/utensils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool loading = false;
final auth = FirebaseAuth.instance;
final firebaseDatabase = FirebaseDatabase.instance.ref('let post');
final searchFilter = TextEditingController();
final updateController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final postController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                });
              },
              icon: Icon(Icons.logout_sharp))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: TextFormField(
              maxLines: 5,
              controller: postController,
              decoration: InputDecoration(hintText: 'what in your mind'),
            ),
          ),
          ReusableButton(
              loading: loading,
              title: 'Add',
              ontap: () {
                setState(() {
                  loading = true;
                });
                firebaseDatabase.child(id).set({
                  'title': postController.text.toString(),
                  'id': id,
                }).then((value) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage('your post added');
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(error.toString());
                });
              }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: 'search here',
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                defaultChild: Text('loading'),
                query: firebaseDatabase,
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('title').value.toString();
                  if (searchFilter.text.isEmpty) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: (){
                                Navigator.pop(context);
                                showMyDialouge(title,snapshot.child('id').value.toString());
                              },
                              leading: Icon(Icons.edit),
                              title: Text('Edit'),
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              onTap: (){
                                Navigator.pop(context);
                                firebaseDatabase.child(snapshot.child('id').value.toString()).remove();
                              },
                              leading: Icon(Icons.delete),
                              title: Text('Delete'),
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (title.toLowerCase().contains(
                      searchFilter.text.toLowerCase().toLowerCase())) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  } else {
                    return Container();
                  }
                }),
          )
        ],
      ),
    );
  }

  Future<void> showMyDialouge(String title,String id) async {
    updateController.text=title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            actions: [
              TextButton(onPressed: (){
              Navigator.pop(context);

              }, child: Text('Cancel')),
              TextButton(onPressed: (){
              Navigator.pop(context);
              firebaseDatabase.child(id).update({
                'title': updateController.text.toLowerCase()
              }).then((value) {
              Utils().toastMessage('Post updated');
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
              }, child: Text('Update')),
            ],
            content: Container(
              child: TextField(
                controller: updateController,
                decoration: InputDecoration(
                  hintText: 'Edit'
                ),
              ),
            ),
          );
        });
  }
}
