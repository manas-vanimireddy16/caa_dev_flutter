import 'package:flutter/material.dart';

class AllowanceRequestForm extends StatefulWidget {
  final void Function(Map<String, dynamic> values) onSubmit;

  const AllowanceRequestForm({super.key, required this.onSubmit});

  @override
  State<AllowanceRequestForm> createState() => _AllowanceRequestFormState();
}

class _AllowanceRequestFormState extends State<AllowanceRequestForm> {
  final _formKey = GlobalKey<FormState>();

  String? allowanceType;
  String? currency;
  final amountCtrl = TextEditingController();
  final contactCtrl = TextEditingController();
  final commentCtrl = TextEditingController();

  @override
  void dispose() {
    amountCtrl.dispose();
    contactCtrl.dispose();
    commentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Allowance Request',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.close),
                ],
              ),

              const SizedBox(height: 6),
              const Text(
                'Provide details about your New Request',
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: allowanceType,
                decoration: const InputDecoration(
                  labelText: 'Allowance Type *',
                ),
                items: const [
                  DropdownMenuItem(value: 'Food', child: Text('Food')),
                  DropdownMenuItem(value: 'Travel', child: Text('Travel')),
                ],
                onChanged: (v) => setState(() => allowanceType = v),
                validator: (v) => v == null ? 'Required' : null,
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: currency,
                decoration: const InputDecoration(labelText: 'Currency Type *'),
                items: const [
                  DropdownMenuItem(value: 'OMR', child: Text('OMR')),
                  DropdownMenuItem(value: 'USD', child: Text('USD')),
                ],
                onChanged: (v) => setState(() => currency = v),
                validator: (v) => v == null ? 'Required' : null,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: amountCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Allowance Amount *',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: contactCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Contact Number *',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: commentCtrl,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Comments'),
              ),

              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.send),
                  label: const Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSubmit({
                        'allowanceType': allowanceType,
                        'currency': currency,
                        'amount': double.parse(amountCtrl.text),
                        'contact': contactCtrl.text,
                        'comments': commentCtrl.text,
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
