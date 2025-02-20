import 'package:flutter/material.dart';

class AdidasOrderPacking extends StatefulWidget {
  final String? imgpath;
  final String? itemName;
  final double? price;
  final int? quantity;

  const AdidasOrderPacking({
    Key? key,
    required BuildContext context,
    this.imgpath,
    this.itemName,
    this.price,
    this.quantity,
  }) : super(key: key);

  @override
  _AdidasOrderPackingState createState() => _AdidasOrderPackingState();
}

class _AdidasOrderPackingState extends State<AdidasOrderPacking>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _currentStep = 0;
  final TextStyle _medium = const TextStyle(
    color: Colors.black,
    fontSize: 20,
  );
  final String dateString = DateTime.now().toString().substring(0, 10);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ORDER DETAILS',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderStatus(context),
              const SizedBox(height: 16),
              _buildOrderStepper(context),
              const SizedBox(height: 16),
              _buildOrderItem(context),
              const SizedBox(height: 16),
              _buildOrderDetails(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderStatus(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'WE\'RE PACKING\nYOUR ORDER',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStepper(BuildContext context) {
    return Stepper(
      currentStep: _currentStep,
      onStepTapped: (step) => setState(() => _currentStep = step),
      onStepContinue: _currentStep < 2
          ? () => setState(() => _currentStep += 1)
          : null,
      onStepCancel: _currentStep > 0
          ? () => setState(() => _currentStep -= 1)
          : null,
      steps: [
        Step(
          title: Text('PACKING YOUR ORDER'),
          content: Text('We are currently packing your order.'),
          isActive: _currentStep >= 0,
          state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: Text('ON ITS WAY'),
          content: Text('We\'ll show your tracking link here when it\'s shipped.'),
          isActive: _currentStep >= 1,
          state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: Text('EXPECTED DELIVERY'),
          content: Text('WED, JANUARY 17'),
          isActive: _currentStep >= 2,
          state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
        ),
      ],
    );
  }

  Widget _buildOrderItem(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1 item',
              style: _medium.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  widget.imgpath.toString(),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.itemName.toString(),
                        style: _medium.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Quantity ${widget.quantity.toString()}",
                        style: _medium.copyWith(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '\$${widget.price.toString()}',
                            style: _medium.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '-10%',
                              style: _medium.copyWith(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ORDER DETAILS',
              style: _medium.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(context, 'Order Number', 'ASG07328257'),
            const SizedBox(height: 16),
            _buildDetailRow(context, 'Order Date', dateString),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: _medium.copyWith(color: Colors.grey[600]),
        ),
        Text(
          value,
          style: _medium.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}