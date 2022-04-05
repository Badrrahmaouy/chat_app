import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  final String username;

  Messages(this.username);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            // .where('username', isEqualTo: username)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = chatSnapshot.hasData ? chatSnapshot.data.docs : '';
          final content = chatDocs != null
              ? ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) => MessageBubble(
                    chatDocs[index].data()['text'],
                    chatDocs[index].data()['username'],
                    chatDocs[index].data()['userImage'],
                    chatDocs[index].data()['userId'] == user.uid,
                    key: ValueKey(
                      chatDocs[index].id,
                    ),
                  ),
                )
              : Center(
                  child: Text('No messages yet!'),
                );
          return content;
        });
  }
}
