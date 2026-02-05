import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pubchem/app/core/base/app_theme.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/presentation/more/controllers/locale_controller.dart';
import 'package:pubchem/app/presentation/more/controllers/theme_controller.dart';
import 'package:pubchem/app/presentation/more/widgets/settings_section.dart';
import 'package:pubchem/app/presentation/more/widgets/settings_tile.dart';
import 'package:pubchem/app/presentation/more/widgets/settings_switch_tile.dart';
import 'package:pubchem/l10n/app_localizations.dart';

class MorePage extends ConsumerStatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  ConsumerState<MorePage> createState() => _MorePageState();
}

class _MorePageState extends ConsumerState<MorePage> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeControllerProvider);
    final currentLocale = ref.watch(localeControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark 
          ? AppColors.darkBackground 
          : AppColors.lightBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          AppLocalizations.of(context)!.moreSettings,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        backgroundColor: isDark 
            ? AppColors.darkBackground 
            : AppColors.lightBackground,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            
            // APPEARANCE & PREFERENCES Section
            SettingsSection(
              title: AppLocalizations.of(context)!.appearanceAndPreferences,
              children: [
                SettingsSwitchTile(
                  icon: Icons.dark_mode_outlined,
                  iconColor: AppColors.settingsIndigo, // Indigo
                  title: AppLocalizations.of(context)!.darkMode,
                  subtitle: AppLocalizations.of(context)!.premium,
                  value: currentTheme == AppTheme.DARK,
                  onChanged: (value) {
                    ref.read(themeControllerProvider.notifier).setTheme(
                      value ? AppTheme.DARK : AppTheme.LIGHT,
                    );
                  },
                  showDivider: true,
                ),
                SettingsTile(
                  icon: Icons.language,
                  iconColor: AppColors.settingsBlue, // Blue
                  title: AppLocalizations.of(context)!.language,
                  subtitle: currentLocale.languageCode == 'en'
                      ? AppLocalizations.of(context)!.englishUS
                      : AppLocalizations.of(context)!.bengali,
                  trailing: Icon(
                    Icons.keyboard_arrow_down,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                  onTap: () => _showLanguageDialog(),
                  showDivider: false,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // SECURITY & ALERTS Section
            SettingsSection(
              title: AppLocalizations.of(context)!.securityAndAlerts,
              children: [
                SettingsTile(
                  icon: Icons.notifications_outlined,
                  iconColor: AppColors.settingsPurple, // Purple
                  title: AppLocalizations.of(context)!.notifications,
                  trailing: Icon(
                    Icons.chevron_right,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                  onTap: () {
                    // TODO: Navigate to notifications settings
                  },
                  showDivider: true,
                ),
                SettingsTile(
                  icon: Icons.lock_outline,
                  iconColor: AppColors.settingsPink, // Pink
                  title: AppLocalizations.of(context)!.privacyAndData,
                  trailing: Icon(
                    Icons.chevron_right,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                  onTap: () {
                    // TODO: Navigate to privacy settings
                  },
                  showDivider: false,
                ),
              ],
            ),

            const SizedBox(height: 40),

            // About Section
            _buildAboutSection(isDark),

            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(bool isDark) {
    return Center(
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.aboutPubChemExplorer,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.empoweringChemicalIntelligence,
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.version,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              color: isDark
                  ? AppColors.darkTextSecondary.withOpacity(0.6)
                  : AppColors.lightTextSecondary.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          // Molecule dots decoration
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDot(isDark, 6),
              const SizedBox(width: 4),
              _buildDot(isDark, 8),
              const SizedBox(width: 4),
              _buildDot(isDark, 6),
              const SizedBox(width: 12),
              _buildDot(isDark, 6),
              const SizedBox(width: 4),
              _buildDot(isDark, 8),
              const SizedBox(width: 4),
              _buildDot(isDark, 6),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDot(bool isDark, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isDark 
            ? AppColors.darkTextSecondary.withOpacity(0.3) 
            : AppColors.lightTextSecondary.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
    );
  }

  void _showLanguageDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: isDark
            ? AppColors.darkSurface
            : AppColors.lightCardBackground,
        title: Text(
          AppLocalizations.of(context)!.selectLanguage,
          style: TextStyle(
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(dialogContext, 'en', AppLocalizations.of(context)!.englishUS, isDark),
            _buildLanguageOption(dialogContext, 'bn', AppLocalizations.of(context)!.bengali, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext dialogContext, String languageKey, String languageLabel, bool isDark) {
    final currentLocale = ref.watch(localeControllerProvider);
    final isSelected = currentLocale.languageCode == languageKey;

    return ListTile(
      title: Text(
        languageLabel,
        style: TextStyle(
          color: isDark
              ? AppColors.darkTextPrimary
              : AppColors.lightTextPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: AppColors.accent)
          : null,
      onTap: () {
        ref.read(localeControllerProvider.notifier).setLocale(Locale(languageKey, ''));
        Navigator.of(dialogContext).pop();
      },
    );
  }
}