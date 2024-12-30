import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solutech/utils/app_colors.dart';

enum FieldType {
  text,
  password,
  date,
  time,
  dropdown,
  searchableDropdown,
  description
}

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double height;
  final bool isPassword;
  final FieldType fieldType;
  final List<String>? dropdownItems;
  final Function(String)? onDropdownChanged;

  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    this.height = 60,
    this.isPassword = false,
    this.fieldType = FieldType.text,
    this.dropdownItems,
    this.onDropdownChanged,
  });

  @override
  _AuthFieldState createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool _isObscured = true; // For password visibility
  String? selectedValue; // For dropdown menus

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.fieldType == FieldType.dropdown ||
              widget.fieldType == FieldType.searchableDropdown
          ? widget.height + 20 // Adjust height for dropdown
          : widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: _buildField(),
    );
  }

  Widget _buildField() {
    switch (widget.fieldType) {
      case FieldType.text:
      case FieldType.password:
        return TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _isObscured : false,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: AppColors.purple400,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: AppColors.purple400,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 10,
            ),
            hintText: widget.hintText,
            hintStyle: GoogleFonts.poppins(
              color: AppColors.grey600,
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.grey600,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  )
                : null,
          ),
        );

      case FieldType.date:
        return _buildDatePicker();

      case FieldType.time:
        return _buildTimePicker();

      case FieldType.description:
        return _buildDescriptionField();

      case FieldType.dropdown:
      case FieldType.searchableDropdown:
        return _buildDropdown();

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: widget.controller,
      maxLines: null, // Allows unlimited lines
      expands: true, // Makes the text field expand within the container
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: AppColors.purple400,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: AppColors.purple400,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(
          color: AppColors.grey600,
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          widget.controller.text = pickedDate.toString().split(' ')[0];
        }
      },
      child: _readOnlyTextField(Icons.calendar_today),
    );
  }

  Widget _buildTimePicker() {
    return InkWell(
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          widget.controller.text = pickedTime.format(context);
        }
      },
      child: _readOnlyTextField(Icons.access_time),
    );
  }

  Widget _readOnlyTextField(IconData icon) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: AppColors.purple400,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: AppColors.purple400,
            width: 2,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(
          color: AppColors.grey600,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
        suffixIcon: Icon(
          icon,
          color: AppColors.grey600,
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: widget.dropdownItems
          ?.map((item) => DropdownMenuItem(
                value: item,
                child: Text(item, maxLines: 2, overflow: TextOverflow.ellipsis),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
        if (widget.onDropdownChanged != null) {
          widget.onDropdownChanged!(value!);
        }
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: AppColors.purple400,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: AppColors.purple400,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 10,
        ),
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(
          color: AppColors.grey600,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
    );
  }
}
