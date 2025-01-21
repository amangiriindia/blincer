import 'package:blinker/constant/app_color.dart';
import 'package:flutter/material.dart';

import '../constant/app_constant.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isAppBarCollapsed = false;
  int? userId;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }
  Future<void> _getUserData() async {
    
   // userId = UserConstant.USER_ID ?? 1;
    setState(() {}); // Call setState to update the UI if `id` is being used there
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo is ScrollUpdateNotification) {
            setState(() {
              _isAppBarCollapsed =
                  scrollInfo.metrics.pixels > 200; // Adjust threshold as needed
            });
          }
          return true;
        },




        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 350, // Adjust as needed
              flexibleSpace: FlexibleSpaceBar(
                background: const _TopPortion(),
                title: _isAppBarCollapsed
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 8),
                          Text("My Profile"),
                        ],
                      )
                    : null,
                centerTitle: false,
                collapseMode: CollapseMode.parallax,
              ),
              pinned: true,
              floating: true, // Allows the app bar to reappear on scroll up
              snap: true, // Makes the app bar snap into view
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        const SizedBox(height: 16),
                        const Divider(),
                        const _SectionHeader(text: 'My Orders'),
                        _ProfileOptionItem(
                          icon: Icons.shopping_cart_outlined,
                          text: 'View Orders',
                          onTap: () {},
                        ),
                        _ProfileOptionItem(
                          icon: Icons.favorite_border,
                          text: 'Wishlist',
                          onTap: () {},
                        ),
                        const Divider(),
                        const _SectionHeader(text: 'Account Settings'),
                        _ProfileOptionItem(
                          icon: Icons.account_circle_outlined,
                          text: 'Profile',
                          onTap: () {},
                        ),
                        _ProfileOptionItem(
                          icon: Icons.location_on_outlined,
                          text: 'Manage Addresses',
                          onTap: () {},
                        ),
                        _ProfileOptionItem(
                          icon: Icons.payment_outlined,
                          text: 'Payment Methods',
                          onTap: () {},
                        ),
                        const Divider(),
                        const _SectionHeader(text: 'Support'),
                        _ProfileOptionItem(
                          icon: Icons.help_outline,
                          text: 'Help & Support',
                          onTap: () {},
                        ),
                        _ProfileOptionItem(
                          icon: Icons.info_outline,
                          text: 'About Us',
                          onTap: () {},
                        ),
                        const Divider(),
                        const _SectionHeader(text: 'More'),
                        _ProfileOptionItem(
                          icon: Icons.settings,
                          text: 'Settings',
                          onTap: () {},
                        ),
                        _ProfileOptionItem(
                          icon: Icons.logout,
                          text: 'Logout',
                          onTap: () {},
                        ),
                        const SizedBox(height: 100),



                      ],
                    ),
                  ),
                ],
              ),
            ),










          ],
        ),
      ),
  
    );
  }
}

class _GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final Gradient gradient;

  const _GradientButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _ProfileOptionItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _ProfileOptionItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
             AppColor.primary,
                  AppColor.secondary
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'A', // Replace 'A' with dynamic text if needed
                    style: TextStyle(
                      fontSize: 80,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const UpdateProfilePage(),
                        //   ),
                        //);
                      // Add your edit action here
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
