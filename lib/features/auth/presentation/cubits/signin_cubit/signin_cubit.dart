import 'package:bloc/bloc.dart';
import 'package:kshk/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepo authRepo;
  SigninCubit(this.authRepo) : super(SigninInitial());

  void signInWithEmailAndPassword(String email, String password) async {
    emit(SigninLoading());
    final result = await authRepo.signInWithEmailAndPassword(email, password);
    result.fold(
      (failure) => emit(SigninFailure(failure.message)),
      (user) => emit(SigninSuccess()),
    );
  }

void signInWithGoogle() async {
    emit(SigninLoading());
    try {
      final result = await authRepo.signInWithGoogle();
      result.fold(
        (failure) => emit(SigninFailure(failure.message)),
        (user) => emit(SigninSuccess()),
      );
    } catch (e) {
      emit(SigninFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }

  void signInWithFacebook() async {
    emit(SigninLoading());
    final result = await authRepo.signinWithFacebook();
    result.fold(
      (failure) => emit(SigninFailure(failure.message)),
      (user) => emit(SigninSuccess()),
    );
  }
}
