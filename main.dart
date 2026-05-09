import 'dart:io';

void main() {
  // constant variables
  String correctPin = '1234';
  double balance = 5000.0;

  bool isAuthenticated = false;
  const int maxAttempts = 3;

  // loop to allow the user to enter PIN for up to maxAttempts times
  for (int attempt = 1; attempt <= maxAttempts; attempt++) {
    stdout.write('Enter your PIN: ');
    final inputPin = stdin.readLineSync();

    if (inputPin == correctPin) {
      print('Access granted. Welcome!');
      isAuthenticated = true;
      break;
    }

    // Calculate remaining attempts
    final remaining = maxAttempts - attempt;

    if (remaining > 0) {
      print('Incorrect PIN. You have $remaining attempt(s) left.');
    } else {
      print('Too many incorrect attempts. Your account is locked.');
      exit(0);
    }
  }

  while (isAuthenticated) {
    print('ATM Main Menu:');
    print('1. Balance Inquiry');
    print('2. Withdraw Cash');
    print('3. Deposit Cash');
    print('4. Transfer Money');
    print('5. Change PIN');
    print('6. Pay Bills');
    print('7. Exit');

    stdout.write('Choose an option: ');
    int? choice = int.tryParse(stdin.readLineSync() ?? '');

    switch (choice) {
      // Balance Inquiry
      case 1:
        print('\nCurrent balance: PHP ${balance.toStringAsFixed(2)}');
        break;
      // Withdraw cash
      case 2:
        stdout.write('Enter amount to withdraw: ');
        double? withdraw = double.tryParse(stdin.readLineSync() ?? '');

        if (withdraw == null || withdraw <= 0) {
          print('Invalid amount. Please enter a positive number.');
        } else if (withdraw > balance) {
          print('Insufficient balance.');
        } else {
          balance -= withdraw;
          print(
            '\nWithdrawal successful. Current balance: PHP ${balance.toStringAsFixed(2)}',
          );
        }
        break;
      // Deposit cash
      case 3:
      // Transfer money
      case 4:
      // Change PIN
      case 5:
      // Pay bills
      case 6:
      // Exit
      case 7:
        print('Thank you for using our ATM. Goodbye!');
        exit(0);
      default:
        print('Invalid option. Please try again.');
    }
  }
}
