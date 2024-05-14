# Projeto Marvel Characters
Este repositório contém uma aplicação iOS para exibir uma lista de personagens da Marvel e seus detalhes. A aplicação permite buscar personagens por nome, visualizar detalhes e marcar personagens como favoritos. Os dados são consumidos da API da Marvel que fazendo um GET para o endpoint `https://gateway.marvel.com/v1/public/characters + apiKey` retorna um payload com array de Character. Esse array é usado para popular a view que pertence a CharacterListViewController. 

<img width="469" alt="Captura de Tela 2024-05-14 às 01 08 33" src="https://github.com/hc-almeida/MarvelCharacter/assets/54284757/5c494abd-4ef3-44e1-812a-7b31093260ae">
<img width="469" alt="Captura de Tela 2024-05-14 às 01 08 38" src="https://github.com/hc-almeida/MarvelCharacter/assets/54284757/615631c9-69f1-4f99-a17a-678d576b9996">
<img width="469" alt="Captura de Tela 2024-05-14 às 01 09 07" src="https://github.com/hc-almeida/MarvelCharacter/assets/54284757/b7108dcd-2a14-4fc2-b463-571f04f340ed">
<img width="469" alt="Captura de Tela 2024-05-14 às 01 09 24" src="https://github.com/hc-almeida/MarvelCharacter/assets/54284757/959d3849-7243-42b1-a030-35f42fd4f6a3">





# Como Executar o Projeto
Para executar o projeto, siga estas etapas:

- Clone o repositório do projeto.
- Abra o projeto no Xcode.
- Execute o projeto em um simulador ou dispositivo iOS.

# Visão Geral
O projeto utiliza a arquitetura MVC (Model-View-Controller) para garantir uma organização clara. Visão geral da estrutura do projeto:


- **CharacterListViewController.swift:** Controla a exibição da lista de personagens e interage com o usuário.

- **CharacterListViewModel.swift:** Coordena a lógica de negócios da tela de lista de personagens.

- **CharacterView.swift:** View customizada para exibir a lista de personagens em uma UICollectionView.

- **CharacterCell.swift:** Célula customizada para exibir informações de um personagem na UICollectionView.

- **CharacterDetailsViewController.swift:** Exibe os detalhes de um personagem selecionado.

- **CharacterDetailsViewModel.swift:** Coordena a lógica de negócios da tela de detalhes do personagem.

- **CharacterListService.swift:** Serviço para buscar os dados dos personagens de uma fonte externa.

- **FavoritesViewController.swift**: Exibe os personagens favoritados

- **FavoritesView.swift**: View customizada para exibir a lista de personagens favoritos em uma UICollectionView.

- **FavoritesViewModel.swift**: Coordena a lógica de negócio da tela de favoritos.

# Descrição dos Métodos
Descrição dos principais métodos e funcionalidades implementadas:

## CharacterListViewController
Este arquivo contém a implementação da view controller responsável por exibir a lista de personagens. Ele se comunica com o CharacterListViewModel para obter os dados do personagem e atualizar a a collectionView.

- **init(viewModel: CharacterListViewModelProtocol):** Inicializa a view controller com o view model fornecido.
- **viewWillAppear(animated: Bool):** Reseta o estado da view e solicita os personagens quando a view está prestes a ser exibida.
- **setupSearchBar():** Configura a barra de pesquisa para permitir buscar por nome.

 ### Protocolo CharacterViewDelegate
- **reloadCharacters(_ characters: [Character], animated: Bool):** Recarrega os personagens na view.
- **displayCharacterSearch(_ data: [Character]):** Exibe os resultados da pesquisa na view.
- **displayCharacters(_ data: [Character]):** Exibe os personagens na view.
- **proceedToDetails(data: Character):** Navega para a tela de detalhes do personagem.
- **displayError(type: ErrorBuild.ErrorType):** Exibe um erro na view.
- **displayLoading():** Exibe um indicador de carregamento na view.

## CharacterListViewModel
Este arquivo contém a implementação do view model para a lista de personagens. Ele é responsável por coordenar a lógica de negócios relacionada aos personagens carregados da API e interagir com o serviço de gerenciamento de favoritos.

- **init(service: CharacterListServiceProtocol):** Inicializa o view model com o serviço fornecido.

 ### Protocolo CharacterListViewModelProtocol
- **fetchCharacters():** Busca os personagens do serviço.
- **fetchCharacterNextPage():** Busca a próxima página de personagens.
- **searchCharacter(with name: String):** Busca personagens com o nome fornecido.
- **reloadCharacters(animated: Bool):** Recarrega os personagens no view controller.
- **isFavorite(id: Int) -> Bool:** Verifica se um personagem é favorito.
- **toggleFavorite(id: Int, isFavorite: Bool):** Alterna o status de favorito de um personagem.
- **reset():** Reseta o estado do view model.

## CharacterView
- **configure(with characters: [Character]):** Configura a view com os personagens fornecidos.
- **reloadCharacters(_ characters: [Character], animated: Bool):** Recarrega os personagens na view.

## CharacterCell
- **configureCell(with data: Character, isFavorite: Bool):** Configura a célula com os dados do personagem e seu status de favorito.

## CharacterDetailsViewController.swift
Este arquivo contém a implementação da view controller responsável por exibir os detalhes de um personagem específico. Ele se comunica com o CharacterDetailsViewModel para obter os dados do personagem e atualizar a interface do usuário conforme necessário.

- **init(viewModel: CharacterDetailsViewModelProtocol):** Inicializa a view controller com o view model fornecido.
- **loadView():** Configura a view da view controller.
- **viewDidLoad():** Chamado após a carga da view. Solicita ao view model para exibir os detalhes do personagem.

### Protocolo CharacterDetailsViewControllerProtocol
- **displayCharacter(data: Character):** Implementa o método para exibir os detalhes do personagem na view.

### Extension CharacterDetailsDelegate
Esta extensão implementa os métodos do protocolo CharacterDetailsDelegate, responsável por lidar com as interações do usuário na tela de detalhes do personagem.

- **didTapFavorite(at id: Int, value: Bool):** Chamado quando o usuário clica no botão de favoritos. Solicita ao view model para alternar o status de favorito do personagem.
- **shareImage(of character: UIImage?):** Chamado quando o usuário clica no botão de compartilhamento. Abre uma UIActivityViewController para compartilhar a imagem do personagem.

## CharacterDetailsViewModel.swift
Este arquivo contém a implementação do view model para a tela de detalhes do personagem. Ele é responsável por coordenar a lógica de negócios relacionada aos detalhes do personagem e interagir com o serviço de gerenciamento de favoritos.

- **init(character: Character):** Inicializa o view model com os dados do personagem.
- **showCharacterDetails():** Exibe os detalhes do personagem na view.
- **toggleFavorite(id: Int, isFavorite: Bool):** Alterna o status de favorito do personagem.
- **isFavorite(id: Int) -> Bool:** Verifica se o personagem é favorito.
- **addToFavorites(id: Int, isFavorite: Bool):** Adiciona o personagem aos favoritos.
- **removeFromFavorites(id: Int):** Remove o personagem dos favoritos.

### CharacterDetails.swift
Este arquivo contém a implementação da view personalizada para exibir os detalhes de um personagem. Ele é composto por vários componentes de interface de usuário, como uma imagem, um nome, uma descrição e botões interativos.

- **configure(with data: Character):** Configura a view com os dados do personagem.
- **didTapShare():** Chamado quando o usuário clica no botão de compartilhamento.
- **didTapLoveItButton():** Chamado quando o usuário clica no botão de favoritos.

### Extension ViewCoding
Implementa os métodos do protocolo ViewCoding para configurar a hierarquia de visualização, as restrições de layout e as configurações adicionais da view. Isso garante uma separação clara entre a lógica de visualização e a lógica de negócios da view.

## FavoritesViewController
Esta classe é responsável por controlar a exibição dos personagens marcados como favoritos. Ele interage com o usuário e coordena as ações relacionadas à lista de personagens favoritos.

- **init(viewModel:** FavoritesViewModelProtocol): Inicializa a view controller com o view model fornecido.
- **loadView():** Configura a view da tela de favoritos.
- **viewWillAppear(animated: Bool):** Solicita ao view model para buscar os personagens favoritos quando a view está prestes a ser exibida.

### Protocolo FavoritesViewControllerProtocol
- **displayCharacters(_ data: [Character]):** Exibe os personagens favoritos na view.
- **displayLoading():** Exibe um indicador de carregamento na view.
- **displayError(type: ErrorBuild.ErrorType):** Exibe um erro na view e oferece a opção de fechar a tela.

### Protocolo FavoritesViewDelegate
- **didTapFavorite(at id: Int, value: Bool):** Solicita ao view model para remover um personagem da lista de favoritos.
- **isFavorite(id: Int) -> Bool:** Verifica se um personagem é favorito.

## FavoritesViewModel
Esta classe é responsável por coordenar a lógica de negócios da tela de favoritos. Ele busca os personagens favoritos, verifica se um personagem é favorito e remove um personagem da lista de favoritos.

- **fetchFavorites():** Busca os personagens favoritos e atualiza a view correspondente.

### Protocolo FavoritesViewModelProtocol
- **fetchFavorites():** Busca os personagens favoritos e atualiza a view correspondente.
- **isFavorite(id: Int) -> Bool:** Verifica se um personagem é favorito.
- **removeFromFavorites(id: Int, isFavorite: Bool):** Remove um personagem da lista de favoritos.

## FavoritesView
Esta classe define a interface de usuário para exibir a lista de personagens favoritos em uma UICollectionView.

- **configure(_ viewModel: [Character]):** Configura a view com os personagens favoritos fornecidos.

## CoreDataStack
Esta classe gerencia a pilha do Core Data para lidar com a persistência de dados.

- **saveContext():** Salva as alterações feitas no contexto do Core Data.

## FavoriteManager
Esta classe gerencia a persistência dos personagens favoritos no Core Data.
