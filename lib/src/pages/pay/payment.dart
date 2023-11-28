import 'package:fire_base_evento/src/providers/pay_provide.dart';
import 'package:fire_base_evento/src/services/eventoservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';

class Payment extends StatelessWidget {
  Payment({super.key});
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final payProvider = context.watch<PayProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.pink,
              Colors.purple,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              CreditCardWidget(
                glassmorphismConfig:
                    useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                bankName: 'BNB',
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: Colors.green,
                backgroundImage:
                    useBackgroundImage ? 'images/card_bg.png' : null,
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                    cardType: CardType.mastercard,
                    cardImage: Image.asset(
                      'images/mastercard.png',
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Número de Tarjeta',
                            prefixIcon: Icon(Icons.credit_card),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16.0),

                        // Fecha de Vencimiento
                        TextField(
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            labelText: 'Fecha de Vencimiento',
                            prefixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16.0),

                        // CVV
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'CVV',
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            child: const Text(
                              'Pagar',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          onPressed: () async {
                            EventoService eventoService = EventoService();
                            await eventoService.setVenta(
                                payProvider.fotos, payProvider.uidEvento);
                            payProvider.vaciarPhotos();
                            payProvider.setUidEvento('');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // devuelve el widget del diálogo
                                return AlertDialog(
                                  title: const Text('Success'),
                                  content: const Text(
                                      'Su compra se realizó con exito'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        'profile',
                                      ),
                                      child: const Text('Aceptar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    cardNumber = creditCardModel!.cardNumber;
    expiryDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
    // setState(() {
    //   cardNumber = creditCardModel!.cardNumber;
    //   expiryDate = creditCardModel.expiryDate;
    //   cardHolderName = creditCardModel.cardHolderName;
    //   cvvCode = creditCardModel.cvvCode;
    //   isCvvFocused = creditCardModel.isCvvFocused;
    // });
  }
}
