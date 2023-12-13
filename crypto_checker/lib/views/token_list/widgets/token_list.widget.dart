import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class TokenListWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;

  const TokenListWidget({super.key, this.padding = const EdgeInsets.all(10)});

  Widget _getLeadingIcon(TokenAsset token) {
    Widget img;
    if (token.icon!.endsWith('.svg')) {
      img = SvgPicture.asset(token.icon!);
    } else {
      img = Image.asset(token.icon!);
    }
    return SizedBox(width: 64.0, height: 64.0, child: img);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Expanded(child: _loadTokens())],
        ),
      ),
    );
  }

  BlocBuilder _loadTokens() {
    return BlocBuilder<TokenAssetsBloc, TokenAssetsBaseState>(builder: (ctx, state) {
      return ListView.builder(
          itemCount: state.tokens.length,
          itemBuilder: (ctx, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 15, left: 6, right: 6),
              elevation: 2.0,
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                tileColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                titleAlignment: ListTileTitleAlignment.center,
                leading: _getLeadingIcon(state.tokens[index]),
                title: Text(
                  state.tokens[index].symbol,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text('price: ${state.tokens[index].price == 0 ? '---' : '\$${state.tokens[index].price}'}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'bag: ${NumberFormat.decimalPatternDigits(locale: 'en_US', decimalDigits: 2).format(state.tokens[index].bagSize)}',
                          ),
                        ),
                      ],
                    )),
                trailing: Switch(
                  // This bool value toggles the switch.
                  value: state.tokens[index].isVisible,
                  activeColor: Theme.of(ctx).colorScheme.primary,
                  onChanged: (bool value) {
                    ctx.read<TokenAssetsBloc>().add(ToggleTokenVisibilityEvent(state.tokens[index].symbol));
                  },
                ),
              ),
            );
          });
    });
  }

}
