<h2 align="center">
  <br>
  <img src="https://github.com/alecomparini-dev/Hangman/assets/76792477/8e48cbff-5d0e-4830-8576-a36aa99f4c2e" width="200">
  <br>
  JOGO DA FORCA
  <br>
</h2>

<br>

# Feature
### Login
- [x] Login Anônimo Firebase
- [ ] Converter para Login Personificado (necessário para compras no app)

### Ajudas no Jogo:
- [x] 5 Vidas Diárias
- [x] 10 Dicas Diárias
- [x] 5 Revelações de letras Diárias
- [x] Renovação Automática das Ajudas todos os dias 00:00
- [ ] Compra de Vidas, Dicas e Revelações
- [ ] Assistir Anúncios para ganhar Vidas, Dicas e Revelações

<br>

## PREVIEW APP 
https://github.com/alecomparini-dev/Hangman/assets/76792477/cf6675d0-fc9b-4da0-9e49-3e5426e62e37

<br>

## DESENVOLVIMENTO
- Firebase Auth para o login anônimo
- FirebaseFirestore para Database
- Modularização usando Targets e SPM para os SDKs próprios

#### SDKs 
- CustomComponentsSDK ( [veja aqui](https://github.com/alecomparini-dev/CustomComponentsSDK/tree/develop/Sources/CustomComponents/Components) )
  - Responsável por todos componentes visuais utilizados nas Views dos meus Projetos.
  - ![Static Badge](https://img.shields.io/badge/status-em_evolu%C3%A7%C3%A3o-green)
    
- DataStorageSDK ( [veja aqui](https://github.com/alecomparini-dev/CustomComponentsSDK/tree/develop/Sources/CustomComponents/Components) )
  - Responsável pela camada de persistências dos meus Projetos.
  - Adaptado para quaisquer provedores
  - Já Utilizados em Projetos:
    - ![Static Badge](https://img.shields.io/badge/CoreData-green?style=for-the-badge)
    - ![Static Badge](https://img.shields.io/badge/FirestoreDatabase-green?style=for-the-badge)
    - ![Static Badge](https://img.shields.io/badge/KeyChain-green?style=for-the-badge)
    - ![Static Badge](https://img.shields.io/badge/UserDefaults-green?style=for-the-badge)
    - ![Static Badge](https://img.shields.io/badge/Realm-green?style=for-the-badge)
  - Próximos a serem criados:
    - ![Static Badge](https://img.shields.io/badge/SQLite-red?style=for-the-badge)

    
- AuthenticationSDK
  - Responsável pela camada de Authenticação do meu Projeto
  - Adaptado para trabalhar com 'n' provedores de authenticação
  - ![Static Badge](https://img.shields.io/badge/status-em_evolu%C3%A7%C3%A3o-green)

#### Arquitetura
- Clean Architecture
- MVVM-C

#### Patterns (em estudo)
- Strategy
- Builder
- Factory
- Adapter
- Singleton

#### Gerenciador de Dependência
- SPM (Swift Package Manager)

#### Testes Unitários
- XCTest

### Outros
- Depedency Injection
- Princípios do SOLID
- Clean Code (em estudo)





## LICENÇA

MIT

---

