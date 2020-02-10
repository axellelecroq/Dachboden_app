class Drink {
  Drink(this.name, this.price);

  String name;
  int buyCounter = 0;
  double price;

  void increment() {
    buyCounter++;
  }

  void decrement() {
    if (buyCounter <= 0) return;
    buyCounter--;
  }
}
