import 'package:pokedox/constants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Animations/FadeAnimation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pokedox/models/user.dart';
import 'package:pokedox/services/pokemonDB.dart';
import 'package:pokedox/services/pokemonDB.dart';

import 'package:provider/provider.dart';
import '../models/listOfPokemon.dart';

class pokeDetail extends StatefulWidget {
  final Pokemon pokemon;

  pokeDetail({this.pokemon});

  @override
  _pokeDetailState createState() => _pokeDetailState();
}

class _pokeDetailState extends State<pokeDetail> {
  Future _future;

  List favourites = [""];
  Future fetch() async {
    final user = Provider.of<User>(context, listen: false);
    final DocumentSnapshot userDoc =
        await Firestore.instance.collection('users').document(user.uid).get();
    setState(() {
      favourites = userDoc.data['favourites'];
    });
  }

  @override
  void initState() {
    _future = fetch();
    super.initState();
  }

  bodyWidget(BuildContext context) =>   FadeAnimation(1,Stack(
        children: <Widget>[
        Positioned(
            height: MediaQuery.of(context).size.height/1.5,
            width: MediaQuery.of(context).size.width-20,
            left: 10.0,
            top: MediaQuery.of(context).size.height *0.1,
            child: Card(

              color: AppTheme.black2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                      height: 80,
                      ),
                  Center(
                    child: Text('${widget.pokemon.name}',style: TextStyle(
                      fontFamily: 'Proxima Nova',
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color:Colors.red
                    ),),
                  ),
                    SizedBox(
                      height: 10.0,
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
 Padding(
   padding: const EdgeInsets.symmetric(horizontal:8.0),
   child: Text("Height : ${widget.pokemon.height}",style: TextStyle(
                    fontFamily: 'Proxima Nova',
                    fontSize: 18.0,
                    color:Colors.red
                  ),),
 ),
 Container(height: 25,width: 1,color: Colors.white),

                   Padding(
   padding: const EdgeInsets.symmetric(horizontal:8.0),child: Text("Weight : ${widget.pokemon.weight}",style: TextStyle(
                    fontFamily: 'Proxima Nova',
                    fontSize: 18.0,
                    color:Colors.red
                  ),)),
                  ],),
                    SizedBox(
                      height: 20.0,
                      ),
                      
                    
                              FutureBuilder(
                      future: _future,
                      builder: (ctx, index) {                   
                        return Container(
                                    width: 250,
                                    height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft:Radius.circular(50),
                              bottomLeft:Radius.circular(50)
                        )
                      ),
                                      child: InkWell(
                                        splashColor: AppTheme.black2.withOpacity(0),
                                        onTap: (){
                                                 setState(() {
                                                 favourites.contains(widget.pokemon.id.toString())?favourites.remove(widget.pokemon.id.toString()):favourites.add(widget.pokemon.id.toString());
                                            });

                                            final user = Provider.of<User>(context,listen: false);
                                            PokemonDB.updateFavourites(widget.pokemon.id.toString(),user.uid); 
                                     
                                         
                                        },
                                                                            child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              (favourites.contains(widget
                                                      .pokemon.id
                                                      .toString()))
                                                  ? "Added to Favourites"
                                                  : 
                                                  "Add to Favourites",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                  fontFamily: "Proxima Nova",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Icon(
                                                // (watchList.contains(widget
                                                //         .movieItem.id
                                                //         .toString()))
                                                //     ? MdiIcons.formatListChecks
                                                //     :
                                                    (favourites.contains(widget
                                                      .pokemon.id
                                                      .toString()))
                                                  ?MdiIcons.heart:  MdiIcons.heartOutline,
                                                size: 20.0,
                                                color: Colors.white),
                                          ],
                                        ),
                                      ),
                                    );}
                                ),
                                
                       SizedBox(
                      height: 20.0,
                      ),
                      ListView
                      (shrinkWrap: true,
                        
                        children: [
                      
                  Center(
                    child: Text("Types ",style: TextStyle(
                      fontFamily: 'Proxima Nova',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color:Colors.red
                    ),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.pokemon.type
                        .map((t) =>
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0),
                              child: FilterChip(backgroundColor:Colors.deepOrangeAccent,label: Text(t,style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),), onSelected: (b) {}),
                            ))
                        .toList(),
                  ),
                    SizedBox(
                      height: 10.0,
                      ),
                  Center(
                    child: Text("Weakness",style: TextStyle(
                      fontFamily: 'Proxima Nova',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color:Colors.red
                    ),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.pokemon.weaknesses
                        .map((t) =>
                         Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0),
                             child:FilterChip(backgroundColor:Colors.redAccent,label: Text(t,style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),), onSelected: (b) {})))
                        .toList(),
                  ),
                    SizedBox(
                      height: 10.0,
                      ),
                  Center(
                    child: Text("Next Evolution",style: TextStyle(
                      fontFamily: 'Proxima Nova',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color:Colors.red
                    ),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:widget.pokemon.nextEvolution
                        ?.map((n) =>
                         Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0),
                             child: FilterChip(backgroundColor:Colors.lightGreen,label: Text(n.name,style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),), onSelected: (b) {})))
                        ?.toList()??[Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Max Evolution",style: TextStyle(
                      fontFamily: 'Proxima Nova',
                      decoration: TextDecoration.underline,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color:Colors.white
                    ),),
                        ),],
                  ),
                    
                      ],)
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(tag: widget.pokemon.img,child: Container(
              height: 170.0,
              width: 170.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.pokemon.img)
                )
              ),
            ),),
          )
        ],
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppTheme.black1,
      appBar: AppBar(
        title: Text("PokéDex",style: TextStyle(color: Colors.red),),
        backgroundColor: AppTheme.black1,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: bodyWidget(context),
    );
  }
}
