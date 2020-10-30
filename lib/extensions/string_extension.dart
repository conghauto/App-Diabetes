extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
  String get capitalizeFirstofEach => this.split(" ").map((str) => str.capitalize).join(" ");
}