import 'package:flutter/foundation.dart';

class MenuCategoriesProvider extends ChangeNotifier {
  int _selectedCategoryIndex = 0;
  
  final List<String> categories = [
    'Destaques',
    'Pratos',
    'Bebidas',
    'Sobremesas',
    'Acompanhamentos',
    'Vegetariano',
    'Vegano',
  ];

  int get selectedIndex => _selectedCategoryIndex;

  void selectCategory(int index) {
    if (index != _selectedCategoryIndex) {
      _selectedCategoryIndex = index;
      notifyListeners();
    }
  }
}

// Menu mock expandido com todas as categorias
final Map<String, List<Map<String, dynamic>>> expandedMenu = {
  'Destaques': [
    {
      'id': 'd1',
      'name': 'Picanha na Brasa',
      'description': 'Picanha grelhada com arroz, farofa e vinagrete',
      'price': 89.90,
      'imageUrl': 'assets/images/picanha.jpg',
      'isPopular': true,
    },
    {
      'id': 'd2',
      'name': 'Costela Premium',
      'description': 'Costela assada lentamente com temperos especiais',
      'price': 79.90,
      'imageUrl': 'assets/images/costela.jpg',
      'isPopular': true,
    },
    {
      'id': 'd3',
      'name': 'Mixed Grill',
      'description': 'Seleção especial de carnes grelhadas',
      'price': 99.90,
      'imageUrl': 'assets/images/mixed_grill.jpg',
      'isPopular': true,
    },
  ],
  'Pratos': [
    {
      'id': 'p1',
      'name': 'Fraldinha na Brasa',
      'description': 'Fraldinha grelhada com batatas rústicas',
      'price': 69.90,
      'imageUrl': 'assets/images/fraldinha.jpg',
    },
    {
      'id': 'p2',
      'name': 'Maminha ao Alho',
      'description': 'Maminha grelhada com molho de alho',
      'price': 65.90,
      'imageUrl': 'assets/images/maminha.jpg',
    },
    {
      'id': 'p3',
      'name': 'Linguiça Toscana',
      'description': 'Linguiça toscana grelhada com cebola',
      'price': 45.90,
      'imageUrl': 'assets/images/linguica.jpg',
    },
    {
      'id': 'p4',
      'name': 'File Mignon',
      'description': 'File Mignon grelhado com molho madeira',
      'price': 85.90,
      'imageUrl': 'assets/images/file_mignon.jpg',
    },
    {
      'id': 'p5',
      'name': 'Cupim na Brasa',
      'description': 'Cupim assado lentamente com especiarias',
      'price': 72.90,
      'imageUrl': 'assets/images/cupim.jpg',
    },
  ],
  'Bebidas': [
    {
      'id': 'b1',
      'name': 'Refrigerante',
      'description': 'Lata 350ml',
      'price': 5.90,
      'imageUrl': 'assets/images/refrigerante.jpg',
    },
    {
      'id': 'b2',
      'name': 'Suco Natural',
      'description': '500ml - Laranja, Limão, Maracujá ou Abacaxi',
      'price': 8.90,
      'imageUrl': 'assets/images/suco.jpg',
    },
    {
      'id': 'b3',
      'name': 'Cerveja',
      'description': 'Long neck 355ml',
      'price': 7.90,
      'imageUrl': 'assets/images/cerveja.jpg',
    },
    {
      'id': 'b4',
      'name': 'Água Mineral',
      'description': '500ml - Com ou sem gás',
      'price': 4.90,
      'imageUrl': 'assets/images/agua.jpg',
    },
    {
      'id': 'b5',
      'name': 'Chopp',
      'description': '400ml',
      'price': 12.90,
      'imageUrl': 'assets/images/chopp.jpg',
    },
    {
      'id': 'b6',
      'name': 'Caipirinha',
      'description': 'Limão, Morango ou Maracujá',
      'price': 16.90,
      'imageUrl': 'assets/images/caipirinha.jpg',
    },
  ],
  'Sobremesas': [
    {
      'id': 's1',
      'name': 'Pudim',
      'description': 'Pudim de leite com calda de caramelo',
      'price': 12.90,
      'imageUrl': 'assets/images/pudim.jpg',
    },
    {
      'id': 's2',
      'name': 'Petit Gateau',
      'description': 'Com sorvete de creme e calda de chocolate',
      'price': 15.90,
      'imageUrl': 'assets/images/petit_gateau.jpg',
    },
    {
      'id': 's3',
      'name': 'Sorvete',
      'description': '2 bolas com calda - Creme, Chocolate ou Morango',
      'price': 10.90,
      'imageUrl': 'assets/images/sorvete.jpg',
    },
    {
      'id': 's4',
      'name': 'Mousse de Maracujá',
      'description': 'Com calda de maracujá fresco',
      'price': 13.90,
      'imageUrl': 'assets/images/mousse.jpg',
    },
    {
      'id': 's5',
      'name': 'Pavê de Chocolate',
      'description': 'Tradicional pavê com chocolate belga',
      'price': 14.90,
      'imageUrl': 'assets/images/pave.jpg',
    },
  ],
  'Acompanhamentos': [
    {
      'id': 'a1',
      'name': 'Arroz Branco',
      'description': 'Porção individual',
      'price': 8.90,
      'imageUrl': 'assets/images/arroz.jpg',
    },
    {
      'id': 'a2',
      'name': 'Farofa Especial',
      'description': 'Com bacon e cebolinha',
      'price': 7.90,
      'imageUrl': 'assets/images/farofa.jpg',
    },
    {
      'id': 'a3',
      'name': 'Legumes Grelhados',
      'description': 'Mix de legumes na brasa',
      'price': 12.90,
      'imageUrl': 'assets/images/legumes.jpg',
    },
    {
      'id': 'a4',
      'name': 'Batatas Rústicas',
      'description': 'Com ervas finas',
      'price': 14.90,
      'imageUrl': 'assets/images/batatas.jpg',
    },
    {
      'id': 'a5',
      'name': 'Purê de Mandioquinha',
      'description': 'Cremoso com queijo',
      'price': 11.90,
      'imageUrl': 'assets/images/pure.jpg',
    },
  ],
  'Vegetariano': [
    {
      'id': 'v1',
      'name': 'Risoto de Cogumelos',
      'description': 'Com mix de cogumelos frescos e parmesão',
      'price': 45.90,
      'imageUrl': 'assets/images/risoto.jpg',
    },
    {
      'id': 'v2',
      'name': 'Berinjela Grelhada',
      'description': 'Com molho de tomate e queijo gratinado',
      'price': 35.90,
      'imageUrl': 'assets/images/berinjela.jpg',
    },
    {
      'id': 'v3',
      'name': 'Lasanha de Berinjela',
      'description': 'Com molho branco e queijo',
      'price': 42.90,
      'imageUrl': 'assets/images/lasanha_berinjela.jpg',
    },
    {
      'id': 'v4',
      'name': 'Espaguete ao Pesto',
      'description': 'Com manjericão fresco e tomates cereja',
      'price': 38.90,
      'imageUrl': 'assets/images/espaguete_pesto.jpg',
    },
  ],
  'Vegano': [
    {
      'id': 'vg1',
      'name': 'Hambúrguer de Grão de Bico',
      'description': 'Com pão vegano e molho especial',
      'price': 39.90,
      'imageUrl': 'assets/images/hamburguer_vegano.jpg',
    },
    {
      'id': 'vg2',
      'name': 'Salada Premium',
      'description': 'Mix de folhas, quinoa e legumes grelhados',
      'price': 32.90,
      'imageUrl': 'assets/images/salada.jpg',
    },
    {
      'id': 'vg3',
      'name': 'Bowl de Proteínas',
      'description': 'Com grãos, legumes e tofu grelhado',
      'price': 36.90,
      'imageUrl': 'assets/images/bowl_proteinas.jpg',
    },
    {
      'id': 'vg4',
      'name': 'Curry de Legumes',
      'description': 'Com arroz integral e grão de bico',
      'price': 34.90,
      'imageUrl': 'assets/images/curry.jpg',
    },
  ],
};

// Extension methods para filtrar o menu
extension MenuFilters on Map<String, List<Map<String, dynamic>>> {
  // Retorna os itens marcados como populares
  List<Map<String, dynamic>> getPopularItems() {
    List<Map<String, dynamic>> popularItems = [];
    forEach((category, items) {
      popularItems.addAll(
        items.where((item) => item['isPopular'] == true),
      );
    });
    return popularItems;
  }

  // Filtra itens por faixa de preço
  List<Map<String, dynamic>> getItemsByPriceRange(double min, double max) {
    List<Map<String, dynamic>> filteredItems = [];
    forEach((category, items) {
      filteredItems.addAll(
        items.where((item) => 
          item['price'] >= min && item['price'] <= max
        ),
      );
    });
    return filteredItems;
  }

  // Busca itens por nome ou descrição
  List<Map<String, dynamic>> searchItems(String query) {
    if (query.isEmpty) return [];
    
    List<Map<String, dynamic>> searchResults = [];
    forEach((category, items) {
      searchResults.addAll(
        items.where((item) =>
          item['name'].toLowerCase().contains(query.toLowerCase()) ||
          item['description'].toLowerCase().contains(query.toLowerCase())
        ),
      );
    });
    return searchResults;
  }

  // Retorna todos os itens de uma categoria específica
  Map<String, List<Map<String, dynamic>>> getCategoryMenu(String category) {
    if (!containsKey(category)) return {};
    return {category: this[category]!};
  }

  // Ordenar itens por preço (crescente ou decrescente)
  List<Map<String, dynamic>> sortByPrice({bool ascending = true}) {
    List<Map<String, dynamic>> allItems = [];
    forEach((category, items) {
      allItems.addAll(items);
    });
    
    allItems.sort((a, b) => ascending 
      ? (a['price'] as double).compareTo(b['price'] as double)
      : (b['price'] as double).compareTo(a['price'] as double)
    );
    
    return allItems;
  }
}