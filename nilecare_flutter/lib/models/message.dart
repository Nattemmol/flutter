class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final String type; // 'text', 'image', 'file'
  final String? fileUrl;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    this.fileUrl,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      type: json['type'],
      fileUrl: json['fileUrl'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'type': type,
      'fileUrl': fileUrl,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
