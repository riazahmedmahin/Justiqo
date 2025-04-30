
// Main app container with all features
import 'package:flutter/material.dart';
import 'package:layer/data/model/model.dart';
import 'package:layer/presentation/screens/AIBot/aibot.dart';
import 'package:layer/presentation/screens/Call%20&%20Chat/chatscreen.dart';
import 'package:layer/presentation/screens/auth/profile.dart';
import 'package:layer/presentation/screens/layer/LawyerDetails.dart';
import 'package:layer/presentation/screens/layer/lawyerListsecetion.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LegalAdvisorApp extends StatefulWidget {
  const LegalAdvisorApp({Key? key}) : super(key: key);

  @override
  _LegalAdvisorAppState createState() => _LegalAdvisorAppState();
}

class _LegalAdvisorAppState extends State<LegalAdvisorApp> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    // Check for upcoming appointments and schedule notifications
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
      //notificationProvider.checkAndScheduleAppointmentNotifications(context);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          LawyerListSection(),
          const AppointmentSection(),
          const ChatSection(),
          const ProfileSection(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            elevation: 20,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Lawyers',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Appointments',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
          ),
        ),
      ),
// Inside your Scaffold
floatingActionButton: FloatingActionButton(
  onPressed: () {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AiBot(),
    );
  },
  backgroundColor: Theme.of(context).primaryColor,
  child: Lottie.asset(
    'assets/animation/aibot.json',
    width: 100,
    height: 100,
    fit: BoxFit.cover,
    repeat: true, // Keep it looping
  ),
),

    );
  }
}





