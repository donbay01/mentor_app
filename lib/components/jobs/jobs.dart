import 'package:career_paddy/pages/community/job_details.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

import '../../theme/color.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({Key? key}) : super(key: key);

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            _buildListItem('Software Engineer', 'We have a new role with an exciting fintech start-up in Nigeria, who are currently looking to hire a talented Digital Product designer to join their fast-growing team.', '\$100,000 - \$120,000', '3+ years', '04/20/2023'),
            _buildListItem('Data Analyst','We have a new role with an exciting fintech start-up in Nigeria, who are currently looking to hire a talented Digital Product designer to join their fast-growing team.', '\$80,000 - \$100,000', '2+ years', '04/19/2023'),
            _buildListItem('Product Manager', 'We have a new role with an exciting fintech start-up in Nigeria, who are currently looking to hire a talented Digital Product designer to join their fast-growing team.', '\$120,000 - \$150,000', '5+ years', '04/18/2023'),
            _buildListItem('Marketing Coordinator', 'We have a new role with an exciting fintech start-up in Nigeria, who are currently looking to hire a talented Digital Product designer to join their fast-growing team.', '\$50,000 - \$70,000', '1+ years', '04/17/2023'),
            _buildListItem('Graphic Designer', 'We have a new role with an exciting fintech start-up in Nigeria, who are currently looking to hire a talented Digital Product designer to join their fast-growing team.', '\$60,000 - \$80,000', '2+ years', '04/16/2023'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: primaryBlue,
      ),
    );
  }

  Widget _buildListItem(String title, String description, String salary, String experience, String date) {
    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=> JobDetailsPage()));
      },
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/adaptLogo.png'
                  )
              ),
              SizedBox(width: 10,),
              Text(title,style: mediumBold(primaryBlack),),
            ],
          ),
          Text(date,style: smallBold(greyText),),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10,),
          Text(description,style: smallText(greyText),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.monetization_on_outlined),
                  SizedBox(width: 5,),
                  Text(salary,style: smallText(greyText),),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.person_2_outlined,size: 20,),
                  SizedBox(width: 5,),
                  Text(experience,style: smallText(greyText),),
                ],
              ),
            ],
          ),
          Divider(color: primaryBlack)
        ],
      ),
    );
  }
}
