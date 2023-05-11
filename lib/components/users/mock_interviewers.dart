import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/components/users/book_sheet.dart';
import 'package:career_paddy/components/users/interests.dart';
import 'package:career_paddy/components/users/query.dart';
import 'package:career_paddy/constants/message.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';
import '../../constants/role.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class MockInterviewers extends StatelessWidget {
  const MockInterviewers({super.key});

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<UserProvider>();
    var isFilter = prov.query != null;
    var mentee = prov.getUser;

    return isFilter
        ? QueryList(
            query: prov.query!
                .where('uid', isNotEqualTo: mentee.uid)
                .where('role', isEqualTo: MENTOR)
                .where('isMockInterviewer', isEqualTo: true)
                .limit(25),
            user: mentee,
          )
        : PaginateFirestore(
            shrinkWrap: true,
            itemBuilder: (context, documentSnapshots, index) {
              final doc = documentSnapshots[index];
              var user = UserModel.fromJson(doc.id, doc.data() as dynamic);

              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: () => buildShowModalBottomSheet(
                    context,
                    user,
                    mentee,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        ProfileIcon(
                          image: user.photoURL,
                          radius: 50,
                          isExternal: true,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.first_name,
                                style: mediumBold(darkBlue),
                              ),
                              if (user.interests != null) ...[
                                SizedBox(
                                  height: 3,
                                ),
                                UsersInterests(user: user),
                              ],
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Text(
                                    user.rating.toString(),
                                    style: small(),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.orangeAccent,
                                    size: 15,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            query: AuthService().getInterviewers(),
            itemBuilderType: PaginateBuilderType.listView,
            isLive: true,
          );
  }

  buildShowModalBottomSheet(
    BuildContext context,
    UserModel user,
    UserModel mentee,
  ) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: false,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80),
          topRight: Radius.circular(80),
        ),
      ),
      context: context,
      builder: (_) => BookSheet(
        user: user,
        mentee: mentee,
        meetingType: MOCK_INTERVIEW,
      ),
    );
    context.read<UserProvider>().cancelShift();
  }
}
