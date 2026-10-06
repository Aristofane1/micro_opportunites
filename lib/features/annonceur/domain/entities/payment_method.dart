enum PaymentMethod {
  mtnMomo('MTN MoMo'),
  moovMoney('Moov Money'),
  celtiisCash('Celtiis Cash');

  const PaymentMethod(this.label);
  final String label;
}
