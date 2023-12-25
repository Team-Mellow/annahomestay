import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:annahomestay/models/user.dart';
import 'package:annahomestay/utils/user_preferences.dart';
import 'package:annahomestay/widget/appbar_widget.dart';
import 'package:annahomestay/widget/button_widget.dart';
import 'package:annahomestay/widget/profile_widget.dart';
import 'package:annahomestay/widget/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;
  var _value = "-1";
  TextStyle commonTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
          child: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.imagePath,
                isEdit: true,
                onClicked: () async {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Full Name',
                text: user.name,
                onChanged: (name) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Email',
                text: user.email,
                onChanged: (email) {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Phone No.',
                text: user.phone,
                onChanged: (phone) {},
              ),
              const SizedBox(height: 24),
              Text('Gender', style: commonTextStyle),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                value: _value,
                items: [
                  DropdownMenuItem(child: Text("-Select Gender-"), value: "-1"),
                  DropdownMenuItem(child: Text("Male"), value: "Male"),
                  DropdownMenuItem(child: Text("Female"), value: "Female"),
                ],
                onChanged: (newValue) {
                  // Handle the value change here
                  setState(() {
                    _value = newValue as String;
                  });
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 24,
                child: ButtonWidget(
                  text: 'Save',
                  onClicked: () {},
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ));
}
