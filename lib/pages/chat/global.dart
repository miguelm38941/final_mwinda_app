import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Global {
  static String Username;
  static String Uid;
  static String currentChat;
  static String ChatTitle;
  static String OtherUserId;
  static bool isGroup=false;
  static bool EditGroup=false;
  static List<String> users;
  static List<String> username;
  static Color MainColor = Colors.lightBlue;
}

EnterData({String type, String Data}) async {

 // Fluttertoast.showToast(msg: "Entering ONe 2 One Data");

  await Firestore.instance
      .collection('Chats')
      .document('chat')
      .collection(Global.currentChat)
      .document()
      .setData({
    'name':Global.Username,
    'msg': Data,
    'type': type,
    'timestamp': FieldValue.serverTimestamp(),
    'uid': Global.Uid,
    'groupchat':Global.isGroup,
    'msgby':Global.Username,
  });

  await Firestore.instance
      .collection('users')
      .document(Global.OtherUserId)
      .collection('chat')
      .document(Global.Uid)
      .updateData({

    'msg': Data,
    'type': type,
    'timestamp': FieldValue.serverTimestamp(),
    'uid': Global.Uid,
    'groupchat':Global.isGroup,
    'msgby':Global.Username,
  });

  await Firestore.instance
      .collection('users')
      .document(Global.Uid)
      .collection('chat')
      .document(Global.OtherUserId)
      .updateData({

    'msg': Data,
    'type': type,
    'timestamp': FieldValue.serverTimestamp(),
    'uid': Global.Uid,
    'groupchat':Global.isGroup,
    'msgby':Global.Username,
  });

}

Future<File> GetImage() async {
  Global global = new Global();

  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        cropStyle: CropStyle.rectangle,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop',
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile != null) {
      File newImagem =
          await testCompressAndGetFile(croppedFile, croppedFile.path, 200);
      final StorageReference storageReferencem = FirebaseStorage()
          .ref()
          .child(Global.Uid + "/" + "${DateTime.now().millisecondsSinceEpoch}");
      final StorageUploadTask uploadTaskm =
          storageReferencem.putFile(newImagem);
      await uploadTaskm.onComplete;
      await storageReferencem.getDownloadURL().then((url) {
        print("Download URL : " + url);

        EnterData(type: "image", Data: url);
      });
    }
  }
}

Future<File> testCompressAndGetFile(
    File file, String targetPath, int size) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: 88,
    minHeight: size,
    minWidth: size,
  );
  print(file.lengthSync());
  print(result.lengthSync());
  return result;
}

AvailableUser(context, {String number, bool answer}) async {
  bool reg;
  DocumentSnapshot documentSnapshot;
  await Firestore.instance
      .collection('users')
      .document(number)
      .get()
      .then((ds) {
    documentSnapshot=ds;
    if (ds.data == null) {
      reg = false;
    } else {
      reg = true;
      print("Adding awsd");
      print(answer);
      if (answer == null) {
        print("Adding aws");
        AddChatUser(context, number: number,documentSnapshot: documentSnapshot);
      }
    }
  });

  return reg;
}

AddChatUser(context, {String number,DocumentSnapshot documentSnapshot}) async {
  bool reg;

    await Firestore.instance
        .collection('users')
        .document(Global.Uid)
        .collection('chat')
        .document(number)
        .setData({
      'type':'user',
      'name':documentSnapshot['name'],
      'phone':number,
      'groupchat':false
    });


  await Firestore.instance
      .collection('users')
      .document(number)
      .collection('chat')
      .document(Global.Uid)
      .setData({
    'type':'user',
    'name':documentSnapshot['name'],
    'phone':number,
    'groupchat':false
  });



  Global.ChatTitle=documentSnapshot['name'];
  Global.currentChat = number;
  Global.OtherUserId = number;

  if (int.parse(Global.currentChat) >
      int.parse(Global.Uid)) {
    Global.currentChat =
        Global.currentChat + "+" + Global.Uid;
  }else
  {
    Global.currentChat =
        Global.Uid + "+" + Global.currentChat;
  }


  print("Current Chat "+Global.currentChat);
//  Fluttertoast.showToast(msg: Global.currentChat,toastLength: Toast.LENGTH_SHORT);
  Navigator.of(context).pop();
  Navigator.of(context).pushNamed('chat');
}


AddGroup(context,{String name,List<String> users}) async {


  final postRef =   await Firestore.instance
      .collection('users')
      .document(Global.Uid)
      .collection('chat')
      .add({
    'type':'text',
    'name':name,
    'users':users,
    'admin':Global.Uid,
    'groupchat':true,
    'msg':"Group Created",
    'msgby':Global.Username
  });

  await Firestore.instance
      .collection('Chats').
        document('chat')
      .collection(postRef.documentID);

users.add(Global.Uid);

  for(int i =0;i<users.length;i++)
    {
      await Firestore.instance
          .collection('users')
          .document(users[i])
          .collection('chat')
          .document(postRef.documentID)
          .setData({
        'type':'text',
        'name':name,
        'users':users,
        'admin':Global.Uid,
        'groupchat':true
        ,
        'msg':"Group Created",
        'msgby':Global.Username
      });
    }
  print("New Registration");
  Global.isGroup=true;
  Global.ChatTitle=name;
  Global.currentChat = postRef.documentID;
  Navigator.of(context).pop();
  Navigator.of(context).pushNamed('chat');
}




EnterGroupData({String type, String Data}) async {

//  Fluttertoast.showToast(msg: "Entering Group Data");

  await Firestore.instance
      .collection('Chats')
      .document('chat')
      .collection(Global.currentChat)
      .document()
      .setData({
    'name':Global.Username,
    'msgby':Global.Username,
    'msg': Data,
    'type': type,
    'timestamp': FieldValue.serverTimestamp(),
    'uid': Global.Uid,
    'groupchat':Global.isGroup

  });

  await Firestore.instance
      .collection('users')
      .document(Global.OtherUserId)
      .collection('chat')
      .document(Global.currentChat)
      .updateData({
    'msgby':Global.Username,
    'msg': Data,
    'type': type,
    'timestamp': FieldValue.serverTimestamp(),
    'uid': Global.Uid,

  });


  await Firestore.instance
      .collection('users')
      .document(Global.Uid)
      .collection('chat')
      .document(Global.currentChat)
      .updateData({
    'msgby':Global.Username,
    'msg': Data,
    'type': type,
    'timestamp': FieldValue.serverTimestamp(),
    'uid': Global.Uid,

  });





}