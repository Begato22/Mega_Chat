class Resource {
  final Status status;
  Resource({required this.status});
}

// ignore: constant_identifier_names
enum Status { Success, Error, Cancelled }
