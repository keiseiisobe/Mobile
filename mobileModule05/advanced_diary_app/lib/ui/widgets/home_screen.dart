import 'package:diary_app/ui/widgets/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';
import 'profile_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
        backgroundColor: Colors.transparent,  
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to your dairy app!',
                // cursive font style
                style: GoogleFonts.lobster(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the home screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return StreamBuilder(
                          stream: auth.authStateChanges(),
                          builder: (context, asyncSnapshot) {
                            if (asyncSnapshot.hasData) {
                              return MyProfileScreen();
                            } 
                            return LoginScreen();
                          }
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.lobster(
                    fontSize: 20,
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

