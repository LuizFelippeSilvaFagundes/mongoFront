import 'package:flutter/material.dart';

import 'led.dart';

class GroupLed extends StatelessWidget {
  final Map<int, Led>? groupList; // Alteração feita aqui

  GroupLed({required this.groupList}); // Alteração feita aqui

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          key: UniqueKey(),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (groupList?[1] != null) groupList![1]!,
                if (groupList?[2] != null) groupList![2]!,
                if (groupList?[3] != null) groupList![3]!,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (groupList?[4] != null) groupList![4]!,
                if (groupList?[5] != null) groupList![5]!,
                if (groupList?[6] != null) groupList![6]!,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (groupList?[7] != null) groupList![7]!,
                if (groupList?[8] != null) groupList![8]!,
                if (groupList?[9] != null) groupList![9]!,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (groupList?[10] != null) groupList![10]!,
                if (groupList?[11] != null) groupList![11]!,
                if (groupList?[12] != null) groupList![12]!,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
