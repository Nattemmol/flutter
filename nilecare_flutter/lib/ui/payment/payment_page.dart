import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/chapa_service.dart';
import '../../services/verifychapa_service.dart';

class PaymentPage extends StatefulWidget {
  final String amount;
  final String currency;
  final String email;
  final String firstName;
  final String lastName;
  final String txRef;
  final String? callbackUrl;
  final String? returnUrl;

  const PaymentPage({
    Key? key,
    required this.amount,
    required this.currency,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.txRef,
    this.callbackUrl,
    this.returnUrl,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isLoading = false;
  String? _checkoutUrl;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializePayment();
  }

  Future<void> _initializePayment() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final chapaService = Provider.of<ChapaService>(context, listen: false);
      final result = await chapaService.initializePayment(
        amount: widget.amount,
        currency: widget.currency,
        email: widget.email,
        firstName: widget.firstName,
        lastName: widget.lastName,
        txRef: widget.txRef,
        callbackUrl: widget.callbackUrl,
        returnUrl: widget.returnUrl,
      );

      setState(() {
        _checkoutUrl = result['checkoutUrl'];
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _verifyPayment() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final verifyChapaService =
          Provider.of<VerifyChapaService>(context, listen: false);
      final result = await verifyChapaService.verifyPaymentStatus(widget.txRef);

      if (result['status'] == 'success') {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment successful!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        }
      } else {
        setState(() {
          _error = 'Payment verification failed';
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _initializePayment,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _checkoutUrl != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Payment Initialized',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Launch the checkout URL in a browser
                              // You'll need to implement this based on your needs
                            },
                            child: const Text('Proceed to Payment'),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _verifyPayment,
                            child: const Text('Verify Payment'),
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: Text('Failed to initialize payment'),
                    ),
    );
  }
}
