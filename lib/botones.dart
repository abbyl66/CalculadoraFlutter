import 'package:flutter/material.dart';

class Botones extends StatelessWidget{
  final color;
  final ColorTxt;
  final String botonTxt;
  final botonTap;

  Botones({this.color, this.ColorTxt, required this.botonTxt, this.botonTap});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: botonTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(child: Text(botonTxt, style: TextStyle(color: ColorTxt, fontSize: 25),),),
          ),
        ),
      )
    );
  }
}

