import 'package:note_warden/features/feature_collection/domain/util/collection_order.dart';

class AppSettings {
  final String theme;
  final CollectionOrder collectionOrder;
  final bool isReceivingBeta;
  const AppSettings(this.theme, this.collectionOrder, this.isReceivingBeta);

  AppSettings copyWith(
      {String? theme,
      CollectionOrder? collectionOrder,
      bool? isReceivingBeta}) {
    return AppSettings(
      theme ?? this.theme,
      collectionOrder ?? this.collectionOrder,
      isReceivingBeta ?? this.isReceivingBeta,
    );
  }
}
