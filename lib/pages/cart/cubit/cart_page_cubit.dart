import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shoppng_app/pages/cart/models/cart_models.dart';

import '../../../helper/dio_helper.dart';

part 'cart_page_state.dart';

class CartPageCubit extends Cubit<CartPageState> {
  CartPageCubit() : super(CartPageInitial());


  CartModel cartModel = CartModel();


  Future  <void> getCart() async {
     try {
       emit(CartLoadingInitial());
       final result = await DioHelper.getData("cart");

       if (result.data["status_code"] < 300) {
         cartModel = CartModel.fromJson(result.data);

         emit(CartSuccessInitial());
       }else {
         Get.snackbar("Error", cartModel.message!);
         emit(CartErrorInitial(
             message: "${result.data["message"]}"
         ));
       }

     } catch (e) {
       emit(CartErrorInitial(
           message: e.toString()
       ));
     }
   }


  Future<void> addCart(int productId,int quantity)async{
     try {
       emit(CartLoadingInitial());
       final result = await DioHelper.postData("cart",body:
       {"productId":productId,"quantity":quantity});
       if(result.data["status_code"] < 300){
         await getCart();

         emit(CartSuccessInitial());
       }else{
         Get.snackbar("Error", result.data["message"]);
         emit(CartErrorInitial(
             message: "${result.data["message"]}"
         ));
       }
     } catch (e) {
       emit(CartErrorInitial(
           message: e.toString()
       ));
     }
   }

   Future <void> deleteCart(int productId)async{
         try{
          emit(CartLoadingInitial());
          final result = await DioHelper.deleteData("cart/$productId");
          if(result.data["status_code"] < 300){
            emit(CartSuccessInitial());
            await getCart();

          }else{
            Get.snackbar("Error", result.data["message"]);
            emit(CartErrorInitial(
                message: "${result.data["message"]}"
            ));
          }
         }catch(e){
           emit(CartErrorInitial(
               message: e.toString()
           ));
         }
   }

  Future<void> updateCart(int productId, int quantity) async {
    try {
      emit(CartLoadingInitial());


      final result = await DioHelper.putData(
        "cart/$productId",
        body: {"quantity": quantity},
      );

      if (result.data["status_code"] < 300) {
        emit(CartSuccessInitial());
        await getCart(); // ✅ Good: refresh cart after update
      } else {
        Get.snackbar("Error", result.data["message"]);
        emit(
          CartErrorInitial(message: result.data["message"].toString()),
        );
      }
    } catch (e) {
      emit(CartErrorInitial(message: e.toString()));
    }
  }

}


