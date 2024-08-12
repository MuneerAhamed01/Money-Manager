import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/screens/create_transaction/models/category_and_date_model.dart';
import 'package:money_manager/utils/categories.dart';
import 'package:money_manager/utils/snackbar.dart';
import 'package:money_manager/widgets/button.dart';

class CategoryWidgetBottomSheet extends StatefulWidget {
  const CategoryWidgetBottomSheet({
    super.key,
    this.iniitalTime,
    this.intialCategory,
  });

  final DateTime? iniitalTime;

  final String? intialCategory;

  @override
  State<CategoryWidgetBottomSheet> createState() =>
      _CategoryWidgetBottomSheetState();
}

class _CategoryWidgetBottomSheetState extends State<CategoryWidgetBottomSheet> {
  String _tag = '';

  DateTime _date = DateTime.now();

  @override
  void initState() {
    _tag = widget.intialCategory ?? '';

    _date = widget.iniitalTime ?? DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: Get.width,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose category :',
            style: Get.textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          ChipsChoice<String>.single(
            value: _tag,
            padding: EdgeInsets.zero,
            wrapped: true,
            onChanged: (val) {},
            choiceBuilder: (choice, value) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _tag = choice.label;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: _tag != choice.label
                        ? Colors.black.withOpacity(0.6)
                        : Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    choice.label,
                    style: Get.textTheme.labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              );
            },
            choiceItems: C2Choice.listFrom<String, String>(
              source: categories,
              value: (i, v) => v,
              label: (i, v) => v,
            ),
          ),
          const SizedBox(height: 20),
          Text('Selectd Date:', style: Get.textTheme.labelMedium),
          const SizedBox(height: 10),
          InkWell(
            onTap: _onDatePicker,
            child: Row(
              children: [
                const Icon(Icons.date_range),
                const SizedBox(width: 10),
                Text(DateFormat('dd-MM-yyyy').format(_date))
              ],
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 48,
            child: AppButton(
              label: 'Continue',
              style: AppButtonStyle.outlined,
              onTap: _onPressContinue,
            ),
          ),
        ],
      ),
    );
  }

  _onPressContinue() {
    if (_tag.isEmpty) {
      showSnackBar('Category is required');
    } else {
      Get.back<CategoryAndDateModel>(
        result: CategoryAndDateModel(date: _date, category: _tag),
      );
    }
  }

  Future<void> _onDatePicker() async {
    final date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        builder: (ctx, child) {
          return Theme(
            data: Get.theme.copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.black, // Header background color
                onPrimary: Colors.white, // Header text color
                onSurface: Colors.black, // Body text color
                secondary: Colors.black, // Selected date circle color
              ),
            ),
            child: child!,
          );
        });

    _date = date ?? DateTime.now();

    setState(() {});
  }
}
