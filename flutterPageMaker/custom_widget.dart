
///////////////// BOTTOM NAVIGATION BAR ///////////////////////
class CustomBottomNavigationBar extends StatefulWidget {
  final List<Map<String, dynamic>> childs;
  const CustomBottomNavigationBar({super.key, required this.childs});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectIndex = 0;
  final List<BottomNavigationBarItem> _items = [];

  @override
  void initState() {
    for (var i = 0; i < widget.childs.length; i++) {
      _items.add(BottomNavigationBarItem(
          icon: widget.childs[i]['icon']!, label: widget.childs[i]['label']));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _items,
      currentIndex: _selectIndex,
      onTap: (index) {
        setState(() {
          _selectIndex = index;
        });
      },
    );
  }
}
////////////////////////// END BOTTOM NAVIGATION BAR ///////////////////////

///////////////// RADIO BUTTON ///////////////////////
class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({super.key, required this.labels});

  final List<String> labels;

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  String _currentValue = "";

  @override
  void initState() {
    _currentValue = widget.labels[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          for (var label in widget.labels)
            ListTile(
              title: Text(label),
              leading: Radio(
                value: label,
                groupValue: _currentValue,
                onChanged: (value) {
                  setState(
                    () {
                      _currentValue = value.toString();
                    },
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
///////////////// END RADIO BUTTON ///////////////////////

///////////////// CUSTOM CHECK BOX ///////////////////////
class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: Text("Check"),
        leading: Checkbox(
          value: value,
          onChanged: (value) {
            setState(
              () {
                this.value = value!;
              },
            );
          },
        ),
      ),
    );
  }
}
///////////////// END CUSTOM CHECK BOX ///////////////////////

///////////////////// CUSTOM SLIDER ////////////////////////
class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _currentValue = 50.0;
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentValue,
      min: 0,
      max: 100,
      divisions: 100,
      label: _currentValue.round().toString(),
      onChanged: (value) {
        setState(
          () {
            _currentValue = value;
          },
        );
      },
    );
  }
}
//////////////////////// END CUSTOM SLIDER ////////////////////////


