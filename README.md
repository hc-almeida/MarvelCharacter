# Projeto Marvel Characters
Este repositório contém uma aplicação iOS para exibir uma lista de personagens da Marvel e seus detalhes. A aplicação permite buscar personagens por nome, visualizar detalhes e marcar personagens como favoritos. Os dados são consumidos da API da Marvel que fazendo um GET para o endpoint `https://gateway.marvel.com/v1/public/characters + apiKey` retorna um payload com array de Character. Esse array é usado para popular a view que pertence a CharacterListViewController. O projeto utiliza a arquitetura MVC (Model-View-Controller) para garantir uma organização clara.

<img width="469" alt="Captura de Tela 2024-05-14 às 01 08 33" src="https://github.com/hc-almeida/MarvelCharacter/assets/54284757/5c494abd-4ef3-44e1-812a-7b31093260ae">
<img width="469" alt="Captura de Tela 2024-05-14 às 01 08 38" src="https://github.com/hc-almeida/MarvelCharacter/assets/54284757/615631c9-69f1-4f99-a17a-678d576b9996">

# Como Executar o Projeto
Para executar o projeto, siga estas etapas:

- Clone o repositório do projeto.
- Abra o projeto no Xcode.
- Execute o projeto em um simulador ou dispositivo iOS.
