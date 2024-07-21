import 'package:flutter/material.dart';

class PinInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please enter your PIN'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 2,
                children: List.generate(12, (index) {
                  return ElevatedButton(
                    onPressed: () {
                      // Handle PIN input here
                    },
                    child: Text(index == 9
                        ? ''
                        : index == 10
                            ? '0'
                            : index == 11
                                ? '⌫'
                                : (index + 1).toString()),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
