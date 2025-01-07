import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_nav.dart';

class EmergencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Centro de emergência',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Toda central de emergência da cidade está aqui',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Emergency Contact Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contatos de emergência',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  EmergencyContactCard(
                    title: 'Equipe policial 97',
                    subtitle: 'Tempo médio de chegada: 10 min',
                    icon: Icons.local_police,
                    phoneNumber: '197',
                  ),
                  SizedBox(height: 12),
                  EmergencyContactCard(
                    title: '911 Hospital geral',
                    subtitle: '800m da sua localização',
                    icon: Icons.local_hospital,
                    phoneNumber: '911',
                  ),
                ],
              ),
            ),

            // Additional Information Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Outras informações',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: InfoCard(
                          title: 'Primeiro socorro',
                          icon: Icons.medical_services,
                          color: Colors.red.withOpacity(0.2),
                          iconColor: Colors.red,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: InfoCard(
                          title: 'Artigos',
                          icon: Icons.article,
                          color: Colors.blue.withOpacity(0.2),
                          iconColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: Colors.orange),
                        SizedBox(width: 12),
                        Text(
                          'Outras informações',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}

class EmergencyContactCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String phoneNumber;

  const EmergencyContactCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.orange),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.phone, color: Colors.orange),
            onPressed: () {
              // Implement phone call
            },
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Color iconColor;

  const InfoCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 32),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}