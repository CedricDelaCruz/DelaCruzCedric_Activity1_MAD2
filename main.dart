import 'dart:io';

void main() {
  // constant variables
  String correctPin = '1234';
  double balance = 5000.0;

  while (true) {
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
      print('\nATM Main Menu:');
      print('1. Balance Inquiry');
      print('2. Withdraw Cash');
      print('3. Deposit Cash');
      print('4. Transfer Money');
      print('5. Change PIN');
      print('6. Pay Bills');
      print('7. Exit\n');

      stdout.write('Choose an option:');
      int? choice = int.tryParse(stdin.readLineSync() ?? '');

      switch (choice) {
        // Balance Inquiry
        case 1:
          print('\nCurrent balance: PHP ${balance.toStringAsFixed(2)}');
          break;
        // Withdraw cash
        case 2:
          stdout.write('\nEnter amount to withdraw: ');
          double? withdraw = double.tryParse(stdin.readLineSync() ?? '');

          if (withdraw == null || withdraw <= 0) {
            print('Invalid amount. Please enter a positive number.\n');
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
          stdout.write('\nEnter amount to deposit: ');
          double? deposit = double.tryParse(stdin.readLineSync() ?? '');

          if (deposit == null || deposit <= 0) {
            print('Invalid amount. Please enter a positive number.\n');
          } else {
            balance += deposit;
            print(
              '\nDeposit successful. New balance: PHP ${balance.toStringAsFixed(2)}',
            );
            break;
          }
        // Transfer money
        case 4:
          const String receiver = 'Soda';

          stdout.write('Enter amount of transfer to $receiver: ');
          double? transfer = double.tryParse(stdin.readLineSync() ?? '');

          if (transfer == null || transfer <= 0) {
            print('Invalid amount. Please enter a positive number.\n');
          } else if (transfer > balance) {
            print('Insufficient balance.');
          } else {
            balance -= transfer;
            print(
              'Transferred PHP ${transfer.toStringAsFixed(2)} to $receiver. Remaining balance: PHP ${balance.toStringAsFixed(2)}',
            );
          }
          break;
        // Change PIN
        case 5:
          stdout.write('Enter new PIN: ');
          String? newPin = stdin.readLineSync();

          if (newPin != null && newPin.length == 4) {
            correctPin = newPin;
            print('PIN changed successfully. Please log in again.');
            isAuthenticated = false;
          } else {
            print('PIN must be 4 digits. Please try again.');
          }
          break;
        // Pay bills
        case 6:
          const String biller = 'PLDT';

          stdout.write('Enter amount to pay for $biller bill: ');
          double? bill = double.tryParse(stdin.readLineSync() ?? '');

          if (bill == null || bill <= 0) {
            print('Invalid amount. Please enter a positive number.\n');
          } else if (bill > balance) {
            print('Insufficient balance.');
          } else {
            balance -= bill;
            print(
              'Successfully paid PHP ${bill.toStringAsFixed(2)} for $biller bill. Remaining balance: PHP ${balance.toStringAsFixed(2)}',
            );
          }
          break;
        // Exit
        case 7:
          print('Thank you for using our ATM. Goodbye!');
          exit(0);
        default:
          print('Invalid option. Please try again.');
      }
    }
  }
}
