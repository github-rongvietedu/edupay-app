class Invoice {
  int? period;
  String? invoiceNumber;
  double? totalMoneyIncludeTax;
  double? totalMoneyPaid;
  double? totalMoneyRemain;
  String? periodName;
  String? fromDate;
  String? toDate;

  Invoice(
      {this.period,
      this.invoiceNumber,
      this.totalMoneyIncludeTax,
      this.totalMoneyPaid,
      this.totalMoneyRemain,
      this.periodName,
      this.fromDate,
      this.toDate});

  Invoice.fromJson(Map<String, dynamic> json) {
    period = json['Period'] ?? 0;
    invoiceNumber = json['InvoiceNumber'] ?? "";
    totalMoneyIncludeTax = json['TotalMoneyIncludeTax'] ?? 0;
    totalMoneyPaid = json['TotalMoneyPaid'] ?? 0;
    totalMoneyRemain = json['TotalMoneyRemain'] ?? 0;
    periodName = json['PeriodName'] ?? "";
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> Invoice = new Map<String, dynamic>();
    Invoice['Period'] = this.period;
    Invoice['InvoiceNumber'] = this.invoiceNumber;
    Invoice['TotalMoneyIncludeTax'] = this.totalMoneyIncludeTax;
    Invoice['TotalMoneyPaid'] = this.totalMoneyPaid;
    Invoice['TotalMoneyRemain'] = this.totalMoneyRemain;
    Invoice['PeriodName'] = this.periodName;
    Invoice['FromDate'] = this.fromDate;
    Invoice['ToDate'] = this.toDate;
    return Invoice;
  }
}
