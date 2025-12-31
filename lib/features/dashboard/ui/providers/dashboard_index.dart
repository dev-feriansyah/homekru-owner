import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dashboard_index.g.dart';

@riverpod
class DashboardIndex extends _$DashboardIndex {
  @override
  int build() => 0;

  void set(int index) => state = index;
}
