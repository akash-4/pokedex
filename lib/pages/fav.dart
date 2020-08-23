import 'dart:convert';

import 'package:pokedox/Animations/FadeAnimation.dart';
import 'package:pokedox/constants/color.dart';
import 'package:pokedox/models/user.dart';
import 'package:flutter/material.dart';
import 'package:pokedox/pages/pokemonDetail.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:http/http.dart' as http;
import '../models/listOfPokemon.dart';

class UserPokemons extends StatefulWidget {
  @override
  _UserPokemonsState createState() => _UserPokemonsState();
}

class _UserPokemonsState extends State<UserPokemons> {
  Future _future;

  List favourites = [];
  Future fetch() async {
    final user = Provider.of<User>(context, listen: false);
    final DocumentSnapshot userDoc =
        await Firestore.instance.collection('users').document(user.uid).get();
    setState(() {
      favourites = userDoc.data['favourites'];
    });
  }

  Pokehub pokeHub;
  @override
  void initState() {
  
    super.initState();
      _future = fetch();
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
      body:Column(
              mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Text("Favourites",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red,
                                fontFamily: "Proxima Nova")),
                      ),
                     
                    ],
                  ),
               
                   pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
            height: MediaQuery.of(context).size.height-180,
                      child: ListView(
     shrinkWrap: true,
                children: pokeHub.pokemon
                    .map((poke) => 
                   favourites.contains(poke.id.toString())?
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
              ),
                        // );}
                      
          )
                ],
              )),
        ],
      ),
    );
  }

}
