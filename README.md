# RestauApp 🍽️

RestauApp é uma aplicação frontend desenvolvida em Flutter para demonstrar a implementação de interfaces modernas de um aplicativo de delivery de comida. Este projeto foi desenvolvido como parte da disciplina de Desenvolvimento de Interfaces.

## 📱 Funcionalidades

- **Autenticação**
  - Login e Registro de usuários
  - Autenticação com redes sociais

- **Navegação Principal**
  - Home com listagem de restaurantes
  - Carrinho de compras
  - Favoritos/Salvos
  - Histórico de pedidos
  - Perfil do usuário

- **Recursos do Restaurante**
  - Visualização detalhada do restaurante
  - Cardápio categorizado
  - Sistema de avaliações
  - Distância e tempo de entrega

- **Carrinho de Compras**
  - Adição/remoção de itens
  - Ajuste de quantidades
  - Cálculo de subtotal e taxas
  - Aplicação de cupons de desconto

- **Pedidos**
  - Histórico completo de pedidos
  - Status de entrega
  - Opção de repetir pedidos anteriores

## 🎨 Design

O aplicativo segue um design moderno e intuitivo com:
- Tema escuro
- Cores primárias: Laranja (#FFA500)
- Interface minimalista e clean
- Animações suaves
- Componentes reutilizáveis

## 🛠️ Tecnologias Utilizadas

- Flutter
- Dart
- Provider (Gerenciamento de Estado)
- Diversos widgets personalizados

## 📦 Estrutura do Projeto

```
lib/
  ├── models/           # Modelos de dados
  ├── providers/        # Gerenciamento de estado
  ├── screens/          # Telas do aplicativo
  │   ├── auth/        # Telas de autenticação
  │   ├── home/        # Tela principal
  │   ├── cart/        # Carrinho de compras
  │   └── profile/     # Perfil do usuário
  ├── widgets/         # Widgets reutilizáveis
  └── utils/           # Utilitários e constantes
```

## 🚀 Como Executar

1. Certifique-se de ter o Flutter instalado
2. Clone este repositório
```bash
git clone https://github.com/seu-usuario/restauapp.git
```
3. Instale as dependências
```bash
cd restauapp
flutter pub get
```
4. Execute o aplicativo
```bash
flutter run
```

## 📱 Screenshots

[Screenshots do aplicativo serão adicionados aqui]

## 🧩 Componentes Principais

- **CustomBottomNavBar**: Barra de navegação personalizada
- **RestaurantCard**: Card para exibição de restaurantes
- **DishCard**: Card para exibição de pratos
- **CartItem**: Componente de item do carrinho
- **CustomTextField**: Campo de texto personalizado

## 🎯 Features Implementadas

- [x] Autenticação de usuário
- [x] Listagem de restaurantes
- [x] Detalhes do restaurante
- [x] Carrinho de compras
- [x] Gerenciamento de favoritos
- [x] Histórico de pedidos
- [x] Perfil de usuário
- [x] Navegação entre telas
- [x] Tema escuro
- [X] Sistema de pagamentos
- [X] Notificações push
- [X] Localização em tempo real
- [X] Chat com entregador
## 🔜 Próximos Passos

- [ ] Implementação do backend

## 💡 Aprendizados

Este projeto demonstra a implementação de:
- Navegação e roteamento em Flutter
- Gerenciamento de estado com Provider
- Componentização e reutilização de widgets
- Design responsivo
- Manipulação de formulários
- Animações básicas

## ✍️ Autor

Este projeto foi desenvolvido como parte da disciplina de Desenvolvimento de Interfaces.

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
