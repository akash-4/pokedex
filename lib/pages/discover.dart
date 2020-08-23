import 'dart:convert';

import 'package:pokedox/Animations/FadeAnimation.dart';
import 'package:pokedox/constants/color.dart';
import 'package:pokedox/models/user.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokedox/pages/pokemonDetail.dart';
import 'package:http/http.dart' as http;
import '../models/listOfPokemon.dart';

class UserPokemons extends StatefulWidget {
  List favourites;
  User usSearch;
  UserPokemons({this.favourites, this.usSearch});
  @override
  _UserPokemonsState createState() => _UserPokemonsState();
}

class _UserPokemonsState extends State<UserPokemons> {
 

  Pokehub pokeHub;
  @override
  void initState() {
  
    super.initState();
   
    fetchData();
  }

 // ignore: missing_return
 Future <List> fetchData() async {
   var url =
       "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeHub = Pokehub.fromJson(decodedJson);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black1,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.red,
                  size: 15,
                ),
                SizedBox(
                  width: 1,
                ),
                Text("Back")
              ],
            ),
          ),
        ),
        backgroundColor: AppTheme.black1,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black26),
        title: Text("pokedox",
            style: TextStyle(
                fontFamily: "Proxima Nova",
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: <Widget>[
                (widget.usSearch.photoUrl != null)
                    ? CircleAvatar(
                        radius: 42.0,
                        backgroundColor: Colors.red,
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: AppTheme.black2,
                          backgroundImage:
                              NetworkImage(widget.usSearch.photoUrl),
                        ),
                      )
                    : CircleAvatar(
                        radius: 42.0,
                        backgroundColor: Colors.red,
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: AppTheme.black2,
                          child: Text(
                            widget.usSearch.displayName.substring(0, 1),
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${widget.usSearch.displayName}",
                      style: TextStyle(
                          color: Colors.red.withOpacity(.8),
                          fontSize: 22.0,
                          fontFamily: "Proxima Nova",
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.usSearch.email}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontFamily: "Proxima Nova",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              FadeAnimation(
                  0.5,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Favourites" ,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontFamily: "Proxima Nova")),
                          ),
                        
                        ],
                      ),
                      FadeAnimation(1.5, con()),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget con() {
    List sel = widget.favourites ;

    sel.removeWhere((element) => element == "");
    return Container(
      height: MediaQuery.of(context).size.height - 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
           pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Expanded(
                      child: ListView(
     shrinkWrap: true,
                children: pokeHub.pokemon
                    .map((poke) => 
                   sel.contains(poke.id.toString())?
                    Padding(
                          padding: EdgeInsets.all(3.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>pokeDetail(
                                    pokemon: poke,
                                  )
                              ));
                            },
                            child: Hero(
                              tag: poke.img,
                              child: Card(
                                color: AppTheme.black2.withOpacity(.7),
                                elevation: 6.0,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 120.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(poke.img))),
                                    ),
                                    Text(
                                      poke.name,
                                      style: TextStyle(
                                        color: AppTheme.red,
                                        fontFamily: "Proxima Nova",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ):Container())
                    .toList(),
              )),
        ],
      ),
    );
  }
}
