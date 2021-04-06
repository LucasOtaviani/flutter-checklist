class Task {
  int id;
  String name;
  int quantity;
  double value;
  bool finished;
  bool active;
  String description;

  Task(
    this.id,
    {
      this.name = "",
      this.quantity = 1,
      this.value = 0.0,
      this.finished = false,
      this.active = true,
      this.description = "",
    }
  );
}
