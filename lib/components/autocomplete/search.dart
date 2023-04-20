import 'package:career_paddy/components/users/interests.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../theme/color.dart';

class AutocompleteSearch extends StatefulWidget {
  const AutocompleteSearch({super.key});

  @override
  State<AutocompleteSearch> createState() => _AutocompleteSearchState();
}

class _AutocompleteSearchState extends State<AutocompleteSearch> {
  var service = AuthService();

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: false,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontStyle: FontStyle.italic),
        decoration: InputDecoration(
          labelText: 'Search ...',
          hintText: 'mentor@gmail.com',
          filled: true,
          fillColor: searchColor,
          prefixIcon: Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(
              color: darkBlue,
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
        var res = await service.search(pattern);
        var data = res.docs.map((e) => UserModel.fromJson(e.id, e.data()));
        return data;
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('${suggestion.first_name} ${suggestion.last_name}'),
          subtitle: UsersInterests(user: suggestion),
        );
      },
      onSuggestionSelected: (suggestion) {},
    );
  }
}
