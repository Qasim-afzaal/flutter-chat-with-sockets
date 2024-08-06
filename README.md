# Chat App

Welcome to the Chat App! This application allows users to communicate in real-time using a chat interface. The app leverages Socket.IO for real-time communication, connectivity package for network management, and Shimmer for loading animations.

## Features

- Real-time messaging
- Network connectivity management
- Smooth loading animations

## Requirements

- Flutter SDK
- Dart SDK
- Compatible IDE (e.g., Visual Studio Code, Android Studio)

## Dependencies

The following dependencies are used in this project:

```yaml
dependencies:
  flutter:
    sdk: flutter
  socket_io_client: ^2.0.3+1
  connectivity: ^3.0.6
  shimmer: ^2.0.0
```

## Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/yourusername/chat-app.git
    cd chat-app
    ```

2. **Install dependencies:**

    ```bash
    flutter pub get
    ```

3. **Run the app:**

    ```bash
    flutter run
    ```

## Usage

1. **Real-time Messaging:**

    The app uses `socket_io_client` for real-time communication. Ensure your backend server supports Socket.IO.

2. **Network Connectivity:**

    The `connectivity` package is used to manage network status. The app will display appropriate messages when the network is unavailable.

3. **Loading Animations:**

    The `shimmer` package is used to display loading animations while data is being fetched.

## Code Overview

- **lib/main.dart:** Entry point of the application.
- **lib/screens/chat_screen.dart:** Main screen for chat functionality.
- **lib/services/socket_service.dart:** Service for managing Socket.IO connections.
- **lib/widgets/shimmer_loading.dart:** Widget for displaying shimmer loading animations.

## Contributing

1. Fork the repository.
2. Create your feature branch: `git checkout -b feature/feature-name`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/feature-name`
5. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any inquiries or support, please contact us at support@chatapp.com.

---

Thank you for using Chat App! We hope you enjoy using it as much as we enjoyed building it.

---

Feel free to customize this README file as per your project details and requirements.
