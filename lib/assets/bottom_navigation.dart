import 'package:flutter/material.dart';
import 'package:estaciona_facil/assets/app_colors.dart';

typedef OnNavItemTap = void Function(int index);

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final OnNavItemTap onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  Widget buildNavItem({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon),
          color:
              selected
                  ? Colors.grey
                  : Colors.white, // Destaque para selecionado
          iconSize: 38,
          onPressed: onPressed,
        ),
        Text(
          label,
          style: TextStyle(
            color: selected ? Colors.grey : Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.corPrincipal,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavItem(
            icon: Icons.home,
            label: 'Home',
            selected: currentIndex == 0,
            onPressed: () => onTap(0),
          ),
          buildNavItem(
            icon: Icons.account_balance_wallet,
            label: 'Saldo',
            selected: currentIndex == 1,
            onPressed: () => onTap(1),
          ),
          buildNavItem(
            icon: Icons.directions_car,
            label: 'Veículos',
            selected: currentIndex == 2,
            onPressed: () => onTap(2),
          ),
          // Botão Menu que abre modal bottom sheet
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.white, size: 32),
                    onPressed: () => onTap(3),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
