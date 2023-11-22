class TokenAsset {
  String symbol;
  String icon;
  int bagSize;
  String? chainId;
  String? pairAddress;
  bool? isVisible;
  double? price;

  TokenAsset({
    required this.symbol,
    required this.icon,
    this.bagSize = 0,
    this.isVisible = true,
    this.chainId,
    this.pairAddress,
    this.price
  });

}

mixin TokenAssetList {
  static List<TokenAsset> getOne() {
    return [
      TokenAsset(
          symbol: 'BTC',
          icon: 'assets/images/token_icons/BTC.png',
          chainId: 'bsc',
          pairAddress: '0x8fE557749165ADF5F387Ad71CE0cFaB597348624'),
    ];
  }

  static List<TokenAsset> get() {
    return [
      TokenAsset(
          symbol: 'BTC',
          icon: 'assets/images/token_icons/BTC.png',
          chainId: 'bsc',
          pairAddress: '0x8fE557749165ADF5F387Ad71CE0cFaB597348624'),
      TokenAsset(
          symbol: 'ETH',
          icon: 'assets/images/token_icons/ETH.png',
          chainId: 'ethereum',
          pairAddress: '0xc7bBeC68d12a0d1830360F8Ec58fA599bA1b0e9b'),
      TokenAsset(
          symbol: 'XRP',
          icon: 'assets/images/token_icons/XRP.png',
          chainId: 'bsc',
          pairAddress: '0x86746cc10BA1422CB17483748105d1d1DF5A2876'),
      TokenAsset(
          symbol: 'SOL',
          icon: 'assets/images/token_icons/SOL.png',
          chainId: 'bsc',
          pairAddress: '0xAe08C9D357731FD8d25681dE753551BE14C00405'),
      TokenAsset(
          symbol: 'ADA',
          icon: 'assets/images/token_icons/ADA.png',
          chainId: 'bsc',
          pairAddress: '0xcb2828964FDa6A0eC8ed1C0b95E73A5eE58CF16A'),
      TokenAsset(
          symbol: 'VET',
          icon: 'assets/images/token_icons/VET.png',
          chainId: 'bsc',
          pairAddress: '0x9fcA1DcE9E0487336355C6485327Cd8728147c18'),
      TokenAsset(
          symbol: 'DOGE',
          icon: 'assets/images/token_icons/DOGE.png',
          chainId: 'ethereum',
          pairAddress: '0xfCd13EA0B906f2f87229650b8D93A51B2e839EBD'),
      TokenAsset(
          symbol: 'MATIC',
          icon: 'assets/images/token_icons/MATIC.png',
          chainId: 'ethereum',
          pairAddress: '0x88C095C8Ba2C7A1353cF3D21E692c5d4d0F90793'),
      TokenAsset(
          symbol: 'SAND',
          icon: 'assets/images/token_icons/SAND.png',
          chainId: 'bsc',
          pairAddress: '0x69f60c87AEcdb037A44cbaD67eD06464432521b6'),
      TokenAsset(
          symbol: 'GALA',
          icon: 'assets/images/token_icons/GALA.png',
          chainId: 'ethereum',
          pairAddress: '0x86b7A8Bf03167ee42b983b383c9D0182FCC07841'),
      TokenAsset(
          symbol: 'WPLS',
          icon: 'assets/images/token_icons/WPLS.svg',
          chainId: 'pulsechain',
          pairAddress: '0xE56043671df55dE5CDf8459710433C10324DE0aE'),
      TokenAsset(
          symbol: 'eHEX',
          icon: 'assets/images/token_icons/eHEX.png',
          chainId: 'ethereum',
          pairAddress: '0x69D91B94f0AaF8e8A2586909fA77A5c2c89818d5'),
      TokenAsset(
          symbol: 'MBL',
          icon: 'assets/images/token_icons/MBL.png',
          chainId: 'bsc',
          pairAddress: '0x863B7B21ff4CA0782F886D929F3E19522e6Cd8a0'),
    ];
  }
}
