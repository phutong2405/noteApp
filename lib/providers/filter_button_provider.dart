import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterButtonNotifier extends StateNotifier<List<List<bool>>> {
  FilterButtonNotifier()
      : super([
          [false, false, false, false],
          [false, false, false, false]
        ]);

  void setButton(int index, int flag) {
    // flag = 0 is filter / flag = 1 is new note
    if (state[flag][index] == true) {
      state[flag] = [false, false, false, false];
    } else {
      state[flag] = [false, false, false, false];
      state[flag][index] = !state[flag][index];
    }
  }

  void resetButton(int flag) {
    state[flag] = [false, false, false, false];
  }

  Color getColorButton(int flag) {
    if (state[flag][0] == true) {
      return Colors.red;
    }
    if (state[flag][1] == true) {
      return Colors.blue;
    }
    if (state[flag][2] == true) {
      return Colors.yellow;
    }
    if (state[flag][3] == true) {
      return Colors.green;
    }
    return Colors.transparent;
  }
}

final filterButtonProvider =
    StateNotifierProvider<FilterButtonNotifier, List<List<bool>>>((ref) {
  return FilterButtonNotifier();
});
