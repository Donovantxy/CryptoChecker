import 'package:crypto_checker/main.dart';
import 'package:crypto_checker/routes.dart';
import 'package:flutter/material.dart';

class CcDrawerWdget extends StatefulWidget {
  const CcDrawerWdget({super.key});

  @override
  State<CcDrawerWdget> createState() => _CcDrawerWdgetState();
}

class _CcDrawerWdgetState extends State<CcDrawerWdget> with RouteAware {
  late String currentRoute;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ObserverUtils.routeObserver.subscribe(this, ModalRoute.of(context)!);
    currentRoute = ModalRoute.of(context)?.settings.name ?? AppRoutes.walletView;
  }

  @override
  void dispose() {
    super.dispose();
    ObserverUtils.routeObserver.unsubscribe(this);
  }

  SizedBox _getheader(BuildContext ctx) {
    const sizeIcon = 80.0;
    return SizedBox(
      height: 160,
      child: DrawerHeader(
        decoration: BoxDecoration(color: Theme.of(ctx).colorScheme.primary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: sizeIcon,
              height: sizeIcon,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipOval(
                child: Center(
                  child: Image.asset(
                    'assets/images/icons/crypto_checker.png',
                    width: sizeIcon,
                    height: sizeIcon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 3.0),
            const Text(
              'rypto Checker',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }

  ListTile _getDrawerItem(BuildContext ctx, String name, IconData icon, String route) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, size: 40, color: Theme.of(ctx).colorScheme.primary),
          const SizedBox(width: 8.0),
          Text(name),
        ],
      ),
      onTap: () {
        Navigator.of(ctx).pop(); // Close the drawer
        Navigator.of(ctx).pushNamed(route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _getheader(context),
          if (currentRoute != AppRoutes.walletView)
            _getDrawerItem(context, 'Wallet', Icons.account_balance_wallet_rounded, AppRoutes.walletView)
          else
            _getDrawerItem(context, 'Token list', Icons.token, AppRoutes.tokenListView)
        ],
      ),
    );
  }
}
