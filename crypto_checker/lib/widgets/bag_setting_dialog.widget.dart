import 'package:flutter/material.dart';

class BagSettingDialog extends StatefulWidget {
  final Function(int) onBagSettingSubmit;
  final String tokenSymbol;
  const BagSettingDialog({
    super.key,
    required this.tokenSymbol,
    required this.onBagSettingSubmit,
  });

  @override
  State<BagSettingDialog> createState() => _BagSettingDialogState();
}

class _BagSettingDialogState extends State<BagSettingDialog> {
  final TextEditingController _bagAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Set the amount of ${widget.tokenSymbol}'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: _bagAmountController,
              decoration: const InputDecoration(hintText: 'Enter the amount'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Set'),
          onPressed: () {
            int enteredBagSize = int.tryParse(_bagAmountController.text) ?? 0;
            widget.onBagSettingSubmit(enteredBagSize);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
