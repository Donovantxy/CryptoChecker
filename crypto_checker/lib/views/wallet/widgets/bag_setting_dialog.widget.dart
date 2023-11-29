import 'package:flutter/material.dart';

class BagSettingDialogWidget extends StatefulWidget {
  final Function(double) onBagSettingSubmit;
  final String tokenSymbol;
  final double amount;
  final FocusNode focusNode;

  const BagSettingDialogWidget({
    super.key,
    required this.focusNode,
    required this.tokenSymbol,
    required this.amount,
    required this.onBagSettingSubmit,
  });

  @override
  State<BagSettingDialogWidget> createState() => _BagSettingDialogWidgetState();
}

class _BagSettingDialogWidgetState extends State<BagSettingDialogWidget> {
  late final TextEditingController _bagAmountController;

  Widget? _resetAmount;

  Widget getResetAmountIcon(String value) {
    return !RegExp(r'^0(.0)?0*$').hasMatch(value)
        ? IconButton(
            onPressed: () {
              setState(() {
                _bagAmountController.text = '0';
              });
            },
            icon: const Icon(Icons.cancel_rounded),
          )
        : const Icon(null);
  }

  @override
  void initState() {
    super.initState();
    _bagAmountController = TextEditingController(text: widget.amount == 0 ? '' : widget.amount.toString());
    _resetAmount = getResetAmountIcon(_bagAmountController.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: Text('Amount of ${widget.tokenSymbol} you own'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: _bagAmountController,
              focusNode: widget.focusNode,
              decoration: InputDecoration(
                hintText: 'amount here',
                suffixIcon: _resetAmount,
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() => _resetAmount = getResetAmountIcon(value));
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
              onPressed: _bagAmountController.text.trim().isEmpty
                  ? null
                  : () {
                      double enteredBagSize = double.tryParse(_bagAmountController.text) ?? 0;
                      widget.onBagSettingSubmit(enteredBagSize);
                      Navigator.of(context).pop();
                    },
              child: const Text('Set'),
            );
          },
        )
      ],
    );
  }
}
