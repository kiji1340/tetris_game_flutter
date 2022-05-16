import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data_notifier.dart';

class NextBlock extends StatefulWidget {
  const NextBlock({Key? key}) : super(key: key);

  @override
  State createState() => _NextBlock();
}

class _NextBlock extends State<NextBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:  <Widget>[
          const Text(
            'Next',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.indigo[600],
              child: Center(
                child: context.watch<DataNotifier>().getNextBlockWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
