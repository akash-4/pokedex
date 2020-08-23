import 'dart:convert';

import 'package:pokedox/constants/color.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:http/http.dart' as http;
import '../models/listOfPokemon.dart';
import 'pokemonDetail.dart';

class Pokemonsearch extends StatefulWidget {
  @override
  _PokemonsearchState createState() => _PokemonsearchState();
}

class _PokemonsearchState extends State<Pokemonsearch> {
 
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // shrinkWrap: true,
        children: <Widget>[
              Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Search",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red,
                            fontFamily: "Proxima Nova")),
                  ),
          getSearchBar(),
          SizedBox(height: 15,),
         (enteredSearchQuery.length!=0)?
      pokeHub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Expanded(
                      child: ListView(
     
                children: pokeHub.pokemon
                    .map((poke) => 
                    poke.name.contains(enteredSearchQuery)?
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
          ):
          Expanded(
           
            child: Center(child: Icon(Icons.search,color: AppTheme.red.withOpacity(.5),size: 200,),)),
          
          
        
        ]));
  }
     bool search = false;
  var searchItemController = TextEditingController();
  var enteredSearchQuery = '';
  getSearchBar() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, right: 0),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Container(
            height: 35.0,
            child: TextField(
                textAlign: TextAlign.center,
                cursorColor: Colors.black,
                controller: searchItemController,
                onChanged: (value) {
                  setState(() {
                     enteredSearchQuery = value;
                  });
                   
                },
                style: TextStyle(color: Colors.red),
              
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 50),
                 
                  fillColor: AppTheme.black2,
                  hintText: "Search",
                  filled: true,
                  
                  hintStyle:
                      TextStyle(color: Color(0xFF686969), fontSize: 14.0),
                
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.red),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                )),
          ),
        ),
      ),
    );
  }
}
