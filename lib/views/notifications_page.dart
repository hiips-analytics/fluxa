import 'package:flutter/material.dart';
import 'product_detail_page.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<Map<String, dynamic>> _notifications = [
    {
      "title": "Baisse de prix sur iPhone 15 !",
      "desc": "Le prix est passé de 700 000 FCFA à 650 000 FCFA chez Santa Lucia.",
      "time": "Il y a 2h",
      "isRead": false,
      "type": "drop"
    },
    {
      "title": "Stock disponible : Lait Bonnet Rouge",
      "desc": "Le produit est de nouveau en stock chez Dovv Bastos.",
      "time": "Il y a 5h",
      "isRead": false,
      "type": "stock"
    },
    {
      "title": "Offre Flash : -20% sur le Riz",
      "desc": "Profitez d'une réduction exceptionnelle chez Mahima Akwa.",
      "time": "Hier",
      "isRead": true,
      "type": "promo"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Notifications",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFC90E),
        elevation: 0,
        actions: [
          if (_notifications.isNotEmpty)
            TextButton(
              onPressed: () {
                setState(() {
                  for (var n in _notifications) {
                    n['isRead'] = true;
                  }
                });
              },
              child:
                  const Text("Tout marquer comme lu", style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _buildNotificationItem(notification, index);
              },
            ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> n, int index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: Colors.redAccent, borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (dir) {
        setState(() => _notifications.removeAt(index));
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
              color: n['isRead']
                  ? Colors.transparent
                  : Colors.orange.withOpacity(0.2)),
        ),
        child: ListTile(
          onTap: () {
            setState(() => n['isRead'] = true);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductDetailPage()));
          },
          leading: _buildIconByType(n['type']),
          title: Text(n['title'],
              style: TextStyle(
                  fontWeight:
                      n['isRead'] ? FontWeight.normal : FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(n['desc'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              const SizedBox(height: 5),
              Text(n['time'],
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          isThreeLine: true,
          trailing: n['isRead']
              ? null
              : const CircleAvatar(radius: 4, backgroundColor: Colors.orange),
        ),
      ),
    );
  }

  Widget _buildIconByType(String type) {
    IconData icon;
    Color color;
    switch (type) {
      case 'drop':
        icon = Icons.trending_down;
        color = Colors.green;
        break;
      case 'stock':
        icon = Icons.inventory_2_outlined;
        color = Colors.blue;
        break;
      default:
        icon = Icons.local_offer_outlined;
        color = Colors.orange;
    }
    return Container(
      padding: const EdgeInsets.all(8),
      decoration:
          BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none_rounded,
              size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text("Aucune notification",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
