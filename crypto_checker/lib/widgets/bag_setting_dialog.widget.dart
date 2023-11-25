import 'package:flutter/material.dart';

class BagSettingDialogWidget extends StatefulWidget {
  final Function(double) onBagSettingSubmit;
  final String tokenSymbol;
  final double exsistingBag;

  const BagSettingDialogWidget({
    super.key,
    required this.tokenSymbol,
    required this.exsistingBag,
    required this.onBagSettingSubmit,
  });

  @override
  State<BagSettingDialogWidget> createState() => _BagSettingDialogWidgetState();
}

class _BagSettingDialogWidgetState extends State<BagSettingDialogWidget> {
  late final TextEditingController _bagAmountController;

  @override
  void initState() {
    super.initState();
    _bagAmountController = TextEditingController(text: widget.exsistingBag.toString());
  }

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
              onChanged: (value) {
                setState(() {});
              },
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        StatefulBuilder(
          builder: (ctx, setState) {
            return TextButton(
              child: const Text('Set'),
              onPressed: _bagAmountController.text.trim().isEmpty
              ? null
              : () {
                double enteredBagSize = double.tryParse(_bagAmountController.text) ?? 0;
                widget.onBagSettingSubmit(enteredBagSize);
                Navigator.of(context).pop();
              },
            );
          },
        )
      ],
    );
  }
}
