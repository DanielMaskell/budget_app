import 'package:flutter/material.dart';
import '../pet_room.dart';
import 'models/payment.dart';
import 'utilities/pets_icons.dart';

class PaymentCard extends StatelessWidget {
  final Payment payment;
  final TextStyle boldStyle;
  final splashColor = {
    'cat': Colors.pink[100],
    'dog': Colors.blue[100],
    'other': Colors.grey[100]
  };

  PaymentCard({Key? key, required this.payment, required this.boldStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(payment.name, style: boldStyle),
            ),
          ),
          //_getPetIcon(payment.type)
        ],
      ),
      // TODO Add pet room navigation
      onTap: () => Navigator.push<Widget>(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentRoom(payment: payment),
        ),
      ),
      splashColor: splashColor[payment.type],
    ));
  }

  Widget _getPetIcon(String type) {
    Widget petIcon;
    if (type == 'cat') {
      petIcon = IconButton(
        icon: const Icon(
          Pets.cat,
          color: Colors.pinkAccent,
        ),
        onPressed: () {},
      );
    } else if (type == 'dog') {
      petIcon = IconButton(
        icon: const Icon(
          Pets.dog_seating,
          color: Colors.blueAccent,
        ),
        onPressed: () {},
      );
    } else {
      petIcon = IconButton(
        icon: const Icon(
          Icons.pets,
          color: Colors.blueGrey,
        ),
        onPressed: () {},
      );
    }
    return petIcon;
  }
}
