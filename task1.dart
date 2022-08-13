import 'dart:io';

void main(List<String> args) {
  int choose;

  do {
    print(
        "\nMain menu\n 1- Display all books \n 2- Display books with rate +4.\n 3- Add book\n 4- Update book \n 5- Delete book\n 6- Search\n 7- EXIT\nWrite your choice: ");
    choose = int.parse(stdin.readLineSync()!);
    switch (choose) {
      case 1:
        Books.getAllBooks();
        break;
      case 2:
        Books.getBooksWithRate();
        break;
      case 3:
        Books.AddBooks();
        break;
      case 4:
        print("Enter the book Name: ");
        String Name = stdin.readLineSync()!;
        Books.UpdateBooks(Name);
        break;
      case 5:
        print("Enter the book Name: ");
        String Name = stdin.readLineSync()!;
        Books.delBook(Name);
        break;
      case 6:
        print("Enter a query: ");
        String Name = stdin.readLineSync()!;
        Books.Search(Name);
        break;
    }
  } while (choose != 7);
}

class Books {
  String? name;
  String? author;
  double? rate;
  static List booksList = <Books>[];

  Books({required this.name, required this.author, required this.rate});

  Map<String, dynamic> get toMap =>
      {"Name": this.name, 'Author': this.author, "Rate": this.rate};

  static void getAllBooks() {
    List<Books>? listBook = Books.booksList.cast<Books>();
    if (listBook.isEmpty) {
      print("There are no Books!");
    } else {
      print("Name\t\t\t\tAuthor\t\t\t\tRate");
      listBook.forEach((Books) {
        print("${Books.getName()}\t\t\t\t${Books.getAuthor()}\t\t\t\t${Books.getRate()}");
      });
    }
  }

  getName() {
    return this.name;
  }

  getAuthor() {
    return this.author;
  }

  getRate() {
    return this.rate;
  }

  static void returnprint(Iterable<dynamic> book) {
    if (book.isEmpty) {
      print("There are no Books!");
    }
    else{
    print("Name\t\t\t\tAuthor\t\t\t\tRate");
    book.forEach((Books) {
      print(
          "${Books.getName()}\t\t\t\t${Books.getAuthor()}\t\t\t\t${Books.getRate()}");
    });
    }


  }

  static void getBooksWithRate() {
    returnprint(booksList.where((element) => element.toMap["Rate"] >= 4));
  }

  static void AddBooks() {
    print("Enter the count of books want to add: ");
    int nbook = int.parse(stdin.readLineSync()!);
    for (int num = 0; num < nbook; num++) {
      print("Enter book ${num + 1} Name: ");
      String? Name = stdin.readLineSync();
      print("Enter book ${num + 1} Author: ");
      String? Author = stdin.readLineSync();
      print("Enter book ${num + 1} Rate: ");
      double Rate = double.parse(stdin.readLineSync()!);
      booksList.add(Books(name: Name, author: Author, rate: Rate));
      print("=======================================");
    }
  }

  static void delBook(String name) {
    try {
      booksList.removeAt(
          booksList.indexWhere((element) => element.toMap["Name"] == name));
      print("Book has been Deleted.\n");
    } on RangeError {
      print("There is no Book with this name.\n");
    }
  }

  static void UpdateBooks(String name) {
    print("Enter book Name: ");
    String? Name = stdin.readLineSync();
    print("Enter book Author: ");
    String? Author = stdin.readLineSync();
    print("Enter book Rate: ");
    double Rate = double.parse(stdin.readLineSync()!);
    booksList[
            booksList.indexWhere((element) => element.toMap["Name"] == name)] =
        Books(name: Name, author: Author, rate: Rate);
  }

  static void Search(String name) {
    returnprint(booksList.where((element) => element.toMap["Name"]
        .toString()
        .toLowerCase()
        .contains(name.toLowerCase())));
  }
}
