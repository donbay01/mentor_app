import 'package:career_paddy/components/users/new_experience.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:flutter/material.dart';

class ExperienceList extends StatelessWidget {
  final UserProvider provider;

  const ExperienceList({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    var experiences = provider.experiences;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('My Experiences'),
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (ctx) => NewExperience(
                  provider: provider,
                ),
              ),
              icon: Icon(Icons.add),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: experiences.length,
          itemBuilder: (context, index) {
            var experience = experiences[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${experience.jobRole}'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${experience.company} ${experience.start.toDate().year} - ${experience.end.toDate().year}',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
