# InsIIT App

InsIIT is the official student app of IIT Gandhinagar.

## Getting Started

Follow these steps to get the InsIIT app up and running on your local machine:

### Setup Flutter

Ensure you have Flutter installed on your development machine. You can follow the official Flutter installation guide [here](https://flutter.dev/docs/get-started/install).

### 1. Fork the Repository

Fork the InsIIT repository to your GitHub account.

### 2. Run `pub get`

Run the following command in the project directory to fetch and update the dependencies:

```bash
flutter pub get
```

### 3. Configure Firebase

Create a Firebase project for the InsIIT app on the [Firebase Console](https://console.firebase.google.com/). Follow the instructions to set up Firebase for your app.

### 4. Generate SHA-1 Key on Your Device

Generate a SHA-1 key for your development machine. You can do this using the following command (replace `your_keystore_path` with the path to your keystore file):

```bash
keytool -list -v -keystore your_keystore_path -alias your_alias_name -storepass your_keystore_password -keypass your_key_password
```

### 5. Configure the Project on Firebase Android

Follow the instructions provided by Firebase to add the generated SHA-1 key to your Firebase project settings. Download the `google-services.json` file and place it in the `android/app` directory of your project.

### 6. Run on adb Devices

Connect your device to your development machine and ensure USB debugging is enabled. Run the following command to check if your device is connected:

```bash
adb devices
```

Then, run the InsIIT app on your connected device using the following command:

```bash
flutter run
```

## Contributing

We welcome contributions from the community! If you'd like to contribute to the InsIIT app, please fork the repository, make your changes, and submit a pull request. Make sure to follow the contribution guidelines outlined in the repository.

## License


This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## App Preview:

<img src="https://github.com/anmolkumr/insiit-ui/assets/77740197/582e0605-3dc8-47fb-92d9-3c168bb111c1" width="50%">
<img src="https://github.com/anmolkumr/insiit-ui/assets/77740197/3bccf1be-3231-411e-82aa-527ba22ff15a" width="50%">
<img src="https://github.com/anmolkumr/insiit-ui/assets/77740197/8bc129cd-68d2-45dd-af7c-1853190bb7e4" width="50%">
<img src="https://github.com/anmolkumr/insiit-ui/assets/77740197/5a5f2974-9805-49b2-b9ec-8d6bc01d5412" width="50%">
<img src="https://github.com/anmolkumr/insiit-ui/assets/77740197/fb4fc6e7-12c0-4a9b-8593-2e122249c5f7" width="50%">
<img src="https://github.com/anmolkumr/insiit-ui/assets/77740197/83825a1b-0ba5-427d-a2c6-263f230bd700" width="50%">

