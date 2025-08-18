import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:shoppng_app/helper/hive_helper.dart';

import '../../constant/appbar.dart';
import '../login/cubit/login_page_cubit.dart';
import '../login/login_page.dart';



class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});



  @override
  Widget build(BuildContext context) {
    final email = HiveHelper.getEmail();
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(

        body:

        Column(
              children: [
                NewAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600"),
                          ),
                        ),

                        Text("John Doe", style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(
                          email.isNotEmpty ? email : "No email found",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      SizedBox(height: 40,),
                        _ProfileOptionCard(width, Icons.person, "My Profile"),
                        _ProfileOptionCard(width, Icons.settings, "Settings"),
                        _ProfileOptionCard(width, Icons.help, "Help Center"),
                        _ProfileOptionCard(width, Icons.logout, "Logout",
                            onTap: () {
                              context.read<LoginPageCubit>().logout();
                              Get.snackbar("Success", "Logout Success");
                        }),

                      ],
                    ),
                  ),
                )

              ],
            ),



    );
  }



  Widget _ProfileOptionCard(double width, IconData icon, String title, {Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
                            padding: const EdgeInsets.all(10),
                            width: width * 0.8,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(

                              children: [
                               Icon(icon),
                                SizedBox(width: width * 0.05,),
                                Text(title, style: TextStyle(color: Colors.black, fontSize: 18,
                                fontWeight: FontWeight.bold),),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios, color: Colors.black,),
                              ],
                            ),
                          ),
      ),
    );
  }
}
