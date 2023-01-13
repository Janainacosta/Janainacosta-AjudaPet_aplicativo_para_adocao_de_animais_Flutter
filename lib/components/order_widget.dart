import 'package:ajudapet/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget({required this.order,super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('pppp'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy').format(widget.order.date),
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            height: 200,
            child: ListView(
              children: widget.order.animalAd.map(
                (e) {
                  return Row(
                    children: [
                      Text('opa')
                    ],
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}