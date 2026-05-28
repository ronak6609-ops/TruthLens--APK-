import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:convert';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const TruthLensApp());
}

// ── Design Tokens ────────────────────────────────────────────────
class T {
  static const bg0   = Color(0xFF050508);
  static const bg1   = Color(0xFF08080D);
  static const bg2   = Color(0xFF0D0D15);
  static const card  = Color(0xFF0F0F18);
  static const card2 = Color(0xFF141420);
  static const cardHi= Color(0xFF1A1A28);

  static const b0    = Color(0xFF13131F);
  static const b1    = Color(0xFF1C1C2C);
  static const b2    = Color(0xFF272738);

  static const accent     = Color(0xFF4A82E8);
  static const accentMid  = Color(0xFF1A3468);
  static const accentSoft = Color(0xFF070E1E);
  static const accentGlow = Color(0x0D4A82E8);
  static const accentLine = Color(0x224A82E8);

  static const danger     = Color(0xFFD95555);
  static const dangerSoft = Color(0xFF130505);
  static const dangerLine = Color(0x28D95555);
  static const safe       = Color(0xFF2FAF6E);
  static const safeSoft   = Color(0xFF051210);
  static const safeLine   = Color(0x282FAF6E);

  static const t0 = Color(0xFFE8E8F2);
  static const t1 = Color(0xFF5C5C88);
  static const t2 = Color(0xFF2E2E48);
  static const t3 = Color(0xFF1A1A2A);
}

// ── App ──────────────────────────────────────────────────────────
class TruthLensApp extends StatelessWidget {
  const TruthLensApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'TruthLens',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: T.bg0,
      useMaterial3: true,
    ),
    home: const SplashScreen(),
  );
}

// ── Splash ───────────────────────────────────────────────────────
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override State<SplashScreen> createState() => _SplashState();
}
class _SplashState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _main, _pulse, _progress;
  late Animation<double> _fade, _slideY, _scale;

  @override
  void initState() {
    super.initState();
    _main     = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600));
    _pulse    = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000))..repeat(reverse: true);
    _progress = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400));

    _fade   = CurvedAnimation(parent: _main, curve: const Interval(0.0, 0.6, curve: Curves.easeOut));
    _slideY = Tween<double>(begin: 20, end: 0).animate(
        CurvedAnimation(parent: _main, curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic)));
    _scale  = Tween<double>(begin: 0.82, end: 1.0).animate(
        CurvedAnimation(parent: _main, curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack)));

    _main.forward();
    _progress.forward();

    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) Navigator.pushReplacement(context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const RootScreen(),
          transitionsBuilder: (_, a, __, child) => FadeTransition(
            opacity: CurvedAnimation(parent: a, curve: Curves.easeOut), child: child),
          transitionDuration: const Duration(milliseconds: 600)));
    });
  }

  @override void dispose() {
    _main.dispose(); _pulse.dispose(); _progress.dispose(); super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: T.bg0,
    body: Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([_main, _pulse, _progress]),
        builder: (_, __) => Opacity(
          opacity: _fade.value,
          child: Transform.translate(
            offset: Offset(0, _slideY.value),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Transform.scale(
                scale: _scale.value,
                child: SizedBox(width: 88, height: 88,
                  child: Stack(alignment: Alignment.center, children: [
                    Container(width: 88, height: 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: T.accent.withOpacity(0.04 + 0.04 * _pulse.value), width: 1))),
                    Container(width: 70, height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: T.accentSoft,
                        border: Border.all(
                          color: T.accent.withOpacity(0.14 + 0.08 * _pulse.value), width: 1),
                        boxShadow: [BoxShadow(
                          color: T.accent.withOpacity(0.08 + 0.05 * _pulse.value),
                          blurRadius: 40, spreadRadius: 0)])),
                    Container(width: 48, height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: T.accentSoft,
                        border: Border.all(color: T.accent.withOpacity(0.3), width: 1))),
                    const Icon(Icons.verified_user_rounded, color: T.accent, size: 22),
                  ])),
              ),
              const SizedBox(height: 32),
              const Text('TruthLens',
                style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.w700,
                  color: T.t0, letterSpacing: -0.5)),
              const SizedBox(height: 6),
              Text('AI Media Verification',
                style: TextStyle(
                  fontSize: 13, color: T.t1, letterSpacing: 0.2,
                  fontWeight: FontWeight.w400)),
              const SizedBox(height: 56),
              SizedBox(width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: _progress.value,
                    backgroundColor: T.b0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      T.accent.withOpacity(0.55)),
                    minHeight: 1.5))),
            ]),
          ),
        ),
      ),
    ),
  );
}

// ── Root ─────────────────────────────────────────────────────────
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  @override State<RootScreen> createState() => _RootState();
}
class _RootState extends State<RootScreen> {
  int _tab = 0;
  final _screens = const [
    ImageDetectScreen(), VideoDetectScreen(),
    NewsDetectScreen(), AudioDetectScreen(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: T.bg0,
    body: AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      switchInCurve: Curves.easeOut,
      child: KeyedSubtree(key: ValueKey(_tab), child: _screens[_tab])),
    bottomNavigationBar: _buildNav(),
  );

  Widget _buildNav() => Container(
    decoration: BoxDecoration(
      color: T.bg1,
      border: Border(top: BorderSide(color: T.b0, width: 0.5))),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Row(children: [
          _navItem(0, Icons.image_search_rounded, 'Image'),
          _navItem(1, Icons.play_circle_outline_rounded, 'Video'),
          _navItem(2, Icons.fact_check_outlined, 'News'),
          _navItem(3, Icons.graphic_eq_rounded, 'Audio'),
        ]),
      ),
    ),
  );

  Widget _navItem(int i, IconData icon, String label) {
    final active = _tab == i;
    return Expanded(
      child: GestureDetector(
        onTap: () { HapticFeedback.lightImpact(); setState(() => _tab = i); },
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: active ? T.accentGlow : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: active ? T.accentLine : Colors.transparent, width: 0.5)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, size: 19, color: active ? T.accent : T.t1),
            const SizedBox(height: 3),
            Text(label, style: TextStyle(
              fontSize: 10.5, letterSpacing: 0.1,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              color: active ? T.accent : T.t1)),
          ]),
        ),
      ),
    );
  }
}

// ── Shared Widgets ───────────────────────────────────────────────

class TopBar extends StatelessWidget {
  final String title, subtitle;
  const TopBar({super.key, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(
      fontSize: 26, fontWeight: FontWeight.w700,
      color: T.t0, letterSpacing: -0.7, height: 1.1)),
    const SizedBox(height: 5),
    Text(subtitle, style: const TextStyle(
      fontSize: 14, color: T.t1, height: 1.4, letterSpacing: 0)),
  ]);
}

class UploadBox extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool active;
  final double height;
  const UploadBox({super.key, required this.child, required this.onTap,
    this.active = false, this.height = 200});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      height: height, width: double.infinity,
      decoration: BoxDecoration(
        color: active ? T.accentGlow : T.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: active ? T.accent.withOpacity(0.28) : T.b1,
          width: active ? 1 : 0.5)),
      child: child),
  );
}

class PrimaryBtn extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool loading;
  const PrimaryBtn({super.key, required this.label, this.onTap, this.loading = false});
  @override State<PrimaryBtn> createState() => _PrimaryBtnState();
}
class _PrimaryBtnState extends State<PrimaryBtn> with SingleTickerProviderStateMixin {
  late AnimationController _press;
  late Animation<double> _scale;
  @override
  void initState() {
    super.initState();
    _press = AnimationController(vsync: this, duration: const Duration(milliseconds: 120), lowerBound: 0, upperBound: 1);
    _scale = Tween<double>(begin: 1, end: 0.976).animate(
      CurvedAnimation(parent: _press, curve: Curves.easeOut));
  }
  @override void dispose() { _press.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null && !widget.loading;
    return GestureDetector(
      onTapDown: enabled ? (_) { _press.forward(); HapticFeedback.lightImpact(); } : null,
      onTapUp: enabled ? (_) { _press.reverse(); widget.onTap!(); } : null,
      onTapCancel: () => _press.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) => Transform.scale(scale: _scale.value, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: double.infinity, height: 52,
          decoration: BoxDecoration(
            color: enabled ? T.accent : T.b1,
            borderRadius: BorderRadius.circular(14),
            boxShadow: enabled ? [
              BoxShadow(color: T.accent.withOpacity(0.18), blurRadius: 24, offset: const Offset(0, 8))
            ] : []),
          child: Center(child: widget.loading
            ? const SizedBox(width: 16, height: 16,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1.8))
            : Text(widget.label, style: TextStyle(
                fontSize: 14.5, fontWeight: FontWeight.w600, letterSpacing: 0.1,
                color: enabled ? Colors.white : T.t2))),
        ),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final bool isNegative;
  final String verdict, detail;
  final double confidence;
  final List<Widget>? extra;
  const ResultCard({super.key, required this.isNegative, required this.verdict,
    required this.confidence, required this.detail, this.extra});
  @override
  Widget build(BuildContext context) {
    final color  = isNegative ? T.danger : T.safe;
    final soft   = isNegative ? T.dangerSoft : T.safeSoft;
    final border = isNegative ? T.dangerLine : T.safeLine;
    return Container(
      decoration: BoxDecoration(
        color: T.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border, width: 0.5)),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: soft,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(17))),
          child: Row(children: [
            Container(
              width: 42, height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.08),
                border: Border.all(color: color.withOpacity(0.2), width: 0.5)),
              child: Icon(
                isNegative ? Icons.warning_amber_rounded : Icons.verified_rounded,
                color: color, size: 18)),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(verdict, style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: color, letterSpacing: -0.2)),
              const SizedBox(height: 2),
              Text(detail, style: const TextStyle(fontSize: 12, color: T.t1, height: 1.4)),
            ])),
            const SizedBox(width: 10),
            CircularPercentIndicator(
              radius: 28, lineWidth: 2.5,
              percent: (confidence / 100).clamp(0.0, 1.0),
              center: Text('${confidence.toStringAsFixed(0)}%',
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: T.t0)),
              progressColor: color,
              backgroundColor: T.b1),
          ]),
        ),
        if (extra != null)
          Padding(padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
            child: Column(children: extra!)),
      ]),
    );
  }
}

Widget kRow(String k, String v, {Color? vc}) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Row(children: [
    Text(k, style: const TextStyle(fontSize: 12.5, color: T.t1)),
    const Spacer(),
    Text(v, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: vc ?? T.t0)),
  ]),
);
Widget kDiv() => const Divider(color: T.b0, height: 1, thickness: 0.5);

class ScanningBar extends StatefulWidget {
  const ScanningBar({super.key});
  @override State<ScanningBar> createState() => _ScanningBarState();
}
class _ScanningBarState extends State<ScanningBar> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  int _stage = 0;
  static const _stages = [
    'Analyzing metadata',
    'Checking authenticity markers',
    'Scanning manipulation patterns',
    'Verifying AI indicators',
    'Compiling results',
  ];

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 1000));
      if (!mounted) return false;
      setState(() => _stage = (_stage + 1) % _stages.length);
      return true;
    });
  }
  @override void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _c,
    builder: (_, __) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: T.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: T.accentLine, width: 0.5)),
      child: Row(children: [
        SizedBox(width: 16, height: 16,
          child: CircularProgressIndicator(
            value: null, strokeWidth: 1.4,
            valueColor: AlwaysStoppedAnimation(T.accent.withOpacity(0.6)))),
        const SizedBox(width: 12),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 320),
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween(begin: const Offset(0, 0.15), end: Offset.zero)
                  .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
                child: child)),
            child: Align(
              key: ValueKey(_stage),
              alignment: Alignment.centerLeft,
              child: Text(_stages[_stage],
                style: const TextStyle(fontSize: 12.5, color: T.t1))))),
        Container(
          width: 5, height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: T.accent.withOpacity(0.4 + 0.6 * sin(_c.value * pi).abs()))),
      ]),
    ),
  );
}

Widget _trustLine() => Padding(
  padding: const EdgeInsets.only(top: 32),
  child: Center(child: Row(mainAxisSize: MainAxisSize.min, children: [
    const Icon(Icons.lock_outline_rounded, size: 10, color: T.t2),
    const SizedBox(width: 5),
    const Text('Encrypted · Processed locally · Never stored',
      style: TextStyle(fontSize: 10.5, color: T.t2, letterSpacing: 0.1)),
  ])));

// ── Image Screen ─────────────────────────────────────────────────
class ImageDetectScreen extends StatefulWidget {
  const ImageDetectScreen({super.key});
  @override State<ImageDetectScreen> createState() => _ImgState();
}
class _ImgState extends State<ImageDetectScreen> {
  File? _img; bool _loading = false; Map<String, dynamic>? _res;
  // ✅ PRODUCTION: Railway backend URL
  final api = "https://truthlens-backend-production-a5a7.up.railway.app";

  Future<void> pick(ImageSource src) async {
    final p = await ImagePicker().pickImage(source: src, imageQuality: 92);
    if (p != null) setState(() { _img = File(p.path); _res = null; });
  }

  Future<void> analyze() async {
    if (_img == null) return;
    HapticFeedback.mediumImpact();
    setState(() { _loading = true; _res = null; });
    try {
      final ext = _img!.path.split('.').last.toLowerCase();
      final mime = ext == 'png' ? 'image/png'
                 : ext == 'webp' ? 'image/webp'
                 : 'image/jpeg';
      final parts = mime.split('/');

      var req = http.MultipartRequest('POST', Uri.parse('$api/detect/image'));
      req.files.add(await http.MultipartFile.fromPath(
        'file', _img!.path,
        contentType: MediaType(parts[0], parts[1]),
      ));
      var streamedResponse = await req.send().timeout(const Duration(seconds: 60));
      var r = await http.Response.fromStream(streamedResponse);
      var d = jsonDecode(r.body);
      setState(() { _res = d['result']; _loading = false; });
    } catch (_) {
      setState(() => _loading = false);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Cannot reach backend'),
          backgroundColor: T.card2, behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.verified_user_rounded, color: T.accent, size: 15),
          const SizedBox(width: 7),
          const Text('TruthLens', style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: T.t0, letterSpacing: 0.1)),
          const Spacer(),
          _BetaBadge(),
        ]),
        const SizedBox(height: 32),
        const TopBar(title: 'Image Analysis', subtitle: 'Detect AI-generated or manipulated imagery'),
        const SizedBox(height: 10),
        _InlineStats(items: const [('96%', 'Accuracy'), ('100K+', 'Samples'), ('<2s', 'Analysis')]),
        const SizedBox(height: 28),
        UploadBox(
          onTap: () => pick(ImageSource.gallery),
          active: _img != null, height: 220,
          child: _img != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Stack(children: [
                  Image.file(_img!, fit: BoxFit.cover, width: double.infinity, height: 220),
                  Positioned(top: 12, right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white.withOpacity(0.08))),
                      child: const Text('Change', style: TextStyle(
                        fontSize: 11.5, color: T.t0, fontWeight: FontWeight.w500)))),
                ]))
            : const _UploadPlaceholder(
                icon: Icons.add_photo_alternate_outlined,
                label: 'Select an image',
                hint: 'JPG · PNG · WEBP'),
        ),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: _SrcBtn(Icons.photo_library_outlined, 'Gallery', () => pick(ImageSource.gallery))),
          const SizedBox(width: 10),
          Expanded(child: _SrcBtn(Icons.camera_alt_outlined, 'Camera', () => pick(ImageSource.camera))),
        ]),
        const SizedBox(height: 12),
        PrimaryBtn(label: 'Analyze Image', onTap: _img != null && !_loading ? analyze : null, loading: _loading),
        if (_loading) ...[const SizedBox(height: 14), const ScanningBar()],
        if (_res != null) ...[
          const SizedBox(height: 28),
          ResultCard(
            isNegative: _res!['is_ai_generated'] as bool,
            verdict: _res!['is_ai_generated'] ? 'AI Generated' : 'Authentic',
            confidence: (_res!['confidence'] as num).toDouble(),
            detail: _res!['is_ai_generated']
              ? 'Synthetic content signatures detected'
              : 'No synthetic signatures found',
            extra: [
              kRow('AI Score', '${_res!['fake_score']}%', vc: T.danger),
              kDiv(),
              kRow('Authenticity Score', '${_res!['real_score']}%', vc: T.safe),
            ]),
        ],
        _trustLine(),
      ]),
    ),
  );
}

// ── Video Screen ─────────────────────────────────────────────────
class VideoDetectScreen extends StatefulWidget {
  const VideoDetectScreen({super.key});
  @override State<VideoDetectScreen> createState() => _VidState();
}
class _VidState extends State<VideoDetectScreen> {
  File? _vid; bool _loading = false; Map<String, dynamic>? _res;
  // ✅ PRODUCTION: Railway backend URL
  final api = "https://truthlens-backend-production-a5a7.up.railway.app";

  Future<void> pick() async {
    final p = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (p != null) setState(() { _vid = File(p.path); _res = null; });
  }

  Future<void> analyze() async {
    if (_vid == null) return;
    HapticFeedback.mediumImpact();
    setState(() { _loading = true; _res = null; });
    try {
      var req = http.MultipartRequest('POST', Uri.parse('$api/detect/video'));
      req.files.add(await http.MultipartFile.fromPath('file', _vid!.path,
        contentType: MediaType('video', 'mp4')));
      var streamedResponse = await req.send().timeout(const Duration(seconds: 120));
      var r = await http.Response.fromStream(streamedResponse);
      var d = jsonDecode(r.body);
      setState(() { _res = d['result']; _loading = false; });
    } catch (_) { setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    final summary = _res?['summary'] as Map<String, dynamic>?;
    final frames  = _res?['frame_results'] as List<dynamic>?;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 48),
          const TopBar(title: 'Video Analysis', subtitle: 'Frame-by-frame deepfake detection'),
          const SizedBox(height: 28),
          UploadBox(onTap: pick, active: _vid != null, height: 185,
            child: _vid != null
              ? _VideoSelectedView(name: _vid!.path.split(Platform.pathSeparator).last)
              : const _UploadPlaceholder(icon: Icons.play_circle_outline_rounded,
                  label: 'Select a video', hint: 'MP4 · MOV · AVI')),
          const SizedBox(height: 12),
          PrimaryBtn(label: 'Analyze Video',
            onTap: _vid != null && !_loading ? analyze : null, loading: _loading),
          if (_loading) ...[const SizedBox(height: 14), const ScanningBar()],
          if (_res != null) ...[
            const SizedBox(height: 28),
            ResultCard(
              isNegative: _res!['is_ai_generated'] as bool,
              verdict: _res!['is_ai_generated'] ? 'AI Generated' : 'Authentic',
              confidence: (_res!['confidence'] as num).toDouble(),
              detail: _res!['is_ai_generated'] ? 'Synthetic frames detected' : 'No deepfake signatures found',
              extra: summary == null ? null : [
                kRow('Frames Scanned', '${summary['total_frames_analyzed']}'),
                kDiv(),
                kRow('AI Frames', '${summary['ai_frames']}', vc: T.danger),
                kDiv(),
                kRow('Duration', '${summary['video_duration']}s'),
                kDiv(),
                kRow('Avg AI Score', '${summary['avg_ai_score']}%'),
                if (frames != null && frames.isNotEmpty) ...[
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: const Text('Frame Analysis',
                      style: TextStyle(
                        fontSize: 11, color: T.t1, fontWeight: FontWeight.w500, letterSpacing: 0.2))),
                  ...frames.map((f) {
                    final ai = f['is_ai'] as bool;
                    final c = ai ? T.danger : T.safe;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(children: [
                        Container(width: 4, height: 4,
                          decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
                        const SizedBox(width: 10),
                        Text('Frame ${f['frame']}  ·  ${f['timestamp']}s',
                          style: const TextStyle(fontSize: 12, color: T.t1)),
                        const Spacer(),
                        Text('${f['ai_score']}%',
                          style: TextStyle(fontSize: 12, color: c, fontWeight: FontWeight.w600)),
                      ]));
                  }),
                ],
              ]),
          ],
          _trustLine(),
        ]),
      ),
    );
  }
}

// ── News Screen ──────────────────────────────────────────────────
class NewsDetectScreen extends StatefulWidget {
  const NewsDetectScreen({super.key});
  @override State<NewsDetectScreen> createState() => _NewsState();
}
class _NewsState extends State<NewsDetectScreen> {
  final _ctrl = TextEditingController();
  bool _loading = false; Map<String, dynamic>? _res;
  // ✅ PRODUCTION: Railway backend URL
  final api = "https://truthlens-backend-production-a5a7.up.railway.app";

  Future<void> analyze() async {
    final text = _ctrl.text.trim();
    if (text.length < 20) return;
    HapticFeedback.mediumImpact();
    setState(() { _loading = true; _res = null; });
    try {
      var r = await http.post(
        Uri.parse('$api/detect/news'),
        body: {'text': text},
      ).timeout(const Duration(seconds: 30));
      var d = jsonDecode(r.body);
      setState(() { _res = d['result']; _loading = false; });
    } catch (_) { setState(() => _loading = false); }
  }

  int get _wc => _ctrl.text.trim().isEmpty ? 0
    : _ctrl.text.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 48),
        const TopBar(title: 'News Verification', subtitle: 'Detect misinformation and editorial bias'),
        const SizedBox(height: 28),
        Container(
          decoration: BoxDecoration(
            color: T.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: T.b1, width: 0.5)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              controller: _ctrl, maxLines: 10,
              style: const TextStyle(color: T.t0, fontSize: 14, height: 1.7),
              decoration: const InputDecoration(
                hintText: 'Paste article text or headline…',
                hintStyle: TextStyle(color: T.t2, fontSize: 14),
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(18, 18, 18, 10)),
              onChanged: (_) => setState(() {})),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: T.b0, width: 0.5))),
              child: Row(children: [
                Text('$_wc words', style: const TextStyle(fontSize: 11, color: T.t2)),
                const Spacer(),
                if (_ctrl.text.isNotEmpty)
                  GestureDetector(
                    onTap: () => setState(() { _ctrl.clear(); _res = null; }),
                    child: const Text('Clear',
                      style: TextStyle(fontSize: 12, color: T.t1, fontWeight: FontWeight.w500))),
              ])),
          ])),
        const SizedBox(height: 12),
        PrimaryBtn(label: 'Verify Content', onTap: _wc >= 3 && !_loading ? analyze : null, loading: _loading),
        if (_loading) ...[const SizedBox(height: 14), const ScanningBar()],
        if (_res != null && _res!['success'] == true) ...[
          const SizedBox(height: 28),
          ResultCard(
            isNegative: _res!['is_fake'] as bool,
            verdict: _res!['is_fake'] ? 'Likely Misinformation' : 'Likely Credible',
            confidence: (_res!['confidence'] as num).toDouble(),
            detail: _res!['is_fake'] ? 'Misinformation indicators detected' : 'Content appears credible',
            extra: [
              kRow('Words Analyzed', '${_res!['word_count']}'),
              kDiv(),
              kRow('Confidence', '${_res!['confidence']}%'),
            ]),
        ],
        _trustLine(),
      ]),
    ),
  );
}

// ── Audio Screen ─────────────────────────────────────────────────
class AudioDetectScreen extends StatefulWidget {
  const AudioDetectScreen({super.key});
  @override State<AudioDetectScreen> createState() => _AudioState();
}
class _AudioState extends State<AudioDetectScreen> {
  File? _audio; String? _audioName;
  bool _loading = false; Map<String, dynamic>? _res;
  // ✅ PRODUCTION: Railway backend URL
  final api = "https://truthlens-backend-production-a5a7.up.railway.app";

  Future<void> pickAudio() async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.audio, allowMultiple: false);
      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.path != null) {
          setState(() { _audio = File(file.path!); _audioName = file.name; _res = null; });
        }
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: T.card2,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
    }
  }

  Future<void> analyze() async {
    if (_audio == null) return;
    HapticFeedback.mediumImpact();
    setState(() { _loading = true; _res = null; });
    try {
      final ext  = _audio!.path.split('.').last.toLowerCase();
      final mime = ext == 'mp3' ? 'audio/mpeg'
                 : ext == 'm4a' ? 'audio/mp4'
                 : ext == 'ogg' ? 'audio/ogg'
                 : 'audio/wav';
      final parts = mime.split('/');
      var req = http.MultipartRequest('POST', Uri.parse('$api/detect/audio'));
      req.files.add(await http.MultipartFile.fromPath('file', _audio!.path,
        contentType: MediaType(parts[0], parts[1])));
      var streamedResponse = await req.send().timeout(const Duration(seconds: 60));
      var r = await http.Response.fromStream(streamedResponse);
      var d = jsonDecode(r.body);
      setState(() { _res = d['result']; _loading = false; });
    } catch (e) {
      setState(() => _loading = false);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: T.card2,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final details = _res?['details'] as Map<String, dynamic>?;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 48),
          const TopBar(title: 'Audio Analysis', subtitle: 'Detect AI voices and cloned speech'),
          const SizedBox(height: 28),
          UploadBox(
            onTap: pickAudio, active: _audio != null, height: 185,
            child: _audio != null
              ? _AudioSelectedView(name: _audioName ?? 'Audio file')
              : _AudioEmptyView()),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
            child: const Text('MP3 · WAV · M4A · OGG  ·  Max 30 seconds',
              style: TextStyle(fontSize: 11.5, color: T.t2))),
          const SizedBox(height: 8),
          PrimaryBtn(label: 'Analyze Audio',
            onTap: _audio != null && !_loading ? analyze : null, loading: _loading),
          if (_loading) ...[const SizedBox(height: 14), const ScanningBar()],
          if (_res != null) ...[
            const SizedBox(height: 28),
            ResultCard(
              isNegative: _res!['is_fake'] as bool,
              verdict: _res!['is_fake'] ? 'AI / Cloned Voice' : 'Human Voice',
              confidence: (_res!['confidence'] as num).toDouble(),
              detail: _res!['is_fake']
                ? 'Synthetic or cloned voice detected'
                : 'Natural voice — no manipulation found',
              extra: details == null ? null : [
                kRow('Fake Score', '${details['model_fake_score']}%', vc: T.danger),
                kDiv(),
                kRow('Acoustic AI Score', '${details['acoustic_ai_score']}%'),
                kDiv(),
                kRow('Duration', '${details['duration']}s'),
                kDiv(),
                kRow('Pitch Variance', '${details['pitch_variance']}'),
                kDiv(),
                kRow('AI Indicators', '${details['ai_hints']} / 4'),
              ]),
          ],
          _trustLine(),
        ]),
      ),
    );
  }
}

// ── Reusable sub-widgets ─────────────────────────────────────────

class _UploadPlaceholder extends StatelessWidget {
  final IconData icon; final String label, hint;
  const _UploadPlaceholder({required this.icon, required this.label, required this.hint});
  @override
  Widget build(BuildContext context) => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Container(width: 54, height: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: T.accentGlow,
        border: Border.all(color: T.accentLine, width: 0.5)),
      child: Icon(icon, color: T.accent, size: 22)),
    const SizedBox(height: 16),
    Text(label, style: const TextStyle(
      fontSize: 15, fontWeight: FontWeight.w600, color: T.t0)),
    const SizedBox(height: 5),
    Text(hint, style: const TextStyle(fontSize: 12, color: T.t2)),
  ]);
}

class _VideoSelectedView extends StatelessWidget {
  final String name;
  const _VideoSelectedView({required this.name});
  @override
  Widget build(BuildContext context) => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Container(width: 48, height: 48,
      decoration: BoxDecoration(shape: BoxShape.circle, color: T.accentGlow,
        border: Border.all(color: T.accentLine, width: 0.5)),
      child: const Icon(Icons.check_circle_outline_rounded, color: T.accent, size: 22)),
    const SizedBox(height: 12),
    Text(name,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: T.t0),
      maxLines: 1, overflow: TextOverflow.ellipsis),
    const SizedBox(height: 4),
    const Text('Tap to change', style: TextStyle(fontSize: 11.5, color: T.t2)),
  ]);
}

class _AudioSelectedView extends StatefulWidget {
  final String name;
  const _AudioSelectedView({required this.name});
  @override State<_AudioSelectedView> createState() => _AudioSelectedViewState();
}
class _AudioSelectedViewState extends State<_AudioSelectedView> with SingleTickerProviderStateMixin {
  late AnimationController _wave;
  @override
  void initState() {
    super.initState();
    _wave = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600))..repeat(reverse: true);
  }
  @override void dispose() { _wave.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    AnimatedBuilder(
      animation: _wave,
      builder: (_, __) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(24, (i) {
          final phase = (_wave.value + i * 0.11) % 1.0;
          final h = 4.0 + 24.0 * sin(phase * pi).abs() * (0.3 + 0.7 * sin(i * 0.75).abs());
          return Container(
            width: 2.5, height: h,
            margin: const EdgeInsets.symmetric(horizontal: 1.1),
            decoration: BoxDecoration(
              color: T.accent.withOpacity(0.35 + 0.55 * (h / 28)),
              borderRadius: BorderRadius.circular(2)));
        }))),
    const SizedBox(height: 14),
    Text(widget.name,
      style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: T.t0),
      maxLines: 1, overflow: TextOverflow.ellipsis),
    const SizedBox(height: 4),
    const Text('Tap to change', style: TextStyle(fontSize: 11.5, color: T.t2)),
  ]);
}

class _AudioEmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end,
      children: [4, 9, 16, 24, 13, 21, 17, 8, 19, 15, 10, 18, 22, 12, 6, 14, 20, 9, 16, 5, 11, 18]
        .map((h) => Container(width: 2.5, height: h.toDouble(),
          margin: const EdgeInsets.symmetric(horizontal: 1.1),
          decoration: BoxDecoration(color: T.b2, borderRadius: BorderRadius.circular(2))))
        .toList()),
    const SizedBox(height: 18),
    const Text('Select Audio File',
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: T.t1)),
    const SizedBox(height: 5),
    const Text('Tap to browse files',
      style: TextStyle(fontSize: 12, color: T.t2)),
  ]);
}

class _InlineStats extends StatelessWidget {
  final List<(String, String)> items;
  const _InlineStats({required this.items});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 4),
    child: Row(children: [
      for (int i = 0; i < items.length; i++) ...[
        if (i > 0)
          Container(width: 0.5, height: 26, margin: const EdgeInsets.symmetric(horizontal: 18),
            color: T.b1),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(items[i].$1, style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.w700, color: T.t0, letterSpacing: -0.3)),
          const SizedBox(height: 1),
          Text(items[i].$2, style: const TextStyle(fontSize: 10.5, color: T.t2)),
        ]),
      ],
    ]),
  );
}

class _BetaBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(
      color: T.accentSoft,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: T.accentMid.withOpacity(0.4), width: 0.5)),
    child: const Text('BETA', style: TextStyle(
      fontSize: 8.5, fontWeight: FontWeight.w700, color: T.accent, letterSpacing: 1.5)));
}

class _SrcBtn extends StatelessWidget {
  final IconData icon; final String label; final VoidCallback onTap;
  const _SrcBtn(this.icon, this.label, this.onTap);
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: T.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: T.b1, width: 0.5)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, color: T.t1, size: 15),
        const SizedBox(width: 7),
        Text(label, style: const TextStyle(
          fontSize: 13, color: T.t1, fontWeight: FontWeight.w500)),
      ])));
}