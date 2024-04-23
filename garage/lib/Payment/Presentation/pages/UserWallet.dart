import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:garage/Payment/Presentation/bloc/payment_bloc.dart';
import 'package:garage/auth/bloc/auth_bloc.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/core/Validations/Butoonvalidator.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_to_act/slide_to_act.dart';

class UserWallet extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<SlideActionState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Kcolor.bg,
      child: LiquidPullToRefresh(
        height: 200,
        color: Kcolor.primary,
        backgroundColor: Kcolor.bg,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 400,
        onRefresh: () async {
          final paymentBloc = context.read<PaymentBloc>();
          paymentBloc.add(UserFetchBalance());
        },
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(280),
              child: AppBar(
                leading: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Kcolor.bg)),
                surfaceTintColor: Kcolor.primary,
                centerTitle: true,
                leadingWidth: 100,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(10, 20),
                  ),
                ),
                title: Text(
                  "Wallet",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: fontstyles.Head,
                    fontSize: 40,
                    color: Kcolor.bg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Kcolor.primary,
                flexibleSpace: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          "Empower Your Transactions with Digital Wallets !",
                          style: TextStyle(
                            fontFamily: fontstyles.Head,
                            fontSize: 15,
                            color: Kcolor.bg,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 5),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.22,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Kcolor.bg,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Account Balance',
                                    style: TextStyle(
                                      fontFamily: fontstyles.Gpop,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text(
                                    'Your current account balance :               ',
                                    style: TextStyle(
                                      fontFamily: fontstyles.Gpop,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  BlocBuilder<PaymentBloc, PaymentState>(
                                    builder: (context, state) {
                                      if (state is BalanceLoaded) {
                                        CurrentBalence = state.amount;
                                        return Row(
                                          children: [
                                            SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: Lottie.asset(
                                                'assets/images/Animation/Paisa.json',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              '${state.amount}',
                                              style: const TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return const Text(
                                          'Loading...',
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        );
                                      }
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
              ),
            ),
            backgroundColor: Kcolor.primary,
            body: BlocListener<PaymentBloc, PaymentState>(
              listener: (context, state) {
                if (state is PaymentLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const AlertDialog(
                      content: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
                if (state is PaymentSuccess) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => PaymentSuccessDialog(),
                  );
                  _amountController.clear();
                }
                if (state is PaymentFailure) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => PaymentFailureDialog());

                  _amountController.clear();
                }
              },
              child: Container(
                padding: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height * 0.65,
                alignment: Alignment.topCenter,
                color: Kcolor.primary,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Kcolor.bg,
                  ),
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(
                                    Icons.attach_money,
                                    size: 25,
                                    weight: 50,
                                    color: Kcolor.primary,
                                  ), // Icon on the left side
                                ),
                                TextSpan(
                                  text:
                                      ' Recharge Your Wallet ', // Text next to the icon
                                  style: TextStyle(
                                    color: Kcolor.TextB,
                                    fontFamily: fontstyles.Gpop,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Card(
                            shadowColor: Kcolor.secondary,
                            elevation: 5,
                            surfaceTintColor: Kcolor.bg,
                            color: Kcolor.bg,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    controller: _amountController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Enter Amount',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an amount';
                                      }
                                      final amount = int.tryParse(value);
                                      if (amount == null || amount <= 200) {
                                        return 'Amount must be greater than 200';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  SlideAction(
                                      sliderRotate: false,
                                      borderRadius: 8,
                                      innerColor: Kcolor.Fbutton,
                                      outerColor: Kcolor.C_Under_4,
                                      sliderButtonIcon: const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.white,
                                      ),
                                      textColor: Kcolor.TextB,
                                      text: "Recharge",
                                      onSubmit: () => safeOnPressed(
                                            context,
                                            () {
                                              FocusScope.of(context).unfocus();
                                              final amount = int.tryParse(
                                                _amountController.text.trim(),
                                              );

                                              final currentammount =
                                                  amount ?? 0;
                                              final Finalammount =
                                                  CurrentBalence +
                                                      currentammount;
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context.read<PaymentBloc>().add(
                                                    PaymentRequested(
                                                        Finalammount));
                                              }
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 100), () {
                                                _key.currentState!.reset();
                                              });
                                            },
                                          )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class PaymentSuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Kcolor.bg,
      surfaceTintColor: Kcolor.bg,
      elevation: 20,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/images/Animation/paymentDone.json',
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          const Text('Payment Successful!'),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Kcolor.Fbutton,
            shadowColor: Kcolor.button,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
          child: Text(
            'Ok',
            style: TextStyle(fontFamily: fontstyles.Gpop, color: Kcolor.bg),
          ),
        )
      ],
    );
  }
}

class PaymentFailureDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 20,
      backgroundColor: Kcolor.bg,
      surfaceTintColor: Kcolor.bg,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/images/Animation/PaymetFaild.json',
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          const Text('Payment Failed!'),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Kcolor.Fbutton,
            shadowColor: Kcolor.button,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
          child: Text(
            'Ok',
            style: TextStyle(fontFamily: fontstyles.Gpop, color: Kcolor.bg),
          ),
        )
      ],
    );
  }
}
