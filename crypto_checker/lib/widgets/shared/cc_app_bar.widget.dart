import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/main.dart';
import 'package:crypto_checker/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class CcCustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool showActions;
  const CcCustomAppBar({required this.title, this.showActions = true, super.key});

  @override
  State<CcCustomAppBar> createState() => _CcCustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CcCustomAppBarState extends State<CcCustomAppBar> {
  late Settings settings;

  void updateSortingBy(OrderBy newValue) {
    setState(() {
      settings.orderBy = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TokenAssetsBloc>();

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      title: Text(widget.title),
      actions: [
        BlocBuilder<TokenAssetsBloc, TokenAssetsBaseState>(builder: (ctx, state) {
          final worth = state.tokens.map((token) => token.price * token.bagSize).fold(0.0, (value, element) => value + element);
          settings = Hive.box<Settings>(HIVE_SETTINGS).get(HIVE_SETTINGS) ?? Settings();
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Text(NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 2).format(worth)),
                ),
              ),
              const SizedBox(width: 10),
              if (widget.showActions)
                Container(
                  width: 1.0,
                  height: 15,
                  color: Colors.white,
                ),
              const SizedBox(width: 10),
              if (widget.showActions)
                DropdownButtonHideUnderline(
                  child: DropdownButton<OrderBy>(
                      dropdownColor: Theme.of(context).colorScheme.primary,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      elevation: 2,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      iconEnabledColor: Colors.white,
                      value: settings.orderBy,
                      items: settings.orderByLabel.entries.toList().map((MapEntry<OrderBy, String> entry) {
                        return DropdownMenuItem<OrderBy>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (newValue) async {
                        bloc.add(UpdateSortingByEvent(newValue!));
                      }),
                ),
              if (widget.showActions)
                IconButton(
                  onPressed: () => bloc.add(UpdateSortingOrderTokensEvent()),
                  icon: Icon(settings.sortingOrder == SortingOrder.asc ? Icons.arrow_circle_up : Icons.arrow_circle_down),
                ),
            ],
          );
        }),
      ],
    );
  }
}
