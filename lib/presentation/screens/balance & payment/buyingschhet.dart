import 'package:flutter/material.dart';
import 'package:layer/presentation/screens/balance%20&%20payment/payment.dart';

class BuyingSheet extends StatelessWidget {
  const BuyingSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rechargeOptions = [
      {'title': 'Basic', 'minutes': 100, 'price': 120},
      {'title': 'Standard', 'minutes': 200, 'price': 180},
      {'title': 'Expensive', 'minutes': 500, 'price': 300},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
        
              const Text(
                'Choose Recharge Option',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
                    IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.cancel)),
            ],
          ),
          const SizedBox(height: 24),
          ...rechargeOptions.map(
            (option) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                leading: const Icon(Icons.phone_android_rounded,
                    size: 30, color: Colors.blueAccent),
                title: Text(
                  option['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text('${option['minutes']} mins - ${option['price']} BDT'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                onTap: () {
                  Navigator.pop(context); // Close bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentCardScreen(
                        selectedOption: option,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
