import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class KhaltiPaymentPage extends StatefulWidget {
  const KhaltiPaymentPage({Key? key}) : super(key: key);

  @override
  State<KhaltiPaymentPage> createState() => _KhaltiPaymentPageState();
}

class _KhaltiPaymentPageState extends State<KhaltiPaymentPage> {
  TextEditingController amountController = TextEditingController();

  getAmt() {
    return int.parse(amountController.text) * 100;
  }

  double _amount = 0;

  late ESewaPnp _eSewaPnp;
  late ESewaConfiguration _configuration;

  @override
  void initState() {
    _configuration = ESewaConfiguration(
        clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
        secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
        environment: ESewaConfiguration.ENVIRONMENT_TEST);
    _eSewaPnp = ESewaPnp(configuration: _configuration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Khalti and Esewa Integration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              onChanged: ((value) {
                setState(() {
                  _amount = double.parse(value);
                });
              }),
              decoration: const InputDecoration(
                  labelText: "Enter Amount to pay",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF56328c),
                ),
                onPressed: () {
                  KhaltiScope.of(context).pay(
                      config: PaymentConfig(
                          amount: getAmt(),
                          productIdentity: 'dells-sssssg5-g5510-2021',
                          productName: 'Product Name'),
                      preferences: [PaymentPreference.khalti],
                      onSuccess: (su) {
                        const sucesssnackBar =
                            SnackBar(content: Text("Payment Sucessfull"));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(sucesssnackBar);
                      },
                      onFailure: (fa) {
                        const failedSnackBar = SnackBar(
                          content: Text("Payment failed"),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(failedSnackBar);
                      },
                      onCancel: () {
                        const cancelSnackBar =
                            SnackBar(content: Text("Payment Cancelled"));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(cancelSnackBar);
                      });
                },
                child: const Text(
                  "Pay With Khalti",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                )),
            const SizedBox(
              height: 20,
            ),
            ESewaPaymentButton(_eSewaPnp,
                width: double.infinity,
                // height: 100,
                amount: _amount,
                productId: "Dipika 123",
                productName: "Flutter Esewa",
                callBackURL: "https://example.com", onSuccess: (result) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result.message.toString())),
              );
            }, onFailure: (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.message.toString())));
            })
          ],
        ),
      ),
    );
  }

  Widget _buildSnackBar(Color color, String msg) {
    return SnackBar(
      backgroundColor: color,
      content: Text(msg),
    );
  }
}
