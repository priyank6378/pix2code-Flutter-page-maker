String makeRow(List<String> childs) {
  return 'Row(children: $childs,)';
}

String makeLabel(String label) {
  return 'const Text(\'$label\',)';
}

String makeButton(String btnLabel) {
  return '''TextButton( 
    onPressed: () {/* TODO : implement functionality */},
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(
        Colors.black.withOpacity(0.2),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    ),
    child: const Text(\'$btnLabel\'),
  )''';
}

String makeSwitch() {
  return '''Expanded(
    child: ListTile(
      title: const Text('Switch'),
      leading: Switch(
        value: true,
        onChanged: (value) {
          /* TODO: implement functionality */
        },
      ),
    ),
  )''';
}

String makeColumn(List<String> childs) {
  return '''Column(
    children: $childs,
  )''';
}

String makeFooter(List<Map<String, dynamic>> childs) {
  /* 
  childs = [
    {
      'icon': icon widget,
      'label': label string
    }
  ]
  */
  return 'CustomBottomNavigationBar(childs: $childs)';
}

String makeRadioButton(List<String> labels) {
  return 'CustomRadioButton(labels: $labels)';
}

Map<String, dynamic> makeButtonSearchBottomNavigationItem() {
  return {
    '\'icon\'': 'Icon(Icons.search)',
    '\'label\'': '\'Search\'',
  };
}

Map<String, dynamic> makeButtonDashboardBottomNavigationItem() {
  return {
    '\'icon\'': 'Icon(Icons.dashboard)',
    '\'label\'': '\'Dashboard\'',
  };
}

Map<String, dynamic> makeButtonHomeBottomNavigationItem() {
  return {
    '\'icon\'': 'Icon(Icons.home)',
    '\'label\'': '\'Home\'',
  };
}

String makeCheckBox() {
  return 'CustomCheckBox()';
}

Map<String, dynamic> makeButtonNotificationBottomNavigationItem() {
  return {
    '\'icon\'': 'Icon(Icons.notifications)',
    '\'label\'': '\'Notification\'',
  };
}

String makeSlider() {
  return 'CustomSlider()';
}
