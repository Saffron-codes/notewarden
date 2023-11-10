import 'package:fluent_ui/fluent_ui.dart';

class SettingsGroup extends StatelessWidget {
  final String groupName;
  final List<Widget> items;

  const SettingsGroup({
    Key? key,
    required this.groupName,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          groupName,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: items,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class SettingsItem<T> extends StatelessWidget {
  final String subtitle;
  final String description;
  final Icon icon;
  final List<SettingOption<T>>? options;
  final T? selectedOption;
  final Function(T?)? onOptionChanged;
  final bool isMenu;
  final Widget? trailing;

  const SettingsItem({
    Key? key,
    required this.subtitle,
    required this.description,
    required this.icon,
    this.options,
    this.selectedOption,
    this.onOptionChanged,
    this.isMenu = true,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: FluentTheme.of(context).cardColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black, width: 0.11)),
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          Visibility(
            visible: isMenu,
            child: ComboBox<T>(
              items: options
                  ?.map((option) => ComboBoxItem(
                        child: Text(option.text),
                        value: option.value,
                      ))
                  .toList(),
              value: selectedOption,
              onChanged: onOptionChanged,
            ),
          ),
          trailing ?? Container()
        ],
      ),
    );
  }
}

class SettingOption<T> {
  final T value;
  final String text;
  SettingOption({
    required this.value,
    required this.text,
  });
}
