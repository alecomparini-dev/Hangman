
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
  - **Handler:**
    > Camada compartilhada com todos os targets
  - **Domain:**
    > Camada dos UseCases e Models do projeto
  - **UseCaseGateway:**
    > Camada de Interface Adapter da base de dados e autenticação (adaptanto os UsesCases com SDKs de banco e auth da camada Detail)
  - **Presenter:**
    > Camada de Interface Adapter para a parte visual (VM da arquitetura MVVM-C)
  - **Detail:**
    > Camada de detalhe, onde ficam a UI, a manipulação da base de dados(utilizando um SDK próprio) e a autenticação (também através de um SDK Próprio)
  - **Hangman(main):**
    > Camada main, nela estão os Coordinators, Factories e os Resources do App(Info.plist, Assets, App/SceneDelegate.. etc)
  - **Tests:**
    > Camada de testes. <br>
    > Não foram realizados testes de UI
- Foi utilizado o Firebase Auth para a realização do login anônimo
- Para banco de dados cloud foi utilizado o Firebase Firestore

#### DEPENDÊNCIAS: 
<a href="https://github.com/alecomparini-dev/CustomComponentsSDK/tree/develop/Sources/CustomComponents/Components" target="_blank" rel="noopener"><span>veja aqui</span> </a>
- SDKs PRÓPRIOS:
  - **CustomComponentsSDK** ( [veja aqui]() )
    > Responsável por todos os componentes visuais utilizados na camada de UI dos meus Projetos.
  - **DataStorageSDK** ( [veja aqui](https://github.com/alecomparini-dev/DataStorageSDK) )
  - **AuthenticationSDK** ( [veja aqui](https://github.com/alecomparini-dev/AuthenticationSDK) )
  
- #### SDKs TERCEIROS:
  - Firebase
 
- #### Gerenciador de Dependência:
  - SPM(Swift Package Manager)

#### ARQUITETURA
- MVVM-C
- Clean Architecture

#### PATTERNS (em estudo)
- Strategy
- Builder
- Factory
- Adapter
- Singleton

#### TESTE UNITÁRIOS
- XCTest

#### OUTROS
- Depedency Injection
- Princípios do SOLID
- Clean Code (em estudo)


<br>

---
## LICENÇA
MIT


