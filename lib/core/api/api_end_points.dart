import 'api_constants.dart';

class ApiEndPoints {
  // Orders
  static const String createOrder =
      '${ApiConstants.edgeFunctionsBaseUrl}/create_order';

  static const String cancelOrder =
      '${ApiConstants.edgeFunctionsBaseUrl}/cancel_order';

  static const String updateOrderStatus =
      '${ApiConstants.edgeFunctionsBaseUrl}/update_order_status';

  static const String updateOrderNotes =
      '${ApiConstants.edgeFunctionsBaseUrl}/update_order_notes';

  static const String getAllOrders =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_all_orders';

  static const String getOrderDetails =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_order_details';

  static const String getCustomerOrders =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_customer_orders';

  static const String getAssignedOrders =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_assigned_orders';

  static const String assignTechnician =
      '${ApiConstants.edgeFunctionsBaseUrl}/assign_technician';

  // Technicians
  static const String getAllTechnicians =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_all_technicians';

  static const String getTechnicianProfile =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_technician_profile';

  static const String updateTechnicianProfile =
      '${ApiConstants.edgeFunctionsBaseUrl}/update_technician_profile';

  // Customers
  static const String updateCustomerProfile =
      '${ApiConstants.edgeFunctionsBaseUrl}/update_customer_profile';

  // Admins & Roles
  static const String createAdminAccount =
      '${ApiConstants.edgeFunctionsBaseUrl}/create_admin_account';

  static const String getAllAdmins =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_all_admins';

  static const String updateUserRole =
      '${ApiConstants.edgeFunctionsBaseUrl}/update_user_role';

  static const String promoteToSuperAdmin =
      '${ApiConstants.edgeFunctionsBaseUrl}/promote_to_super_admin';

  static const String manageRolePermissions =
      '${ApiConstants.edgeFunctionsBaseUrl}/manage_role_permissions';

  // Categories & Services
  static const String manageCategories =
      '${ApiConstants.edgeFunctionsBaseUrl}/manage_categories';

  static const String manageSubServices =
      '${ApiConstants.edgeFunctionsBaseUrl}/manage_sub_services';

  // Notifications
  static const String saveFcmToken =
      '${ApiConstants.edgeFunctionsBaseUrl}/save_fcm_token';

  static const String sendNotification =
      '${ApiConstants.edgeFunctionsBaseUrl}/send_notification';

  // Reviews
  static const String submitReview =
      '${ApiConstants.edgeFunctionsBaseUrl}/submit_review';

  // Uploads
  static const String uploadImages =
      '${ApiConstants.edgeFunctionsBaseUrl}/upload_images';

  static const String registerUser =
      '${ApiConstants.edgeFunctionsBaseUrl}/register_user';

  static const String deleteUser =
      '${ApiConstants.edgeFunctionsBaseUrl}/delete_user';

  static const String getCurrentUser =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_current_user';

  static const String login = '${ApiConstants.edgeFunctionsBaseUrl}/login_user';
  static const String getAllServices =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_all_services';
  static const String createVideoUploadUrl =
      '${ApiConstants.edgeFunctionsBaseUrl}/create_video_upload_url';
  static const String googleSignIn =
      '${ApiConstants.edgeFunctionsBaseUrl}/google_auth';
  static const String getNotifications =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_notifications';
  static const String markNotificationAsRead =
      '${ApiConstants.edgeFunctionsBaseUrl}/mark_notification_read';
  static const String markAllNotificationsAsRead =
      '${ApiConstants.edgeFunctionsBaseUrl}/mark_all_notifications_as_read';
  static const String unreadNotificationCount =
      '${ApiConstants.edgeFunctionsBaseUrl}/unread_notifications_count';
  static const String deleteAccount =
      '${ApiConstants.edgeFunctionsBaseUrl}/delete_account';
  static const String deleteNotification =
      '${ApiConstants.edgeFunctionsBaseUrl}/soft_delete_notification';
  static const String updatePassword =
      '${ApiConstants.edgeFunctionsBaseUrl}/update-password';
  static const String sendResetPassword =
      '${ApiConstants.edgeFunctionsBaseUrl}/send-reset-password';
  static const String getBanners =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_banners';
  static const String getRequestPriorities =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_request_priorities';
  static const String getServiceAreas =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_service_areas';
      static const String addReview =
      '${ApiConstants.edgeFunctionsBaseUrl}/add_review';
      static const String getReviews =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_user_reviews';
      static const String hasReview =
      '${ApiConstants.edgeFunctionsBaseUrl}/has_review';
 static const String manageSparePart =
      '${ApiConstants.edgeFunctionsBaseUrl}/manage_spare_part';
  static const verifyOtp = "${ApiConstants.edgeFunctionsBaseUrl}/verify-otp";
 static const String getSpareParts =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_spare_parts';
      static const String getTermsAndCondiations =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_documents';
      static const String getInvoiceByOrderId =
      '${ApiConstants.edgeFunctionsBaseUrl}/get_invoice';

       static const String sendOtp =
      '${ApiConstants.edgeFunctionsBaseUrl}/send-otp';
}
