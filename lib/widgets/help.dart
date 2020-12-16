import 'package:flutter/material.dart';

help(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text(
        'Need Help!',
        style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('We are happy to solve your problem.'),
          const Text(
            'Mail us at otgcarwash@123gmail.com.',
            style:const TextStyle(fontWeight: FontWeight.w500),
          ),
          const Text('OR'),
          const Text('Contact us at 1234567890'),
        ],
      ),
      actions: [
        FlatButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}
