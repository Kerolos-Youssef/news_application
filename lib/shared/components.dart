import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/modules/web_view/web_view_screen.dart';

Widget buildArticleItem({required BuildContext context, required article}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 12.h,
      horizontal: 12.w,
    ),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WebViewScreen(
              url: article['url'],
            ),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            height: 105.h,
            width: 145.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.r,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  article['urlToImage'] == null
                      ? "https://cdn.pixabay.com/photo/2015/02/15/09/33/news-636978_960_720.jpg"
                      : "${article['urlToImage']}",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 7.w,
          ),
          Expanded(
            child: Container(
              height: 100.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            height: 1.5.h,
                            fontSize: 19.sp,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      // textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    '${(article['publishedAt'])}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget separator() {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 8.h,
      horizontal: 8.w,
    ),
    child: Container(
      color: Colors.grey,
      height: 1.8.h,
    ),
  );
}

Widget articleBuilder({required list}) {
  return ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      return buildArticleItem(
        context: context,
        article: list[index],
      );
    },
    separatorBuilder: (context, index) {
      return separator();
    },
    itemCount: list.length,
  );
}

Widget defaultTextFormField({
  required bool isDark,
  required TextEditingController controller,
  required TextInputType keyboardType,
  bool isPassword = false,
  String? Function(String?)? onSubmit,
  String? Function(String?)? onChange,
  void Function()? onTab,
  required String? Function(String?)? validate,
  required String label,
  required Icon prefix,
  Icon? suffix,
  void Function()? suffixPressed,
}) =>
    TextFormField(
      style: isDark
          ? TextStyle(color: Colors.white)
          : TextStyle(color: Colors.black),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      onTap: onTab,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefix,
        suffixIcon: suffix != null
            ? IconButton(
                icon: suffix,
                onPressed: suffixPressed,
              )
            : null,
        border: OutlineInputBorder(),
      ),
      autofocus: true,
    );
