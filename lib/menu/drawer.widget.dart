import 'package:first_project/config/global.params.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyDrawer extends StatelessWidget {
    late SharedPreferences prefs ;


    @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.white , Colors.blue])
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profil.jpg'),
              ),
            )),
            
            ...(GlobalParams.menus as List).map((item){
              return Column(
                children: [
                  ListTile(
                    title: Text('${item["title"]}',style: TextStyle(fontSize: 22),),
                    leading: item['icon'],
                    trailing: Icon(Icons.arrow_right , color: Colors.blue,),
                    onTap: () async{
                      if('${item['title']}' != "Deconnexion"){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "${item['route']}");
                      }else{
                        prefs = await SharedPreferences.getInstance();
                        prefs.setBool("connect", false);
                        Navigator.pushNamedAndRemoveUntil(context, "/authentification", (Route)=> false);
                      }
                    },
                  )
                ],
              );
            }),
            Divider(height: 4, color: Colors.blue,)
        ],
      ),
    );
  }
}
