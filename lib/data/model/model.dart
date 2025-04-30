

// Models
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String phoneNumber;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.phoneNumber,
  });
}

class Lawyer {
  final String id;
  final String name;
  final String photoUrl;
  final String specialization;
  final double rating;
  final int reviewCount;
  final String experience;
  final String about;
  final double consultationFee;
  final List<String> languages;
  final List<String> availableDays;

  Lawyer({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.specialization,
    required this.rating,
    required this.reviewCount,
    required this.experience,
    required this.about,
    required this.consultationFee,
    required this.languages,
    required this.availableDays,
  });
}

class Appointment {
  final String id;
  final String lawyerId;
  final String userId;
  final String lawyerName;
  final String userEmail;
  final DateTime dateTime;
  final String status; // 'pending', 'confirmed', 'completed', 'cancelled'
  final String consultationType; // 'video', 'audio', 'in-person'
  final String issue;

  Appointment({
    required this.id,
    required this.lawyerId,
    required this.userId,
    required this.lawyerName,
    required this.userEmail,
    required this.dateTime,
    required this.status,
    required this.consultationType,
    required this.issue,
  });
}

class ChatMessage {
  final String senderId;
  final String text;
  final DateTime timestamp;
  
  ChatMessage({
    required this.senderId,
    required this.text,
    required this.timestamp,
  });
}

// Providers
class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String phoneNumber, String password) async {
    // In a real app, this would make an API call to authenticate
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock successful login
      if (phoneNumber.contains('+1') && password == 'password') {
        _currentUser = User(
          id: '1',
          name: 'John Doe',
          email: 'john.doe@example.com',
          photoUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
          phoneNumber: phoneNumber,
        );
        _isLoggedIn = true;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    // In a real app, this would clear tokens, etc.
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<bool> register(String name, String phoneNumber, String password) async {
    // In a real app, this would make an API call to register
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock successful registration
      _currentUser = User(
        id: '1',
        name: name,
        email: '$name.user@example.com',
        photoUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        phoneNumber: phoneNumber,
      );
      _isLoggedIn = true;
      notifyListeners();
      return true;
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  Future<void> updateProfile(String name, String phoneNumber) async {
    // In a real app, this would make an API call to update profile
    if (_currentUser != null) {
      _currentUser = User(
        id: _currentUser!.id,
        name: name,
        email: _currentUser!.email,
        photoUrl: _currentUser!.photoUrl,
        phoneNumber: phoneNumber,
      );
      notifyListeners();
    }
  }
}

class LawyerProvider with ChangeNotifier {
  List<Lawyer> _lawyers = [];
  List<Appointment> _appointments = [];
  
  List<Lawyer> get lawyers => _lawyers;
  List<Appointment> get appointments => _appointments;

  LawyerProvider() {
    _loadLawyers();
  }

  Future<void> _loadLawyers() async {
    // In a real app, this would fetch from an API
    await Future.delayed(const Duration(seconds: 1));
    
    _lawyers = [
      Lawyer(
        id: '1',
        name: 'Sarah Johnson',
        photoUrl: 'https://plus.unsplash.com/premium_photo-1690407617686-d449aa2aad3c?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fHww',
        specialization: 'Family Law',
        rating: 4.8,
        reviewCount: 124,
        experience: '15 years',
        about: 'Specializing in divorce, child custody, and family matters with compassion and expertise. I have handled hundreds of cases and have a strong track record of successful outcomes for my clients.',
        consultationFee: 150.0,
        languages: ['English', 'Spanish'],
        availableDays: ['Monday', 'Tuesday', 'Wednesday', 'Friday'],
      ),
      Lawyer(
        id: '2',
        name: 'Michael Chen',
        photoUrl: 'https://plus.unsplash.com/premium_photo-1689977807477-a579eda91fa2?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDl8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fHww',
        specialization: 'Corporate Law',
        rating: 4.9,
        reviewCount: 89,
        experience: '12 years',
        about: 'Expert in business formation, contracts, and corporate compliance matters. I help businesses of all sizes navigate complex legal challenges and achieve their goals while minimizing legal risks.',
        consultationFee: 200.0,
        languages: ['English', 'Mandarin'],
        availableDays: ['Monday', 'Wednesday', 'Thursday', 'Friday'],
      ),
      Lawyer(
        id: '3',
        name: 'Jessica Rodriguez',
        photoUrl: 'https://plus.unsplash.com/premium_photo-1688350839154-1a131bccd78a?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NzN8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fHww',
        specialization: 'Criminal Defense',
        rating: 4.7,
        reviewCount: 156,
        experience: '10 years',
        about: 'Dedicated criminal defense attorney with experience in both state and federal courts. I am committed to protecting your rights and providing aggressive representation for all criminal matters.',
        consultationFee: 175.0,
        languages: ['English', 'Spanish'],
        availableDays: ['Tuesday', 'Wednesday', 'Thursday', 'Saturday'],
      ),
      Lawyer(
        id: '4',
        name: 'David Wilson',
        photoUrl: 'https://plus.unsplash.com/premium_photo-1661374927471-24a90ebd5737?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTI1fHxwcm9maWxlJTIwcGljdHVyZXxlbnwwfHwwfHx8MA%3D%3D',
        specialization: 'Real Estate Law',
        rating: 4.6,
        reviewCount: 78,
        experience: '8 years',
        about: 'Helping clients navigate property transactions, landlord-tenant issues, and real estate disputes. I provide comprehensive legal services for buyers, sellers, landlords, and tenants.',
        consultationFee: 160.0,
        languages: ['English'],
        availableDays: ['Monday', 'Tuesday', 'Thursday', 'Friday'],
      ),
      Lawyer(
        id: '5',
        name: 'Amanda Patel',
        photoUrl: 'https://images.unsplash.com/photo-1607746882042-944635dfe10e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Njd8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fHww',
        specialization: 'Immigration Law',
        rating: 4.9,
        reviewCount: 112,
        experience: '9 years',
        about: 'Passionate about helping clients navigate the complex immigration system with confidence. I assist with visas, green cards, citizenship applications, and deportation defense.',
        consultationFee: 165.0,
        languages: ['English', 'Hindi', 'Gujarati'],
        availableDays: ['Monday', 'Wednesday', 'Friday', 'Saturday'],
      ),
    ];
    
    notifyListeners();
  }

  Future<List<Lawyer>> searchLawyers(String query) async {
    // In a real app, this would search from an API
    if (query.isEmpty) return _lawyers;
    
    return _lawyers.where((lawyer) => 
      lawyer.name.toLowerCase().contains(query.toLowerCase()) ||
      lawyer.specialization.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  Future<bool> bookAppointment(Appointment appointment) async {
    // In a real app, this would make an API call
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      _appointments.add(appointment);
      notifyListeners();
      return true;
    } catch (e) {
      print('Booking error: $e');
      return false;
    }
  }

  Future<List<Appointment>> getUserAppointments(String userId) async {
    // In a real app, this would fetch from an API
    return _appointments.where((appointment) => appointment.userId == userId).toList();
  }

  Future<bool> cancelAppointment(String appointmentId) async {
    // In a real app, this would make an API call
    try {
      final index = _appointments.indexWhere((appointment) => appointment.id == appointmentId);
      if (index != -1) {
        final appointment = _appointments[index];
        final updatedAppointment = Appointment(
          id: appointment.id,
          lawyerId: appointment.lawyerId,
          userId: appointment.userId,
          lawyerName: appointment.lawyerName,
          userEmail: appointment.userEmail,
          dateTime: appointment.dateTime,
          status: 'cancelled',
          consultationType: appointment.consultationType,
          issue: appointment.issue,
        );
        
        _appointments[index] = updatedAppointment;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Cancellation error: $e');
      return false;
    }
  }

  getTopLawyers() {}
}

// Notification Provider
class NotificationProvider with ChangeNotifier {
  void scheduleInAppReminder(BuildContext context, Appointment appointment) {
    final scheduledTime = appointment.dateTime.subtract(const Duration(minutes: 5));
    final now = DateTime.now();
    final durationUntilReminder = scheduledTime.difference(now);

    // Check if the duration is positive
    if (durationUntilReminder.inSeconds > 0) {
      Timer(durationUntilReminder, () {
        _showReminderDialog(context, appointment);
      });

      print('In-app reminder scheduled for: $scheduledTime');
    }
  }

  void _showReminderDialog(BuildContext context, Appointment appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upcoming Appointment'),
        content: Text('You have an appointment with ${appointment.lawyerName} in 5 minutes.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
  
  Future<void> checkAndScheduleAppointmentNotifications(BuildContext context) async {
    final lawyerProvider = Provider.of<LawyerProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.currentUser;
    
    if (user != null) {
      final appointments = await lawyerProvider.getUserAppointments(user.id);
      
      for (final appointment in appointments) {
        if (appointment.status == 'confirmed') {
        }
      }
    }
  }
//}

// Extension for string capitalization
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}