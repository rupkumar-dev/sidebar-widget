# Flutter Sidebar Widget 🎯

[![Pub Version](https://img.shields.io/pub/v/sidebar_widget.svg)](https://pub.dev/packages/sidebar_widget)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A highly customizable sidebar navigation package for Flutter applications that provides a beautiful, responsive, and feature-rich navigation experience. Perfect for admin panels, dashboards, and complex navigation structures.


## Features ✨

- 🎨 **Highly Customizable** - Customize colors, width, icons, and more
- 📱 **Responsive Design** - Automatically adapts to different screen sizes
- 🔗 **Nested Navigation** - Support for multi-level navigation items
- ⚡ **Smooth Animations** - Beautiful expand/collapse animations
- 💫 **Hover Effects** - Interactive hover states for better UX
- 🎈 **Dynamic Widgets** - Support for both navigation items and custom widgets
- 🔄 **Route Integration** - Seamless integration with Flutter routing
- 📦 **Easy to Use** - Simple API with minimal setup required


## 📸 Screenshots

<img src="https://github.com/user-attachments/assets/b0900338-f362-450b-889f-7b0603b46b72" alt="desktop-ui" width="940"/>
<img src="https://github.com/user-attachments/assets/a2ac6bb1-47db-45b0-8b9d-6b056b745cce" alt="Animation" width="940"/>

## Installation 📦

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  sidebar_widget: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Usage 💻

1. Import the package:
```dart
import 'package:sidebar_widget/sidebar_widget.dart';
```


### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:sidebar_widget/sidebar_widget.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    return CustomSideBar(
      currentRoute: path,
      items: items,
      backgroundColor: Colors.black87,
      width: 250,
      onRouteSelected: (route) {
        context.goNamed(route);
      },
    );
  }
}
```

### Navigation Items Configuration

```dart
final List<dynamic> items = [
  NavigationItem(
    title: 'Dashboard',
    icon: Icons.dashboard,
    route: RouteNames.dashboard,
  ),
  
  Divider(), // You can add widgets directly
  
  NavigationItem(
    title: 'Students',
    icon: Icons.school,
    route: RouteNames.students,
    subItems: [
      Subitem(title: 'Student List', route: RouteNames.studentList),
      Subitem(title: 'Attendance', icon: Icons.assignment, route: RouteNames.attendance),
    ],
  ),
  
  // Custom widgets
  Container(child: Text('Custom Widget'))
];
```

## Customization 🎨

The sidebar is highly customizable. Here are some key properties:

- `currentRoute`: Current active route
- `items`: List of navigation items and widgets
- `backgroundColor`: Sidebar background color
- `width`: Sidebar width
- `onRouteSelected`: Callback for route selection
- `onRoute`: Enable/disable route handling

## Mobile Support 📱

The sidebar automatically adapts to mobile screens:

<img src="https://github.com/user-attachments/assets/04bad514-e074-4715-b077-2dcbbbf27c3b" alt="Animation" width="250"/>

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support ❤️

If you find this package helpful, please give it a ⭐️ on [GitHub](https://github.com/masteronevil/sidebar-widget)!




## 📚 Documentation

For detailed documentation and examples, visit our [LivePreview](https://masteronevil.github.io/sidebar-widget/).

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Rupkumar Sarkar** - *Initial work* - [YourGithubProfile](https://github.com/masteronevil)

## 🙏 Acknowledgments

- Thanks to all contributors who have helped make this package better
- Special thanks to the Flutter community

## 📧 Contact

If you have any questions, feel free to reach out:

- Email: rupkumarcomputer@gmail.com
- Instagram: [@masteronevil](https://www.instagram.com/masteronevil/)

---

Made with ❤️ by [Rupkumar Sarkar]