
<h3 align="center">
  <br>
  <img src="https://github.com/alecomparini-dev/Hangman/assets/76792477/7a7b9d00-1a23-4329-812e-8d6171e9958f" width="500">
  <br>
</h3>



## Feature

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
- Firebase Auth para o login anônimo
- FirebaseFirestore para Database
- Modularização usando Targets e SPM para os SDKs próprios

### SDKs 
- CustomComponentsSDK ( [veja aqui](https://github.com/alecomparini-dev/CustomComponentsSDK/tree/develop/Sources/CustomComponents/Components) )
  > Responsável por todos componentes visuais utilizados nas Views dos meus Projetos.
  - ![Static Badge](https://img.shields.io/badge/status-em_evolu%C3%A7%C3%A3o-green)
    
- DataStorageSDK ( [veja aqui](https://github.com/alecomparini-dev/CustomComponentsSDK/tree/develop/Sources/CustomComponents/Components) )
  > Responsável pela camada de persistências dos meus Projetos. <br>
    Adaptado para trabalhar com diversos provedores de Database.
  - Já Utilizados em Projetos:
    - ![Static Badge](https://img.shields.io/badge/CoreData-green?style=for-the-badge)
    - ![Static Badge](https://img.shields.io/badge/FirestoreDatabase-green?style=for-the-badge)
    - ![Static Badge](https://img.shields.io/badge/KeyChain-green?style=for-the-badge)
    - ![Static Badge](https://img.shields.io/badge/UserDefaults-green?style=for-the-badge)
    - ![Static Badge](https://img.shields.io/badge/Realm-green?style=for-the-badge)
  - Próximos a serem criados:
    - ![Static Badge](https://img.shields.io/badge/SQLite-red?style=for-the-badge)

    
- AuthenticationSDK
  > Responsável pela camada de Authenticação do meu Projeto <br>
    Adaptado para trabalhar com diversos provedores de authenticação
  - Já Utilizados em Projetos:
    - ![Static Badge](https://img.shields.io/badge/FirestoreAuth_Anônimo-green?style=for-the-badge)
    - ![Static Badge](https://img.shields.io/badge/FirestoreAuth_Email/Senha-green?style=for-the-badge)
    - ![Static Badge](https://img.shields.io/badge/Biometria-green?style=for-the-badge)
  - ![Static Badge](https://img.shields.io/badge/status-em_evolu%C3%A7%C3%A3o-green)

### Arquitetura
- Clean Architecture
- MVVM-C

### Patterns (em estudo)
- Strategy
- Builder
- Factory
- Adapter
- Singleton

### Gerenciador de Dependência
- SPM (Swift Package Manager)

### Testes Unitários
- XCTest

### Outros
- Depedency Injection
- Princípios do SOLID
- Clean Code (em estudo)



<br>

---
## LICENÇA
MIT


