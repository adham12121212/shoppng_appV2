import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../bottom_nav_bar.dart';
import '../../helper/hive_helper.dart';
import '../home/home_page.dart';
import 'cubit/login_page_cubit.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return BlocListener<LoginPageCubit, LoginPageState>(
  listener: (context, state) {

    if (HiveHelper.getToken().isNotEmpty) {
      Get.snackbar("success", "Login Success",
      backgroundColor: Colors.grey[200],);
      Get.off(BottomNavBar());

    }
    if (state is LoginPageError) {
      Get.snackbar("Error", state.message,
          backgroundColor: Colors.grey[200],);
    }
  },
  child: Scaffold(
      
      
      
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 130,),
             Container(
                padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),
               SizedBox(height: 5,),
            Container(
              margin: EdgeInsets.only(left: 200),
              padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("Welcome ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),
            SizedBox(height: 5,),
            Container(

              padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("Let's Start ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: height*0.6,
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
              ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [

                 Container(
                   width: width*0.8,
                   height: height*0.06,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(20)
                   ),
                   child: Center(
                     child: TextFormField(
                       controller: emailController,
                       keyboardType: TextInputType.emailAddress,
                       decoration: InputDecoration(
                         labelText: "Email Address",
                         labelStyle: TextStyle(color: Colors.black),
                         border: InputBorder.none,
                         prefixIcon: Icon(Icons.person),

                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: 20,),
                 Container(
                   width: width*0.8,
                   height: height*0.06,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(20)
                   ),
                   child: Center(
                     child: TextFormField(
                       controller: passwordController,
                       keyboardType: TextInputType.visiblePassword,
                       decoration: InputDecoration(
                         labelStyle: TextStyle(color: Colors.black),
                         labelText: "Password",
                         border: InputBorder.none,
                         prefixIcon: Icon(Icons.password),

                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: 20,),
                 BlocBuilder<LoginPageCubit, LoginPageState>(
             builder: (context, state) {
               final cubit = BlocProvider.of<LoginPageCubit>(context);
                 return GestureDetector(
                   onTap: (){
                     cubit.login(emailController.text, passwordController.text);

                   },
                   child: Container(
                     width: width*0.4,
                     height: height*0.06,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(20)
                     ),
                     child: Center(
                       child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,
                           fontSize: 20,color: Colors.black),),
                     ),
                   ),
                 );
  },
)

               ],
             ),
            )
        
          ],
        
        ),
      )



    ),
);
  }
}
