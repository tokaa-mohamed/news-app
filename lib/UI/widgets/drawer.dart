
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/Api/Api_manager.dart';
import 'package:newsapp/Provider/Category_provider.dart';
import 'package:newsapp/Provider/LocalProvider.dart';
import 'package:newsapp/Provider/themeprovider.dart';
import 'package:newsapp/UI/Home/homee.dart';
import 'package:newsapp/UI/Screens/initPage.dart';
import 'package:newsapp/generated/l10n.dart';
import 'package:newsapp/utils/app_colors.dart';
import 'package:newsapp/utils/app_styles.dart';
import 'package:newsapp/utils/theme.dart';
import 'package:provider/provider.dart';

class Drawerwidget extends StatefulWidget {
  const Drawerwidget({super.key});

  @override
  State<Drawerwidget> createState() => _DrawerwidgetState();
}

class _DrawerwidgetState extends State<Drawerwidget> {


void sheetlang(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final lang = Provider.of<LocaleProvider>(context);   

      return FractionallySizedBox(
        heightFactor: 0.5,
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  GestureDetector(
                    onTap: () {
                      Provider.of<LocaleProvider>(context, listen: false)
                          .changeLanguage('en');
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).english,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        if (lang.languageCode == 'en')
                          Icon(Icons.check, color: Colors.black, size: 35),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      Provider.of<LocaleProvider>(context, listen: false)
                          .changeLanguage('ar');
                      Navigator.pop(context);

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).arabic,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        if (lang.languageCode == 'ar')
                          Icon(Icons.check, color: Colors.black, size: 35),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}


  void sheettheme(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        
                    final theme=Provider.of<ThemeProvider>(context,);

        return FractionallySizedBox(
          heightFactor: 0.5, 
          widthFactor: 1,
          child: 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: 
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                   
                   GestureDetector(
  onTap: () {
    theme.setLightTheme();
    Navigator.pop(context);
  },
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        S.of(context).light,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      if (!theme.isDarkMode) Icon(Icons.check, color: Colors.black,size: 50,),
    ],
  ),
),
SizedBox(height: 20),
GestureDetector(
  onTap: () {
    theme.setDarkTheme();
    Navigator.pop(context);
  },
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        S.of(context).dark,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      if (theme.isDarkMode) Icon(Icons.check, color: Colors.black, size: 50,),
    ],
  ),
),
       ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
          final category=Provider.of<Categoryprovider>(context,listen: false);
                    final theme=Provider.of<ThemeProvider>(context,listen: false);
                    final locale=Provider.of<LocaleProvider>(context,listen: false);


    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        
        children: [
          Container(
            color: Colors.white,
            child: 
            Padding(
              padding: const EdgeInsets.all(70),
              child: 
              Center(child: Text('News App',style: Appstyles.black18Bold,),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 15,left: 10),
            child: 
            GestureDetector(
onTap: () {
  Navigator.pop(context); 
    category.clearcategory();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const initPage()),
    );
},
              child: Row(
                children: [
                  Icon(Icons.home,color: Appcolors.whitecolor),
                                  SizedBox(width: 8,),
                  Text(S.of(context).goHome,style: Appstyles.white16Bold)
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
Container(width: 270,
height: 1,
color: Colors.white,),
          SizedBox(height: 5,),

             Padding(
              padding: const EdgeInsets.only(top: 15,bottom: 15,left: 10),
              child: Row(
                children: [
                  Icon(Icons.format_paint_outlined,color: Appcolors.whitecolor,),
                                  SizedBox(width: 8,),
            
                  Text(S.of(context).theme,style: Appstyles.white16Bold)
                ],
              ),
            ),
          
          Container(
            width: 300,
            height: 50,
            margin: EdgeInsets.all(13),
            
decoration: ShapeDecoration(shape: 
                                 RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
      color: Appcolors.whitecolor, 
      width: 1,                    
    ),
                                 ),
),
            child:
                         GestureDetector(
            onTap:(){
            sheettheme(context);
            },
child: 
               Padding(
                 padding: const EdgeInsets.all(5),
                 child: Row(
                             
                  children: [
                    Text(S.of(context).theme,style: Appstyles.white16Bold,),
                    SizedBox(width: MediaQuery.of(context).size.width*0.44,),
                    Icon(Icons.keyboard_arrow_down ,color: Appcolors.whitecolor),
                  ],
                             ),
               ),
             ),
          ),
          SizedBox(height: 10,),
Container(width: 270,
height: 1,
color: Colors.white,),
          Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 15,left: 10),
            child: Row(
              children: [
                Icon(Icons.language_outlined,color: Appcolors.whitecolor,),
                                SizedBox(width: 8,),

                Text(S.of(context).language,style: Appstyles.white16Bold,)
              ],
            ),
          ),
                    Container(
            width: 300,
            height: 50,
            margin: EdgeInsets.all(13),
            
decoration: ShapeDecoration(shape: 
                                 RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
      color: Appcolors.whitecolor, 
      width: 1,                    
    ),
                                 ),
),
            child:

                                     GestureDetector(
            onTap:(){
            sheetlang(context);
            },
child: 

  
           Padding(
               padding: const EdgeInsets.all(6.0),
               child: Row(
                           
                children: [
                  Text(S.of(context).language,style: Appstyles.white16Bold),
                  SizedBox(width: MediaQuery.of(context).size.width*0.44,),
                  Icon(Icons.keyboard_arrow_down,color: Appcolors.whitecolor),
                ],
                           ),
             ),
                                     ),
          

                    ),

        ],
      
      ),
    );

    
  }
  
}