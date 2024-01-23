import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScreenHome(),
    );
  }
}

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  String paymentOption = 'Cash';

  List<Map<String, String>> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        shrinkWrap: true,
        children: [
          const SizedBox(height: 32),
          // Field for the name of the user
          nameField(),
          const SizedBox(height: 16),
          // All the elemnts from products list
          ...itemsList(),
          // Add a new item to products
          addItem(),
          const SizedBox(height: 16),
          // Tax for the Invoice
          taxField(),
          const SizedBox(height: 16),
          // Discount for the Invoice
          discountField(),
          const SizedBox(height: 16),
          // Payment option of the invoice
          choosePayment(),
          const SizedBox(height: 16),
          // Calculation button
          calculateButon(context)
        ],
      ),
    );
  }

  TextField nameField() {
    return TextField(
      controller: nameController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'Name',
      ),
    );
  }

  TextField discountField() {
    return TextField(
      controller: discountController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'Discount %',
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
    );
  }

  TextField taxField() {
    return TextField(
      controller: taxController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: 'Tax %',
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
    );
  }

  Container addItem() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Text(
            "Items",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: itemNameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: "Name"),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: itemQuantityController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: 'Quantity',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: itemPriceController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: "Price",
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                // Validating for empty fields
                if (itemNameController.text.trim().isEmpty) {
                  showSnackbar("Item name can't be empty");
                  return;
                } else if (itemQuantityController.text.trim().isEmpty) {
                  showSnackbar("Quantity can't be empty");
                  return;
                } else if (itemPriceController.text.trim().isEmpty) {
                  showSnackbar("Price can't be empty");
                  return;
                }
                products.add({
                  "name": itemNameController.text.trim(),
                  "quantity": itemQuantityController.text.trim(),
                  "price": itemPriceController.text.trim(),
                });
                itemNameController.clear();
                itemQuantityController.clear();
                itemPriceController.clear();
                setState(() {});
              },
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Wrap choosePayment() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              paymentOption = "Cash";
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
              color: paymentOption == "Cash" ? Colors.blue : Colors.white,
            ),
            child: Text(
              "Cash",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: paymentOption == "Cash" ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              paymentOption = "Debit Card";
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
              color: paymentOption == "Debit Card" ? Colors.blue : Colors.white,
            ),
            child: Text(
              "Debit Card",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color:
                    paymentOption == "Debit Card" ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              paymentOption = "Credit Card";
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
              color:
                  paymentOption == "Credit Card" ? Colors.blue : Colors.white,
            ),
            child: Text(
              "Credit Card",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: paymentOption == "Credit Card"
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  SizedBox calculateButon(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.blue,
        ),
        onPressed: () {
          // Validating for empty fields
          if (nameController.text.isEmpty) {
            showSnackbar("Name can't be empty");
            return;
          } else if (products.isEmpty) {
            showSnackbar("Products can't be empty");
            return;
          } else if (taxController.text.trim().isEmpty) {
            showSnackbar("Tax can't be empty");
            return;
          } else if (discountController.text.trim().isEmpty) {
            showSnackbar("Discount can't be empty");
            return;
          }
          // Caculation
          // Total price of all the items are taken and tax is calculated with the total price + calculation we calculate discount finally we calculate the surcharges
          double totalPrice = 0;
          double surCharges = 0;
          double taxAmount = 0;
          double discountAmount = 0;
          for (var element in products) {
            totalPrice += int.parse(element['quantity'] ?? '1') *
                int.parse(element['price'] ?? '0');
          }
          taxAmount = totalPrice * double.parse(taxController.text) / 100;
          discountAmount = (totalPrice + taxAmount) *
              double.parse(discountController.text) /
              100;
          if (paymentOption == "Credit Card") {
            surCharges = (totalPrice + taxAmount - discountAmount) * 1.2 / 100;
          }

          // Display the invoice
          showInvoice(
              context, taxAmount, discountAmount, surCharges, totalPrice);
        },
        child: const Text(
          "Calculate",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  List<Widget> itemsList() {
    return List.generate(
      products.length,
      (index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Text(
              products[index]['name'] ?? "",
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              products[index]['quantity'] ?? "",
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const Text(" X "),
            Text(
              products[index]['price'] ?? "",
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const Text(" = "),
            Text(
              (double.parse(products[index]['price'] ?? "0") *
                      double.parse(products[index]['quantity'] ?? '0'))
                  .toString(),
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            IconButton(
                onPressed: () {
                  products.removeAt(index);
                  setState(() {});
                },
                icon: const Icon(Icons.remove_circle, color: Colors.red)),
          ],
        ),
      ),
    );
  }

  showSnackbar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<dynamic> showInvoice(BuildContext context, double taxAmount,
      double discountAmount, double surCharges, double totalPrice) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text("Invoice for ${nameController.text}"),
        scrollable: true,
        content: Column(
          children: [
            // Products
            ...List.generate(
              products.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                      products[index]['name'] ?? "",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      products[index]['quantity'] ?? "",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    const Text(" X "),
                    Text(
                      products[index]['price'] ?? "",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    const Text(" = "),
                    Text(
                      "\$${(double.parse(products[index]['price'] ?? "0") * double.parse(products[index]['quantity'] ?? '0')).toStringAsFixed(2)}",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Row(
                children: [
                  const Text(
                    "Tax",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "\$${taxAmount.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  const Text(
                    "Discount",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "\$${discountAmount.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            if (surCharges != 0.0)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Text(
                      "Sur Charges",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "\$${surCharges.toStringAsFixed(2)}",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Row(
                children: [
                  const Text(
                    "Sub Total",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "\$${(totalPrice + taxAmount - discountAmount + surCharges).toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: Colors.grey),
                    child: const Text(
                      "Close",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Clearing all the fields
                    nameController.clear();
                    products = [];
                    paymentOption = 'Cash';
                    itemNameController.clear();
                    itemPriceController.clear();
                    itemQuantityController.clear();
                    taxController.clear();
                    discountController.clear();
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
