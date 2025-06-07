import 'package:json_annotation/json_annotation.dart';

part 'base_pagination_model.g.dart';

typedef BasePaginationEntity = BasePaginationModel;

@JsonSerializable(
    genericArgumentFactories: true, fieldRename: FieldRename.snake)
class BasePaginationModel<T> {
  final int? currentPage;
  final T? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<BasePagingLinks>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  BasePaginationModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory BasePaginationModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BasePaginationModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BasePaginationModelToJson(this, toJsonT);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class BasePagingLinks {
  final String? url;
  final String? label;
  final bool? active;

  BasePagingLinks({this.url, this.label, this.active});

  factory BasePagingLinks.fromJson(Map<String, dynamic> json) {
    return _$BasePagingLinksFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BasePagingLinksToJson(this);
}
