import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../constant/appbar.dart';
import '../cart/cubit/cart_page_cubit.dart';
import '../home/cubit/home_page_cubit.dart';
import '../login/cubit/login_page_cubit.dart';
import 'cubit/wishlist_page_cubit.dart';


class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            NewAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text("Mobile Wishlist",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                    BlocBuilder<WishlistPageCubit, WishlistPageState>(
                  builder: (context, state) {
                    final cubit = context.read<WishlistPageCubit>();
                    if (state is WishlistLoadingInitial) {
                      return  Center(
                          child: CircularProgressIndicator());
                    }
                    if (state is WishlistErrorInitial) {
                      return Container(
                          padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 60),
                          child: Column(
                            children: [
                              Image.asset("images/favorite.png",height: 250,),
                              Text("Your wishlist is empty",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                            ],
                          ));
                    }
                    final item = cubit.wishlistmodel;
                    final itemlist = item.data!.items!;
                   return ListView.separated(
                      shrinkWrap: true,
                        itemBuilder: (context, index) => _wishlistContainer(index),
                        separatorBuilder: (context, index) => const SizedBox(height: 10,),
                        itemCount: itemlist.length,
                        );
  },
)

                  ],
                ),
              ),
            )
          ],
        ),

    );
  }

  
  
  Widget _wishlistContainer( int index) {
    return BlocBuilder<HomePageCubit, HomePageState>(
  builder: (context, state) {
    final cubit = context.read<HomePageCubit>();
    final productList = cubit.productModel.data!.products;
    return Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[200],
                ),
                child: Stack(
                  children: [
                    Positioned(

                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                        child: Image.network(productList![index].image.toString()
                          ,height:200,
                          width: 150,
                          fit: BoxFit.cover,),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 170,
                      child: Text(productList[index].name!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,maxLines: 2,),
                    ),
                    Positioned(
                      top: 40,
                      left: 170,
                      child: Text(productList[index].brand!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                    ),
                    Positioned(
                      top: 60,
                      left: 165,
                      child: Row(
                        children: [
                          Icon(Icons.star,color: Colors.yellow[700],),
                          Text(productList[index].rating.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        ],
                      )
                    ),
                    Positioned(
                      top: 60,
                      left: 230,
                      child: Text("(${productList[index].reviews.toString()})",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                    ),
                    Positioned(
                      top: 90,
                      left: 170,
                      child: Text(" \$ ${productList[index].price!.toInt().toString()}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                    ),

                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        height: 50,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(child: Text("Add to cart",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),

                      ),
                    ),

                  ],
                ),
              );
  },
);
  }
}
