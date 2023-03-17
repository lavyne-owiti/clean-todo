import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/preferences.dart';

abstract class PreferencesRepository {
  Future<Either<Failure, Preferences?>> getPreferences();
  Future<Either<Failure, Unit>> savePreferences(Preferences preferences);
}