import 'package:flutter/material.dart';


class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = "card"; // Mode de paiement sélectionné

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Paiement sécurisé")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Choisissez un mode de paiement",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            // 🎯 Options de paiement
            _buildPaymentOptions(),

            SizedBox(height: 30),

            // 🔥 Bouton pour traiter le paiement
            ElevatedButton(
              onPressed: () {},
              //_processPayment,
              child: Text("Payer maintenant", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  /// 🎯 **Affichage des options de paiement**
  Widget _buildPaymentOptions() {
    return Column(
      children: [
        _buildRadioButton("Carte bancaire (Visa, MasterCard)", "card"),
        _buildRadioButton("Google Pay", "google_pay"),
        _buildRadioButton("Apple Pay", "apple_pay"),
        _buildRadioButton("Orange Money", "orange_money"),
        _buildRadioButton("M-Pesa", "m_pesa"),
        _buildRadioButton("Airtel Money", "airtel_money"),
      ],
    );
  }

  /// ✅ **Widget radio bouton pour le choix du mode de paiement**
  Widget _buildRadioButton(String title, String value) {
    return RadioListTile<String>(
      title: Text(title),
      value: value,
      groupValue: selectedPaymentMethod,
      onChanged: (String? newValue) {
        setState(() {
          selectedPaymentMethod = newValue!;
        });
      },
    );
  }

  // /// 💰 **Traitement du paiement**
  // void _processPayment() {
  //   switch (selectedPaymentMethod) {
  //     case "card":
  //       _payWithCard();
  //       break;
  //     case "google_pay":
  //       _payWithGooglePay();
  //       break;
  //     case "apple_pay":
  //       _payWithApplePay();
  //       break;
  //     case "orange_money":
  //       _payWithMobileMoney("orange_money");
  //       break;
  //     case "m_pesa":
  //       _payWithMobileMoney("m_pesa");
  //       break;
  //     case "airtel_money":
  //       _payWithMobileMoney("airtel_money");
  //       break;
  //   }
  // }

  // /// 💳 **Paiement par carte bancaire (via Stripe)**
  // void _payWithCard() async {
  //   try {
  //     // 🔹 Paramètres de paiement
  //     final paymentMethod = await Stripe.instance.createPaymentMethod(
  //       PaymentMethodParams.card(
  //         paymentMethodData: PaymentMethodData(),
  //       ),
  //     );

  //     print("Paiement réussi : ${paymentMethod.id}");
  //     _showSuccessMessage();
  //   } catch (e) {
  //     print("Erreur de paiement : $e");
  //     _showErrorMessage();
  //   }
  // }

  // /// 🏦 **Paiement via Google Pay**
  // void _payWithGooglePay() async {
  //   final googlePayConfig = PaymentConfiguration.fromJsonString('''
  //   {
  //     "provider": "google_pay",
  //     "data": {
  //       "environment": "TEST",
  //       "apiVersion": 2,
  //       "apiVersionMinor": 0,
  //       "allowedPaymentMethods": [
  //         {
  //           "type": "CARD",
  //           "parameters": {
  //             "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
  //             "allowedCardNetworks": ["VISA", "MASTERCARD"]
  //           },
  //           "tokenizationSpecification": {
  //             "type": "PAYMENT_GATEWAY",
  //             "parameters": {
  //               "gateway": "stripe",
  //               "stripe:version": "2020-08-27",
  //               "stripe:publishableKey": "your_stripe_publishable_key"
  //             }
  //           }
  //         }
  //       ]
  //     }
  //   }
  //   ''');

  //   final result = await Pay.withConfiguration(
  //     configuration: googlePayConfig,
  //     onPaymentResult: (result) {
  //       print("Paiement Google Pay réussi !");
  //       _showSuccessMessage();
  //     },
  //   );

  //   if (result == null) {
  //     _showErrorMessage();
  //   }
  // }

  // /// 🍏 **Paiement via Apple Pay**
  // void _payWithApplePay() async {
  //   try {
  //     final result = await ApplePayFlutter.showPaymentSelector(
  //       merchantIdentifier: "merchant.com.yourapp",
  //       countryCode: "US",
  //       currencyCode: "USD",
  //       supportedNetworks: ["visa", "mastercard"],
  //       paymentSummaryItems: [
  //         PaymentSummaryItem(label: "Total", amount: "20.00"),
  //       ],
  //     );

  //     if (result == "success") {
  //       print("Paiement Apple Pay réussi !");
  //       _showSuccessMessage();
  //     } else {
  //       _showErrorMessage();
  //     }
  //   } catch (e) {
  //     print("Erreur Apple Pay : $e");
  //     _showErrorMessage();
  //   }
  // }

  // /// 📲 **Paiement via Mobile Money (Flutterwave)**
  // void _payWithMobileMoney(String network) async {
  //   try {
  //     final Flutterwave flutterwave = Flutterwave(
  //       context: context,
  //       publicKey: "FLWPUBK-xxxxxxxxxxxxxxxxxxxxxxxx-X",
  //       currency: "XAF",
  //       amount: "20.00",
  //       customer: Customer(
  //         name: "John Doe",
  //         phoneNumber: "123456789",
  //         email: "johndoe@example.com",
  //       ),
  //       transactionRef: "TX-${DateTime.now().millisecondsSinceEpoch}",
  //       paymentOptions: network,
  //       customization: Customization(title: "Paiement Mobile Money"),
  //       isTestMode: true, // ⚠️ Mettre à false en production
  //     );

  //     final ChargeResponse response = await flutterwave.charge();

  //     if (response.success!) {
  //       print("Paiement Mobile Money réussi !");
  //       _showSuccessMessage();
  //     } else {
  //       _showErrorMessage();
  //     }
  //   } catch (e) {
  //     print("Erreur Mobile Money : $e");
  //     _showErrorMessage();
  //   }
  // }

  // /// ✅ **Message de succès**
  // void _showSuccessMessage() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text("Paiement réussi ✅")),
  //   );
  // }

  // /// ❌ **Message d'erreur**
  // void _showErrorMessage() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text("Échec du paiement ❌")),
  //   );
  // }
}
