#!/bin/bash

# Run Flutter tests with coverage
echo "Running tests with coverage..."
flutter test --coverage

# Check if lcov is installed (needed for HTML reports)
if ! command -v lcov &> /dev/null; then
    echo "ERROR: lcov is not installed. Please install lcov to generate HTML coverage reports."
    echo "On macOS, you can install it using: brew install lcov"
    echo "On Ubuntu/Debian, you can install it using: sudo apt-get install lcov"
    exit 1
fi

# Generate HTML reports
echo "Generating HTML reports..."
genhtml coverage/lcov.info -o coverage/html

# Open the coverage report in the default browser
echo "Opening coverage report in browser..."
open coverage/html/index.html

echo "Test coverage process completed!" 