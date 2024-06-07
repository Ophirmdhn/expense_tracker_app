import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController(); // object untuk menangani user input
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async { // function Future adalah object yang membungkus nilai yang belum ada tetapi akan dimiliki/ada
    final now = DateTime.now();
    final firstDate = DateTime(now.year -1, now.month, now.day);

    final pickedDate = await showDatePicker( // baris di bawahnya hanya akan di eksekusi ketika nilai variable await tersedia
      context: context, 
      initialDate: now,
      firstDate: firstDate, // batas tanggal awal/paling lama
      lastDate: now // batas akhir tanggal 
    );

    // di eksekusi ketika nilai variable await sudah tersedia / ada
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() { // validasi input
    // parsing data textField amound ke double
    final enteredAmount = double.tryParse(_amountController.text); // tryParse("1.23") => 1.23, tryParse(hello) => null;

    // validasi textField amound
    final amoundIsInvalid = enteredAmount == null || enteredAmount <= 0;
    
    if (_titleController.text.trim().isEmpty || amoundIsInvalid || _selectedDate == null) {
      showDialog(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("bae bae kasi masuk datamu"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text("Omke!")
            )
          ],
        )
      );
      return; // hanya menampilkan pesan tidak ada yang lain
    }
  }

  @override
  void dispose() { // untuk menghapus controller dari memori ketika widget sudah tidak tampil/digunakan
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title')
            ),
          ),
          Row(  
            children: [
              Expanded( // untuk mengambil ruang sesuai dengan ukuran layar
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  maxLength: 50,
                  decoration: const InputDecoration(
                      prefixText: "\$ ",
                      label: Text('Amount')
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                      ? "No Date Selected"
                      : formatter.format(_selectedDate!)
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month)
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory, // yang akan tampil di layar
                items: Category.values.map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase())
                  )
                ).toList(), 
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text("Save Expense")
              )
            ],
          )
        ],
      ),
    );
  }
}