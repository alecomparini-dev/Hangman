
<h3 align="center">
  <br>
  <img src="https://github.com/alecomparini-dev/Hangman/assets/76792477/7a7b9d00-1a23-4329-812e-8d6171e9958f" width="500">
  <br>
</h3>

## FEATURES

#### # Login
- [x] Login Anônimo Firebase
- [ ] Converter para Login Personificado (necessário para compras no app)

#### # Ajudas no Jogo:
- [x] 5 Vidas Diárias
- [x] 10 Dicas Diárias
- [x] 5 Revelações de letras Diárias
- [x] Renovação Automática das Ajudas todos os dias 00:00
- [ ] Comprar Vidas, Dicas e Revelações
- [ ] Assistir Anúncios para ganhar Vidas, Dicas e Revelações

<br>

---
## PREVIEW APP

<br>

https://github.com/alecomparini-dev/Hangman/assets/76792477/cf6675d0-fc9b-4da0-9e49-3e5426e62e37

<br>

---
## DESENVOLVIMENTO
- O app foi modularizado nos seguintes targets:
  - ***Handler:*** compartilhado com todos os targets
  - ***Domain:*** camada dos UseCases e models do projeto
  - ***UseCaseGateway:*** camada de interface adapter para a base de dados e authenticação (adaptanto os uses cases com sdks de banco e auth da camada Details)
  - ***Presenter:*** camada de interface adapter para a parte visual (VM da arquitetura MVVM-C)
  - ***Detail:*** camada de detalhe, onde ficam a UI, a manipulação da base de dados(utilizando um SDK próprio) e a autenticação (também através de um SDK Próprio)
  - ***Hangman(main):** camada main, nela estão os Coordinators, factories e os resources do app(Info.plist, Assets, App/SceneDelegate.. etc)
  - ***Tests:*** cadadas de testes
- Foi utilizado o Firebase Auth para a realização do login anônimo
- Para banco de dados cloud foi utilizado o Firebase Firestore

### DEPENDÊNCIAS: 
- #### SDKs PRÓPRIOS:
  - ***CustomComponentsSDK*** ( [veja aqui](https://github.com/alecomparini-dev/CustomComponentsSDK/tree/develop/Sources/CustomComponents/Components) )
    > Responsável por todos componentes visuais utilizados nas Views dos meus Projetos.
    
  - ***DataStorageSDK*** ( [veja aqui](https://github.com/alecomparini-dev/DataStorageSDK) )
  - ***AuthenticationSDK*** ( [veja aqui](https://github.com/alecomparini-dev/AuthenticationSDK) )
  
- #### SDKs TERCEIROS:
  - Firebase
 
- #### Gerenciados de Depêndencia:
  - SPM(Swift Package Manager)

### ARQUITETURA
- MVVM-C
- Clean Architecture

### PATTERNS (em estudo)
- Strategy
- Builder
- Factory
- Adapter
- Singleton

### TESTE UNITÁRIOS
- XCTest

### OUTROS
- Depedency Injection
- Princípios do SOLID
- Clean Code (em estudo)


<br>

---
## LICENÇA
MIT


