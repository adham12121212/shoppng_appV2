import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../cart/cubit/cart_page_cubit.dart';
import '../home/cubit/home_page_cubit.dart';
import '../wishlist/cubit/wishlist_page_cubit.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.index});

  final int index;
  final isFavorite = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: 
      BlocBuilder<CartPageCubit, CartPageState>(
      builder: (context, state) {
    final cubit = context.read<HomePageCubit>();
    final productList = cubit.productModel.data!.products;
    final productId = productList![index].id;
    return GestureDetector(
        onTap: () async {
          await context.read<CartPageCubit>().addCart(
              int.parse(productId .toString()),1);
          Get.snackbar("Success", "${productList[index].name} added to cart");
        },
        child: Container(
          color: Colors.blue[200],
          width: double.infinity,
          height: height * 0.1,
          child: const Center(child: Text("Add to cart",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,
              color: Colors.white),)),
        ),
      );
  },
),
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,

      ),
      body:
      BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          final cubit = context.read<HomePageCubit>();
          final productList = cubit.productModel.data!.products;
          final productId = productList![index].id;
          return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(productList[index].image.toString(),
                          width: double.infinity, height: height * 0.4, fit: BoxFit.cover,),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                            icon:  Icon(Icons.favorite_border, size: 30,),
                            color: Colors.white,
                            onPressed: () async {

                                await context.read<WishlistPageCubit>().addWishlist(
                                   int.parse(productId.toString()),1);
                               Get.snackbar("Success", "${productList[index].name} added to wishlist");
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Text(productList[index].brand!,style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(width: 10,),
                      Icon(Icons.star_rounded,color: Colors.yellow[700],),
                      Text(productList[index].rating.toString(),style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productList[index].name!,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text("\$${productList[index].price!.toInt()}",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Text(productList[index].description!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),),


              
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
