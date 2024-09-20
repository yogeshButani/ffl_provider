import 'package:fitforalegend_provider/const/app_network_image.dart';
import 'package:fitforalegend_provider/provider/user_profile_provider.dart';
import 'package:fitforalegend_provider/screens/edit_profile_screen.dart';
import 'package:fitforalegend_provider/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab5ProfileScreen extends StatefulWidget {
  const Tab5ProfileScreen({super.key});

  @override
  State<Tab5ProfileScreen> createState() => _Tab5ProfileScreenState();
}

class _Tab5ProfileScreenState extends State<Tab5ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProfileProvider>(builder: (context, provider, __) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          ); // Show loading
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 50, right: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()));
                  },
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 50),
                child: ClipOval(
                  child: AppNetworkImage(
                    image:
                        '${ApiServices.imageForProfile}${provider.res.data?.image}',
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  '${provider.res.data?.firstName}',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  '${provider.res.data?.gender}',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
