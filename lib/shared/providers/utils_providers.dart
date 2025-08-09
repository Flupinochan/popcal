import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/shared/utils/time_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'utils_providers.g.dart';

@riverpod
TimeUtils timeUtils(Ref ref) {
  return TimeUtilsImpl();
}
