# W8ly

A beautiful and customizable horizontal weight picker for Flutter apps.

## ✨ Features

- Smooth horizontal scrolling
- Customizable indicator
- Responsive UI
- Custom colors and text styles
- Lightweight and easy to use
- Supports kg, lbs, or custom units

---

## 📸 Preview

<img src="https://github.com/AbdullahAltaf99/w8ly/blob/main/assets/demoImage.jpeg" width="300"/>

---

## 🎥 Demo Video

[Watch Demo Video](https://github.com/AbdullahAltaf99/w8ly/blob/main/assets/demoVideo.mp4)

---

## 🚀 Getting Started

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  w8ly: ^0.0.1
```

Run:

```bash
flutter pub get
```

---

## 📦 Usage

```dart
import 'package:w8ly/w8ly.dart';

W8lyWeightPicker(
  initialWeight: 70,
  minWeight: 1,
  maxWeight: 200,
  unit: "kg",
  activeColor: Colors.blue,
  inactiveColor: Colors.grey,
  onChanged: (value) {
    debugPrint(value.toString());
  },
)
```

---

## ⚙️ Parameters

| Parameter | Description |
|---|---|
| `initialWeight` | Initial selected weight |
| `minWeight` | Minimum weight |
| `maxWeight` | Maximum weight |
| `unit` | Weight unit |
| `activeColor` | Active tick color |
| `inactiveColor` | Inactive tick color |
| `indicator` | Custom indicator widget |
| `onChanged` | Callback when value changes |

---

## 📁 Example

Check the `/example` folder for a complete example app.

---

## 🛠 Roadmap

- Add snapping effect
- Add haptic feedback
- Add animations
- Add controller support

---

## 🤝 Contributing

Contributions are welcome.

Feel free to open issues or submit pull requests on GitHub.

---

## 🔗 Links

- GitHub Repository: https://github.com/AbdullahAltaf99/w8ly
- Pub.dev: https://pub.dev/packages/w8ly

---

## 📄 License

MIT License © 2026 Abdullah Altaf