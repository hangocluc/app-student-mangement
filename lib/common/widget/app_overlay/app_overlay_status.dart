enum OverlayStatus {
  show,
  dismiss,
}

typedef OverlayStatusCallback = void Function(OverlayStatus status);
