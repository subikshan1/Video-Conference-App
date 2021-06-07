import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File image;
  String pic,name;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData() async{
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      name = snapshot.data()['UserName'];
      pic = snapshot.data()['ProfilePic'];
    });

  }



  //ProfileImage
  Future pickImage() async {
    var Image = await ImagePicker.pickImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: Image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    var result = await FlutterImageCompress.compressAndGetFile(
      Image.path,croppedFile.path,
      quality: 30,

    );
    setState(() {
      image = result;
      isLoading = true;
    });
    StorageReference ImageReference = FirebaseStorage.instance.ref().child(FirebaseAuth.instance.currentUser.uid);
    StorageUploadTask uploadTask = ImageReference.child('ProfilePic').putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      pic = url;
    });
    FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser.uid).update({
      "ProfilePic":url
    });
    setState(() {
      pic = url;
      isLoading = false;
    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: isLoading ? new Center(child: new CircularProgressIndicator(),): new Stack(
        fit: StackFit.expand,
        children: [
           pic != null?new FractionallySizedBox(
             alignment: Alignment.topCenter,
             heightFactor: 0.7,
             child: new Container(
               decoration: new BoxDecoration(
                 image: new DecorationImage(
                   image: new NetworkImage(pic),fit: BoxFit.cover
                 )
               ),
             ),
           ) :new Container(),
          new FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.3,
            child: new Container(
              height: MediaQuery.of(context).size.height*0.35,
              decoration: new BoxDecoration(
                  color: Colors.white
              ),
              child: new Column(
                children: [
                 SizedBox(height: 10,),
                 name!=null? new Text(name,style: new TextStyle(fontWeight: FontWeight.w800,fontSize: 32),):new Container(),
                  SizedBox(height: 5,),
                  new InkWell(
                    child: new Container(
                      width: 200,
                      height: 40,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(20),color: Colors.green
                      ),
                      child: new Center(child: Text('Edit Name',style: new TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white),),)
                    ),
                  ),
                  SizedBox(height: 10,),
                  new InkWell(
                    child: new Container(
                        width: 200,
                        height: 40,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(20),color: Colors.blue
                        ),
                        child: InkWell(
                            onTap: (){
                              pickImage();
                            },
                            child: new Center(child: Text('Edit Profile',style: new TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white),),))
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
