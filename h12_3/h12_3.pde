class BankAccount{
  int rekeningnummer;
  int saldo;
  String eigenaar;
  
  BankAccount(int rekeningnummer, int saldo, String eigenaar){
    this.rekeningnummer = rekeningnummer;
    this.saldo = saldo;
    this.eigenaar = eigenaar;
  }
  
  public void accountInfo(){
    println("rekeningnummer : " + rekeningnummer);
    println("saldo : " + saldo);
    println("eigenaar : " + eigenaar);
  }
  
}

void setup(){
  BankAccount myBankAccount = new BankAccount(6767, 2000, "Bas De Gerth ");
  myBankAccount.accountInfo();
}
