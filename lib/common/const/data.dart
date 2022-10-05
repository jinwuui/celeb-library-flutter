import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost
const emulatorIp = '10.0.0.2:3000';
const simulatorIp = '127.0.0.1:3000';

const TRUE = 'true';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;

const xxl = 50.0;
const xl = 32.0;
const lg = 24.0;
const md = 16.0;
const sm = 8.0;
