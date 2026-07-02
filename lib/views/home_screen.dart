import 'package:alive_app/views/chats_screen.dart';
import 'package:alive_app/views/live_screen.dart';
import 'package:alive_app/views/party_screen.dart';
import 'package:alive_app/views/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:alive_app/core/constants/colors.dart';

/// ─────────────────────────────────────────────
///  HOME SCREEN - Social/Live Streaming Style
///  Matches the provided UI design
/// ─────────────────────────────────────────────

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ── State ─────────────────────────────────
  int _selectedNavIndex = 0;

  // Create separate widgets for each tab
  final List<Widget> _pages = [
    const HomeContent(), // Home tab content
    const PartyScreen(), // Party tab
    const LiveScreen(), // Live tab (for Go Live button)
    const ChatsScreen(), // Chats tab
    const ProfileScreen(), // Profile tab
  ];

  // ── BUILD ──────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ── App Bar ─────────────────────────────
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(color: AppColors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // App Logo / Title
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                        ),
                      ),
                      child: Center(
                        child: Image.asset('assets/alive_logo.png'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Alive',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),

                // Right actions
                Row(
                  children: [
                    _buildIconButton(Icons.search_outlined, () {
                      debugPrint('Search tapped');
                    }),
                    const SizedBox(width: 4),
                    _buildIconButton(Icons.notifications_outlined, () {
                      debugPrint('Notifications tapped');
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // ── Body with IndexedStack ──────────────
      body: IndexedStack(index: _selectedNavIndex, children: _pages),

      // ── Bottom Navigation Bar ──────────────
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedNavIndex,
        height: 65,
        backgroundColor: Colors.transparent,
        color: AppColors.white,
        buttonBackgroundColor: AppColors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
        items: [
          // Home
          _buildNavItem(icon: Icons.home_filled, label: 'Home', index: 0),

          // Party
          _buildNavItem(icon: Icons.celebration, label: 'Party', index: 1),

          // Go Live (Special Button)
          _buildGoLiveButton(),

          // Chats
          _buildNavItem(
            icon: Icons.chat_bubble_outline,
            label: 'Chats',
            index: 3,
          ),

          // Profile
          _buildNavItem(icon: Icons.person_outline, label: 'Profile', index: 4),
        ],
      ),
    );
  }

  // ── Helper Widgets ──────────────────────────

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return IconButton(
      icon: Icon(icon, color: AppColors.black, size: 24),
      onPressed: onTap,
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _selectedNavIndex == index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? AppColors.primary : AppColors.grey,
          size: 28,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.grey,
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildGoLiveButton() {
    return GestureDetector(
      onTap: () {
        // Navigate to Live tab when Go Live button is pressed
        setState(() {
          _selectedNavIndex = 2;
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.bottomStart, AppColors.bottomEnd],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

// ── Home Content Widget (Separate from HomeScreen) ──
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<_Streamer> _streamers = [
    _Streamer(
      name: 'Sofia Chen',
      viewers: '8.2K',
      avatar: 'https://i.pravatar.cc/150?img=1',
      isLive: true,
      isFollowed: false,
    ),
    _Streamer(
      name: 'Emma Watson',
      viewers: '8.2K',
      avatar: 'https://i.pravatar.cc/150?img=2',
      isLive: true,
      isFollowed: false,
    ),
    _Streamer(
      name: 'Sofía Chen',
      viewers: '8.2K',
      avatar: 'https://i.pravatar.cc/150?img=3',
      isLive: true,
      isFollowed: false,
    ),
    _Streamer(
      name: 'Olivia Chen',
      viewers: '8.2K',
      avatar: 'https://i.pravatar.cc/150?img=4',
      isLive: true,
      isFollowed: false,
    ),
    _Streamer(
      name: 'Sophia Chen',
      viewers: '8.4K',
      avatar: 'https://i.pravatar.cc/150?img=5',
      isLive: true,
      isFollowed: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // ── Stream / Hot / Follow Buttons ──
          Row(
            children: [
              _buildFilterChip('Stream', isSelected: true),
              const SizedBox(width: 12),
              _buildFilterChip('Hot'),
              const SizedBox(width: 12),
              _buildFilterChip('Follow'),
            ],
          ),

          const SizedBox(height: 16),

          // ── Country/Region Filters ──────────
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildRegionChip('Global', isSelected: true),
                const SizedBox(width: 8),
                _buildRegionChip('India'),
                const SizedBox(width: 8),
                _buildRegionChip('Philippines'),
                const SizedBox(width: 8),
                _buildRegionChip('Brazil'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Live Streamers Grid ────────────
          Text(
            'Live Now',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 14),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.75,
            ),
            itemCount: _streamers.length,
            itemBuilder: (context, index) {
              final streamer = _streamers[index];
              return _buildStreamerCard(streamer);
            },
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () => debugPrint('$label filter tapped'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.lightGrey,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.grey,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildRegionChip(String label, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () => debugPrint('$label region tapped'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.lightGrey,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.grey,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildStreamerCard(_Streamer streamer) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stream preview
          Expanded(
            child: Stack(
              children: [
                // Background image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://picsum.photos/seed/${streamer.name}/300/400',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient overlay at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                // Viewers count - top right
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.visibility,
                          color: Colors.white,
                          size: 12,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          streamer.viewers,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // User info - bottom overlay
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundImage: NetworkImage(streamer.avatar),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          streamer.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.followButton,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '+ Follow',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data Models ─────────────────────────────────
class _Streamer {
  final String name;
  final String viewers;
  final String avatar;
  final bool isLive;
  final bool isFollowed;

  _Streamer({
    required this.name,
    required this.viewers,
    required this.avatar,
    this.isLive = true,
    this.isFollowed = false,
  });
}
