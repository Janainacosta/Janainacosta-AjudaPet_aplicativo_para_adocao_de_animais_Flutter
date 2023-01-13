import 'package:ajudapet/providers/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({ super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    final Provider = CounterProvider.of(context);
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo contador'),
      ),
      body: Column(
        children: [
          Text(Provider?.state.value.toString() ?? '0'),
          IconButton(
            onPressed: (){
              setState(() {
                Provider?.state.inc();
              });
              print(Provider?.state.value);
            }, 
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: (){
               setState(() {
              Provider?.state.dec();
              });
              print(Provider?.state.value);
            }, 
            icon: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}