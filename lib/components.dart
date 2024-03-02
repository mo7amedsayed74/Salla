import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/constants.dart';

import 'cubits/app_cubit/cubit.dart';


Future<Widget> navigateTo({
  required Widget screenToView,
  required BuildContext context,
}) async {
  return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screenToView,
      ));
}

// context.navigateTo();
extension NavigatorExtension on BuildContext {
  Future<Widget> navigatePush({
    required Widget screenToView,
  }) async {
    return await Navigator.push(
        this,
        // this keyWord refers to context that call this function (navigateTo)
        MaterialPageRoute(
          builder: (context) => screenToView,
        ));
  }

  Future<Widget> navigatePushReplacement({
    required Widget screenToView,
  }) async {
    return await Navigator.pushReplacement(
        this, // this keyWord refers to context that call this function (navigateTo)
        MaterialPageRoute(
          builder: (context) => screenToView,
        ));
  }
}

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.teal,
  double radius = 20.0,
  bool isUpperCase = true,
  required String text,
  required Function() onPressedFunction,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: onPressedFunction,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType boardType,
  required String label,
  required IconData prefix,
  required String? Function(String?)? validate,
  void Function(String)? onChange,
  void Function(String)? onSubmit,
  void Function()? onTap,
  IconData? suffix,
  bool obscure = false,
  Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: boardType,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate!,
      decoration: InputDecoration(
        //contentPadding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: defaultColor),
            borderRadius: BorderRadius.circular(20)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: label,
        //enabled: false,

        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix),)
            : null,
      ),
    );

void showToast({
  required String msg,
  required ToastStates state,
 }) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG, // المده اللي هتظهرها في الاندرويد
      gravity: ToastGravity.BOTTOM, // هتظهر فين
      timeInSecForIosWeb: 5, // المده اللي هتظهرها في الويب و ال ios
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStates {success,error,warning}

Color toastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.success : color = Colors.green;
      break;
    case ToastStates.error : color = Colors.red;
      break;
    case ToastStates.warning : color = Colors.yellow;
      break;
  }
  return color;
}



Widget favoritesAndSearchItemsBuilder(dynamic item, BuildContext context ,{isSearch = false}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      color: Colors.white,
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(item!.image!),
                height: 120.0,
                width: 120,
              ),
              if (isSearch==false)
                if(item!.discount > 0)
                  Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    item!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '${item!.price.round()}',
                          style: TextStyle(
                            color: Colors.teal[300],
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        if (isSearch==false)
                          if(item!.discount > 0)
                            Text(
                            '${item!.oldPrice.round()}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed:(!isSearch) ? (){AppCubit.get(context).changeFavorites(item!.productid!);} : (){},
                      icon: CircleAvatar(
                        backgroundColor:AppCubit.get(context).favorites[item!.productid] != null ?
                        (AppCubit.get(context).favorites[item!.productid]! ) ? defaultColor : Colors.grey[350]
                            : Colors.grey[350],
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}