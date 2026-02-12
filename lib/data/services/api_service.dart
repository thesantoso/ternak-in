import '../models/livestock_model.dart';
import '../models/analytics_model.dart';
import '../models/user_model.dart';
import '../models/chat_message_model.dart';

class ApiService {
  // Mock data for dashboard
  Future<List<LivestockModel>> getLivestockData() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    return [
      LivestockModel(
        id: '1',
        name: 'Cattle Barn A',
        type: 'Cattle',
        count: 25,
        health: 'Excellent',
        lastCheckup: DateTime.now().subtract(const Duration(days: 2)),
      ),
      LivestockModel(
        id: '2',
        name: 'Goat Pen B',
        type: 'Goat',
        count: 40,
        health: 'Good',
        lastCheckup: DateTime.now().subtract(const Duration(days: 5)),
      ),
      LivestockModel(
        id: '3',
        name: 'Chicken Coop C',
        type: 'Chicken',
        count: 150,
        health: 'Good',
        lastCheckup: DateTime.now().subtract(const Duration(days: 1)),
      ),
      LivestockModel(
        id: '4',
        name: 'Sheep Farm D',
        type: 'Sheep',
        count: 35,
        health: 'Fair',
        lastCheckup: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ];
  }

  // Mock data for analytics
  Future<List<AnalyticsDataModel>> getAnalyticsData() async {
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      AnalyticsDataModel(
        title: 'Total Livestock',
        value: '250',
        trend: 'up',
        percentage: 12.5,
      ),
      AnalyticsDataModel(
        title: 'Healthy Animals',
        value: '237',
        trend: 'up',
        percentage: 5.2,
      ),
      AnalyticsDataModel(
        title: 'Monthly Production',
        value: '1,250 kg',
        trend: 'up',
        percentage: 8.7,
      ),
      AnalyticsDataModel(
        title: 'Revenue',
        value: '\$15,400',
        trend: 'down',
        percentage: -2.3,
      ),
    ];
  }

  // Mock data for user profile
  Future<UserModel> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return UserModel(
      id: 'user123',
      name: 'John Doe',
      email: 'john.doe@ternakin.com',
      phone: '+1234567890',
      role: 'Farm Manager',
      avatar: null,
    );
  }

  // Mock data for chat messages
  Future<List<ChatMessageModel>> getChatMessages() async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    return [
      ChatMessageModel(
        id: '1',
        message: 'Hello! How can I help you today?',
        sender: 'Support Agent',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      ChatMessageModel(
        id: '2',
        message: 'I need help with livestock health monitoring',
        sender: 'You',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
      ),
      ChatMessageModel(
        id: '3',
        message: 'Sure! I can help you with that. What specific information do you need?',
        sender: 'Support Agent',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
    ];
  }

  // Send chat message
  Future<ChatMessageModel> sendChatMessage(String message) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: message,
      sender: 'You',
      isMe: true,
      timestamp: DateTime.now(),
    );
  }

  // Get auto-reply
  Future<ChatMessageModel> getAutoReply() async {
    await Future.delayed(const Duration(seconds: 1));
    
    final replies = [
      'Thank you for your message. Our team will get back to you shortly.',
      'I understand. Let me check that for you.',
      'That\'s a great question! Here\'s what I can tell you...',
      'I\'m here to help. Could you provide more details?',
    ];
    
    return ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: replies[DateTime.now().second % replies.length],
      sender: 'Support Agent',
      isMe: false,
      timestamp: DateTime.now(),
    );
  }
}
