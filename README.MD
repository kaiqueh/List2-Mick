# Documentação do Arquivo `STRUCTURE.SQL` 📄

Este arquivo contém a definição de três pacotes PL/SQL: `PKG_ALUNO`, `PKG_PROFESSOR` e `PKG_DISCIPLINA`. Cada pacote possui procedimentos e funções que realizam operações específicas no banco de dados. Abaixo está a descrição detalhada de cada pacote e seus componentes.

## Pacote `PKG_ALUNO` 🎓

### Interface do Pacote `PKG_ALUNO`
- **Procedimento `EXCLUIR_ALUNO(p_id_aluno IN NUMBER)`**: Exclui um aluno e suas matrículas do banco de dados.
- **Procedimento `LISTAR_ALUNOS_MAIORES_18`**: Lista todos os alunos maiores de 18 anos.
- **Procedimento `LISTAR_ALUNOS_POR_CURSO(p_id_curso IN NUMBER)`**: Lista todos os alunos matriculados em um curso específico.

### Corpo do Pacote `PKG_ALUNO`
- **Procedimento `EXCLUIR_ALUNO(p_id_aluno IN NUMBER)**: 
  - Exclui registros da tabela `matriculas` e `alunos` onde `id_aluno` é igual ao parâmetro `p_id_aluno`.
- **Procedimento `LISTAR_ALUNOS_MAIORES_18`**:
  - Declara um cursor que seleciona nome e data de nascimento dos alunos com mais de 18 anos.
  - Itera sobre o cursor e imprime o nome e a data de nascimento dos alunos.
- **Procedimento `LISTAR_ALUNOS_POR_CURSO(p_id_curso IN NUMBER)`**:
  - Declara um cursor que seleciona o nome dos alunos matriculados no curso especificado pelo parâmetro `p_id_curso`.
  - Itera sobre o cursor e imprime o nome dos alunos.

## Pacote `PKG_PROFESSOR` 👨‍🏫

### Interface do Pacote `PKG_PROFESSOR`
- **Procedimento `LISTAR_PROFESSORES_COM_MAIS_DE_UMA_TURMA`**: Lista professores que possuem mais de uma turma.
- **Função `TOTAL_TURMAS_POR_PROFESSOR(p_id_professor IN NUMBER) RETURN NUMBER`**: Retorna o total de turmas de um professor específico.
- **Função `PROFESSOR_POR_DISCIPLINA(p_id_disciplina IN NUMBER) RETURN VARCHAR2`**: Retorna o nome do professor responsável por uma disciplina específica.

### Corpo do Pacote `PKG_PROFESSOR`
- **Procedimento `LISTAR_PROFESSORES_COM_MAIS_DE_UMA_TURMA`**:
  - Declara um cursor que seleciona o nome dos professores e o total de turmas que possuem, filtrando aqueles com mais de uma turma.
  - Itera sobre o cursor e imprime o nome dos professores e o total de turmas.

## Pacote `PKG_DISCIPLINA` 📚

### Interface do Pacote `PKG_DISCIPLINA`
- **Procedimento `CADASTRAR_DISCIPLINA(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER)`**: Cadastra uma nova disciplina.
- **Procedimento `LISTAR_TOTAL_ALUNOS_POR_DISCIPLINA`**: Lista disciplinas com mais de 10 alunos matriculados.
- **Procedimento `MEDIA_IDADE_POR_DISCIPLINA(p_id_disciplina IN NUMBER)`**: Calcula e lista a média de idade dos alunos de uma disciplina específica.
- **Procedimento `LISTAR_ALUNOS_POR_DISCIPLINA(p_id_disciplina IN NUMBER)`**: Lista os alunos matriculados em uma disciplina específica.

### Corpo do Pacote `PKG_DISCIPLINA`
- **Procedimento `CADASTRAR_DISCIPLINA(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER)`**:
  - Insere uma nova disciplina na tabela `disciplinas` com os dados fornecidos.
- **Procedimento `LISTAR_TOTAL_ALUNOS_POR_DISCIPLINA`**:
  - Declara um cursor que seleciona o nome das disciplinas e o total de alunos matriculados, filtrando aquelas com mais de 10 alunos.
  - Itera sobre o cursor e imprime o nome das disciplinas e o total de alunos.
- **Procedimento `MEDIA_IDADE_POR_DISCIPLINA(p_id_disciplina IN NUMBER)`**:
  - Declara um cursor que calcula a média de idade dos alunos matriculados em uma disciplina específica.
  - Abre o cursor, busca a média de idade e imprime o resultado.
- **Procedimento `LISTAR_ALUNOS_POR_DISCIPLINA(p_id_disciplina IN NUMBER)`**:
  - Declara um cursor que seleciona o nome dos alunos matriculados em uma disciplina específica.
  - Itera sobre o cursor e imprime o nome dos alunos.

## Executando o Script no Oracle 🚀

Para executar este script no Oracle, basta carregar o arquivo `STRUCTURE.SQL` no SQL ou em qualquer outra ferramenta de administração de banco de dados Oracle. Use o comando `@` seguido do caminho do arquivo:

```sql
@/caminho/para/seu/arquivo/STRUCTURE.SQL