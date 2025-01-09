# Shopdicator App

Welcome to Shopdicator 
## Features

- **Order Statistics**: View detailed statistics like order count, total price, average price, and total returns.
- **Interactive Charts**: Swipeable charts displaying detailed metrics.
 
## Packages Used

- **dartz**: Functional programming tools for Dart.
- **flutter_bloc**: State management library to simplify complex state management with BLoC (Business Logic Component) pattern.
- **get_it**: Simple service locator for dependency injection.
- **syncfusion_flutter_charts**: Provides a rich set of features for creating beautiful and interactive charts.
- **fl_chart**: A charting library for creating various types of charts.
- **charts_painter**: A flexible and painter-friendly chart library.

## Getting Started

To get started with the project, follow these steps:

1. **Clone the repository**:
    ```bash
    git clone <your-repository-url>
    cd shopdicator
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **Run the application**:
    ```bash
    flutter run
    ```

## Code Structure

- **lib**: Contains the main application code.
  - **features/graph/presentation/bloc**: Business logic components for graph-related features.
  - **features/graph/presentation/pages**: Contains the main pages for displaying graphs and statistics.
  - **features/graph/presentation/widgets**: Custom widgets used across the application.

## Widgets

- **AnimatedBoxWidget**: Custom widget for displaying animated statistic boxes.
- **StatsScreen**: Main screen displaying order statistics and providing navigation to detailed charts.
- **GraphPage**: Page displaying detailed graphs with interactive charts.

 
