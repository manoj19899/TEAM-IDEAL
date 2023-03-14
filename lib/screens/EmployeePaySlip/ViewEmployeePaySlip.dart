import 'dart:typed_data';

import 'package:dakshattendance/AppConst/AppConst.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../../Model/SlipDetailsModel.dart';
import '../../provider/PaySlipProvider.dart';

class ViewSlip extends StatefulWidget {
  const ViewSlip(
      {Key? key, required this.slipId, required this.month, required this.year})
      : super(key: key);
  final String slipId;
  final String month;
  final String year;

  @override
  State<ViewSlip> createState() => _ViewSlipState();
}

class _ViewSlipState extends State<ViewSlip> {
  void init() async {
    await Provider.of<SlipProvider>(context, listen: false)
        .getSlipDetails(widget.slipId);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SlipProvider>(builder: (context, sp, _) {
      return sp.isLoadingDetails
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : sp.sd != null
              ? PdfPreviewPage(
                  invoice: sp.sd!,
                  month: widget.month,
                  year: widget.year,
                )
              : Scaffold(
                  body: Center(
                    child: Text('Could\'nt load document'),
                  ),
                );
    });
  }
}

class PdfPreviewPage extends StatelessWidget {
  final SlipDetails invoice;
  final String month;
  final String year;
  const PdfPreviewPage(
      {Key? key,
      required this.invoice,
      required this.month,
      required this.year})
      : super(key: key);

  Future<Uint8List> makePdf(SlipDetails invoice) async {
    final pdf = pw.Document();
    final emoji = await PdfGoogleFonts.notoColorEmoji();
    final netImage = await networkImage(AppConst.companyLogoUrl);

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.standard,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                children: [
                  pw.Image(netImage),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          invoice.employee!.companyName ?? '',
                          style: pw.TextStyle(
                              fontFallback: [emoji],
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 18),
                        ),
                        pw.Text(
                          invoice.employee!.companyAddress ?? '',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontFallback: [emoji],
                            fontWeight: pw.FontWeight.bold,
                            // fontSize: 18
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              'Payslip for the Month of : ',
                              style: pw.TextStyle(
                                  fontFallback: [emoji],
                                  fontWeight: pw.FontWeight.normal,
                                  fontSize: 14),
                            ),
                            pw.Text(
                              '${month ?? ''} ${year ?? ''}',
                              style: pw.TextStyle(
                                  fontFallback: [emoji],
                                  fontWeight: pw.FontWeight.normal,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 15),
              pw.Divider(),
              pw.SizedBox(height: 15),
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      children: [
                        pw.Row(
                          // mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              'Employee Code : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              '${invoice.employee!.empCode ?? ''}',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Name : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              '${invoice.employee!.empNm ?? ''}',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        if (invoice.employee!.joindt != null)
                          pw.Row(
                            children: [
                              pw.Text(
                                'Date of Joining : ',
                                style: pw.TextStyle(
                                  fontFallback: [emoji],
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                              pw.Text(
                                // '${DateFormat('dd-MM-yyyy').format(DateTime.parse(invoice.employee!.joindt))}',
                                '${invoice.employee!.joindt.toString().split('-').reversed.join('-')}',
                                style: pw.TextStyle(
                                  fontFallback: [emoji],
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Location : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              '${invoice.employee!.location ?? ''}',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Division : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              '${invoice.employee!.division ?? ''}',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Designation : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              '${invoice.employee!.designation ?? ''}',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Grade : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              '${invoice.employee!.grade ?? ''}',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Gender : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              '${invoice.employee!.gender ?? ''}',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      children: [
                        pw.Row(
                          // mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              'Bank Name : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              '${invoice.employee!.banknm ?? ''}',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'Bank Account No. : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              '${invoice.employee!.accno ?? ''}',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'UAN No : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              '${invoice.employee!.pfno ?? ''}',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'PAN : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              '${invoice.employee!.panNo ?? ''}',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              'ESI No. : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              '${invoice.employee!.esicNo ?? ''}',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              ' \n',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              ' ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              'Paid Days : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              invoice.empsalReg!.daysPresent.toString() ?? '',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              'Days in Month : ',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                            pw.Text(
                              invoice.employee!.dayInMonth.toString() ?? '',
                              style: pw.TextStyle(
                                fontFallback: [emoji],
                                fontWeight: pw.FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 15),

              ///
              //     ],
              //   );
              // }));
              // pdf.addPage(pw.Page(
              // pageFormat: PdfPageFormat.standard,
              // build: (pw.Context context) {
              //   return pw.Column(
              //     children: [

              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                      child: pw.Table(border: pw.TableBorder.all(), children: [
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('Earning',
                            textAlign: pw.TextAlign.left,
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('Amount',
                            textAlign: pw.TextAlign.left,
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ]),
                    if (invoice.empsalReg!.basic != '0' &&
                        invoice.empsalReg!.basic != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('BASIC', textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.basic ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.hra != '0' &&
                        invoice.empsalReg!.hra != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('HRA', textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.hra ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.miscallow != '0' &&
                        invoice.empsalReg!.miscallow != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Misc Allow	',
                              textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.miscallow ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.commallow != '0' &&
                        invoice.empsalReg!.commallow != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Comm Allow',
                              textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.commallow ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.foodallow != '0' &&
                        invoice.empsalReg!.foodallow != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Food Allow',
                              textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.foodallow ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.otamount != '0' &&
                        invoice.empsalReg!.otamount != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('OT Amount	',
                              textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.otamount ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.conveyance != '0' &&
                        invoice.empsalReg!.conveyance != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Conveyance',
                              textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.conveyance ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.medical != '0' &&
                        invoice.empsalReg!.medical != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child:
                              pw.Text('Medical', textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.medical ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.educationAllow != '0' &&
                        invoice.empsalReg!.educationAllow != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Edu. Allowance',
                              textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                              invoice.empsalReg!.educationAllow ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.lta != '0' &&
                        invoice.empsalReg!.lta != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('LTA', textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.lta ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.otherAllow != '0' &&
                        invoice.empsalReg!.otherAllow != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Other Allowance',
                              textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.otherAllow ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.arrears != '0' &&
                        invoice.empsalReg!.arrears != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child:
                              pw.Text('Arrears', textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.arrears ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.incent != '0' &&
                        invoice.empsalReg!.incent != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Incentive',
                              textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.incent ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.mobileAllow != '0' &&
                        invoice.empsalReg!.mobileAllow != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Mobile Allow',
                              textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.mobileAllow ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.monthlybonus != '0' &&
                        invoice.empsalReg!.monthlybonus != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Monthly Bonus	',
                              textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.monthlybonus ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                    if (invoice.empsalReg!.statbonus != 0 &&
                        invoice.empsalReg!.statbonus != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Stat Bonus ',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.normal)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                              invoice.empsalReg!.statbonus!.toString() ?? '',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.normal)),
                        ),
                      ]),
                    if (invoice.empsalReg!.revgross != '0' &&
                        invoice.empsalReg!.revgross != '')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Total Earnings ',
                              textAlign: pw.TextAlign.left,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.revgross ?? '',
                              textAlign: pw.TextAlign.left,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                      ]),
                  ])),
                  pw.SizedBox(width: 10),
                  pw.Expanded(
                    child: pw.Table(border: pw.TableBorder.all(), children: [
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Deduction',
                              textAlign: pw.TextAlign.left,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Deduction Amount',
                              textAlign: pw.TextAlign.left,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                      ]),
                      if (invoice.empsalReg!.pf12 != '0' &&
                          invoice.empsalReg!.pf12 != '')
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('P.F. @12%	',
                                textAlign: pw.TextAlign.left),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(invoice.empsalReg!.pf12 ?? '',
                                textAlign: pw.TextAlign.left),
                          ),
                        ]),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('ESIC @0.75%	',
                              textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.esic175 ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('PT', textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.ptax ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                      if (invoice.empsalReg!.retnamt != '0')
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('Retention',
                                textAlign: pw.TextAlign.left),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(invoice.empsalReg!.retnamt ?? '',
                                textAlign: pw.TextAlign.left),
                          ),
                        ]),
                      if (invoice.empsalReg!.otherDeduct != '0')
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('Other Deduction',
                                textAlign: pw.TextAlign.left),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(invoice.empsalReg!.retnamt ?? '',
                                textAlign: pw.TextAlign.left),
                          ),
                        ]),
                      if (invoice.empsalReg!.mlwf1 != '0')
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child:
                                pw.Text('MLWF', textAlign: pw.TextAlign.left),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(invoice.empsalReg!.mlwf1 ?? '',
                                textAlign: pw.TextAlign.left),
                          ),
                        ]),
                      // if (invoice.employee!.workingFor != 'Shaunak Med Tech LLP')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Total Deductions ',
                              textAlign: pw.TextAlign.left,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                              (int.parse(invoice.empsalReg!.totalDeduct!))
                                  .toString(),
                              textAlign: pw.TextAlign.left,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                      ]),
                    ]),
                  ),
                ],
              ),


              /*
              pw.Row(
                children: [
                  // pw.Expanded(
                  //     child: pw.Table(border: pw.TableBorder.all(), children: [
                  //       pw.TableRow(children: [
                  //         pw.Padding(
                  //           padding: const pw.EdgeInsets.all(5),
                  //           child: pw.Text('Earning',
                  //               textAlign: pw.TextAlign.left,
                  //               style:
                  //               pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  //         ),
                  //         pw.Padding(
                  //           padding: const pw.EdgeInsets.all(5),
                  //           child: pw.Text('Amount',
                  //               textAlign: pw.TextAlign.left,
                  //               style:
                  //               pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  //         ),
                  //       ]),
                  //       if (invoice.empsalReg!.basic != '0' &&
                  //           invoice.empsalReg!.basic != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('BASIC', textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.basic ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.hra != '0' &&
                  //           invoice.empsalReg!.hra != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('HRA', textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.hra ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.miscallow != '0' &&
                  //           invoice.empsalReg!.miscallow != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('Misc Allow	',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.miscallow ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.commallow != '0' &&
                  //           invoice.empsalReg!.commallow != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('Comm Allow',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.commallow ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.foodallow != '0' &&
                  //           invoice.empsalReg!.foodallow != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('Food Allow',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.foodallow ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.otamount != '0' &&
                  //           invoice.empsalReg!.otamount != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('OT Amount	',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.otamount ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.conveyance != '0' &&
                  //           invoice.empsalReg!.conveyance != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('Conveyance',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.conveyance ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.medical != '0' &&
                  //           invoice.empsalReg!.medical != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child:
                  //             pw.Text('Medical', textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.medical ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.educationAllow != '0' &&
                  //           invoice.empsalReg!.educationAllow != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('Education Allowance	',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(
                  //                 invoice.empsalReg!.educationAllow ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.lta != '0' &&
                  //           invoice.empsalReg!.lta != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('LTA', textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.lta ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.otherAllow != '0' &&
                  //           invoice.empsalReg!.otherAllow != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('Other Allowance',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.otherAllow ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.arrears != '0' &&
                  //           invoice.empsalReg!.arrears != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child:
                  //             pw.Text('Arrears', textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.arrears ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.incent != '0' &&
                  //           invoice.empsalReg!.incent != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('Incentive',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.incent ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.mobileAllow != '0' &&
                  //           invoice.empsalReg!.mobileAllow != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('Mobile Allow',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.mobileAllow ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.monthlybonus != '0' &&
                  //           invoice.empsalReg!.monthlybonus != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('Monthly Bonus	',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.monthlybonus ?? '',
                  //                 textAlign: pw.TextAlign.left),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.statbonus != 0 &&
                  //           invoice.empsalReg!.statbonus != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('Stat Bonus ',
                  //                 textAlign: pw.TextAlign.left,
                  //                 style: pw.TextStyle(
                  //                     fontWeight: pw.FontWeight.normal)),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(
                  //                 invoice.empsalReg!.statbonus!.toString() ?? '',
                  //                 textAlign: pw.TextAlign.left,
                  //                 style: pw.TextStyle(
                  //                     fontWeight: pw.FontWeight.normal)),
                  //           ),
                  //         ]),
                  //       if (invoice.empsalReg!.revgross != '0' &&
                  //           invoice.empsalReg!.revgross != '')
                  //         pw.TableRow(children: [
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text('Total Earnings ',
                  //                 textAlign: pw.TextAlign.left,
                  //                 style:
                  //                 pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  //           ),
                  //           pw.Padding(
                  //             padding: const pw.EdgeInsets.all(5),
                  //             child: pw.Text(invoice.empsalReg!.revgross ?? '',
                  //                 textAlign: pw.TextAlign.left,
                  //                 style:
                  //                 pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  //           ),
                  //         ]),
                  //     ])),
                  pw.SizedBox(width: 10),
                  pw.Expanded(
                    child: pw.Table(border: pw.TableBorder.all(), children: [
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Deduction',
                              textAlign: pw.TextAlign.left,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Deduction Amount',
                              textAlign: pw.TextAlign.left,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                      ]),
                      if (invoice.empsalReg!.pf12 != '0' &&
                          invoice.empsalReg!.pf12 != '')
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('P.F. @12%	',
                                textAlign: pw.TextAlign.left),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(invoice.empsalReg!.pf12 ?? '',
                                textAlign: pw.TextAlign.left),
                          ),
                        ]),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('ESIC @0.75%	',
                              textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.esic175 ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('PT', textAlign: pw.TextAlign.left),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(invoice.empsalReg!.ptax ?? '',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                      if (invoice.empsalReg!.retnamt != '0')
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('Retention',
                                textAlign: pw.TextAlign.left),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(invoice.empsalReg!.retnamt ?? '',
                                textAlign: pw.TextAlign.left),
                          ),
                        ]),
                      if (invoice.empsalReg!.otherDeduct != '0')
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text('Other Deduction',
                                textAlign: pw.TextAlign.left),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(invoice.empsalReg!.retnamt ?? '',
                                textAlign: pw.TextAlign.left),
                          ),
                        ]),
                      if (invoice.empsalReg!.mlwf1 != '0')
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child:
                                pw.Text('MLWF', textAlign: pw.TextAlign.left),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(invoice.empsalReg!.retnamt ?? '',
                                textAlign: pw.TextAlign.left),
                          ),
                        ]),
                      // if (invoice.employee!.workingFor != 'Shaunak Med Tech LLP')
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('Total Deductions ',
                              textAlign: pw.TextAlign.left,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                              (int.parse(invoice.empsalReg!.totalDeduct!))
                                  .toString(),
                              textAlign: pw.TextAlign.left,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        ),
                      ]),
                    ]),
                  ),
                ],
              ),
              */
              pw.SizedBox(height: 15),
              pw.Row(children: [
                pw.Text('Net Pay : Rs. ',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('${invoice.empsalReg!.netPay ?? '' + '/-'}',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(' /-',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Text('In Words : Rs. ',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('${invoice.empsalReg!.netpayinwords ?? ''}',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Text(
                    'This is a computer generated Payslip and does not require signature.',
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ]),
            ],
          );
        }));
// Page
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: themeColor,
      appBar: AppBar(
        // backgroundColor: themeColor,
        title: Text('Pay Slip Preview'),
      ),
      body: PdfPreview(
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,

        // actions: [IconButton(onPressed: (){}, icon: Icon(Icons.print))],
        build: (context) => makePdf(invoice),
      ),
    );
  }
}
