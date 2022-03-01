import 'package:firepost/model/post_model.dart';
import 'package:firepost/pages/detail_page.dart';
import 'package:firepost/pages/signinpage.dart';
import 'package:firepost/services/auth_service.dart';
import 'package:firepost/services/realtime_service.dart';
import 'package:flutter/material.dart';

import '../services/pref_service.dart';


class HomePage extends StatefulWidget {
  static String id = "HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiGetPost();
  }

  Future _openDetail() async{
    Map results = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
      return DetailPage();
    }));
    if(results!= null && results.containsKey("data")){
      _apiGetPost();
    }
  }

  void _apiGetPost()async{
    var id = await Prefs.loadUserId();
    RTDBService.getPosts(id!).then((posts) => {
      _resPosts(posts),
    });
  }
  void _resPosts(List<Post> posts ){
    setState(() {
      items = posts;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(onPressed: (){
            AuthService.signOutUser(context);
            Navigator.pushReplacementNamed(context, SignInPage.id);
          },
          icon: Icon(Icons.exit_to_app)
          )
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
       itemBuilder:(context,index){
          return itemOfList(items[index]);
       }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openDetail,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
  Widget itemOfList(Post post){
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.title,style: TextStyle(color: Colors.black,fontSize: 20),),
          SizedBox(height: 10,),
          Text(post.content,style: TextStyle(color: Colors.black,fontSize: 16),),
        ],
      ),
    );
  }

}
