import 'package:flutter/material.dart';

Widget quote(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 100,
          constraints: const BoxConstraints(maxWidth: 326),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "\"Quote\"",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .fontSize),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}