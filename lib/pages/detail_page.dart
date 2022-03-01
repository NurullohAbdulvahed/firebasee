import 'package:firepost/model/post_model.dart';
import 'package:firepost/services/pref_service.dart';
import 'package:firepost/services/realtime_service.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';


class DetailPage extends StatefulWidget {
  static final String id = "detail_page";
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();


  void _addPost()async{
   String title = titleController.text.trim().toString();
   String content = contentController.text.trim().toString();
   if(title.isEmpty || content.isEmpty) return;
   _apiAdd(title,content);

  }
  void _apiAdd(String title,String content) async{
    var id =await Prefs.loadUserId();
    RTDBService.addPost(Post(userId: id ?? "Hello" , title: title, content: content)).then((value) => {
      respAddPost(),
    });
  }
  respAddPost(){
    Navigator.of(context).pop({"data": "done"});

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add post"),

      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "Title"
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                    hintText: "Content"
                ),
              ),
              SizedBox(height: 20,),
              MaterialButton(
                color: Colors.blue,
                  minWidth: double.infinity,
                  onPressed:_addPost,
                  child: Text("Add ")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
