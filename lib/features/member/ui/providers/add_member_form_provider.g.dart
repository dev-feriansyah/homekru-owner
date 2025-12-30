// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_member_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddMemberForm)
const addMemberFormProvider = AddMemberFormProvider._();

final class AddMemberFormProvider
    extends $NotifierProvider<AddMemberForm, AddMemberFormState> {
  const AddMemberFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addMemberFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addMemberFormHash();

  @$internal
  @override
  AddMemberForm create() => AddMemberForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddMemberFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddMemberFormState>(value),
    );
  }
}

String _$addMemberFormHash() => r'57b9a00647d9b34dd39b9c6a02d93f7c70c2c1db';

abstract class _$AddMemberForm extends $Notifier<AddMemberFormState> {
  AddMemberFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AddMemberFormState, AddMemberFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AddMemberFormState, AddMemberFormState>,
              AddMemberFormState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
