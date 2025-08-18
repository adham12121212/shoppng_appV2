import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shoppng_app/pages/home/models/banner_model.dart';

import '../../constant/appbar.dart';
import '../cart/cubit/cart_page_cubit.dart';
import '../details/details_page.dart';
import '../login/cubit/login_page_cubit.dart';
import 'cubit/home_page_cubit.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: [
          NewAppBar(),
          SizedBox(height: 10,),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Banner(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Popular ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text("See All", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 280,
                    child: BlocBuilder<HomePageCubit, HomePageState>(
                      builder: (context, state) {
                        final cubit = context.read<HomePageCubit>();

                      if(state is HomePageLoading){
                        return  Center(child: CircularProgressIndicator(),);
                      }
                      if(state is HomePageError){
                        return Center(child: Text(state.message),);
                      }
                      if(state is HomePageSuccess){
                        final productList = cubit.productModel.data!.products;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount:productList!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return _foodContaner(index: index);
                          },
                        );
                      }
                        return Container();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Latest ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text("See All", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 280,
                    child: BlocBuilder<HomePageCubit, HomePageState>(
                      builder: (context, state) {
                        final cubit = context.read<HomePageCubit>();

                      if(state is HomePageLoading){
                        return  Center(child: CircularProgressIndicator(),);
                      }
                      if(state is HomePageError){
                        return Center(child: Text(state.message),);
                      }
                      if(state is HomePageSuccess){
                        final productList = cubit.productModel.data!.products;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount:productList!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return _foodContaner(index: index);
                          },
                        );
                      }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget Banner() {
    return BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            final cubit = context.read<HomePageCubit>();

            if (state is HomePageLoading) {
              return Center(child: CircularProgressIndicator());
            }

            final bannerImage = cubit.bannarList;
            final productList = cubit.bannerModel.data!;
            return CarouselSlider(
                options: CarouselOptions(
                  height: 220,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.5,
                  scrollDirection: Axis.horizontal,
                ),
                items:
                bannerImage.map((i) {
                  return SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),child: Image.network(i, fit: BoxFit.cover))),
                        Padding(
                          padding: const EdgeInsets.only(top: 100.0, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(productList[bannerImage.indexOf(i)].title!,style: TextStyle(
                                  fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold
                              ),),
                              Text(productList[bannerImage.indexOf(i)].description!,style: TextStyle(
                                  fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
            );

          },
        );
  }

  Widget _foodContaner({required int index}) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        final cubit = context.read<HomePageCubit>();
        final productList = cubit.productModel.data!.products;
        final productId = productList![index].id;
        return GestureDetector(
          onTap: () {
            Get.to(DetailsPage(index: index,));
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        productList[index].image.toString(),
                        width: 170,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 155,
                      right: 8,
                      child:
                      GestureDetector(
                        onTap: () async {
                         await context.read<CartPageCubit>().addCart(
                           int.parse(productId .toString()),1);
                         Get.snackbar("Success", "${productList[index].name} added to cart");
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue[200],
                          ),
                          child: Center(child:
                          Icon(Icons.add, color: Colors.white,),
                          ),),
                      ),

                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Text(productList[index].name!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: Colors.yellow[700],),
                    SizedBox(width: 5,),
                    Text(productList[index].rating.toString(), style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Text("(${productList[index].reviews.toString()})", style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}



