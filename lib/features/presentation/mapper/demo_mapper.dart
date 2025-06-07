import 'package:base_bloc_cubit/core/base/src/base_mapper.dart';
import 'package:base_bloc_cubit/features/presentation/model/demo_model_ui.dart';

import '../../domain/entities/src/demo_entity.dart';

class DemoMapper extends BaseMapper<DemoUIModel, DemoEntity> {
  DemoUIModel mapFromEntityToModel(DemoEntity? type) {
    return DemoUIModel(name: type?.name ?? '');
  }
}
