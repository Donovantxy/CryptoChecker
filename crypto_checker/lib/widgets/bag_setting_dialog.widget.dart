import 'package:flutter/material.dart';

class BagSettingDialogWidget extends StatefulWidget {
  final Function(int) onBagSettingSubmit;
  final String tokenSymbol;
  
  const BagSettingDialogWidget({
    super.key,
    required this.tokenSymbol,
    required this.onBagSettingSubmit,
  });

  @override
  State<BagSettingDialogWidget> createState() => _BagSettingDialogWidgetState();
}

class _BagSettingDialogWidgetState extends State<BagSettingDialogWidget> {
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
