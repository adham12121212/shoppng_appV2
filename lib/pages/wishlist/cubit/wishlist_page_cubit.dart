import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../../helper/dio_helper.dart';
import '../models/Wishlist_models.dart';

part 'wishlist_page_state.dart';

class WishlistPageCubit extends Cubit<WishlistPageState> {
  WishlistPageCubit() : super(WishlistPageInitial());


  WishlistModel wishlistmodel = WishlistModel();


  Future  <void> getWishlist() async {
     try {
       emit(WishlistLoadingInitial());
       final result = await DioHelper.getData("wishlist");

       if (result.data["status_code"] < 300) {
         wishlistmodel = WishlistModel.fromJson(result.data);

         emit(WishlistSuccessInitial());
       }else {
         Get.snackbar("Error", wishlistmodel.message!);
         emit(WishlistErrorInitial(
             message: "${result.data["message"]}"
         ));
       }

     } catch (e) {
       emit(WishlistErrorInitial(
           message: e.toString()
       ));
     }
   }


  Future<void> addWishlist(int productId,int quantity)async{
     try {
       emit(WishlistLoadingInitial());
       final result = await DioHelper.postData("wishlist",body:
       {"productId":productId,"quantity":quantity});
       if(result.data["status_code"] < 300){
         await getWishlist();

         emit(WishlistSuccessInitial());
       }else{
         Get.snackbar("Error", result.data["message"]);
         emit(WishlistErrorInitial(
             message: "${result.data["message"]}"
         ));
       }
     } catch (e) {
       emit(WishlistErrorInitial(
           message: e.toString()
       ));
     }
   }

   Future <void> deleteWishlist(int productId)async{
         try{
          emit(WishlistLoadingInitial());
          final result = await DioHelper.deleteData("wishlist/$productId");
          if(result.data["status_code"] < 300){
            emit(WishlistSuccessInitial());
            await getWishlist();

          }else{
            Get.snackbar("Error", result.data["message"]);
            emit(WishlistErrorInitial(
                message: "${result.data["message"]}"
            ));
          }
         }catch(e){
           emit(WishlistErrorInitial(
               message: e.toString()
           ));
         }
   }

  Future<void> updateWishlist(int productId, int quantity) async {
    try {
      emit(WishlistLoadingInitial());


      final result = await DioHelper.putData(
        "wishlist/$productId",
        body: {"quantity": quantity},
      );

      if (result.data["status_code"] < 300) {
        emit(WishlistSuccessInitial());
        await getWishlist();
      } else {
        Get.snackbar("Error", result.data["message"]);
        emit(
          WishlistErrorInitial(message: result.data["message"].toString()),
        );
      }
    } catch (e) {
      emit(WishlistErrorInitial(message: e.toString()));
    }
  }

}


