import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/core/widgets/app_scaffold.dart';
import 'package:visual_algo/core/widgets/glass_app_bar.dart';
import 'package:visual_algo/core/widgets/glass_container.dart';
import 'package:visual_algo/features/auth/providers.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  static const routePath = '/home/profile';
  static const routeName = 'profile';

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  File? _localImage;
  bool _isUploading = false;
  String? _uploadedImageUrl;

  Future<void> _pickAndUploadImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    setState(() => _isUploading = true);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );
      if (result == null || result.files.isEmpty) {
        setState(() => _isUploading = false);
        return;
      }
      final fileBytes = result.files.first.bytes;
      final fileName = 'profile_${user.uid}.jpg';
      final storageRef = FirebaseStorage.instance.ref().child(
        'profile_images/$fileName',
      );
      try {
        await storageRef.delete();
      } catch (_) {}
      final uploadTask = await storageRef.putData(fileBytes!);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      await user.updatePhotoURL(downloadUrl);
      await user.reload();
      FirebaseAuth.instance.authStateChanges().listen((_) {});
      ref.invalidate(currentUserProvider);
      ref.invalidate(authStateChangesProvider);
      setState(() {
        _uploadedImageUrl = downloadUrl;
        _isUploading = false;
      });
    } catch (e) {
      debugPrint('❌ Error uploading image: $e');
      setState(() => _isUploading = false);
    }
  }

  Future<void> _editDisplayName(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final controller = TextEditingController(text: user.displayName ?? '');
    final theme = Theme.of(context);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Display Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Full name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await user.updateDisplayName(controller.text);
              await user.reload();
              ref.invalidate(currentUserProvider);
              ref.invalidate(authStateChangesProvider);
              if (context.mounted) Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final theme = Theme.of(context);
    final joinDate = user?.metadata.creationTime != null
        ? DateFormat('MMMM yyyy').format(user!.metadata.creationTime!)
        : DateFormat('MMMM yyyy').format(DateTime.now());
    final lastLogin = user?.metadata.lastSignInTime != null
        ? DateFormat(
            'dd MMM yyyy, hh:mm a',
          ).format(user!.metadata.lastSignInTime!)
        : 'Unknown';
    final photoUrl = _uploadedImageUrl ?? user?.photoURL;

    return AppScaffold(
      appBar: const GlassAppBar(title: 'Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white.withValues(alpha: 0.08),
                    backgroundImage: photoUrl != null
                        ? NetworkImage(photoUrl)
                        : null,
                    child: photoUrl == null
                        ? const Icon(
                            Icons.person_rounded,
                            size: 80,
                            color: Colors.white54,
                          )
                        : null,
                  ),
                  IconButton(
                    onPressed: _isUploading ? null : _pickAndUploadImage,
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.neonTeal.withValues(
                        alpha: 0.25,
                      ),
                    ),
                    icon: _isUploading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(
                            Icons.camera_alt_rounded,
                            color: AppColors.neonTeal,
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user?.displayName ?? 'Anonymous User',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _editDisplayName(context),
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                ],
              ),
              Text(
                user?.email ?? 'No email registered',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 24),
              GlassContainer(
                padding: const EdgeInsets.all(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.05),
                    Colors.white.withValues(alpha: 0.02),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Details',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Divider(thickness: 0.5, height: 18),
                    _detailRow('User ID', user?.uid ?? 'N/A'),
                    _detailRow('Joined', joinDate),
                    _detailRow('Last login', lastLogin),
                    _detailRow(
                      'Provider',
                      user?.providerData.first.providerId ?? 'Unknown',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GlassContainer(
                padding: const EdgeInsets.all(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.05),
                    Colors.white.withValues(alpha: 0.02),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Activity Overview',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Divider(thickness: 0.5, height: 18),
                    _activityRow(
                      Icons.calendar_today_rounded,
                      'Last Login',
                      lastLogin,
                    ),
                    _activityRow(
                      Icons.verified_user_rounded,
                      'Email Verified',
                      user?.emailVerified == true ? 'Yes ✅' : 'Not Verified ❌',
                    ),
                    _activityRow(
                      Icons.access_time_rounded,
                      'Member Since',
                      joinDate,
                    ),
                    _activityRow(
                      Icons.language_rounded,
                      'Sign-in Provider',
                      user?.providerData.first.providerId ?? 'Unknown',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GlassContainer(
                padding: const EdgeInsets.all(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.05),
                    Colors.white.withValues(alpha: 0.02),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Stats',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Divider(thickness: 0.5, height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statCard(
                          Icons.auto_awesome_rounded,
                          'Level',
                          'Intermediate',
                        ),
                        _statCard(
                          Icons.psychology_rounded,
                          'Problems Solved',
                          '128',
                        ),
                        _statCard(
                          Icons.local_fire_department_rounded,
                          'Streak',
                          '6 days',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statCard(Icons.leaderboard_rounded, 'Rank', 'Top 15%'),
                        _statCard(
                          Icons.access_time_filled_rounded,
                          'Total Time',
                          '14h 20m',
                        ),
                        _statCard(
                          Icons.star_rounded,
                          'Achievements',
                          '5 badges',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GlassContainer(
                padding: const EdgeInsets.all(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.05),
                    Colors.white.withValues(alpha: 0.02),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Achievements & Badges',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Divider(thickness: 0.5, height: 18),
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        _badgeTile('🔥', '6-Day Streak'),
                        _badgeTile('💡', 'Quick Thinker'),
                        _badgeTile('🏆', 'Top Performer'),
                        _badgeTile('🧠', 'Quiz Master'),
                        _badgeTile('⚡', 'Fast Solver'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.withValues(alpha: 0.2),
                  foregroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await ref.read(authViewModelProvider.notifier).signOut();

                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else {
                    if (mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/auth/sign-in',
                        (route) => false,
                      );
                    }
                  }
                },

                icon: const Icon(Icons.logout_rounded),
                label: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.neonTeal, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: const TextStyle(color: Colors.white70)),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(IconData icon, String title, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.neonTeal, size: 26),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 13, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _badgeTile(String emoji, String label) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
