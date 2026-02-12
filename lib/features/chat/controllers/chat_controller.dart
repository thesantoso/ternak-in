import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/chat_message_model.dart';
import '../../../data/services/api_service.dart';
import '../../../core/errors/error_handler.dart';

class ChatController extends GetxController {
  final ApiService _apiService = Get.find();
  
  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSending = false.obs;
  final TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  Future<void> loadMessages() async {
    try {
      isLoading.value = true;
      final data = await _apiService.getChatMessages();
      messages.value = data;
    } catch (e) {
      ErrorHandler.handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    try {
      isSending.value = true;
      
      // Clear input immediately
      messageController.clear();
      
      // Send message
      final message = await _apiService.sendChatMessage(text);
      messages.add(message);
      
      // Get auto-reply after a delay
      await Future.delayed(const Duration(milliseconds: 500));
      final reply = await _apiService.getAutoReply();
      messages.add(reply);
    } catch (e) {
      ErrorHandler.handleError(e);
    } finally {
      isSending.value = false;
    }
  }

  Future<void> refresh() async {
    await loadMessages();
  }
}
