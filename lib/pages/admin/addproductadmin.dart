import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppng_app/pages/home/cubit/home_page_cubit.dart';


class Addproductadmin extends StatelessWidget {
  Addproductadmin({super.key});

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();


  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "images/homemade.webp",
                  width: 200, height: 200, fit: BoxFit.cover,)),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Product Name",
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _priceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Product Price",
              ),
            ),
          ),

          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Product Description",
              ),
            ),
          ),

          SizedBox(height: 20,),
          BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {
              return ElevatedButton(onPressed: () {
                context.read<HomePageCubit>().AddProduct(
                  name: _nameController.text,
                  price: _priceController.text,
                  description: _descriptionController.text,

                );
              }, child: Text("Add Product"));
            },
          )

        ],
      ),
    );
  }
}
