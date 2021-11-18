import 'package:flutter/material.dart';
import 'package:news/modules/web_view/web_view_screen.dart';

Widget buildArticleItem({required BuildContext context, required article}) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.all(15),
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
            height: height * 0.15,
            width: width * 0.37,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                width * 0.02,
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
            width: width * 0.035,
          ),
          Expanded(
            child: Container(
              height: height * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      // textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.001,
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      fontSize: width * 0.04,
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
    padding: const EdgeInsets.all(10),
    child: Container(
      color: Colors.grey,
      height: 1,
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
