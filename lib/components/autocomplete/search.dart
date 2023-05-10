import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/components/users/book_sheet.dart';
import 'package:career_paddy/components/users/interests.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../../theme/color.dart';

class AutocompleteSearch extends StatefulWidget {
  const AutocompleteSearch({super.key});

  @override
  State<AutocompleteSearch> createState() => _AutocompleteSearchState();
}

class _AutocompleteSearchState extends State<AutocompleteSearch> {
  var service = AuthService();
  var controller = TextEditingController();

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().getUser;

    return TypeAheadField(
      hideOnError: true,
      minCharsForSuggestions: 2,
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        autofocus: false,
        decoration: InputDecoration(
          suffixIcon: controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: () => controller.clear(),
                  child: Icon(Icons.close),
                )
              : null,
          labelText: 'Name, job and industry',
          hintText: 'mentor@gmail.com',
          labelStyle: smallText(searchGrey),
          hintStyle: small(),
          filled: true,
          fillColor: searchColor,
          prefixIcon: Icon(Icons.search,color: greyText,),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(
              color: searchGrey,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(
              color: primaryBlue,
              width: 1.0,
            ),
          ),
        ),
      ),
      suggestionsCallback: (pattern) async {
        try {
          if (pattern.isEmpty) {
            return <UserModel>[];
          }

          var res = await service.search(pattern);
          var data = res.docs.map((e) => UserModel.fromJson(e.id, e.data()));
          return data;
        } catch (e) {
          return <UserModel>[];
        }
      },
      itemBuilder: (context, suggestion) {
        return Padding(
          padding: const EdgeInsets.all(
             10,
          ),
          child: Row(
            children: [
              ProfileIcon(
                image: suggestion.photoURL,
                isExternal: true,
                radius: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${suggestion.first_name} ${suggestion.last_name}'),
                  UsersInterests(user: suggestion),
                ],
              ),
            ],
          ),
        );
      },
      onSuggestionSelected: (suggestion) => showBottomSheet(
        context: context,
        builder: (ctx) => BookSheet(
          user: suggestion,
          mentee: user,
        ),
      ),
    );
  }
}
