# HIIT App

Aplicativo de Treino HIIT desenvolvido em Flutter. Com ele, é possível criar treinos personalizados, adicionar exercícios com tempos de execução e descanso, e executar os treinos com contagem. Os dados são armazenados localmente usando Hive.



## Funcionalidades já implementadas

- [x] Criar treinos personalizados com nome  
- [x] Adicionar exercícios a um treino (com tempo de execução e descanso)  
- [x] Excluir exercícios com deslizar para o lado  
- [x] Iniciar o treino com contagem regressiva para execução e descanso  
- [x] Persistência local com Hive (salva os treinos mesmo após fechar o app)  



## Funcionalidades planejadas

- [ ] Editar treino (renomear e modificar exercícios)  
- [ ] Excluir treinos  
- [ ] Melhorias na interface (UI/UX)  
- [ ] Botões na tela de execução (pausar, pular, finalizar treino)  
- [ ] Histórico de treinos realizados  
- [ ] Compartilhar ou exportar treinos  



## Tecnologias utilizadas

- Flutter  
- Dart  
- Hive (persistência local)  
- State Management com `StatefulWidget`



## Como rodar o projeto localmente

1. **Clone o repositório**

```bash
git clone https://github.com/PedroJuanOfc/treino_hit_app.git
cd treino_hit_app
```

2. **Instale as dependências**

```bash
flutter pub get
```

3. **Gere os arquivos do Hive**

```bash
dart run build_runner build --delete-conflicting-outputs
```

4. **Execute o app**

```bash
flutter run
```

## Sobre a persistência com Hive

- Os modelos `Train` e `Exercise` usam `@HiveType` e `@HiveField`.
- Os arquivos `.g.dart` são gerados com o `build_runner`.
- Os dados são armazenados no box chamado `trains`.

> Sempre que clonar o projeto em uma nova máquina, é necessário rodar o `build_runner` para gerar os arquivos `.g.dart`.

---

Desenvolvido por **Pedro Juan Ferreira Saraiva**  
