// Mocks generated by Mockito 5.3.2 from annotations
// in konfiso/test/features/loading/controller/loading_page_state_notifer_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:konfiso/features/loading/model/loading_repository.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [LoadingRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoadingRepository extends _i1.Mock implements _i2.LoadingRepository {
  @override
  _i3.Future<bool> autoSignIn() => (super.noSuchMethod(
        Invocation.method(
          #autoSignIn,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
        returnValueForMissingStub: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}
