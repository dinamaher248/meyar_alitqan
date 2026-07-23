abstract class AddSparePartViewModelStates {}

class AddSparePartViewModelInitial extends AddSparePartViewModelStates {}

class AddSparePartViewModelLoading extends AddSparePartViewModelStates {}

class AddSparePartViewModelError extends AddSparePartViewModelStates {
  final String message;
  AddSparePartViewModelError(this.message);
}

class AddSparePartViewModelSuccess extends AddSparePartViewModelStates {}
