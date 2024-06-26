import 'package:crypto_checker/main.dart';
import 'package:crypto_checker/routes.dart';
import 'package:flutter/material.dart';

class CcDrawerWidget extends StatefulWidget {
  const CcDrawerWidget({super.key});

  @override
  State<CcDrawerWidget> createState() => _CcDrawerWidgetState();
}

class _CcDrawerWidgetState extends State<CcDrawerWidget> with RouteAware {
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
          Text(name, style: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
        ],
      ),
      onTap: () {
        Navigator.of(ctx).pop(); // Close the drawer
        Navigator.of(ctx).pushReplacementNamed(route);
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
            _getDrawerItem(context, 'Wallet', Icons.account_balance_wallet_rounded, AppRoutes.walletView),
          if ( currentRoute != AppRoutes.tokenListView )
            _getDrawerItem(context, 'Token list', Icons.token, AppRoutes.tokenListView),
          Divider(color: Colors.grey.shade300),
          if ( currentRoute != AppRoutes.financialView )
            _getDrawerItem(context, 'Financial', Icons.monetization_on, AppRoutes.financialView),
          if ( currentRoute != AppRoutes.settingsView )
            _getDrawerItem(context, 'Settings', Icons.settings, AppRoutes.settingsView)
        ],
      ),
    );
  }
}
