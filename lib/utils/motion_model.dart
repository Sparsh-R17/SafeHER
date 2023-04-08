import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:kavach/utils/sos_fn.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

import '../utils/model_enum.dart' as enums;
import 'db_trigger.dart';

void motionModel() {
  loadModel();
  accelerometerEvents.listen(_onAccelerometerEvent);
  modelTimer();
}

int activityTracker = 0;

dynamic interpreter;
enums.Orientation _orientation = enums.Orientation.waiting;
enums.Activity activity = enums.Activity.sitting;
double anglexy = 0.0;
double angleyz = 0.0;
double anglexz = 0.0;
double x = 0.0;
double y = 0.0;
double z = 0.0;
var maxIndex = 2;
List<List<double>> accData = [[], [], []];
List<double> currentState = [0, 0, 0];

double setAngle(double val) {
  if (val < 0) {
    val += 360;
  } else if (val == 360) {
    val = 0;
  }
  return val;
}

void _onAccelerometerEvent(AccelerometerEvent event) {
  currentState[0] = event.x;
  currentState[1] = event.y;
  currentState[2] = event.z;
}

void _setOrientation(double anglexy, double angleyz, double anglexz) {
  if (true) {
    _orientation = enums.Orientation.error;
  }
  if (anglexy >= 30 && anglexy < 145) {
    _orientation = enums.Orientation.portraitUp;
  } else if (anglexy >= 215 && anglexy < 330) {
    _orientation = enums.Orientation.portraitDown;
  }
  if ((anglexy >= 330 && anglexy <= 360) || (anglexy >= 0 && anglexy <= 30)) {
    _orientation = enums.Orientation.landscapeLeft;
  } else if (anglexy >= 145 && anglexy <= 215) {
    _orientation = enums.Orientation.landscapeRight;
  }
  if (((anglexz >= -1 && anglexz <= 30) ||
          (anglexz >= 330 && anglexz <= 360)) ||
      (anglexz >= 150 && anglexz <= 210)) {
    if ((angleyz >= 0 && angleyz <= 25) || (angleyz >= 335 && angleyz <= 360)) {
      _orientation = enums.Orientation.faceUp;
    } else if (angleyz >= 170 && angleyz <= 195) {
      _orientation = enums.Orientation.faceDown;
    }
  }
}

modelTimer() {
  Timer.periodic(Duration(milliseconds: 50), (timer) {
    y = double.parse(currentState[1].toStringAsFixed(2));
    z = double.parse(currentState[2].toStringAsFixed(2));
    x = double.parse(currentState[0].toStringAsFixed(2));

    var ym = double.parse(currentState[1].toStringAsFixed(4));
    var zm = double.parse(currentState[2].toStringAsFixed(4));
    var xm = double.parse(currentState[0].toStringAsFixed(4));

    anglexy = atan2(y, x) * 180 / pi;
    angleyz = atan2(y, z) * 180 / pi;
    anglexz = atan2(x, z) * 180 / pi;
    anglexy = setAngle(anglexy);
    angleyz = setAngle(angleyz);
    anglexz = setAngle(anglexz);
    _setOrientation(anglexy, angleyz, anglexz);

    //orientation logic
    List<int> axis = [0, 1, 2];
    List<double> mul = [1, 1, 1];

    if (_orientation == enums.Orientation.landscapeLeft) {
      axis = [0, 1, 2];
      mul = [1, 1, 1];
    } else if (_orientation == enums.Orientation.landscapeRight) {
      axis = [0, 1, 2];
      mul = [1, -1, 1];
    } else if (_orientation == enums.Orientation.portraitUp) {
      axis = [1, 0, 2];
      mul = [1, -1, -1];
    } else if (_orientation == enums.Orientation.portraitDown) {
      axis = [0, 2, 1];
      mul = [1, 1, 1];
    } else if (_orientation == enums.Orientation.faceUp) {
      axis = [0, 1, 2];
      mul = [1, -1, 1];
    } else if (_orientation == enums.Orientation.faceDown) {
      axis = [0, 1, 2];
      mul = [1, 1, -1];
    }

    accData[axis[0]].add(xm * mul[0]);
    accData[axis[1]].add(ym * mul[1]);
    accData[axis[2]].add(zm * mul[2]);

    if (accData[0].length == 80) {
      modelpredict(_processdata(accData));
      accData = [[], [], []];
    }
  });
}

List<List<double>> _processdata(List<List<double>> data) {
  // Normalization
  double max = data[0].reduce((a, b) => a > b ? a : b);
  data[0] = data[0].map((e) => e / max).toList();
  max = data[1].reduce((a, b) => a > b ? a : b);
  data[1] = data[1].map((e) => e / max).toList();
  max = data[2].reduce((a, b) => a > b ? a : b);
  data[2] = data[2].map((e) => e / max).toList();

  int timeSteps = 80;
  int nFeatures = 3;
  int inputShape = 240;

  List<double> flattenedList = data.expand((list) => list).toList();
  data = [];
  data.add(flattenedList);
  print("Reshaped Segments Shape : ${data.shape}");

  return data;
}

modelpredict(List<List<double>> inputData) async {
  var inputTensor = interpreter.getInputTensor(0);
  var inputShape = inputTensor.shape;
  print("Input Shape $inputShape");

  // Create a Float32List from your input data and reshape it to match the input shape of your model
  var inputList =
      Float32List.fromList(inputData.expand((list) => list).toList());
  inputTensor.data.buffer.asFloat32List().setAll(0, inputList);

  // Run the inference using the run() method of the Interpreter object and retrieve the output tensor(s)
  interpreter.allocateTensors();
  interpreter.invoke();

  var outputTensor = interpreter.getOutputTensor(0);
  var outputShape = outputTensor.shape;
  print("Output Shape $outputShape");

  var outputData = outputTensor.data.buffer.asFloat32List() as List<double>;

  // Process the predictions as needed
  print("Prediction $outputData");

  maxIndex = outputData.indexWhere((element) =>
      element ==
      outputData.reduce((value, element) => value > element ? value : element));
  print("Index $maxIndex");

  switch (maxIndex) {
    case 0:
      activity = enums.Activity.downstairs;
      break;
    case 1:
      activity = enums.Activity.jogging;
      break;
    case 2:
      activity = enums.Activity.sitting;
      break;
    case 3:
      activity = enums.Activity.standing;
      break;
    case 4:
      activity = enums.Activity.upstairs;
      break;
    case 5:
      activity = enums.Activity.walking;
      break;
  }

  if (activity == enums.Activity.jogging) {
    activityTracker += 1;
  } else {
    activityTracker = 0;
  }

  if (activityTracker == 5) {
    print('SOS sent');
    callTriggerForUser(true);
    sendSOS(false);
    activityTracker = 0;
  }
}

loadModel() async {
  interpreter = await tfl.Interpreter.fromAsset('models/my_model.tflite');
  print("Model Loaded");
}
