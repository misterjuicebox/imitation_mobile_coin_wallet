class BalanceStatus {
  String unspentPmob;
  String displayMob;
  String dollars;

  BalanceStatus(this.unspentPmob, this.displayMob, this.dollars);

  BalanceStatus.init() : this('', '', '');
}
