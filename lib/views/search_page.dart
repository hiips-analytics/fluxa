import 'package:flutter/material.dart';
import 'product_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedLocation = "Toutes les zones";
  String _selectedCategory = "Tout";
  String _sortBy = "Pertinence";
  bool _isSearching = false;

  final List<String> _categories = [
    "Tout",
    "Alimentation",
    "Électronique",
    "Mode",
    "Maison",
    "Santé",
    "Agriculture"
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final isNotEmpty = _searchController.text.isNotEmpty;
      if (isNotEmpty != _isSearching) {
        setState(() {
          _isSearching = isNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            const Text("Filtrer par quartier",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ...["Toutes les zones", "Bastos", "Akwa", "Bonanjo", "Melen", "Essos"]
                .map((loc) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: _selectedLocation == loc
                            ? const Color(0xFFFFC90E).withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: Text(loc,
                            style: TextStyle(
                                color: _selectedLocation == loc
                                    ? Colors.orange[900]
                                    : Colors.black87,
                                fontWeight: _selectedLocation == loc
                                    ? FontWeight.bold
                                    : FontWeight.normal)),
                        trailing: _selectedLocation == loc
                            ? const Icon(Icons.check_circle,
                                color: Color(0xFFFFC90E))
                            : null,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onTap: () {
                          setState(() => _selectedLocation = loc);
                          Navigator.pop(context);
                        },
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Rechercher",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFC90E),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryFilters(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _isSearching
                  ? _buildSearchResults()
                  : _buildSearchSuggestions(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: const Color(0xFFFFC90E),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Produit, marque...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: _isSearching
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () => _searchController.clear(),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildFilterButton(Icons.tune, _showFilterSheet),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = _selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(cat),
              selected: isSelected,
              onSelected: (val) => setState(() => _selectedCategory = cat),
              selectedColor: const Color(0xFFFFC90E),
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              elevation: isSelected ? 2 : 0,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                      color: isSelected ? Colors.transparent : Colors.grey[200]!)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    return SingleChildScrollView(
      key: const ValueKey("suggestions"),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.orange[50], shape: BoxShape.circle),
                  child: Icon(Icons.search_rounded,
                      size: 60, color: Colors.orange[300]),
                ),
                const SizedBox(height: 16),
                const Text("Trouvez les meilleurs prix",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
                const SizedBox(height: 8),
                Text("Entrez un nom de produit pour commencer",
                    style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: const [
              Icon(Icons.trending_up, color: Colors.orange, size: 20),
              SizedBox(width: 8),
              Text("Recherches populaires",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ["Huile", "iPhone 15", "Lait", "Riz", "Savon", "Pâtes", "Café"]
                .map((term) => InkWell(
                      onTap: () {
                        _searchController.text = term;
                        _searchController.selection = TextSelection.fromPosition(
                            TextPosition(offset: _searchController.text.length));
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[200]!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(term,
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Column(
      key: const ValueKey("results"),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("6 résultats trouvés",
                  style: TextStyle(
                      color: Colors.grey[700], fontWeight: FontWeight.w600)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[200]!)),
                child: DropdownButton<String>(
                  value: _sortBy,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.expand_more, size: 18),
                  items: ["Pertinence", "Prix croissant", "Plus proche"]
                      .map((s) => DropdownMenuItem(
                          value: s,
                          child: Text(s, style: const TextStyle(fontSize: 13))))
                      .toList(),
                  onChanged: (val) => setState(() => _sortBy = val!),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 6,
            itemBuilder: (context, index) => _buildSearchResultCard(index),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResultCard(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductDetailPage())),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(15)),
                      child: const Icon(Icons.shopping_basket_outlined,
                          color: Colors.orange, size: 40),
                    ),
                    if (index % 2 == 0)
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(10))),
                          child: const Text("-10%",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Lait Bonnet Rouge 1L",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black87)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.store, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text("Mahima",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 14, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text("Quartier Bastos",
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text("1 150 FCFA",
                          style: TextStyle(
                              color: Colors.orange[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.grey[300], size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
