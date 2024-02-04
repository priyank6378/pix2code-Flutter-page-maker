import 'pageBodyCreater.dart';
import 'widgets_templates.dart';

int btnIndex = 1;
int labelIndex = 1;

// Returns the next token (widget) in the code
String getNextToken(String code, int index) {
  String token = "";
  for (int i = index; i < code.length; i++) {
    if (code[i] == " ") {
      break;
    }
    token += code[i];
  }
  return token;
}

// Function to create footer
List<dynamic> makeFooterWidget(String code, int index) {
  String token = getNextToken(code, index);
  index += token.length + 1;
  List<Map<String, dynamic>> widgets = [];
  while (true) {
    token = getNextToken(code, index);
    index += token.length + 1;
    if (token == 'btn-dashboard') {
      widgets.add(makeButtonDashboardBottomNavigationItem());
    } else if (token == 'btn-home') {
      widgets.add(makeButtonHomeBottomNavigationItem());
    } else if (token == 'btn-search') {
      widgets.add(makeButtonSearchBottomNavigationItem());
    } else if (token == 'btn-notifications') {
      widgets.add(makeButtonNotificationBottomNavigationItem());
    } else if (token == "}") {
      break;
    }
  }
  return [makeFooter(widgets), index];
}

// Function to create row
List<dynamic> makeRowWidget(String code, int index) {
  String token = getNextToken(code, index);
  index += token.length + 1;
  List<String> widgets = [];
  while (true) {
    token = getNextToken(code, index);
    index += token.length + 1;
    if (token == 'btn') {
      widgets.add(makeButton('btn$btnIndex'));
      btnIndex++;
    } else if (token == 'switch') {
      widgets.add(makeSwitch());
    } else if (token == 'radio') {
      widgets.add(makeRadioButton(['\'label$labelIndex\'']));
      labelIndex++;
    } else if (token == 'label') {
      widgets.add(makeLabel('label$labelIndex'));
      labelIndex++;
    } else if (token == 'slider') {
      widgets.add(makeSlider());
    } else if (token == 'check') {
      widgets.add(makeCheckBox());
    } else if (token == "}") {
      break;
    }
  }
  return [makeRow(widgets), index];
}

// Function to create column
List<dynamic> makeColWidget(String code, int index) {
  List<String> widgets = [];
  // reading {
  String token = getNextToken(code, index);
  index += token.length + 1;
  while (true) {
    token = getNextToken(code, index);
    index += token.length + 1;
    if (token == 'row') {
      // create row
      var row = makeRowWidget(code, index);
      widgets.add(row[0]);
      index = row[1];
    } else if (token == "}") {
      break;
    }
  }
  String col = makeColumn(widgets);
  return [col, index];
}

// Function to create full Page
void pageMaker(String code, String outputFolder) {
  // scaffold body
  String scaffoldBody = '';
  // scaffold footer
  String scaffoldFooter = '';
  int index = 0;
  String token = getNextToken(code, index);
  if (token == 'stack') {
    var col = makeColWidget(code, index + token.length + 1);
    scaffoldBody = col[0];
    // print(scaffoldBody);
    index = col[1] + 1;
  } else if (token == 'footer') {
    var footer = makeFooterWidget(code, index + token.length + 1);
    scaffoldFooter = footer[0];
    // print(scaffoldFooter);
    index = footer[1] + 1;
  }

  if (index < code.length) {
    var footer = makeFooterWidget(code, index);
    scaffoldFooter = footer[0];
    index = footer[1] + 1;
  }
  
  // save the page
  pageMakerAndSaver(scaffoldBody, scaffoldFooter, outputFolder);
}

void main(List<String> arguments) {
  String code = arguments[0];
  String outputFolder = 'generated_page_output';
  if (arguments.length > 1){
    outputFolder = arguments[1];
  }
  // print(code);
  pageMaker(code, outputFolder);
}