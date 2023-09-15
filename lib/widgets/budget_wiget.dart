import 'package:flutter/material.dart';

class BudgetWidget extends StatefulWidget {
  const BudgetWidget({super.key});

  @override
  State<BudgetWidget> createState() => _BudgetWidgetState();
}

class _BudgetWidgetState extends State<BudgetWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        right: 2,
        child: IconButton(
            onPressed: () {},
            splashColor: Colors.cyan,
            splashRadius: 30,
            icon: Transform.scale(
              scaleX: -1,
              child: const Icon(
                Icons.sort_rounded,
                size: 40,
              ),
            )),
      )
    ]);
  }
}
