import 'package:flutter/material.dart';

class AdidasOrderPacking extends StatefulWidget {
  String? imgpath;
  String?itemName;
  double? price;
  int? quantity;
   AdidasOrderPacking({super.key, required BuildContext context,this.imgpath,this.itemName,this.price,this.quantity});

  @override
  _AdidasOrderPackingState createState() => _AdidasOrderPackingState();
}

class _AdidasOrderPackingState extends State<AdidasOrderPacking>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int? _selectedTimelineIndex;
  TextStyle _medium = const TextStyle(
    color: Colors.black,
    fontSize: 20,
  );
String dateString = DateTime.now().toString().substring(0,10);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('ORDER DETAILS',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderStatus(context),
            _buildOrderTimeline(context),
            _buildOrderItem(context),
            _buildOrderDetails(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatus(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WE\'RE PACKING\nYOUR ORDER',
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTimeline(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildTimelineItem(
            context,
            icon: Icons.inventory_2_outlined,
            title: 'PACKING YOUR ORDER',
            isActive: true,
            index: 0,
          ),
          _buildTimelineItem(
            context,
            icon: Icons.local_shipping_outlined,
            title: 'ON ITS WAY',
            subtitle: 'We\'ll show your tracking link here when it\'s shipped.',
            index: 1,
          ),
          _buildTimelineItem(
            context,
            icon: Icons.calendar_today_outlined,
            title: 'EXPECTED DELIVERY',
            subtitle: 'WED, JANUARY 17',
            isLast: true,
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    bool isActive = false,
    bool isLast = false,
    required int index,
  }) {
    final bool isSelected = _selectedTimelineIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedTimelineIndex == index) {
            _selectedTimelineIndex = null;
            _animationController.reverse();
          } else {
            _selectedTimelineIndex = index;
            _animationController.forward();
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive || isSelected
                          ? Color.lerp(Colors.black, Colors.blue,
                              _animationController.value)!
                          : Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: isActive || isSelected
                        ? Color.lerp(Colors.black, Colors.blue,
                            _animationController.value)
                        : Colors.grey[400],
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: _medium,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: _medium,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1 item',
            style: _medium,
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
                      style: _medium,
                    ),
                    const SizedBox(height: 4),
                    Text(
    "Quantity ${widget.quantity.toString()}",
                      style: _medium,
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
                          style: _medium,
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
                            style: _medium,
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
    );
  }

  Widget _buildOrderDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ORDER DETAILS',
            style: _medium,
          ),
          const SizedBox(height: 16),
          _buildDetailRow(context, 'Order Number', 'ASG07328257'),
          const SizedBox(height: 16),
          _buildDetailRow(context, 'Order Date',dateString),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: _medium,
        ),
        Text(
          value,
          style: _medium,
        ),
      ],
    );
  }
}
