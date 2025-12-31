// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_index.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardIndex)
const dashboardIndexProvider = DashboardIndexProvider._();

final class DashboardIndexProvider
    extends $NotifierProvider<DashboardIndex, int> {
  const DashboardIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardIndexHash();

  @$internal
  @override
  DashboardIndex create() => DashboardIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$dashboardIndexHash() => r'40afc5132614e624ce0751523e1edf03eb440cec';

abstract class _$DashboardIndex extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
