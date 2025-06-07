// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AppEffect {
  static _EffectShadow get shadow => _EffectShadow();
}

class _EffectShadow {
  BoxShadow boxXS = BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
    color: const Color(0xFF1C2731).withOpacity(0.08),
  );

  BoxShadow boxS = BoxShadow(
    offset: const Offset(0, 2),
    blurRadius: 6,
    spreadRadius: 0,
    color: const Color(0xFF1C2731).withOpacity(0.08),
  );
  BoxShadow boxM = BoxShadow(
    offset: const Offset(0, 6),
    blurRadius: 12,
    spreadRadius: 0,
    color: const Color(0xFF1C2731).withOpacity(0.08),
  );
  BoxShadow boxL = BoxShadow(
    offset: const Offset(0, 17),
    blurRadius: 33,
    spreadRadius: -2,
    color: const Color(0xFF1C2731).withOpacity(0.08),
  );
  BoxShadow boxXL = BoxShadow(
    offset: const Offset(0, 25),
    blurRadius: 40,
    spreadRadius: -10,
    color: const Color(0xFF1C2731).withOpacity(0.08),
  );
  BoxShadow boxXXL = BoxShadow(
    offset: const Offset(0, 25),
    blurRadius: 60,
    spreadRadius: -10,
    color: const Color(0xFF1C2731).withOpacity(0.12),
  );
  BoxShadow boxAppBar = const BoxShadow(
    color: Color(0x1C273114),
    offset: Offset(0, 1),
    blurRadius: 2.0,
    spreadRadius: 0.0,
  );
  BoxShadow boxButton = const BoxShadow(
    color: Color(0x1C273114),
    offset: Offset(0, -2),
    blurRadius: 6,
    spreadRadius: 0,
  );
}
