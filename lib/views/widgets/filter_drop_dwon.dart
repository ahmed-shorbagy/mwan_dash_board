import 'package:dash_board/core/theme/theme_constants.dart';
import 'package:dash_board/core/utils/app_styles.dart';
import 'package:dash_board/views/widgets/helper_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterDropdown extends StatefulWidget {
  final String label;
  final String initialValue;

  const FilterDropdown({
    super.key,
    required this.label,
    required this.initialValue,
  });

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  String? selectedValue;
  final List<String> items = ['الكل', 'قسم 1', 'قسم 2', 'قسم 3', 'قسم 4'];

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.label, style: AppStyles.tajawalLight20),
        const SizedBox(height: 8),
        DashboardContainer(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: EdgeInsets.zero,
          child: DropdownButtonHideUnderline(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 120,
                maxWidth: 200,
              ),
              child: DropdownButton<String>(
                value: selectedValue,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: kItemTitleTextColor,
                ),
                style: AppStyles.tajawalLight18.copyWith(
                  color: kItemTitleTextColor,
                ),
                dropdownColor: const Color(0xFF2E2E2E),
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: AppStyles.tajawalLight18.copyWith(
                        color: kItemTitleTextColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SimpleDropdown extends StatefulWidget {
  const SimpleDropdown({super.key});

  @override
  State<SimpleDropdown> createState() => _SimpleDropdownState();
}

class _SimpleDropdownState extends State<SimpleDropdown> {
  String? selectedValue = 'منسقين';
  final List<String> items = ['منسقين', 'مدير', 'موظف', 'مشرف'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: kItemTitleTextColor,
          ),
          style: AppStyles.tajawalLight18,
          dropdownColor: const Color(0xFF2E2E2E),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppStyles.tajawalLight18,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
          },
        ),
      ),
    );
  }
}

class FilterDateDropdown extends StatefulWidget {
  final String label;

  const FilterDateDropdown({
    super.key,
    required this.label,
  });

  @override
  _FilterDateDropdownState createState() => _FilterDateDropdownState();
}

class _FilterDateDropdownState extends State<FilterDateDropdown> {
  DateTimeRange? selectedDateRange;

  String getFormattedDateRange() {
    if (selectedDateRange == null) {
      return "اختر فترة العرض";
    }
    final formatter = DateFormat('MMMM yyyy', 'ar');
    final start = formatter.format(selectedDateRange!.start);
    final end = formatter.format(selectedDateRange!.end);
    return "$start حتى $end";
  }

  Future<void> _pickDateRange(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange ??
          DateTimeRange(
            start: now,
            end: now.add(const Duration(days: 30)),
          ),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('ar'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: const Color(0xFF2E2E2E),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF2E2E2E),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.label, style: AppStyles.tajawalLight20),
        const SizedBox(height: 8),
        DashboardContainer(
          padding: const EdgeInsets.all(12),
          margin: EdgeInsets.zero,
          child: InkWell(
            onTap: () => _pickDateRange(context),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 120,
                maxWidth: 200,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      getFormattedDateRange(),
                      style: AppStyles.tajawalLight18.copyWith(
                        color: kItemTitleTextColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: kItemTitleTextColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
