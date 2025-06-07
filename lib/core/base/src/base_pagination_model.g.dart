// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePaginationModel<T> _$BasePaginationModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BasePaginationModel<T>(
      currentPage: (json['current_page'] as num?)?.toInt(),
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      firstPageUrl: json['first_page_url'] as String?,
      from: (json['from'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      lastPageUrl: json['last_page_url'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => BasePagingLinks.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String?,
      perPage: (json['per_page'] as num?)?.toInt(),
      prevPageUrl: json['prev_page_url'] as String?,
      to: (json['to'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BasePaginationModelToJson<T>(
  BasePaginationModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'links': instance.links,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'per_page': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

BasePagingLinks _$BasePagingLinksFromJson(Map<String, dynamic> json) =>
    BasePagingLinks(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$BasePagingLinksToJson(BasePagingLinks instance) =>
    <String, dynamic>{
      'url': instance.url,
      'label': instance.label,
      'active': instance.active,
    };
