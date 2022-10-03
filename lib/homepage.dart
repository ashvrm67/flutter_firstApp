

import 'package:dio/dio.dart';
import 'package:firstapp_flutter/UserData.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  double height = 0;
  double width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("HomePage "),
      ),
      body: Center(
        child: FutureBuilder<List<UserData>>(
          future: fetchData(),  //future means it will not load untill values are fetched.
          builder: (context,snapShot) {  //snapshot is variable has userdata
            if(snapShot.hasData) {
              List<UserData>? userData = snapShot.data;  //if value is not there it will assign null- it is null check operator
              return ListView.builder(
                itemCount: userData!.length,   //this syntax due to null check operator above
                itemBuilder: (context,index) {   // to show build
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  elevation: 18,
                  child: Container(
                    width: double.infinity,
                    height: height / 4,
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Image.network('${userData[index].picture}', errorBuilder: (
                          e,
                          _,
                          __,
                        ) {
                          return Container(
                            height: 100,
                            width: 60,
                            child: Text("No Image"),
                          );
                        }),
                        Column(
                          children: [

                            Text('${userData[index].lastName}'),
                            Text('${userData[index].firstName}'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
            }

            return CircularProgressIndicator();   //progress indicator
          }
        ),
      ),
      drawer: Drawer(),
    );
  }

  Future <List<UserData>> fetchData () async
  {
    List<UserData> userData= [];
    var dio= Dio();
    dio.options.headers['app-id']='63343a8a5fbacb9d826cc2bd';
    Response response= await dio.get('https://dummyapi.io/data/v1/user?limit=10',  );
    if(response.statusCode==200)
      {
        List users=response.data['data'];
        users.forEach((element) {userData.add(UserData.fromJson(element));});
        print("value fetched");
        return userData;
      }
 else
    {
      return userData;
    }
  }

}
