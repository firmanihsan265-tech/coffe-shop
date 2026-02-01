// pages/address_management_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../models/address.dart';

class AddressManagementPage extends StatefulWidget {
  @override
  _AddressManagementPageState createState() => _AddressManagementPageState();
}

class _AddressManagementPageState extends State<AddressManagementPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isDefault = false;
  bool _isEditing = false;
  String? _editingAddressId;

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _streetController.clear();
    _cityController.clear();
    _postalCodeController.clear();
    _phoneController.clear();
    _isDefault = false;
    _isEditing = false;
    _editingAddressId = null;
  }

  void _editAddress(Address address) {
    setState(() {
      _isEditing = true;
      _editingAddressId = address.id;
      _nameController.text = address.name;
      _streetController.text = address.street;
      _cityController.text = address.city;
      _postalCodeController.text = address.postalCode;
      _phoneController.text = address.phone;
      _isDefault = address.isDefault;
    });
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final appState = Provider.of<AppState>(context, listen: false);
      
      final address = Address(
        id: _isEditing ? _editingAddressId! : DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        street: _streetController.text.trim(),
        city: _cityController.text.trim(),
        postalCode: _postalCodeController.text.trim(),
        phone: _phoneController.text.trim(),
        isDefault: _isDefault,
      );

      if (_isEditing) {
        appState.updateAddress(_editingAddressId!, address);
      } else {
        appState.addAddress(address);
      }

      _resetForm();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isEditing ? 'Alamat berhasil diperbarui' : 'Alamat berhasil ditambahkan'),
          backgroundColor: Color(0xFFC67C4E),
        ),
      );
    }
  }

  void _deleteAddress(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Alamat'),
        content: Text('Apakah Anda yakin ingin menghapus alamat ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              final appState = Provider.of<AppState>(context, listen: false);
              appState.removeAddress(id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Alamat berhasil dihapus'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final addresses = appState.addresses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola Alamat'),
        backgroundColor: Color(0xFFC67C4E),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Form Tambah/Edit Alamat
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isEditing ? 'Edit Alamat' : 'Tambah Alamat Baru',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Nama Penerima',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan nama penerima';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _streetController,
                          decoration: InputDecoration(
                            labelText: 'Alamat Lengkap',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan alamat lengkap';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            labelText: 'Kota',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan kota';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _postalCodeController,
                          decoration: InputDecoration(
                            labelText: 'Kode Pos',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan kode pos';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Nomor Telepon',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan nomor telepon';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Checkbox(
                              value: _isDefault,
                              onChanged: (value) {
                                setState(() {
                                  _isDefault = value ?? false;
                                });
                              },
                            ),
                            Text('Jadikan alamat utama'),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _saveAddress,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFC67C4E),
                                ),
                                child: Text(_isEditing ? 'Update Alamat' : 'Simpan Alamat'),
                              ),
                            ),
                            if (_isEditing) ...[
                              SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: _resetForm,
                                  child: Text('Batal'),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Daftar Alamat
              Expanded(
                child: addresses.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_off, size: 80, color: Colors.grey[400]),
                            SizedBox(height: 16),
                            Text(
                              'Belum ada alamat',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Tambahkan alamat untuk pengiriman',
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: addresses.length,
                        itemBuilder: (context, index) {
                          final address = addresses[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: Icon(
                                Icons.location_on,
                                color: Color(0xFFC67C4E),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        address.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (address.isDefault) ...[
                                        SizedBox(width: 8),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFC67C4E),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            'UTAMA',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    address.fullAddress,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Telp: ${address.phone}',
                                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, size: 20),
                                    onPressed: () => _editAddress(address),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, size: 20, color: Colors.red),
                                    onPressed: () => _deleteAddress(address.id),
                                  ),
                                ],
                              ),
                            ),
                          );
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