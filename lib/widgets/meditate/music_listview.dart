import 'package:flutter/material.dart';

Widget customListTile({required String title, required String singer, required String cover, required VoidCallback onPressed}){
   return GestureDetector(
    onTap: onPressed,
     child: Container(
      decoration: BoxDecoration(
            
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.06),
              offset: const Offset(0, 4)
            ),
            ],
          ),
      padding: const EdgeInsets.all(8.0),
      child: Column(

        children: [
          Row(
            children: [
              Container(
                height: 50.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                    image: AssetImage('assets/$cover')),
                ),
              ),
              const SizedBox(width: 10.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  ),
                  const SizedBox(width: 5.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(singer, style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  ),

                ],
              )
            ]
          ),
            ],
          ),
          
        ],
      ),
  ),
   );
}
