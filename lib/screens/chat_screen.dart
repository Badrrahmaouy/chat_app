import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (ctx, index) => Container(
          padding: EdgeInsets.all(10),
          child: Text('This works!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/4vK6dFptuC6mG4S1zcGe/messages')
              .snapshots()
              .listen(
            (data) {
              data.documents.forEach((document) {
                print(document['text']);
              });
            },
          );
        },
      ),
    );
  }
}
