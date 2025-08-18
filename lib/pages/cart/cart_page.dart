import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/appbar.dart';
import 'cubit/cart_page_cubit.dart';
import 'package:shoppng_app/pages/cart/models/cart_models.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartPageCubit()..getCart(),
      child: Scaffold(
        body: Column(
          children: [
            NewAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<CartPageCubit, CartPageState>(
                      builder: (context, state) {
                        final cubit = context.read<CartPageCubit>();
                        if (state is CartLoadingInitial) {
                          return  Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is CartErrorInitial) {
                          return Container(
                              padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 60),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment(10, 0),
                                      child: Image.asset("images/empty cart.png",height: 300,)),
                                  Text("   Your wishlist is empty",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                                ],
                              ));
                        }
                        final item = cubit.cartModel;
                        final itemlist = item.data!.items!;
                        return ListView.separated(
                            separatorBuilder: (context, index) => const SizedBox(height: 10),
                            itemCount: itemlist.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _buildContainer(item, index);
                            }
                        );
                      },
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Container _buildContainer(CartModel item, int index) {
    final itemlist = item.data!.items!;
    return Container(
      height: 160,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[200],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                itemlist[index].product!.image ?? "https://via.placeholder.com/120",
                height: 140,

                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(left: 5.0,top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            itemlist[index].product!.name ?? "",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                    Text(
                      itemlist[index].product!.brand ?? "",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "⭐ ${itemlist[index].product!.rating?.toString() ?? "0"}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      "\$${itemlist[index].product!.price?.toInt().toString() ?? "0"}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),

                    BlocBuilder<CartPageCubit, CartPageState>(
                builder: (context, state) {
                       return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Row(
                            children: [
                              IconButton(onPressed: (){
                                if(itemlist[index].quantity==1){
                                  context.read<CartPageCubit>().deleteCart(itemlist[index].id!);
                                }else{
                                context.read<CartPageCubit>().updateCart(itemlist[index].id!,itemlist[index].quantity!-1);
                                }
                              }, icon: const Icon(Icons.remove,color: Colors.white,)),
                              Text("${itemlist[index].quantity}",style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                              IconButton(onPressed: (){
                                context.read<CartPageCubit>().updateCart(itemlist[index].id!,itemlist[index].quantity!+1);
                              },
                               icon: const Icon(Icons.add,color: Colors.white,)),
                            ],
                          ),
                        ),
                        Row(
                          children: [

                                 GestureDetector(
                              onTap: (){
                                context.read<CartPageCubit>().deleteCart(itemlist[index].id!);
                              },
                              child: Container(
                                height: 25,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Center(child:Text("Delete",style: const TextStyle(fontSize: 16,  color: Colors.black),)),
                              ),
                            ),

                          ],
                        )

                      ],
                    );
  },
),

              ],
            ),
          ),


        ],
      ),
    );
  }

}
