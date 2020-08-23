import 'dart:convert';

import 'package:pokedox/Animations/FadeAnimation.dart';
import 'package:pokedox/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:http/http.dart' as http;
import '../models/listOfPokemon.dart';
import 'pokemonDetail.dart';

class MyMovieApp extends StatefulWidget {
  @override
  _MyMovieAppState createState() => _MyMovieAppState();
}

class _MyMovieAppState extends State<MyMovieApp> {
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
      body:  pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokeHub.pokemon
                  .map((poke) => Padding(
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
                      ))
                  .toList(),
            ),
    );
  }

}
