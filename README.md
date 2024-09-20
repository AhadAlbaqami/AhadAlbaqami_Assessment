# AhadAlbaqami_Assessment

# Project Overview
This project demonstrates a well-structured service management system and ViewModel architecture using **Moya** for API integration, along with other essential features.

## Key Components

### 1. BaseServiceManager
- I developed a `BaseServiceManager` to be inherited and extended by specific service classes. This setup enables easy API communication by creating a unified base for API calls.

### 2. BaseViewModel
- A `BaseViewModel` was created to handle common functionalities, making it easier to inherit and override specific behaviors in individual ViewModels.

### 3. API Integration using Moya
- Used **Moya** for API interaction:
- **Login validation**: Implemented API validation for login functionality, ensuring secure and effective user authentication.
- **Error Handling**: Managed error messages gracefully to provide clear feedback to users.
- **Fetching Users List**: Fetched a list of users and displayed their names and profile images.

### 4. Basic Calculator
- Implemented a basic calculator functionality:
- Division of two numbers, showcasing simple arithmetic capabilities within the app.

### 5. Unit Testing
- Comprehensive **Unit Tests** were written for each service to validate:
- API response accuracy.
- Error handling.
- Business logic correctness.

## How to Run the Project

1. Clone the repository.
2. Run `pod install` to install dependencies, including **Moya**.
3. Build and run the project using Xcode.
4. Execute the test cases using Xcode’s testing framework.
