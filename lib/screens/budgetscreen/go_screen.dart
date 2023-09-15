import 'package:flutter/material.dart';
import 'package:someapp/screens/budgetscreen/add_bud_sheet.dart';
import 'package:someapp/widgets/budget_wiget.dart';

class GoScreen extends StatelessWidget {
  const GoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerLeft,
          child: const Text('Budget', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                
              },
            
            child: RichText(text: const TextSpan(text: '12300', style: TextStyle(fontSize: 22, color: Colors.green), children: [TextSpan(text: '\$', style: TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold))]),),),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(150),
          ),
          // color: Colors.amber,
          gradient: LinearGradient(
              colors: [Colors.cyan, Colors.cyan.withOpacity(0.4)],
              end: Alignment.topLeft,
              begin: Alignment.centerRight),
        ),
        alignment: Alignment.center,
        child: const BudgetWidget(),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor:
              Colors.cyan,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0))),
          child:
              Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
          onPressed: () async {
            await showModalBottomSheet(
          
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60),
                  topLeft: Radius.circular(60),
                ),
              ),
              showDragHandle: true,
              context: context,
              builder: (context) => Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: 400,
                  child: const AddTran()),
              ),
            );
          },
        ));
  }
}