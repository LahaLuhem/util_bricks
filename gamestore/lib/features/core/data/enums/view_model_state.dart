/// Initialing states of a ViewModel.
enum ViewModelState {
  /// Initializing
  isInitialising,

  /// Initializing done
  isInitialised,

  /// Busy with some other task
  isBusy,

  /// Error
  hasError;
}
