import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../models/invoice/invoice.dart';
import '../../../models/profile.dart';
import '../../../widget/text_with_space_invoice.dart';
import 'bloc/invoice_bloc.dart';
import 'bloc/invoice_event.dart';
import 'bloc/invoice_state.dart';

class TuitionFeeScreen extends StatefulWidget {
  const TuitionFeeScreen({Key? key, this.scrollController}) : super(key: key);
  final scrollController;
  @override
  State<TuitionFeeScreen> createState() => _ClassInfoState();
}

class _ClassInfoState extends State<TuitionFeeScreen> {
  late InvoiceBloc _invoiceBloc;
  late ScrollController _scrollController;
  final TextStyle _textStyle =
      GoogleFonts.ptSansNarrow(fontSize: 18, fontWeight: FontWeight.w500);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _invoiceBloc = context.read<InvoiceBloc>()
      ..add(LoadInvoice(student: Profile.currentStudent));
    _scrollController = widget.scrollController;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          switch (state.status) {
            case InvoiceStatus.failure:
              // _showSnackBar(context, state.message, Colors.red);
              break;
            case InvoiceStatus.initial:
              // TODO: Handle this case.
              break;
            case InvoiceStatus.changed:
              // TODO: Handle this case.
              break;
            case InvoiceStatus.success:
              // TODO: Handle this case.
              break;
          }
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.70,
              // color: kPrimaryColor
            ),
            SingleChildScrollView(
              // physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height * 0.70,
                  minWidth: size.width,
                  maxHeight: double.infinity,
                ),
                child: Container(
                    height: size.height * 0.70,
                    margin: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 1,
                    ),
                    // height: size.height * 0.73,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Icon(Icons.person, size: 30, color: Colors.grey[500]),
                            const SizedBox(
                              width: 8,
                            ),
                            Text("Hoá đơn:", style: kTextStyleTitle),
                            const SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                        BlocBuilder<InvoiceBloc, InvoiceState>(
                            builder: (context, state) {
                          switch (state.status) {
                            case InvoiceStatus.failure:
                              return Card(
                                color: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: Center(
                                  child: Container(
                                      height: 100,
                                      width: size.width,
                                      child: Center(
                                        child: Text(
                                            'Chưa có thông tin hoá đơn ',
                                            style: kTextStyleRowBlue),
                                      )),
                                ),
                              );

                            case InvoiceStatus.initial:
                              break;
                            case InvoiceStatus.changed:
                              return Center(
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator()));

                            case InvoiceStatus.success:
                              List<Invoice> listInvoice =
                                  state.listInvoiceDetail;
                              return buildListInvoice(listInvoice, size);
                          }
                          return Center(
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()));
                        }),
                      ],
                    )
                    // Stack(
                    //   children: [],
                    // )
                    ),
              ),
            ),
          ],
        ));
  }

  ListView buildListInvoice(List<Invoice> listInvoice, Size size) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listInvoice.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 120,
                minWidth: size.width,
                maxHeight: double.infinity,
              ),
              child: Container(
                  padding: const EdgeInsets.only(
                      left: 12, top: 8, bottom: 8, right: 12),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Học phí tháng ${listInvoice[index].periodName}",
                            style: kTextStyleTitleColor),
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.black38))),
                          child: TextWithSpaceV2(
                              flex1: 50,
                              text1: "Tổng:",
                              textStyle1: GoogleFonts.robotoCondensed(
                                  color: Colors.blueAccent, fontSize: 20),
                              text2:
                                  "${NumberFormat("###,###,###", "en_us").format(listInvoice[index].totalMoneyIncludeTax)} ",
                              flex2: 50,
                              textStyle2: GoogleFonts.robotoCondensed(
                                  color: Colors.blueAccent,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              space: 5),
                        ),
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.black38))),
                          child: TextWithSpaceV2(
                              flex1: 50,
                              text1: "Đã thanh toán:",
                              textStyle1: GoogleFonts.robotoCondensed(
                                  color: Colors.blueAccent, fontSize: 20),
                              text2:
                                  "${NumberFormat("###,###,###", "en_us").format(listInvoice[index].totalMoneyPaid)}",
                              flex2: 50,
                              textStyle2: GoogleFonts.robotoCondensed(
                                  color: Colors.green,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              space: 5),
                        ),
                        Container(
                          height: 35,
                          child: TextWithSpaceV2(
                              flex1: 50,
                              text1: "Còn lại:",
                              text2:
                                  "${NumberFormat("###,###,###", "en_us").format(listInvoice[index].totalMoneyRemain)} ",
                              textStyle1: GoogleFonts.robotoCondensed(
                                  color: Colors.blueAccent, fontSize: 20),
                              flex2: 50,
                              textStyle2: GoogleFonts.robotoCondensed(
                                  color: Colors.redAccent,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              space: 5),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        });
  }
}

//
void _showSnackBar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 3));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
