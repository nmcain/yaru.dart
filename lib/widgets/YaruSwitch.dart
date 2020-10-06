/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/src/material/colors.dart';
import 'package:flutter/src/material/constants.dart';
import 'package:flutter/src/material/debug.dart';
import 'package:flutter/src/material/material_state.dart';
import 'package:flutter/src/material/shadows.dart';
import 'package:flutter/src/material/theme.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:flutter/src/material/toggleable.dart';

const double _kTrackHeight = 14.0;
const double _kTrackWidth = 33.0;
const double _kTrackRadius = _kTrackHeight / 2.0;
const double _kThumbRadius = 10.0;
const double _kYaruSwitchWidth = _kTrackWidth - 2 * _kTrackRadius + 2 * kRadialReactionRadius;
const double _kYaruSwitchHeight = 2 * kRadialReactionRadius + 8.0;
const double _kYaruSwitchHeightCollapsed = 2 * kRadialReactionRadius;

enum _YaruSwitchType { material, adaptive }

























class YaruSwitch extends StatefulWidget {
  
  
  
  
  
  
  
  
  
  
  
  const YaruSwitch({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.autofocus = false,
  })  : _YaruSwitchType = _YaruSwitchType.material,
        assert(dragStartBehavior != null),
        assert(activeThumbImage != null || onActiveThumbImageError == null),
        assert(inactiveThumbImage != null || onInactiveThumbImageError == null),
        super(key: key);

  
  
  
  
  
  
  
  
  
  const YaruSwitch.adaptive({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.focusNode,
    this.autofocus = false,
  })  : assert(autofocus != null),
        assert(activeThumbImage != null || onActiveThumbImageError == null),
        assert(inactiveThumbImage != null || onInactiveThumbImageError == null),
        _YaruSwitchType = _YaruSwitchType.adaptive,
        super(key: key);

  
  
  
  final bool value;

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  final ValueChanged<bool> onChanged;

  
  
  
  final Color activeColor;

  
  
  
  
  
  final Color activeTrackColor;

  
  
  
  
  
  final Color inactiveThumbColor;

  
  
  
  
  
  final Color inactiveTrackColor;

  
  
  
  final ImageProvider activeThumbImage;

  
  
  final ImageErrorListener onActiveThumbImageError;

  
  
  
  final ImageProvider inactiveThumbImage;

  
  
  final ImageErrorListener onInactiveThumbImageError;

  
  
  
  
  
  
  
  final MaterialTapTargetSize materialTapTargetSize;

  final _YaruSwitchType _YaruSwitchType;

  
  final DragStartBehavior dragStartBehavior;

  
  
  
  
  
  
  
  
  
  
  
  
  final MouseCursor mouseCursor;

  
  final Color focusColor;

  
  final Color hoverColor;

  
  final FocusNode focusNode;

  
  final bool autofocus;

  @override
  _YaruSwitchState createState() => _YaruSwitchState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('value', value: value, ifTrue: 'on', ifFalse: 'off', showName: true));
    properties.add(ObjectFlagProperty<ValueChanged<bool>>('onChanged', onChanged, ifNull: 'disabled'));
  }
}

class _YaruSwitchState extends State<YaruSwitch> with TickerProviderStateMixin {
  Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: _actionHandler),
    };
  }

  void _actionHandler(ActivateIntent intent) {
    if (widget.onChanged != null) {
      widget.onChanged(!widget.value);
    }
    final RenderObject renderObject = context.findRenderObject();
    renderObject.sendSemanticsEvent(const TapSemanticEvent());
  }

  bool _focused = false;
  void _handleFocusHighlightChanged(bool focused) {
    if (focused != _focused) {
      setState(() { _focused = focused; });
    }
  }

  bool _hovering = false;
  void _handleHoverChanged(bool hovering) {
    if (hovering != _hovering) {
      setState(() { _hovering = hovering; });
    }
  }

  Size getYaruSwitchSize(ThemeData theme) {
    YaruSwitch (widget.materialTapTargetSize ?? theme.materialTapTargetSize) {
      case MaterialTapTargetSize.padded:
        return const Size(_kYaruSwitchWidth, _kYaruSwitchHeight);
        break;
      case MaterialTapTargetSize.shrinkWrap:
        return const Size(_kYaruSwitchWidth, _kYaruSwitchHeightCollapsed);
        break;
    }
    assert(false);
    return null;
  }

  bool get enabled => widget.onChanged != null;

  void _didFinishDragging() {
    
    
    setState(() {});
  }

  Widget buildMaterialYaruSwitch(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final Color activeThumbColor = widget.activeColor ?? theme.toggleableActiveColor;
    final Color activeTrackColor = widget.activeTrackColor ?? activeThumbColor.withAlpha(0x80);
    final Color hoverColor = widget.hoverColor ?? theme.hoverColor;
    final Color focusColor = widget.focusColor ?? theme.focusColor;

    Color inactiveThumbColor;
    Color inactiveTrackColor;
    if (enabled) {
      const Color black32 = Color(0x52000000); 
      inactiveThumbColor = widget.inactiveThumbColor ?? (isDark ? Colors.grey.shade400 : Colors.grey.shade50);
      inactiveTrackColor = widget.inactiveTrackColor ?? (isDark ? Colors.white30 : black32);
    } else {
      inactiveThumbColor = widget.inactiveThumbColor ?? (isDark ? Colors.grey.shade800 : Colors.grey.shade400);
      inactiveTrackColor = widget.inactiveTrackColor ?? (isDark ? Colors.white10 : Colors.black12);
    }
    final MouseCursor effectiveMouseCursor = MaterialStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? MaterialStateMouseCursor.clickable,
      <MaterialState>{
        if (!enabled) MaterialState.disabled,
        if (_hovering) MaterialState.hovered,
        if (_focused) MaterialState.focused,
        if (widget.value) MaterialState.selected,
      },
    );

    return FocusableActionDetector(
      actions: _actionMap,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enabled: enabled,
      onShowFocusHighlight: _handleFocusHighlightChanged,
      onShowHoverHighlight: _handleHoverChanged,
      mouseCursor: effectiveMouseCursor,
      child: Builder(
        builder: (BuildContext context) {
          return _YaruSwitchRenderObjectWidget(
            dragStartBehavior: widget.dragStartBehavior,
            value: widget.value,
            activeColor: activeThumbColor,
            inactiveColor: inactiveThumbColor,
            hoverColor: hoverColor,
            focusColor: focusColor,
            activeThumbImage: widget.activeThumbImage,
            onActiveThumbImageError: widget.onActiveThumbImageError,
            inactiveThumbImage: widget.inactiveThumbImage,
            onInactiveThumbImageError: widget.onInactiveThumbImageError,
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor,
            configuration: createLocalImageConfiguration(context),
            onChanged: widget.onChanged,
            additionalConstraints: BoxConstraints.tight(getYaruSwitchSize(theme)),
            hasFocus: _focused,
            hovering: _hovering,
            state: this,
          );
        },
      ),
    );
  }

  Widget buildCupertinoYaruSwitch(BuildContext context) {
    final Size size = getYaruSwitchSize(Theme.of(context));
    return Focus(
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      child: Container(
        width: size.width, 
        height: size.height,
        alignment: Alignment.center,
        child: CupertinoYaruSwitch(
          dragStartBehavior: widget.dragStartBehavior,
          value: widget.value,
          onChanged: widget.onChanged,
          activeColor: widget.activeColor,
          trackColor: widget.inactiveTrackColor
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    YaruSwitch (widget._YaruSwitchType) {
      case _YaruSwitchType.material:
        return buildMaterialYaruSwitch(context);

      case _YaruSwitchType.adaptive: {
        final ThemeData theme = Theme.of(context);
        assert(theme.platform != null);
        YaruSwitch (theme.platform) {
          case TargetPlatform.android:
          case TargetPlatform.fuchsia:
          case TargetPlatform.linux:
          case TargetPlatform.windows:
            return buildMaterialYaruSwitch(context);
          case TargetPlatform.iOS:
          case TargetPlatform.macOS:
            return buildCupertinoYaruSwitch(context);
        }
      }
    }
    assert(false);
    return null;
  }
}

class _YaruSwitchRenderObjectWidget extends LeafRenderObjectWidget {
  const _YaruSwitchRenderObjectWidget({
    Key key,
    this.value,
    this.activeColor,
    this.inactiveColor,
    this.hoverColor,
    this.focusColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.configuration,
    this.onChanged,
    this.additionalConstraints,
    this.dragStartBehavior,
    this.hasFocus,
    this.hovering,
    this.state,
  }) : super(key: key);

  final bool value;
  final Color activeColor;
  final Color inactiveColor;
  final Color hoverColor;
  final Color focusColor;
  final ImageProvider activeThumbImage;
  final ImageErrorListener onActiveThumbImageError;
  final ImageProvider inactiveThumbImage;
  final ImageErrorListener onInactiveThumbImageError;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final ImageConfiguration configuration;
  final ValueChanged<bool> onChanged;
  final BoxConstraints additionalConstraints;
  final DragStartBehavior dragStartBehavior;
  final bool hasFocus;
  final bool hovering;
  final _YaruSwitchState state;

  @override
  _RenderYaruSwitch createRenderObject(BuildContext context) {
    return _RenderYaruSwitch(
      dragStartBehavior: dragStartBehavior,
      value: value,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      hoverColor: hoverColor,
      focusColor: focusColor,
      activeThumbImage: activeThumbImage,
      onActiveThumbImageError: onActiveThumbImageError,
      inactiveThumbImage: inactiveThumbImage,
      onInactiveThumbImageError: onInactiveThumbImageError,
      activeTrackColor: activeTrackColor,
      inactiveTrackColor: inactiveTrackColor,
      configuration: configuration,
      onChanged: onChanged,
      textDirection: Directionality.of(context),
      additionalConstraints: additionalConstraints,
      hasFocus: hasFocus,
      hovering: hovering,
      state: state,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderYaruSwitch renderObject) {
    renderObject
      ..value = value
      ..activeColor = activeColor
      ..inactiveColor = inactiveColor
      ..hoverColor = hoverColor
      ..focusColor = focusColor
      ..activeThumbImage = activeThumbImage
      ..onActiveThumbImageError = onActiveThumbImageError
      ..inactiveThumbImage = inactiveThumbImage
      ..onInactiveThumbImageError = onInactiveThumbImageError
      ..activeTrackColor = activeTrackColor
      ..inactiveTrackColor = inactiveTrackColor
      ..configuration = configuration
      ..onChanged = onChanged
      ..textDirection = Directionality.of(context)
      ..additionalConstraints = additionalConstraints
      ..dragStartBehavior = dragStartBehavior
      ..hasFocus = hasFocus
      ..hovering = hovering
      ..vsync = state;
  }
}

class _RenderYaruSwitch extends RenderToggleable {
  _RenderYaruSwitch({
    bool value,
    Color activeColor,
    Color inactiveColor,
    Color hoverColor,
    Color focusColor,
    ImageProvider activeThumbImage,
    ImageErrorListener onActiveThumbImageError,
    ImageProvider inactiveThumbImage,
    ImageErrorListener onInactiveThumbImageError,
    Color activeTrackColor,
    Color inactiveTrackColor,
    ImageConfiguration configuration,
    BoxConstraints additionalConstraints,
    @required TextDirection textDirection,
    ValueChanged<bool> onChanged,
    DragStartBehavior dragStartBehavior,
    bool hasFocus,
    bool hovering,
    @required this.state,
  }) : assert(textDirection != null),
       _activeThumbImage = activeThumbImage,
       _onActiveThumbImageError = onActiveThumbImageError,
       _inactiveThumbImage = inactiveThumbImage,
       _onInactiveThumbImageError = onInactiveThumbImageError,
       _activeTrackColor = activeTrackColor,
       _inactiveTrackColor = inactiveTrackColor,
       _configuration = configuration,
       _textDirection = textDirection,
       super(
         value: value,
         tristate: false,
         activeColor: activeColor,
         inactiveColor: inactiveColor,
         hoverColor: hoverColor,
         focusColor: focusColor,
         onChanged: onChanged,
         additionalConstraints: additionalConstraints,
         hasFocus: hasFocus,
         hovering: hovering,
         vsync: state,
       ) {
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onEnd = _handleDragEnd
      ..dragStartBehavior = dragStartBehavior;
  }

  ImageProvider get activeThumbImage => _activeThumbImage;
  ImageProvider _activeThumbImage;
  set activeThumbImage(ImageProvider value) {
    if (value == _activeThumbImage)
      return;
    _activeThumbImage = value;
    markNeedsPaint();
  }

  ImageErrorListener get onActiveThumbImageError => _onActiveThumbImageError;
  ImageErrorListener _onActiveThumbImageError;
  set onActiveThumbImageError(ImageErrorListener value) {
    if (value == _onActiveThumbImageError) {
      return;
    }
    _onActiveThumbImageError = value;
    markNeedsPaint();
  }

  ImageProvider get inactiveThumbImage => _inactiveThumbImage;
  ImageProvider _inactiveThumbImage;
  set inactiveThumbImage(ImageProvider value) {
    if (value == _inactiveThumbImage)
      return;
    _inactiveThumbImage = value;
    markNeedsPaint();
  }

  ImageErrorListener get onInactiveThumbImageError => _onInactiveThumbImageError;
  ImageErrorListener _onInactiveThumbImageError;
  set onInactiveThumbImageError(ImageErrorListener value) {
    if (value == _onInactiveThumbImageError) {
      return;
    }
    _onInactiveThumbImageError = value;
    markNeedsPaint();
  }

  Color get activeTrackColor => _activeTrackColor;
  Color _activeTrackColor;
  set activeTrackColor(Color value) {
    assert(value != null);
    if (value == _activeTrackColor)
      return;
    _activeTrackColor = value;
    markNeedsPaint();
  }

  Color get inactiveTrackColor => _inactiveTrackColor;
  Color _inactiveTrackColor;
  set inactiveTrackColor(Color value) {
    assert(value != null);
    if (value == _inactiveTrackColor)
      return;
    _inactiveTrackColor = value;
    markNeedsPaint();
  }

  ImageConfiguration get configuration => _configuration;
  ImageConfiguration _configuration;
  set configuration(ImageConfiguration value) {
    assert(value != null);
    if (value == _configuration)
      return;
    _configuration = value;
    markNeedsPaint();
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    assert(value != null);
    if (_textDirection == value)
      return;
    _textDirection = value;
    markNeedsPaint();
  }

  DragStartBehavior get dragStartBehavior => _drag.dragStartBehavior;
  set dragStartBehavior(DragStartBehavior value) {
    assert(value != null);
    if (_drag.dragStartBehavior == value)
      return;
    _drag.dragStartBehavior = value;
  }

  _YaruSwitchState state;

  @override
  set value(bool newValue) {
    assert(value != null);
    super.value = newValue;
    
    if (_needsPositionAnimation) {
      _needsPositionAnimation = false;
      position
        ..curve = null
        ..reverseCurve = null;
      if (newValue)
        positionController.forward();
      else
        positionController.reverse();
    }
  }


  @override
  void detach() {
    _cachedThumbPainter?.dispose();
    _cachedThumbPainter = null;
    super.detach();
  }

  double get _trackInnerLength => size.width - 2.0 * kRadialReactionRadius;

  HorizontalDragGestureRecognizer _drag;

  bool _needsPositionAnimation = false;

  void _handleDragStart(DragStartDetails details) {
    if (isInteractive)
      reactionController.forward();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      position
        ..curve = null
        ..reverseCurve = null;
      final double delta = details.primaryDelta / _trackInnerLength;
      YaruSwitch (textDirection) {
        case TextDirection.rtl:
          positionController.value -= delta;
          break;
        case TextDirection.ltr:
          positionController.value += delta;
          break;
      }
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    _needsPositionAnimation = true;

    if (position.value >= 0.5 != value)
      onChanged(!value);
    reactionController.reverse();
    state._didFinishDragging();
  }

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && onChanged != null)
      _drag.addPointer(event);
    super.handleEvent(event, entry);
  }

  Color _cachedThumbColor;
  ImageProvider _cachedThumbImage;
  ImageErrorListener _cachedThumbErrorListener;
  BoxPainter _cachedThumbPainter;

  BoxDecoration _createDefaultThumbDecoration(Color color, ImageProvider image, ImageErrorListener errorListener) {
    return BoxDecoration(
      color: color,
      image: image == null ? null : DecorationImage(image: image, onError: errorListener),
      shape: BoxShape.circle,
      boxShadow: kElevationToShadow[1],
    );
  }

  bool _isPainting = false;

  void _handleDecorationChanged() {
    
    
    
    
    if (!_isPainting)
      markNeedsPaint();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isToggled = value == true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    final bool isEnabled = onChanged != null;
    final double currentValue = position.value;

    double visualPosition;
    YaruSwitch (textDirection) {
      case TextDirection.rtl:
        visualPosition = 1.0 - currentValue;
        break;
      case TextDirection.ltr:
        visualPosition = currentValue;
        break;
    }

    final Color trackColor = isEnabled
      ? Color.lerp(inactiveTrackColor, activeTrackColor, currentValue)
      : inactiveTrackColor;

    final Color thumbColor = isEnabled
      ? Color.lerp(inactiveColor, activeColor, currentValue)
      : inactiveColor;

    final ImageProvider thumbImage = isEnabled
      ? (currentValue < 0.5 ? inactiveThumbImage : activeThumbImage)
      : inactiveThumbImage;

    final ImageErrorListener thumbErrorListener = isEnabled
      ? (currentValue < 0.5 ? onInactiveThumbImageError : onActiveThumbImageError)
      : onInactiveThumbImageError;

    
    final Paint paint = Paint()
      ..color = trackColor;
    const double trackHorizontalPadding = kRadialReactionRadius - _kTrackRadius;
    final Rect trackRect = Rect.fromLTWH(
      offset.dx + trackHorizontalPadding,
      offset.dy + (size.height - _kTrackHeight) / 2.0,
      size.width - 2.0 * trackHorizontalPadding,
      _kTrackHeight,
    );
    final RRect trackRRect = RRect.fromRectAndRadius(trackRect, const Radius.circular(_kTrackRadius));
    canvas.drawRRect(trackRRect, paint);

    final Offset thumbPosition = Offset(
      kRadialReactionRadius + visualPosition * _trackInnerLength,
      size.height / 2.0,
    );

    paintRadialReaction(canvas, offset, thumbPosition);

    try {
      _isPainting = true;
      BoxPainter thumbPainter;
      if (_cachedThumbPainter == null || thumbColor != _cachedThumbColor || thumbImage != _cachedThumbImage || thumbErrorListener != _cachedThumbErrorListener) {
        _cachedThumbColor = thumbColor;
        _cachedThumbImage = thumbImage;
        _cachedThumbErrorListener = thumbErrorListener;
        _cachedThumbPainter = _createDefaultThumbDecoration(thumbColor, thumbImage, thumbErrorListener).createBoxPainter(_handleDecorationChanged);
      }
      thumbPainter = _cachedThumbPainter;

      
      final double inset = 1.0 - (currentValue - 0.5).abs() * 2.0;
      final double radius = _kThumbRadius - inset;
      thumbPainter.paint(
        canvas,
        thumbPosition + offset - Offset(radius, radius),
        configuration.copyWith(size: Size.fromRadius(radius)),
      );
    } finally {
      _isPainting = false;
    }
  }
}
*/
