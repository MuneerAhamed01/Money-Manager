import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/widgets/button.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key, this.initalRange});

  final DateTimeRange? initalRange;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int? _selectedOption;

  DateTimeRange? _range;

  bool get isThisMonth {
    return widget.initalRange?.start.year == DateTime.now().year &&
        widget.initalRange?.start.month == DateTime.now().month &&
        widget.initalRange?.start.day == 1;
  }

  bool get isThisYear {
    return widget.initalRange?.start.year == DateTime.now().year &&
        widget.initalRange?.start.month == 1 &&
        widget.initalRange?.start.day == 1;
  }

  bool get isCustom =>
      !isThisYear && !isThisMonth && widget.initalRange != null;

  @override
  void initState() {
    super.initState();

    if (isThisMonth) _selectedOption = 1;
    if (isThisYear) _selectedOption = 2;
    if (isCustom) _selectedOption = 3;

    _range = widget.initalRange;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      width: Get.width,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            checkColor: Colors.white,
            value: _selectedOption == 1,
            onChanged: (_) {
              _range = DateTimeRange(
                start: DateTime(DateTime.now().year, DateTime.now().month, 1),
                end: DateTime.now(),
              );
              _setStateWithSelectedOption(1);
            },
            title: Text(
              'This Month',
              style: Get.textTheme.titleMedium,
            ),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            checkColor: Colors.white,
            value: _selectedOption == 2,
            onChanged: (_) {
              _range = DateTimeRange(
                start: DateTime(DateTime.now().year, 1, 1),
                end: DateTime.now(),
              );
              _setStateWithSelectedOption(2);
            },
            title: Text(
              'This Year',
              style: Get.textTheme.titleMedium,
            ),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            checkColor: Colors.white,
            value: _selectedOption == 3,
            onChanged: (_) => _setStateWithSelectedOption(3),
            title: Text(
              'Custom Range',
              style: Get.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 20),
          _buildDateRange(),
          const SizedBox(height: 20),
          SizedBox(
            height: 48,
            child: AppButton(
              label: 'Continue',
              onTap: () {
                Get.back(result: _range);
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 48,
            child: AppButton(
              label: 'Reset',
              style: AppButtonStyle.outlined,
              onTap: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }

  Opacity _buildDateRange() {
    return Opacity(
      opacity: _selectedOption == 3 ? 1 : 0.2,
      child: IgnorePointer(
        ignoring: _selectedOption != 3,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final date =
                      await _onDatePicker(_range?.start ?? DateTime.now());

                  if (date != null) {
                    _range = DateTimeRange(
                        start: date, end: _range?.end ?? DateTime.now());
                    setState(() {});
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text(
                    DateFormat('dd-MM-yyyy')
                        .format(_range?.start ?? DateTime.now()),
                  )),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () async {
                  final date = await _onDatePicker(
                      _range?.end ?? DateTime.now(), _range?.start);

                  if (date != null) {
                    _range = DateTimeRange(
                        start: _range?.start ?? DateTime.now(), end: date);
                    setState(() {});
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text(
                    DateFormat('dd-MM-yyyy').format(
                      _range?.end ?? DateTime.now(),
                    ),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _setStateWithSelectedOption(int index) {
    setState(() {
      _selectedOption = index;
    });
  }

  Future<DateTime?> _onDatePicker(DateTime initalDate,
      [DateTime? firstDate]) async {
    final date = await showDatePicker(
        context: context,
        initialDate: initalDate,
        firstDate: firstDate ?? DateTime(2000),
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

    return date;
  }
}
