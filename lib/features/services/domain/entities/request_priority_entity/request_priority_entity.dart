class RequestPriorityEntity {
  final String type; // scheduled | urgent | emergency
  final int percentage;

  const RequestPriorityEntity({
    required this.type,
    required this.percentage,
  });
}
