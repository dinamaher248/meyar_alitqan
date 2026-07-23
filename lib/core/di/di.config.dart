// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/auth/data/data_sources/remote/auth_remote_data_sources/delete_account_remote_data_source/delete_account_remote_data_source.dart'
    as _i282;
import '../../features/auth/data/data_sources/remote/auth_remote_data_sources/forget_password_remote_data_source/forget_password_remote_data_source.dart'
    as _i706;
import '../../features/auth/data/data_sources/remote/auth_remote_data_sources/google_remote_data_source/google_remote_data_source.dart'
    as _i979;
import '../../features/auth/data/data_sources/remote/auth_remote_data_sources/login_remote_data_source/login_remote_data_source.dart'
    as _i106;
import '../../features/auth/data/data_sources/remote/auth_remote_data_sources/register_remote_data_source/register_remote_data_source.dart'
    as _i757;
import '../../features/auth/data/data_sources/remote/auth_remote_data_sources/reset_password_remote_data_source/reset_password_remote_data_source.dart'
    as _i523;
import '../../features/auth/data/data_sources/remote/auth_remote_data_sources/save_fcm_token_remote_data_source/save_fcm_token_remote_data_source.dart'
    as _i419;
import '../../features/auth/data/data_sources_impl/remote/auth_remote_data_sources_impl/delete_account_remote_data_source_impl/delete_account_remote_data_source_impl.dart'
    as _i72;
import '../../features/auth/data/data_sources_impl/remote/auth_remote_data_sources_impl/forget_password_remote_data_source_impl/forget_password_remote_data_source_impl.dart'
    as _i133;
import '../../features/auth/data/data_sources_impl/remote/auth_remote_data_sources_impl/google_remote_data_source_impl/google_remote_data_source_impl.dart'
    as _i613;
import '../../features/auth/data/data_sources_impl/remote/auth_remote_data_sources_impl/login_remote_data_source_impl/login_remote_data_source_impl.dart'
    as _i922;
import '../../features/auth/data/data_sources_impl/remote/auth_remote_data_sources_impl/register_remote_data_source_impl/register_remote_data_source_impl.dart'
    as _i269;
import '../../features/auth/data/data_sources_impl/remote/auth_remote_data_sources_impl/reset_password_remote_data_source_impl/reset_password_remote_data_source_impl.dart'
    as _i699;
import '../../features/auth/data/data_sources_impl/remote/auth_remote_data_sources_impl/save_fcm_token_remote_data_source_impl/save_fcm_token_remote_data_source_impl.dart'
    as _i595;
import '../../features/auth/data/repositories_impl/auth_repositories_impl/delete_account_repo_impl/delete_account_repo_impl.dart'
    as _i639;
import '../../features/auth/data/repositories_impl/auth_repositories_impl/forget_password_repo_impl/forget_password_repo_impl.dart'
    as _i293;
import '../../features/auth/data/repositories_impl/auth_repositories_impl/google_repo_impl/google_repo_impl.dart'
    as _i1021;
import '../../features/auth/data/repositories_impl/auth_repositories_impl/login_repo_impl/login_repo_impl.dart'
    as _i399;
import '../../features/auth/data/repositories_impl/auth_repositories_impl/register_repo_impl/register_repo_impl.dart'
    as _i57;
import '../../features/auth/data/repositories_impl/auth_repositories_impl/reset_password_repo_impl/reset_password_repo_impl.dart'
    as _i565;
import '../../features/auth/data/repositories_impl/auth_repositories_impl/save_fcm_token_repo_impl/save_fcm_token_repo_impl.dart'
    as _i888;
import '../../features/auth/domain/repositories/auth_repositories/delete_account_repo/delete_account_repo.dart'
    as _i823;
import '../../features/auth/domain/repositories/auth_repositories/forget_password_repo/forget_password_repo.dart'
    as _i344;
import '../../features/auth/domain/repositories/auth_repositories/google_repo/google_repo.dart'
    as _i356;
import '../../features/auth/domain/repositories/auth_repositories/login_repo/login_repo.dart'
    as _i630;
import '../../features/auth/domain/repositories/auth_repositories/register_repo/register_repo.dart'
    as _i744;
import '../../features/auth/domain/repositories/auth_repositories/reset_password_repo/reset_password_repo.dart'
    as _i1023;
import '../../features/auth/domain/repositories/auth_repositories/save_fcm_token_repo/save_fcm_token_repo.dart'
    as _i403;
import '../../features/auth/domain/use_cases/auth_use_cases/delete_account_usecase/delete_account_usecase.dart'
    as _i49;
import '../../features/auth/domain/use_cases/auth_use_cases/forget_password_use_case/forget_password_use_case.dart'
    as _i331;
import '../../features/auth/domain/use_cases/auth_use_cases/google_use_case/google_use_case.dart'
    as _i77;
import '../../features/auth/domain/use_cases/auth_use_cases/login_usecase/login_usecase.dart'
    as _i745;
import '../../features/auth/domain/use_cases/auth_use_cases/register_usecase/register_usecase.dart'
    as _i964;
import '../../features/auth/domain/use_cases/auth_use_cases/reset_password_use_case/reset_password_use_case.dart'
    as _i517;
import '../../features/auth/domain/use_cases/auth_use_cases/save_fcm_token_usecase/save_fcm_token_usecase.dart'
    as _i568;
import '../../features/auth/domain/use_cases/auth_use_cases/verify_otp_use_case/verify_otp_use_case.dart'
    as _i30;
import '../../features/auth/presentation/manager/complete_profile_view_model/complete_profile_view_model.dart'
    as _i99;
import '../../features/auth/presentation/manager/delete_account_view_model/delete_account_view_model.dart'
    as _i710;
import '../../features/auth/presentation/manager/forget_password_view_model/forget_password_view_model.dart'
    as _i33;
import '../../features/auth/presentation/manager/google_auth_view_model/google_auth_view_model.dart'
    as _i157;
import '../../features/auth/presentation/manager/login_view_model/login_view_model.dart'
    as _i573;
import '../../features/auth/presentation/manager/register_view_model/register_view_model.dart'
    as _i19;
import '../../features/auth/presentation/manager/reset_password_view_model/reset_password_view_model.dart'
    as _i268;
import '../../features/auth/presentation/manager/save_fcm_token_view_model/save_fcm_token_view_model.dart'
    as _i18;
import '../../features/auth/presentation/manager/verify_otp_view_model/verify_otp_view_model.dart'
    as _i582;
import '../../features/banners/data/data_source/remote/get_banners_remote_data_source/get_banners_remote_data_source.dart'
    as _i141;
import '../../features/banners/data/data_source_impl/remote/get_banners_remote_data_source_impl/get_banners_remote_data_source_impl.dart'
    as _i193;
import '../../features/banners/data/repos_impl/get_banners_repo_impl/get_banners_repo_impl.dart'
    as _i567;
import '../../features/banners/domain/repos/get_banners_repo/get_banners_repo.dart'
    as _i70;
import '../../features/banners/domain/use_cases/get_banners_use_case/get_banners_use_case.dart'
    as _i859;
import '../../features/banners/presentation/manager/get_banners_view_model/get_banners_view_model.dart'
    as _i122;
import '../../features/location/data/data_sources/remote/location_remote_data_source/get_current_location_remote_data_source/get_current_location_remote_data_source.dart'
    as _i91;
import '../../features/location/data/data_sources/remote/service_areas_remote_data_source/get_service_areas_remote_data_source/get_service_areas_remote_data_source.dart'
    as _i483;
import '../../features/location/data/data_sources_impl/remote/location_remote_data_source/get_current_location_remote_data_source_impl/get_current_location_remote_data_source_impl.dart'
    as _i936;
import '../../features/location/data/data_sources_impl/remote/service_areas_remote_data_source_impl/get_service_areas_remote_data_source_impl/get_service_areas_remote_data_source_impl.dart'
    as _i304;
import '../../features/location/data/repositories_impl/locations_repo_impl/get_current_location_repo_impl/get_current_location_repo_impl.dart'
    as _i170;
import '../../features/location/data/repositories_impl/service_areas_repos_impl/get_service_areas_repo_impl/get_service_areas_repo_impl.dart'
    as _i995;
import '../../features/location/domain/repositories/location_repos/get_current_location_repo/get_current_location_repo.dart'
    as _i345;
import '../../features/location/domain/repositories/service_areas_repos/get_service_areas_repo/get_service_areas_repo.dart'
    as _i929;
import '../../features/location/domain/use_cases/location_use_cases/get_current_location_use_case/get_current_location_use_case.dart'
    as _i1018;
import '../../features/location/domain/use_cases/service_areas_use_case/get_service_areas_use_case/get_service_areas_use_case.dart'
    as _i905;
import '../../features/location/presentation/manager/get_current_location_view_model/get_current_location_view_model.dart'
    as _i438;
import '../../features/location/presentation/manager/get_service_areas_view_model/get_service_areas_view_model.dart'
    as _i764;
import '../../features/notifications/data/data_sources/remote/delete_notification_data_remote_data_source/delete_notification_data_remote_data_source.dart'
    as _i609;
import '../../features/notifications/data/data_sources/remote/get_notifications_remote_data_source/get_notifications_remote_data_source.dart'
    as _i243;
import '../../features/notifications/data/data_sources/remote/mark_notification_as_read_remote_data_source/mark_notification_as_read_remote_data_source.dart'
    as _i33;
import '../../features/notifications/data/data_sources/remote/send_notifications_remote_data_source/send_notifications_remote_data_source.dart'
    as _i919;
import '../../features/notifications/data/data_sources/remote/unread_notifications_count_remote_data_source/unread_notifications_count_remote_data_source.dart'
    as _i348;
import '../../features/notifications/data/data_sources_impl/remote/delete_notification_data_remote_data_source_impl/delete_notification_data_remote_data_source_impl.dart'
    as _i371;
import '../../features/notifications/data/data_sources_impl/remote/get_notifications_remote_data_source_impl/get_notifications_remote_data_source_impl.dart'
    as _i698;
import '../../features/notifications/data/data_sources_impl/remote/mark_notification_as_read_remote_data_source_impl/mark_notification_as_read_remote_data_source_impl.dart'
    as _i876;
import '../../features/notifications/data/data_sources_impl/remote/send_notifications_remote_data_source_impl/send_notifications_remote_data_source_impl.dart'
    as _i418;
import '../../features/notifications/data/data_sources_impl/remote/unread_notifications_count_remote_data_source_impl/unread_notifications_count_remote_data_source_impl.dart'
    as _i935;
import '../../features/notifications/data/repositories_impl/delete_notification_data_repo_impl/delete_notification_data_repo_impl.dart'
    as _i13;
import '../../features/notifications/data/repositories_impl/get_notifications_repo_impl/get_notifications_repo_impl.dart'
    as _i147;
import '../../features/notifications/data/repositories_impl/mark_notification_as_read_repo_impl/mark_notification_as_read_repo_impl.dart'
    as _i315;
import '../../features/notifications/data/repositories_impl/send_notifications_repo_impl/send_notifications_repo_impl.dart'
    as _i453;
import '../../features/notifications/data/repositories_impl/unread_notifications_count_repo_impl/unread_notifications_count_repo_impl.dart'
    as _i247;
import '../../features/notifications/domain/repositories/delete_notification_data_repo/delete_notification_data_repo.dart'
    as _i721;
import '../../features/notifications/domain/repositories/get_notifications_repo/get_notifications_repo.dart'
    as _i999;
import '../../features/notifications/domain/repositories/mark_notification_as_read_repo/mark_notification_as_read_repo.dart'
    as _i930;
import '../../features/notifications/domain/repositories/send_notifications_repo/send_notifications_repo.dart'
    as _i772;
import '../../features/notifications/domain/repositories/unread_notifications_count_repo/unread_notifications_count_repo.dart'
    as _i392;
import '../../features/notifications/domain/use_cases/delete_notification_data_use_case/delete_notification_data_use_case.dart'
    as _i157;
import '../../features/notifications/domain/use_cases/get_notifications_use_case/get_notifications_use_case.dart'
    as _i1053;
import '../../features/notifications/domain/use_cases/mark_notification_as_read_use_case/mark_notification_as_read_use_case.dart'
    as _i299;
import '../../features/notifications/domain/use_cases/send_notifications_use_case/send_notifications_use_case.dart'
    as _i908;
import '../../features/notifications/domain/use_cases/unread_notifications_count_use_case/unread_notifications_count_use_case.dart'
    as _i589;
import '../../features/notifications/presentation/manager/delete_notification_data_view_model/delete_notification_data_view_model.dart'
    as _i837;
import '../../features/notifications/presentation/manager/get_notifications_view_model/get_notifications_view_model.dart'
    as _i378;
import '../../features/notifications/presentation/manager/mark_notification_as_read_view_model/mark_notification_as_read_view_model.dart'
    as _i841;
import '../../features/notifications/presentation/manager/send_notifications_view_model/send_notifications_view_model.dart'
    as _i231;
import '../../features/notifications/presentation/manager/unread_notifications_count_view_model/unread_notifications_count_view_model.dart'
    as _i219;
import '../../features/onboarding/presentation/manager/onboarding_view_model.dart'
    as _i914;
import '../../features/orders/customer/data/data_sources/remote/orders_remote_data_source/cancel_order_remote_data_source/cancel_order_remote_data_source.dart'
    as _i244;
import '../../features/orders/customer/data/data_sources/remote/orders_remote_data_source/create_order_remote_data_source/create_order_remote_data_source.dart'
    as _i237;
import '../../features/orders/customer/data/data_sources/remote/orders_remote_data_source/get_customer_orders_remote_data_source/get_customer_orders_remote_data_source.dart'
    as _i373;
import '../../features/orders/customer/data/data_sources_impl/remote/orders_remote_data_source_impl/cancel_order_remote_data_source_impl/cancel_order_remote_data_source_impl.dart'
    as _i1061;
import '../../features/orders/customer/data/data_sources_impl/remote/orders_remote_data_source_impl/create_order_remote_data_source_impl/create_order_remote_data_source_impl.dart'
    as _i869;
import '../../features/orders/customer/data/data_sources_impl/remote/orders_remote_data_source_impl/get_customer_orders_remote_data_source_impl/get_customer_orders_remote_data_source_impl.dart'
    as _i344;
import '../../features/orders/customer/data/repositories_impl/orders_repos_impl/cancel_order_repo_impl/cancel_order_repo_impl.dart'
    as _i10;
import '../../features/orders/customer/data/repositories_impl/orders_repos_impl/create_order_repo_impl/create_order_repo_impl.dart'
    as _i137;
import '../../features/orders/customer/data/repositories_impl/orders_repos_impl/get_customer_orders_repo_impl/get_customer_orders_repo_impl.dart'
    as _i872;
import '../../features/orders/customer/domain/repositories/orders_repos/cancel_order_repo/cancel_order_repo.dart'
    as _i658;
import '../../features/orders/customer/domain/repositories/orders_repos/create_order_repo/create_order_repo.dart'
    as _i400;
import '../../features/orders/customer/domain/repositories/orders_repos/get_customer_orders_repo/get_customer_orders_repo.dart'
    as _i494;
import '../../features/orders/customer/domain/use_cases/orders_use_cases/cancel_order_use_case/cancel_order_use_case.dart'
    as _i232;
import '../../features/orders/customer/domain/use_cases/orders_use_cases/create_order_use_case/create_order_use_case.dart'
    as _i193;
import '../../features/orders/customer/domain/use_cases/orders_use_cases/get_customer_orders_use_case/get_customer_orders_use_case.dart'
    as _i711;
import '../../features/orders/customer/presentation/manager/cancel_order_view_model/cancel_order_view_model.dart'
    as _i306;
import '../../features/orders/customer/presentation/manager/create_order_view_model/create_order_view_model.dart'
    as _i632;
import '../../features/orders/customer/presentation/manager/get_customer_orders_view_model/get_customer_orders_view_model.dart'
    as _i432;
import '../../features/orders/shared/data/data_sources/remote/get_order_details_remote_data_source/get_order_details_remote_data_source.dart'
    as _i82;
import '../../features/orders/shared/data/data_sources/remote/invoice_remote_data_source/invoice_remote_data_source.dart'
    as _i734;
import '../../features/orders/shared/data/data_sources_impl/remote/get_order_details_remote_data_source_impl/get_order_details_remote_data_source_impl.dart'
    as _i102;
import '../../features/orders/shared/data/data_sources_impl/remote/invoice_remote_data_source_impl/invoice_remote_data_source_impl.dart'
    as _i454;
import '../../features/orders/shared/data/repositories_impl/get_order_details_repo_impl/get_order_details_repo_impl.dart'
    as _i762;
import '../../features/orders/shared/data/repositories_impl/invoice_repo_impl/invoice_repo_impl.dart'
    as _i882;
import '../../features/orders/shared/domain/repositories/get_order_details_repo/get_order_details_repo.dart'
    as _i674;
import '../../features/orders/shared/domain/repositories/invoice_repo/invoice_repo.dart'
    as _i270;
import '../../features/orders/shared/domain/use_cases/get_order_details_use_case/get_order_details_use_case.dart'
    as _i411;
import '../../features/orders/shared/domain/use_cases/invoice_use_case/invoice_use_case.dart'
    as _i744;
import '../../features/orders/shared/presentation/manager/get_invoice_view_model/get_invoice_view_model.dart'
    as _i481;
import '../../features/orders/shared/presentation/manager/get_order_details_view_model/get_order_details_view_model.dart'
    as _i9;
import '../../features/orders/technician/data/data_sources/remote/orders_remote_data_source/get_technician_orders_remote_data_source/get_technician_orders_remote_data_source.dart'
    as _i903;
import '../../features/orders/technician/data/data_sources/remote/orders_remote_data_source/update_order_status_remote_data_source/update_order_status_remote_data_source.dart'
    as _i425;
import '../../features/orders/technician/data/data_sources_impl/remote/orders_remote_data_source_impl/get_technician_orders_remote_data_source_impl/get_technician_orders_remote_data_source_impl.dart'
    as _i381;
import '../../features/orders/technician/data/data_sources_impl/remote/orders_remote_data_source_impl/update_order_status_remote_data_source_impl/update_order_status_remote_data_source_impl.dart'
    as _i937;
import '../../features/orders/technician/data/realtime/order_realtime_service.dart'
    as _i505;
import '../../features/orders/technician/data/repositories_impl/orders_repos_impl/get_technician_orders_repo_impl/get_technician_orders_repo_impl.dart'
    as _i587;
import '../../features/orders/technician/data/repositories_impl/orders_repos_impl/update_order_status_repo_impl/update_order_status_repo_impl.dart'
    as _i976;
import '../../features/orders/technician/domain/repositories/orders_repos/get_technician_orders_repo/get_technician_orders_repo.dart'
    as _i623;
import '../../features/orders/technician/domain/repositories/orders_repos/update_order_status_repo/update_order_status_repo.dart'
    as _i296;
import '../../features/orders/technician/domain/use_cases/orders_use_case/get_technician_orders_use_case/get_technician_orders_use_case.dart'
    as _i333;
import '../../features/orders/technician/domain/use_cases/orders_use_case/update_order_status_use_case/update_order_status_use_case.dart'
    as _i842;
import '../../features/orders/technician/presentation/manager/get_technician_orders_view_model/get_technician_orders_view_model.dart'
    as _i937;
import '../../features/orders/technician/presentation/manager/update_order_status_view_model/update_order_status_view_model.dart'
    as _i838;
import '../../features/profile/customer/data/data_sources/remote/profile_remote_data_sources/update_customer_profile_remote_data_source/update_customer_profile_remote_data_source.dart'
    as _i860;
import '../../features/profile/customer/data/data_sources_impl/remote/profile_remote_data_sources_impl/update_customer_profile_remote_data_source_impl/update_customer_profile_remote_data_source_impl.dart'
    as _i699;
import '../../features/profile/customer/data/repositories_impl/profile_repos_impl/update_customer_profile_repo_impl/update_customer_profile_repo_impl.dart'
    as _i652;
import '../../features/profile/customer/domain/repositories/profile_repo/update_customer_profile_repo/update_customer_profile_repo.dart'
    as _i36;
import '../../features/profile/customer/domain/use_cases/profile_use_cases/update_customer_profile_use_case/update_customer_profile_use_case.dart'
    as _i400;
import '../../features/profile/customer/presentation/manager/update_customer_profile_view_model/update_customer_profile_view_model.dart'
    as _i1006;
import '../../features/profile/shared/data/data_sources/remote/get_current_user_remote_data_source/get_current_user_remote_data_source.dart'
    as _i932;
import '../../features/profile/shared/data/data_sources/remote/get_terms_and_condiations_remote_data_source/get_terms_and_condiations_remote_data_source.dart'
    as _i379;
import '../../features/profile/shared/data/data_sources_impl/remote/get_current_user_remote_data_source_impl/get_current_user_remote_data_source_impl.dart'
    as _i489;
import '../../features/profile/shared/data/data_sources_impl/remote/get_terms_and_condiations_remote_data_source_impl/get_terms_and_condiations_remote_data_source_impl.dart'
    as _i895;
import '../../features/profile/shared/data/repositories_impl/get_current_user_repo_impl/get_current_user_repo_impl.dart'
    as _i555;
import '../../features/profile/shared/data/repositories_impl/get_terms_and_condiations_repo_impl/get_terms_and_condiations_repo_impl.dart'
    as _i148;
import '../../features/profile/shared/domain/repositories/get_current_user_repo/get_current_user_repo.dart'
    as _i961;
import '../../features/profile/shared/domain/repositories/get_terms_and_condiations_repo/get_terms_and_condiations_repo.dart'
    as _i695;
import '../../features/profile/shared/domain/use_cases/get_current_user_usecase/get_current_user_usecase.dart'
    as _i86;
import '../../features/profile/shared/domain/use_cases/get_terms_and_condiations_use_case/get_terms_and_condiations_use_case.dart'
    as _i977;
import '../../features/profile/shared/presentation/manager/get_current_user_view_model/get_current_user_view_model.dart'
    as _i1026;
import '../../features/profile/shared/presentation/manager/get_terms_and_condiations_view_model/get_terms_and_condiations_view_model.dart'
    as _i1004;
import '../../features/profile/shared/presentation/manager/language_view_model/language_view_model.dart'
    as _i764;
import '../../features/profile/techinican/data/data_sources/remote/profile_remote_data_sources/update_technician_profile_remote_data_source/update_technician_profile_remote_data_source.dart'
    as _i149;
import '../../features/profile/techinican/data/data_sources_impl/remote/profile_remote_data_sources_impl/update_technician_profile_remote_data_source_impl/update_technician_profile_remote_data_source_impl.dart'
    as _i540;
import '../../features/profile/techinican/data/repositories_impl/profile_repos_impl/update_technician_profile_repo_impl/update_technician_profile_repo_impl.dart'
    as _i273;
import '../../features/profile/techinican/domain/repositories/profile_repo/update_technician_profile_repo/update_technician_profile_repo.dart'
    as _i980;
import '../../features/profile/techinican/domain/use_cases/profile_use_cases/update_technician_profile_use_case/update_technician_profile_use_case.dart'
    as _i901;
import '../../features/profile/techinican/presentation/manager/update_techinican_profile_view_model/update_technician_profile_view_model.dart'
    as _i1017;
import '../../features/reviews/data/data_source/remote/add_review_remote_data_source/add_review_remote_data_source.dart'
    as _i124;
import '../../features/reviews/data/data_source/remote/get_review_remote_data_source/get_review_remote_data_source.dart'
    as _i694;
import '../../features/reviews/data/data_source/remote/has_review_remote_data_source/has_review_remote_data_source.dart'
    as _i638;
import '../../features/reviews/data/data_source_impl/remote/add_review_remote_data_source_impl/add_review_remote_data_source_impl.dart'
    as _i479;
import '../../features/reviews/data/data_source_impl/remote/get_review_remote_data_source_impl/get_review_remote_data_source_impl.dart'
    as _i412;
import '../../features/reviews/data/data_source_impl/remote/has_review_remote_data_source_impl/has_review_remote_data_source_impl.dart'
    as _i330;
import '../../features/reviews/data/repos_impl/add_review_repo_impl/add_review_repo_impl.dart'
    as _i123;
import '../../features/reviews/data/repos_impl/get_review_repo_impl/get_review_repo_impl.dart'
    as _i171;
import '../../features/reviews/data/repos_impl/has_review_repo_impl/has_review_repo_impl.dart'
    as _i346;
import '../../features/reviews/domain/repos/add_review_repo/add_review_repo.dart'
    as _i640;
import '../../features/reviews/domain/repos/get_review_repo/get_review_repo.dart'
    as _i87;
import '../../features/reviews/domain/repos/has_review_repo/has_review_repo.dart'
    as _i626;
import '../../features/reviews/domain/use_cases/add_review_use_case/add_review_use_case.dart'
    as _i552;
import '../../features/reviews/domain/use_cases/get_reviews_use_case/get_reviews_use_case.dart'
    as _i753;
import '../../features/reviews/domain/use_cases/has_review_use_case/has_review_use_case.dart'
    as _i792;
import '../../features/reviews/presentation/manager/add_review_view_model/add_review_view_model.dart'
    as _i559;
import '../../features/reviews/presentation/manager/get_review_view_model/get_review_view_model.dart'
    as _i411;
import '../../features/reviews/presentation/manager/has_review_view_model/has_review_view_model.dart'
    as _i765;
import '../../features/services/data/data_sources/remote/categories_remote_data_source/get_main_categories_remote_data_source/get_main_categories_remote_data_source.dart'
    as _i71;
import '../../features/services/data/data_sources/remote/categories_remote_data_source/get_services_by_sub_remote_data_source/get_services_by_sub_remote_data_source.dart'
    as _i425;
import '../../features/services/data/data_sources/remote/categories_remote_data_source/get_sub_categories_remote_data_source/get_sub_categories_remote_data_source.dart'
    as _i450;
import '../../features/services/data/data_sources/remote/request_priority_remote_data_sources/get_request_priority_remote_data_source/get_request_priority_remote_data_source.dart'
    as _i810;
import '../../features/services/data/data_sources_impl/remote/categories_remote_data_source_impl/get_main_categories_remote_data_source_impl/get_main_categories_remote_data_source_impl.dart'
    as _i523;
import '../../features/services/data/data_sources_impl/remote/categories_remote_data_source_impl/get_services_by_sub_remote_data_source_impl/get_services_by_sub_remote_data_source_impl.dart'
    as _i180;
import '../../features/services/data/data_sources_impl/remote/categories_remote_data_source_impl/get_sub_categories_remote_data_source_impl/get_sub_categories_remote_data_source_impl.dart'
    as _i53;
import '../../features/services/data/data_sources_impl/remote/request_priority_remote_data_sources_impl/get_request_priority_remote_data_source_impl/get_request_priority_remote_data_source_impl.dart'
    as _i214;
import '../../features/services/data/repositories_impl/categories_repos_impl/get_main_categories_repo_impl/get_main_categories_repo_impl.dart'
    as _i910;
import '../../features/services/data/repositories_impl/categories_repos_impl/get_services_by_sub_repo_impl/get_services_by_sub_repo_impl.dart'
    as _i748;
import '../../features/services/data/repositories_impl/categories_repos_impl/get_sub_categories_repo_impl/get_sub_categories_repo_impl.dart'
    as _i104;
import '../../features/services/data/repositories_impl/request_priority_repos_impl/get_request_priority_repo_impl/get_request_priority_repo_impl.dart'
    as _i13;
import '../../features/services/domain/repositories/categories_repos/get_main_categories_repo/get_main_categories_repo.dart'
    as _i207;
import '../../features/services/domain/repositories/categories_repos/get_services_by_sub_repo/get_services_by_sub_repo.dart'
    as _i466;
import '../../features/services/domain/repositories/categories_repos/get_sub_categories_repo/get_sub_categories_repo.dart'
    as _i261;
import '../../features/services/domain/repositories/request_priority_repos/get_request_priority_repo/get_request_priority_repo.dart'
    as _i984;
import '../../features/services/domain/use_cases/categories_use_cases/get_main_categories_use_case/get_main_categories_use_case.dart'
    as _i111;
import '../../features/services/domain/use_cases/categories_use_cases/get_services_by_sub_use_case/get_services_by_sub_use_case.dart'
    as _i196;
import '../../features/services/domain/use_cases/categories_use_cases/get_sub_categories_use_case/get_sub_categories_use_case.dart'
    as _i1025;
import '../../features/services/domain/use_cases/request_priority_use_cases/get_request_priority_use_case/get_request_priority_use_case.dart'
    as _i48;
import '../../features/services/presentation/manager/get_main_categories_view_model/get_main_categories_view_model.dart'
    as _i934;
import '../../features/services/presentation/manager/get_request_priority_view_model/get_request_priority_view_model.dart'
    as _i445;
import '../../features/services/presentation/manager/get_serives_by_sub_view_model/get_serives_by_sub_view_model.dart'
    as _i899;
import '../../features/services/presentation/manager/get_sub_categories_view_model/get_sub_categories_view_model.dart'
    as _i952;
import '../../features/spare_parts/data/data_source/remote/add_spare_part_remote_data_source/add_spare_part_remote_data_source.dart'
    as _i8;
import '../../features/spare_parts/data/data_source/remote/get_spare_part_remote_data_source/get_spare_part_remote_data_source.dart'
    as _i798;
import '../../features/spare_parts/data/data_source_impl/remote/add_spare_part_remote_data_source_impl/add_spare_part_remote_data_source_impl.dart'
    as _i1028;
import '../../features/spare_parts/data/data_source_impl/remote/get_spare_part_remote_data_source_impl/get_spare_part_remote_data_source_impl.dart'
    as _i543;
import '../../features/spare_parts/data/repos_impl/add_spare_part_repo_impl/add_spare_part_repo_impl.dart'
    as _i32;
import '../../features/spare_parts/data/repos_impl/get_spare_part_repo_impl/get_spare_part_repo_impl.dart'
    as _i981;
import '../../features/spare_parts/domain/repos/add_spare_part_repo/add_spare_part_repo.dart'
    as _i237;
import '../../features/spare_parts/domain/repos/get_spare_part_repo/get_spare_part_repo.dart'
    as _i407;
import '../../features/spare_parts/domain/use_cases/add_spare_part_use_case/add_spare_part_use_case.dart'
    as _i1072;
import '../../features/spare_parts/domain/use_cases/get_spare_part_use_case/get_spare_part_use_case.dart'
    as _i119;
import '../../features/spare_parts/presentation/manager/add_spare_part_view_model/add_spare_part_view_model.dart'
    as _i584;
import '../../features/spare_parts/presentation/manager/get_spare_part_view_model/get_spare_part_view_model.dart'
    as _i467;
import '../../features/splash/presentation/manager/splash_view_model.dart'
    as _i984;
import '../../features/uploads/data/data_sources/remote/upload_images_remote_data_source/upload_images_remote_data_source.dart'
    as _i245;
import '../../features/uploads/data/data_sources/remote/upload_video_remote_data_source/upload_video_remote_data_source.dart'
    as _i696;
import '../../features/uploads/data/data_sources_impl/remote/upload_images_remote_data_source_impl/upload_images_remote_data_source_impl.dart'
    as _i393;
import '../../features/uploads/data/data_sources_impl/remote/upload_video_remote_data_source_impl/upload_video_remote_data_source_impl.dart'
    as _i779;
import '../../features/uploads/data/repositories_impl/upload_images_repo_impl/upload_images_repo_impl.dart'
    as _i11;
import '../../features/uploads/data/repositories_impl/upload_video_repo_impl/upload_video_repo_impl.dart'
    as _i548;
import '../../features/uploads/domain/repositories/upload_images_repo/upload_images_repo.dart'
    as _i128;
import '../../features/uploads/domain/repositories/upload_video_repo/upload_video_repo.dart'
    as _i800;
import '../../features/uploads/domain/use_cases/upload_images_use_case/upload_images_use_case.dart'
    as _i50;
import '../../features/uploads/domain/use_cases/upload_video_use_case/upload_video_use_case.dart'
    as _i444;
import '../../features/uploads/presentation/manager/upload_images_view_model/upload_images_view_model.dart'
    as _i257;
import '../../features/uploads/presentation/manager/upload_video_view_model/upload_video_view_model.dart'
    as _i368;
import '../api/api_manager.dart' as _i1047;
import '../cubit/app_user/app_user_cubit.dart' as _i204;
import '../network/dio_module.dart' as _i614;
import '../services/secure_storage_service.dart' as _i535;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.factory<_i99.CompleteProfileViewModel>(
      () => _i99.CompleteProfileViewModel(),
    );
    gh.factory<_i914.OnboardingViewModel>(() => _i914.OnboardingViewModel());
    gh.factory<_i53.GetSubCategoriesRemoteDataSourceImpl>(
      () => _i53.GetSubCategoriesRemoteDataSourceImpl(),
    );
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.singleton<_i535.SecureStorageService>(
      () => _i535.SecureStorageService(),
    );
    gh.singleton<_i764.LanguageCubit>(() => _i764.LanguageCubit());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio());
    gh.factory<_i124.AddReviewRemoteDataSource>(
      () => _i479.AddReviewRemoteDataSourceImpl(),
    );
    gh.factory<_i640.AddReviewRepo>(
      () => _i123.AddReviewRepoImpl(gh<_i124.AddReviewRemoteDataSource>()),
    );
    gh.factory<_i33.MarkNotificationAsReadRemoteDataSource>(
      () => _i876.MarkNotificationAsReadRemoteDataSourceImpl(),
    );
    gh.factory<_i425.UpdateOrderStatusRemoteDataSource>(
      () => _i937.UpdateOrderStatusRemoteDataSourceImpl(),
    );
    gh.factory<_i149.UpdateTechnicianProfileRemoteDataSource>(
      () => _i540.UpdateTechnicianProfileRemoteDataSourceImpl(),
    );
    gh.factory<_i237.CreateOrderRemoteDataSource>(
      () => _i869.CreateOrderRemoteDataSourceImpl(),
    );
    gh.factory<_i798.GetSparePartRemoteDataSource>(
      () => _i543.GetSparePartRemoteDataSourceImpl(),
    );
    gh.factory<_i82.GetOrderDetailsRemoteDataSource>(
      () => _i102.GetOrderDetailsRemoteDataSourceImpl(),
    );
    gh.factory<_i348.UnreadNotificationsCountRemoteDataSource>(
      () => _i935.UnreadNotificationsCountRemoteDataSourceImpl(),
    );
    gh.factory<_i483.GetServiceAreasRemoteDataSource>(
      () => _i304.GetServiceAreasRemoteDataSourceImpl(),
    );
    gh.factory<_i919.SendNotificationsRemoteDataSource>(
      () => _i418.SendNotificationsRemoteDataSourceImpl(),
    );
    gh.factory<_i860.UpdateCustomerProfileRemoteDataSource>(
      () => _i699.UpdateCustomerProfileRemoteDataSourceImpl(),
    );
    gh.factory<_i419.SaveFcmTokenRemoteDataSource>(
      () => _i595.SaveFcmTokenRemoteDataSourceImpl(),
    );
    gh.factory<_i734.InvoiceRemoteDataSource>(
      () => _i454.InvoiceRemoteDataSourceImpl(),
    );
    gh.factory<_i8.AddSparePartRemoteDataSource>(
      () => _i1028.AddSparePartRemoteDataSourceImpl(),
    );
    gh.factory<_i237.AddSparePartRepo>(
      () => _i32.AddSparePartRepoImpl(gh<_i8.AddSparePartRemoteDataSource>()),
    );
    gh.factory<_i694.GetReviewRemoteDataSource>(
      () => _i412.GetReviewRemoteDataSourceImpl(),
    );
    gh.factory<_i373.GetCustomerOrdersRemoteDataSource>(
      () => _i344.GetCustomerOrdersRemoteDataSourceImpl(),
    );
    gh.factory<_i106.LoginRemoteDataSource>(
      () => _i922.LoginRemoteDataSourceImpl(),
    );
    gh.factory<_i141.GetBannersRemoteDataSource>(
      () => _i193.GetBannersRemoteDataSourceImpl(),
    );
    gh.factory<_i979.GoogleRemoteDataSource>(
      () => _i613.GoogleRemoteDataSourceImpl(),
    );
    gh.factory<_i245.UploadImagesRemoteDataSource>(
      () => _i393.UploadImagesRemoteDataSourceImpl(
        gh<_i1047.ApiManager>(),
        gh<_i361.Dio>(),
      ),
    );
    gh.factory<_i87.GetReviewsRepo>(
      () => _i171.GetReviewRepoImpl(gh<_i694.GetReviewRemoteDataSource>()),
    );
    gh.factory<_i379.GetTermsAndCondiationsRemoteDataSource>(
      () => _i895.GetTermsAndCondiationsRemoteDataSourceImpl(),
    );
    gh.factory<_i706.ForgetPasswordRemoteDataSource>(
      () => _i133.ForgetPasswordRemoteDataSourceImpl(),
    );
    gh.factory<_i243.GetNotificationsRemoteDataSource>(
      () => _i698.GetNotificationsRemoteDataSourceImpl(),
    );
    gh.factory<_i757.RegisterRemoteDataSource>(
      () => _i269.RegisterRemoteDataSourceImpl(),
    );
    gh.factory<_i244.CancelOrderRemoteDataSource>(
      () => _i1061.CancelOrderRemoteDataSourceImpl(),
    );
    gh.factory<_i810.GetRequestPriorityRemoteDataSource>(
      () => _i214.GetRequestPriorityRemoteDataSourceImpl(),
    );
    gh.factory<_i523.ResetPasswordRemoteDataSource>(
      () => _i699.ResetPasswordRemoteDataSourceImpl(),
    );
    gh.factory<_i932.GetCurrentUserRemoteDataSource>(
      () => _i489.GetCurrentUserRemoteDataSourceImpl(),
    );
    gh.factory<_i282.DeleteAccountRemoteDataSource>(
      () => _i72.DeleteAccountRemoteDataSourceImpl(),
    );
    gh.factory<_i638.HasReviewRemoteDataSource>(
      () => _i330.HasReviewRemoteDataSourceImpl(),
    );
    gh.factory<_i71.GetMainCategoriesRemoteDataSource>(
      () => _i523.GetMainCategoriesRemoteDataSourceImpl(),
    );
    gh.factory<_i425.GetServicesBySubRemoteDataSource>(
      () => _i180.GetServicesBySubRemoteDataSourceImpl(),
    );
    gh.factory<_i696.UploadVideoRemoteDataSource>(
      () => _i779.UploadVideoRemoteDataSourceImpl(gh<_i1047.ApiManager>()),
    );
    gh.factory<_i296.UpdateOrderStatusRepo>(
      () => _i976.UpdateOrderStatusRepoImpl(
        gh<_i425.UpdateOrderStatusRemoteDataSource>(),
      ),
    );
    gh.factory<_i930.MarkNotificationAsReadRepo>(
      () => _i315.MarkNotificationAsReadRepoImpl(
        gh<_i33.MarkNotificationAsReadRemoteDataSource>(),
      ),
    );
    gh.factory<_i1023.ResetPasswordRepo>(
      () => _i565.ResetPasswordRepoImpl(
        gh<_i523.ResetPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i961.GetCurrentUserRepo>(
      () => _i555.GetCurrentUserRepoImpl(
        getCurrentUserRemoteDataSource:
            gh<_i932.GetCurrentUserRemoteDataSource>(),
      ),
    );
    gh.factory<_i630.LoginRepo>(
      () => _i399.LoginRepoImpl(
        loginRemoteDataSource: gh<_i106.LoginRemoteDataSource>(),
      ),
    );
    gh.factory<_i609.DeleteNotificationDataRemoteDataSource>(
      () => _i371.DeleteNotificationDataRemoteDataSourceImpl(),
    );
    gh.factory<_i91.GetCurrentLocationRemoteDataSource>(
      () => _i936.GetCurrentLocationRemoteDataSourceImpl(),
    );
    gh.factory<_i903.GetTechnicianOrdersRemoteDataSource>(
      () => _i381.GetTechnicianOrdersRemoteDataSourceImpl(),
    );
    gh.factory<_i980.UpdateTechnicianProfileRepo>(
      () => _i273.UpdateTechnicianProfileRepoImpl(
        gh<_i149.UpdateTechnicianProfileRemoteDataSource>(),
      ),
    );
    gh.factory<_i929.GetServiceAreasRepo>(
      () => _i995.GetServiceAreasRepoImpl(
        getServiceAreasRemoteDataSource:
            gh<_i483.GetServiceAreasRemoteDataSource>(),
      ),
    );
    gh.factory<_i466.GetServicesBySubRepo>(
      () => _i748.GetServicesBySubRepoImpl(
        gh<_i425.GetServicesBySubRemoteDataSource>(),
      ),
    );
    gh.singleton<_i505.OrdersRealtimeService>(
      () => _i505.OrdersRealtimeService(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i623.GetTechnicianOrdersRepo>(
      () => _i587.GetTechnicianOrdersRepoImpl(
        gh<_i903.GetTechnicianOrdersRemoteDataSource>(),
      ),
    );
    gh.factory<_i392.UnreadNotificationsCountRepo>(
      () => _i247.UnreadNotificationsCountRepoImpl(
        gh<_i348.UnreadNotificationsCountRemoteDataSource>(),
      ),
    );
    gh.factory<_i905.GetServiceAreasUseCase>(
      () => _i905.GetServiceAreasUseCase(
        getServiceAreasRepo: gh<_i929.GetServiceAreasRepo>(),
      ),
    );
    gh.factory<_i494.GetCustomerOrdersRepo>(
      () => _i872.GetCustomerOrdersRepoImpl(
        getCustomerOrdersRemoteDataSource:
            gh<_i373.GetCustomerOrdersRemoteDataSource>(),
      ),
    );
    gh.factory<_i626.HasReviewRepo>(
      () => _i346.HasReviewRepoImpl(gh<_i638.HasReviewRemoteDataSource>()),
    );
    gh.factory<_i842.UpdateOrderStatusUseCase>(
      () => _i842.UpdateOrderStatusUseCase(gh<_i296.UpdateOrderStatusRepo>()),
    );
    gh.factory<_i196.GetServicesBySubUseCase>(
      () => _i196.GetServicesBySubUseCase(gh<_i466.GetServicesBySubRepo>()),
    );
    gh.factory<_i36.UpdateCustomerProfileRepo>(
      () => _i652.UpdateCustomerProfileRepoImpl(
        gh<_i860.UpdateCustomerProfileRemoteDataSource>(),
      ),
    );
    gh.factory<_i838.UpdateOrderStatusViewModel>(
      () => _i838.UpdateOrderStatusViewModel(
        gh<_i842.UpdateOrderStatusUseCase>(),
      ),
    );
    gh.factory<_i407.GetSparePartRepo>(
      () => _i981.GetSparePartRepoImpl(
        getSparePartRemoteDataSource: gh<_i798.GetSparePartRemoteDataSource>(),
      ),
    );
    gh.factory<_i261.GetSubCategoriesRepo>(
      () => _i104.GetSubCategoriesRepoImpl(
        gh<_i450.GetSubCategoriesRemoteDataSource>(),
      ),
    );
    gh.factory<_i128.UploadImagesRepo>(
      () => _i11.UploadImagesRepoImpl(gh<_i245.UploadImagesRemoteDataSource>()),
    );
    gh.factory<_i753.GetReviewsUseCase>(
      () => _i753.GetReviewsUseCase(gh<_i87.GetReviewsRepo>()),
    );
    gh.factory<_i1072.AddSparePartUseCase>(
      () => _i1072.AddSparePartUseCase(gh<_i237.AddSparePartRepo>()),
    );
    gh.factory<_i744.RegisterRepo>(
      () => _i57.RegisterRepoImpl(
        registerRemoteDataSource: gh<_i757.RegisterRemoteDataSource>(),
      ),
    );
    gh.factory<_i400.CreateOrderRepo>(
      () => _i137.CreateOrderRepoImpl(
        createOrderRemoteDataSource: gh<_i237.CreateOrderRemoteDataSource>(),
      ),
    );
    gh.factory<_i1025.GetSubCategoriesUseCase>(
      () => _i1025.GetSubCategoriesUseCase(gh<_i261.GetSubCategoriesRepo>()),
    );
    gh.factory<_i552.AddReviewUseCase>(
      () => _i552.AddReviewUseCase(gh<_i640.AddReviewRepo>()),
    );
    gh.factory<_i984.GetRequestPriorityRepo>(
      () => _i13.GetRequestPriorityRepoImpl(
        gh<_i810.GetRequestPriorityRemoteDataSource>(),
      ),
    );
    gh.factory<_i356.GoogleRepo>(
      () => _i1021.GoogleRepoImpl(gh<_i979.GoogleRemoteDataSource>()),
    );
    gh.factory<_i403.SaveFcmTokenRepo>(
      () =>
          _i888.SaveFcmTokenRepoImpl(gh<_i419.SaveFcmTokenRemoteDataSource>()),
    );
    gh.factory<_i344.ForgetPasswordRepo>(
      () => _i293.ForgetPasswordRepoImpl(
        gh<_i706.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i270.InvoiceRepo>(
      () => _i882.InvoiceRepoImpl(
        invoiceRemoteDataSource: gh<_i734.InvoiceRemoteDataSource>(),
      ),
    );
    gh.factory<_i207.GetMainCategoriesRepo>(
      () => _i910.GetMainCategoriesRepoImpl(
        gh<_i71.GetMainCategoriesRemoteDataSource>(),
      ),
    );
    gh.factory<_i86.GetCurrentUserUseCase>(
      () => _i86.GetCurrentUserUseCase(gh<_i961.GetCurrentUserRepo>()),
    );
    gh.factory<_i745.LoginUseCase>(
      () => _i745.LoginUseCase(gh<_i630.LoginRepo>()),
    );
    gh.factory<_i411.GetReviewViewModel>(
      () => _i411.GetReviewViewModel(gh<_i753.GetReviewsUseCase>()),
    );
    gh.factory<_i193.CreateOrderUseCase>(
      () => _i193.CreateOrderUseCase(gh<_i400.CreateOrderRepo>()),
    );
    gh.factory<_i674.GetOrderDetailsRepo>(
      () => _i762.GetOrderDetailsRepoImpl(
        gh<_i82.GetOrderDetailsRemoteDataSource>(),
      ),
    );
    gh.factory<_i901.UpdateTechnicianProfileUseCase>(
      () => _i901.UpdateTechnicianProfileUseCase(
        gh<_i980.UpdateTechnicianProfileRepo>(),
      ),
    );
    gh.factory<_i70.GetBannersRepo>(
      () => _i567.GetBannersRepoImpl(gh<_i141.GetBannersRemoteDataSource>()),
    );
    gh.factory<_i899.GetSerivesBySubViewModel>(
      () => _i899.GetSerivesBySubViewModel(gh<_i196.GetServicesBySubUseCase>()),
    );
    gh.factory<_i952.GetSubCategoriesViewModel>(
      () =>
          _i952.GetSubCategoriesViewModel(gh<_i196.GetServicesBySubUseCase>()),
    );
    gh.factory<_i772.SendNotificationsRepo>(
      () => _i453.SendNotificationsRepoImpl(
        gh<_i919.SendNotificationsRemoteDataSource>(),
      ),
    );
    gh.factory<_i999.GetNotificationsRepo>(
      () => _i147.GetNotificationsRepoImpl(
        gh<_i243.GetNotificationsRemoteDataSource>(),
      ),
    );
    gh.factory<_i119.GetSparePartUseCase>(
      () => _i119.GetSparePartUseCase(
        getSparePartRepo: gh<_i407.GetSparePartRepo>(),
      ),
    );
    gh.factory<_i345.GetCurrentLocationRepo>(
      () => _i170.GetCurrentLocationRepoImpl(
        gh<_i91.GetCurrentLocationRemoteDataSource>(),
      ),
    );
    gh.factory<_i517.ResetPasswordUseCase>(
      () => _i517.ResetPasswordUseCase(gh<_i1023.ResetPasswordRepo>()),
    );
    gh.factory<_i467.GetSparePartViewModel>(
      () => _i467.GetSparePartViewModel(gh<_i119.GetSparePartUseCase>()),
    );
    gh.factory<_i299.MarkNotificationAsReadUseCase>(
      () => _i299.MarkNotificationAsReadUseCase(
        gh<_i930.MarkNotificationAsReadRepo>(),
      ),
    );
    gh.factory<_i111.GetMainCategoriesUseCase>(
      () => _i111.GetMainCategoriesUseCase(gh<_i207.GetMainCategoriesRepo>()),
    );
    gh.factory<_i589.UnreadNotificationsCountUseCase>(
      () => _i589.UnreadNotificationsCountUseCase(
        gh<_i392.UnreadNotificationsCountRepo>(),
      ),
    );
    gh.factory<_i658.CancelOrderRepo>(
      () => _i10.CancelOrderRepoImpl(
        cancelOrderRemoteDataSource: gh<_i244.CancelOrderRemoteDataSource>(),
      ),
    );
    gh.factory<_i800.UploadVideoRepo>(
      () => _i548.UploadVideoRepoImpl(gh<_i696.UploadVideoRemoteDataSource>()),
    );
    gh.factory<_i584.AddSparePartViewModel>(
      () => _i584.AddSparePartViewModel(
        addSparePartUseCase: gh<_i1072.AddSparePartUseCase>(),
      ),
    );
    gh.factory<_i400.UpdateCustomerProfileUseCase>(
      () => _i400.UpdateCustomerProfileUseCase(
        gh<_i36.UpdateCustomerProfileRepo>(),
      ),
    );
    gh.factory<_i721.DeleteNotificationDataRepo>(
      () => _i13.DeleteNotificationDataRepoImpl(
        remoteDataSource: gh<_i609.DeleteNotificationDataRemoteDataSource>(),
      ),
    );
    gh.factory<_i695.GetTermsAndCondiationsRepo>(
      () => _i148.GetTermsAndCondiationsRepoImpl(
        remoteDataSource: gh<_i379.GetTermsAndCondiationsRemoteDataSource>(),
      ),
    );
    gh.factory<_i268.ResetPasswordViewModel>(
      () => _i268.ResetPasswordViewModel(gh<_i517.ResetPasswordUseCase>()),
    );
    gh.factory<_i50.UploadImagesUseCase>(
      () => _i50.UploadImagesUseCase(gh<_i128.UploadImagesRepo>()),
    );
    gh.factory<_i841.MarkAllNotificationsAsReadViewModel>(
      () => _i841.MarkAllNotificationsAsReadViewModel(
        gh<_i299.MarkNotificationAsReadUseCase>(),
      ),
    );
    gh.factory<_i444.UploadVideoUseCase>(
      () => _i444.UploadVideoUseCase(gh<_i800.UploadVideoRepo>()),
    );
    gh.factory<_i744.InvoiceUseCase>(
      () => _i744.InvoiceUseCase(gh<_i270.InvoiceRepo>()),
    );
    gh.factory<_i573.LoginViewModel>(
      () => _i573.LoginViewModel(
        gh<_i745.LoginUseCase>(),
        gh<_i535.SecureStorageService>(),
        gh<_i86.GetCurrentUserUseCase>(),
      ),
    );
    gh.factory<_i823.DeleteAccountRepo>(
      () => _i639.DeleteAccountRepoImpl(
        deleteAccountRemoteDataSource:
            gh<_i282.DeleteAccountRemoteDataSource>(),
      ),
    );
    gh.factory<_i711.GetCustomerOrdersUseCase>(
      () => _i711.GetCustomerOrdersUseCase(gh<_i494.GetCustomerOrdersRepo>()),
    );
    gh.factory<_i764.GetServiceAreasViewModel>(
      () => _i764.GetServiceAreasViewModel(
        getServiceAreasUseCase: gh<_i905.GetServiceAreasUseCase>(),
      ),
    );
    gh.factory<_i77.GoogleUseCase>(
      () => _i77.GoogleUseCase(gh<_i356.GoogleRepo>()),
    );
    gh.factory<_i333.GetTechnicianOrdersUseCase>(
      () =>
          _i333.GetTechnicianOrdersUseCase(gh<_i623.GetTechnicianOrdersRepo>()),
    );
    gh.factory<_i48.GetRequestPriorityUseCase>(
      () => _i48.GetRequestPriorityUseCase(gh<_i984.GetRequestPriorityRepo>()),
    );
    gh.factory<_i632.CreateOrderViewModel>(
      () => _i632.CreateOrderViewModel(
        gh<_i193.CreateOrderUseCase>(),
        gh<_i535.SecureStorageService>(),
      ),
    );
    gh.factory<_i984.SplashViewModel>(
      () => _i984.SplashViewModel(
        gh<_i535.SecureStorageService>(),
        gh<_i86.GetCurrentUserUseCase>(),
      ),
    );
    gh.factory<_i792.HasReviewUseCase>(
      () => _i792.HasReviewUseCase(gh<_i626.HasReviewRepo>()),
    );
    gh.factory<_i1006.UpdateCustomerProfileViewModel>(
      () => _i1006.UpdateCustomerProfileViewModel(
        gh<_i400.UpdateCustomerProfileUseCase>(),
      ),
    );
    gh.factory<_i908.SendNotificationsUseCase>(
      () => _i908.SendNotificationsUseCase(gh<_i772.SendNotificationsRepo>()),
    );
    gh.factory<_i445.GetRequestPriorityViewModel>(
      () => _i445.GetRequestPriorityViewModel(
        getRequestPriorityUseCase: gh<_i48.GetRequestPriorityUseCase>(),
      ),
    );
    gh.factory<_i257.UploadImagesViewModel>(
      () => _i257.UploadImagesViewModel(gh<_i50.UploadImagesUseCase>()),
    );
    gh.factory<_i859.GetBannersUseCase>(
      () => _i859.GetBannersUseCase(getBannersRepo: gh<_i70.GetBannersRepo>()),
    );
    gh.factory<_i964.RegisterUseCase>(
      () => _i964.RegisterUseCase(gh<_i744.RegisterRepo>()),
    );
    gh.factory<_i1053.GetNotificationsUseCase>(
      () => _i1053.GetNotificationsUseCase(gh<_i999.GetNotificationsRepo>()),
    );
    gh.factory<_i559.AddReviewViewModel>(
      () => _i559.AddReviewViewModel(
        addReviewUseCase: gh<_i552.AddReviewUseCase>(),
      ),
    );
    gh.factory<_i331.ForgetPasswordUseCase>(
      () => _i331.ForgetPasswordUseCase(gh<_i344.ForgetPasswordRepo>()),
    );
    gh.singleton<_i204.AppUserCubit>(
      () => _i204.AppUserCubit(gh<_i86.GetCurrentUserUseCase>()),
    );
    gh.factory<_i1026.GetCurrentUserViewModel>(
      () => _i1026.GetCurrentUserViewModel(gh<_i86.GetCurrentUserUseCase>()),
    );
    gh.factory<_i568.SaveFcmTokenUseCase>(
      () => _i568.SaveFcmTokenUseCase(gh<_i403.SaveFcmTokenRepo>()),
    );
    gh.factory<_i219.UnreadNotificationsCountViewModel>(
      () => _i219.UnreadNotificationsCountViewModel(
        gh<_i589.UnreadNotificationsCountUseCase>(),
      ),
    );
    gh.factory<_i30.VerifyOtpUseCase>(
      () => _i30.VerifyOtpUseCase(registerRepo: gh<_i744.RegisterRepo>()),
    );
    gh.factory<_i1018.GetCurrentLocationUseCase>(
      () =>
          _i1018.GetCurrentLocationUseCase(gh<_i345.GetCurrentLocationRepo>()),
    );
    gh.factory<_i157.DeleteNotificationDataUseCase>(
      () => _i157.DeleteNotificationDataUseCase(
        deleteNotificationDataRepo: gh<_i721.DeleteNotificationDataRepo>(),
      ),
    );
    gh.factory<_i934.GetMainCategoriesViewModel>(
      () => _i934.GetMainCategoriesViewModel(
        gh<_i111.GetMainCategoriesUseCase>(),
      ),
    );
    gh.factory<_i157.GoogleAuthViewModel>(
      () => _i157.GoogleAuthViewModel(
        gh<_i77.GoogleUseCase>(),
        gh<_i535.SecureStorageService>(),
        gh<_i86.GetCurrentUserUseCase>(),
      ),
    );
    gh.factory<_i1017.UpdateTechnicianProfileViewModel>(
      () => _i1017.UpdateTechnicianProfileViewModel(
        gh<_i901.UpdateTechnicianProfileUseCase>(),
      ),
    );
    gh.factory<_i411.GetOrderDetailsUseCase>(
      () => _i411.GetOrderDetailsUseCase(gh<_i674.GetOrderDetailsRepo>()),
    );
    gh.factory<_i837.DeleteNotificationDataViewModel>(
      () => _i837.DeleteNotificationDataViewModel(
        gh<_i157.DeleteNotificationDataUseCase>(),
      ),
    );
    gh.factory<_i368.UploadVideoViewModel>(
      () => _i368.UploadVideoViewModel(gh<_i444.UploadVideoUseCase>()),
    );
    gh.factory<_i977.GetTermsAndCondiationsUseCase>(
      () => _i977.GetTermsAndCondiationsUseCase(
        gh<_i695.GetTermsAndCondiationsRepo>(),
      ),
    );
    gh.factory<_i1004.GetTermsAndCondiationsViewModel>(
      () => _i1004.GetTermsAndCondiationsViewModel(
        gh<_i977.GetTermsAndCondiationsUseCase>(),
      ),
    );
    gh.factory<_i9.GetOrderDetailsViewModel>(
      () => _i9.GetOrderDetailsViewModel(gh<_i411.GetOrderDetailsUseCase>()),
    );
    gh.factory<_i481.GetInvoiceViewModel>(
      () => _i481.GetInvoiceViewModel(gh<_i744.InvoiceUseCase>()),
    );
    gh.factory<_i378.GetNotificationsViewModel>(
      () =>
          _i378.GetNotificationsViewModel(gh<_i1053.GetNotificationsUseCase>()),
    );
    gh.factory<_i232.CancelOrderUseCase>(
      () => _i232.CancelOrderUseCase(gh<_i658.CancelOrderRepo>()),
    );
    gh.factory<_i49.DeleteAccountUseCase>(
      () => _i49.DeleteAccountUseCase(gh<_i823.DeleteAccountRepo>()),
    );
    gh.factory<_i765.HasReviewViewModel>(
      () => _i765.HasReviewViewModel(
        hasReviewUseCase: gh<_i792.HasReviewUseCase>(),
      ),
    );
    gh.factory<_i432.GetCustomerOrdersViewModel>(
      () => _i432.GetCustomerOrdersViewModel(
        gh<_i711.GetCustomerOrdersUseCase>(),
      ),
    );
    gh.factory<_i122.GetBannersViewModel>(
      () => _i122.GetBannersViewModel(gh<_i859.GetBannersUseCase>()),
    );
    gh.factory<_i937.GetTechnicianOrdersViewModel>(
      () => _i937.GetTechnicianOrdersViewModel(
        gh<_i333.GetTechnicianOrdersUseCase>(),
        gh<_i505.OrdersRealtimeService>(),
      ),
    );
    gh.factory<_i19.RegisterViewModel>(
      () => _i19.RegisterViewModel(
        gh<_i964.RegisterUseCase>(),
        gh<_i535.SecureStorageService>(),
        gh<_i86.GetCurrentUserUseCase>(),
      ),
    );
    gh.factory<_i231.SendNotificationsViewModel>(
      () => _i231.SendNotificationsViewModel(
        gh<_i908.SendNotificationsUseCase>(),
      ),
    );
    gh.factory<_i18.SaveFcmTokenViewModel>(
      () => _i18.SaveFcmTokenViewModel(gh<_i568.SaveFcmTokenUseCase>()),
    );
    gh.factory<_i582.VerifyOtpViewModel>(
      () => _i582.VerifyOtpViewModel(
        gh<_i30.VerifyOtpUseCase>(),
        gh<_i535.SecureStorageService>(),
        gh<_i86.GetCurrentUserUseCase>(),
      ),
    );
    gh.factory<_i438.GetCurrentUserLocationViewModel>(
      () => _i438.GetCurrentUserLocationViewModel(
        getCurrentUserLocationUseCase: gh<_i1018.GetCurrentLocationUseCase>(),
      ),
    );
    gh.factory<_i33.ForgetPasswordViewModel>(
      () => _i33.ForgetPasswordViewModel(gh<_i331.ForgetPasswordUseCase>()),
    );
    gh.factory<_i306.CancelOrderViewModel>(
      () => _i306.CancelOrderViewModel(gh<_i232.CancelOrderUseCase>()),
    );
    gh.factory<_i710.DeleteAccountViewModel>(
      () => _i710.DeleteAccountViewModel(gh<_i49.DeleteAccountUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i614.DioModule {}
