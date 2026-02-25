class NextEventPlayer {
  final String id;
  final String name;
  final String initials;
  final String? photo;
  final String? position;
  final bool isConfirmed;
  final DateTime? confirmationDate;

  NextEventPlayer._({
    required this.id,
    required this.name,
    required this.initials,
    this.photo,
    this.position,
    this.isConfirmed = false,
    this.confirmationDate,
  });

  factory NextEventPlayer({
    required String id,
    required String name,
    required bool isConfirmed,
    String? photo,
    String? position,
    DateTime? confirmationDate,
  }) => NextEventPlayer._(
    id: id,
    name: name,
    initials: _getInitials(name),
    photo: photo,
    position: position,
    isConfirmed: isConfirmed,
    confirmationDate: confirmationDate,
  );

  static String _getInitials(String name) {
    final names = name.toUpperCase().trim().split(' ');
    final firstChar = names.first.split('').firstOrNull ?? '--';
    final lastChar =
        names.last.split('').elementAtOrNull(names.length == 1 ? 1 : 0) ?? '';

    return '$firstChar$lastChar';
  }
}
