import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../details/details_page.dart';
import '../home/cubit/home_page_cubit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Container(

          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(10),),
          child: TextField(
            controller: controller,
            autofocus: true, // يفتح الكيبورد مباشرة
            decoration: const InputDecoration(
              hintText: "Search products...",
              prefixIcon: Icon(Icons.search, color: Colors.white),
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              border: InputBorder.none,
            ),
            onChanged: (text) {
              cubit.searchProduct(text);
            },
          ),
        ),
      ),
      body: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state is HomePageLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomePageSuccess) {
            final products = cubit.productModel.data!.products!;
            if (products.isEmpty) {
              return const Center(child: Text("No products found"));
            }
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(DetailsPage(index: index,));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Image.network(products[index].image!),
                      subtitle: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[800],
                          ),
                          Text(products[index].rating.toString()),
                          Text("(${products[index].reviews})"),
                          SizedBox(width: 10,),
                          Text("\$ ${products[index].price?.toInt().toString()}"),

                        ],
                      ),
                      title: Text(products[index].name!),
                    ),
                  ),
                );
              },
            );
          }
          if (state is HomePageError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
