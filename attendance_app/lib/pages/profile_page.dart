import 'package:attendance_app/pages/login.dart';
import 'package:attendance_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // Simulated user data for demonstration purposes// Replace with user's age

  Future<bool> _onBackPressed() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        title: const Text(
          'Do you want to Log out..?',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        actions: <Widget>[
          CloseButton(
            onPressed: () => Navigator.of(context).pop(false),
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.check,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    ).then((value) =>
        value ?? false); // Ensure to return false if the dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: CustomTheme.loginGradientStart,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ), // Add a logout icon here
            onPressed: () {
              // Implement logout functionality
              _onBackPressed();
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    UserProfileCard(
                      onEditProfile: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const EditProfileScreen(),
                        //   ),
                        // );
                      },
                    ),

                    // ... Other sections (Screening History, Progress Tracker, Recommendations) ...
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfileCard extends StatelessWidget {
  final VoidCallback? onEditProfile;

  UserProfileCard({
    super.key,
    this.onEditProfile,
  });
  // double a = map['age'];
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User Profile Picture (optional)

            const SizedBox(height: 16.0),
            // User Name
            Text(
              // map['name']!,
              "Nikhil Soni",
              style: GoogleFonts.roboto(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: CustomTheme.loginGradientStart, // Custom text color
              ),
            ),
            const SizedBox(height: 8.0),
            // User Email
            Text(
              "nikhilsoni2910@gmail.com",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const Divider(
              color: Colors.grey,
              height: 32.0,
            ),
            // User State
            ListTile(
              leading: const Icon(
                Icons.location_on, // Custom icon
                color: CustomTheme.loginGradientStart,
              ),
              title: const Text(
                'State',
                style: TextStyle(
                  color: CustomTheme.loginGradientStart,
                ),
              ),
              subtitle: Text(
                "Goa",
                style: const TextStyle(
                  color: CustomTheme.loginGradientStart,
                ),
              ),
            ),
            // User City
            ListTile(
              leading: Icon(
                "male" == "male"
                    ? Icons.male_rounded
                    : Icons.female_rounded, // Custom icon
                color: CustomTheme.loginGradientStart,
              ),
              title: const Text(
                'Gender',
                style: TextStyle(
                  color: CustomTheme.loginGradientStart,
                ),
              ),
              subtitle: Text(
                "male",
                style: const TextStyle(
                  color: CustomTheme.loginGradientStart,
                ),
              ),
            ),
            // User Age
            ListTile(
              leading: const Icon(
                Icons.cake, // Custom icon
                color: CustomTheme.loginGradientStart,
              ),
              title: const Text(
                'Age',
                style: TextStyle(
                  color: CustomTheme.loginGradientStart,
                ),
              ),
              subtitle: Text(
                '30 years',
                style: const TextStyle(
                  color: CustomTheme.loginGradientStart,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Edit Profile Button
            if (onEditProfile != null)
              ElevatedButton(
                onPressed: onEditProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      CustomTheme.loginGradientStart, // Custom button color
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),

            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const GroupHomePage(),
                //     ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    CustomTheme.loginGradientStart, // Custom button color
              ),
              child: const Text(
                'Group Chat',
                style: TextStyle(color: Colors.white),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const MultiLineGraphPage(),
                //     ));
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    CustomTheme.loginGradientStart, // Custom button color
              ),
              child: const Text(
                'View Upload History',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
