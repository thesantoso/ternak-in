class ChatMessageModel {
  final String id;
  final String message;
  final String sender;
  final bool isMe;
  final DateTime timestamp;

  ChatMessageModel({
    required this.id,
    required this.message,
    required this.sender,
    required this.isMe,
    required this.timestamp,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      message: json['message'] ?? '',
      sender: json['sender'] ?? '',
      isMe: json['isMe'] ?? false,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'sender': sender,
      'isMe': isMe,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
