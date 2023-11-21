# local_auth_test

A flutter project to determine an error at 'local_auth' package of flutter that 'Dark theme breaks the dialog of local_auth'

## Test results

Tested on android device HUAWEISNE-L01 (Huawei Mate 20 Lite) | sdk: 29
The actual result is that:

- In light theme it is working just fine,

![image](https://github.com/flutter/flutter/assets/29236412/b23a686c-5dd3-4392-8c31-9824e2af6a96)

- In the dark theme the dialog background color will stay same as white,
The background color of the bottom area (grey area on light dialog) of the dialog will be same as background,
The texts will not be visible (probably using colors from dark_theme: white on white-background)
Also the cancel button's text style changed a little. (less font weight)

![image](https://github.com/flutter/flutter/assets/29236412/ee1c5bcf-c43a-4def-9cb8-bd73b0caaa5d)
