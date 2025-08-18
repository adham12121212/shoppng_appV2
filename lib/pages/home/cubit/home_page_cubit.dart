import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoppng_app/helper/dio_helper.dart';
import 'package:shoppng_app/pages/home/models/product_model.dart';

import '../models/banner_model.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());


  ProductModel productModel = ProductModel();
  BannerModel bannerModel = BannerModel();

  List  <String> bannarList = [];
  
  
  void getProduct()async{
   try{
     emit(HomePageLoading());
   final result = await DioHelper.getData("products");
   if(result.data["status_code"]==200){
     productModel= ProductModel.fromJson(result.data);
     emit(HomePageSuccess());
   }else{
     emit(HomePageError(message: ' ${result.data["message"]}'));
   }
   }catch(e){
     emit(HomePageError(message: e.toString()));
   }
    
  }


  void getBanners()async{
    try{
      emit(HomePageLoading());
      final result  = await DioHelper.getData("banners");
      bannerModel = BannerModel.fromJson(result.data);
      if(bannerModel.statusCode! < 300){
        bannerModel.data!.forEach((element) {
          bannarList.add(element.image!);
        });
        emit(HomePageSuccess());
      }else{
        emit(HomePageError(message: ' ${result.data["message"]}'));
      }
    }catch(e){
      emit(HomePageError(message: e.toString()));
    }
  }


  void searchProduct(String text) async {
    try {
      emit(HomePageLoading());


      final result = await DioHelper.getData("products");

      if (result.data["status_code"] == 200) {

        productModel = ProductModel.fromJson(result.data);

        final filtered = productModel.data!.products!
            .where((item) => item.name!.toLowerCase().contains(text.toLowerCase()))
            .toList();


        productModel.data!.products = filtered;

        emit(HomePageSuccess());
      } else {
        emit(HomePageError(message: '${result.data["message"]}'));
      }
    } catch (e) {
      emit(HomePageError(message: e.toString()));
    }
  }


}
