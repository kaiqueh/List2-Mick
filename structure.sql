CREATE OR REPLACE PACKAGE PKG_ALUNO AS
    PROCEDURE EXCLUIR_ALUNO(p_id_aluno IN NUMBER);
    PROCEDURE LISTAR_ALUNOS_MAIORES_18;
    PROCEDURE LISTAR_ALUNOS_POR_CURSO(p_id_curso IN NUMBER);
END PKG_ALUNO;
/

CREATE OR REPLACE PACKAGE BODY PKG_ALUNO AS

    PROCEDURE EXCLUIR_ALUNO(p_id_aluno IN NUMBER) IS
    BEGIN
        DELETE FROM matriculas WHERE id_aluno = p_id_aluno;
        DELETE FROM alunos WHERE id_aluno = p_id_aluno;
    END EXCLUIR_ALUNO;

    PROCEDURE LISTAR_ALUNOS_MAIORES_18 IS
        CURSOR c_alunos_maiores_18 IS
            SELECT nome, data_nascimento
            FROM alunos
            WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, data_nascimento) / 12) > 18;
    BEGIN
        FOR r_aluno IN c_alunos_maiores_18 LOOP
            DBMS_OUTPUT.PUT_LINE('Nome: ' || r_aluno.nome || ', Data de Nascimento: ' || r_aluno.data_nascimento);
        END LOOP;
    END LISTAR_ALUNOS_MAIORES_18;

    PROCEDURE LISTAR_ALUNOS_POR_CURSO(p_id_curso IN NUMBER) IS
        CURSOR c_alunos_por_curso IS
            SELECT a.nome
            FROM alunos a
            JOIN matriculas m ON a.id_aluno = m.id_aluno
            WHERE m.id_curso = p_id_curso;
    BEGIN
        FOR r_aluno IN c_alunos_por_curso LOOP
            DBMS_OUTPUT.PUT_LINE('Nome: ' || r_aluno.nome);
        END LOOP;
    END LISTAR_ALUNOS_POR_CURSO;

END PKG_ALUNO;
/

CREATE OR REPLACE PACKAGE PKG_PROFESSOR AS
    PROCEDURE LISTAR_PROFESSORES_COM_MAIS_DE_UMA_TURMA;
    FUNCTION TOTAL_TURMAS_POR_PROFESSOR(p_id_professor IN NUMBER) RETURN NUMBER;
    FUNCTION PROFESSOR_POR_DISCIPLINA(p_id_disciplina IN NUMBER) RETURN VARCHAR2;
END PKG_PROFESSOR;
/

CREATE OR REPLACE PACKAGE BODY PKG_PROFESSOR AS

    PROCEDURE LISTAR_PROFESSORES_COM_MAIS_DE_UMA_TURMA IS
        CURSOR c_professores IS
            SELECT p.nome, COUNT(t.id_turma) AS total_turmas
            FROM professores p
            JOIN turmas t ON p.id_professor = t.id_professor
            GROUP BY p.nome
            HAVING COUNT(t.id_turma) > 1;
    BEGIN
        FOR r_professor IN c_professores LOOP
            DBMS_OUTPUT.PUT_LINE('Nome: ' || r_professor.nome || ', Total de Turmas: ' || r_professor.total_turmas);
        END LOOP;
    END LISTAR_PROFESSORES_COM_MAIS_DE_UMA_TURMA;

    FUNCTION TOTAL_TURMAS_POR_PROFESSOR(p_id_professor IN NUMBER) RETURN NUMBER IS
        v_total_turmas NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_total_turmas
        FROM turmas
        WHERE id_professor = p_id_professor;
        RETURN v_total_turmas;
    END TOTAL_TURMAS_POR_PROFESSOR;

    FUNCTION PROFESSOR_POR_DISCIPLINA(p_id_disciplina IN NUMBER) RETURN VARCHAR2 IS
        v_nome_professor VARCHAR2(100);
    BEGIN
        SELECT p.nome
        INTO v_nome_professor
        FROM professores p
        JOIN disciplinas d ON p.id_professor = d.id_professor
        WHERE d.id_disciplina = p_id_disciplina;
        RETURN v_nome_professor;
    END PROFESSOR_POR_DISCIPLINA;

END PKG_PROFESSOR;
/

CREATE OR REPLACE PACKAGE PKG_DISCIPLINA AS
    PROCEDURE CADASTRAR_DISCIPLINA(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER);
    PROCEDURE LISTAR_TOTAL_ALUNOS_POR_DISCIPLINA;
    PROCEDURE MEDIA_IDADE_POR_DISCIPLINA(p_id_disciplina IN NUMBER);
    PROCEDURE LISTAR_ALUNOS_POR_DISCIPLINA(p_id_disciplina IN NUMBER);
END PKG_DISCIPLINA;
/

CREATE OR REPLACE PACKAGE BODY PKG_DISCIPLINA AS

    PROCEDURE CADASTRAR_DISCIPLINA(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER) IS
    BEGIN
        INSERT INTO disciplinas (nome, descricao, carga_horaria)
        VALUES (p_nome, p_descricao, p_carga_horaria);
    END CADASTRAR_DISCIPLINA;

    PROCEDURE LISTAR_TOTAL_ALUNOS_POR_DISCIPLINA IS
        CURSOR c_total_alunos IS
            SELECT d.nome, COUNT(m.id_aluno) AS total_alunos
            FROM disciplinas d
            JOIN matriculas m ON d.id_disciplina = m.id_disciplina
            GROUP BY d.nome
            HAVING COUNT(m.id_aluno) > 10;
    BEGIN
        FOR r_disciplina IN c_total_alunos LOOP
            DBMS_OUTPUT.PUT_LINE('Disciplina: ' || r_disciplina.nome || ', Total de Alunos: ' || r_disciplina.total_alunos);
        END LOOP;
    END LISTAR_TOTAL_ALUNOS_POR_DISCIPLINA;

    PROCEDURE MEDIA_IDADE_POR_DISCIPLINA(p_id_disciplina IN NUMBER) IS
        CURSOR c_media_idade IS
            SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, a.data_nascimento) / 12)) AS media_idade
            FROM alunos a
            JOIN matriculas m ON a.id_aluno = m.id_aluno
            WHERE m.id_disciplina = p_id_disciplina;
        v_media_idade NUMBER;
    BEGIN
        OPEN c_media_idade;
        FETCH c_media_idade INTO v_media_idade;
        CLOSE c_media_idade;
        DBMS_OUTPUT.PUT_LINE('Média de Idade: ' || v_media_idade);
    END MEDIA_IDADE_POR_DISCIPLINA;

    PROCEDURE LISTAR_ALUNOS_POR_DISCIPLINA(p_id_disciplina IN NUMBER) IS
        CURSOR c_alunos IS
            SELECT a.nome
            FROM alunos a
            JOIN matriculas m ON a.id_aluno = m.id_aluno
            WHERE m.id_disciplina = p_id_disciplina;
    BEGIN
        FOR r_aluno IN c_alunos LOOP
            DBMS_OUTPUT.PUT_LINE('Nome: ' || r_aluno.nome);
        END LOOP;
    END LISTAR_ALUNOS_POR_DISCIPLINA;

END PKG_DISCIPLINA;
/