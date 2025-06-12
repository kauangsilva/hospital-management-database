 --             ######     Criação de Procedures  ######
      
-- Procedure pra gerar um relatório de consultas por período, retorna a data da consulta, nome do medico, nome do paciente, e a especialidade,convenio e valor, inserindo a data(inicio / fim)
-- Para chamar essa procedure: CALL sp_relatorio_consultas_periodo('data inicio', 'data fim');
DELIMITER //
CREATE PROCEDURE sp_relatorio_consultas_periodo(
    IN p_data_inicio DATE,
    IN p_data_fim DATE
)
BEGIN
    SELECT 
        c.data_consulta,
        m.nome AS medico,
        p.nome AS paciente,
        esp.nome AS especialidade,
        IFNULL(cv.nome, 'Particular') AS convenio,
        c.valor
    FROM 
        consultas c
    JOIN 
        medicos m ON c.medico_id = m.id
    JOIN 
        pacientes p ON c.paciente_id = p.id
    JOIN 
        especialidades esp ON c.especialidade_id = esp.id
    LEFT JOIN 
        convenios cv ON c.convenio_id = cv.id
    WHERE 
        DATE(c.data_consulta) BETWEEN p_data_inicio AND p_data_fim
    ORDER BY 
        c.data_consulta;
END //
DELIMITER ;

-- Exemplo de consulta :
CALL sp_relatorio_consultas_periodo('2023-06-10', '2023-06-15');


      --             ######     Criação de Index (aceleração no resultado das consultas) ######
      
-- 1 : Index para consultas por data:
CREATE INDEX idx_consultas_data ON consultas(data_consulta);
-- 2 : Index para consultas pelo nome e pf do paciente:
CREATE INDEX idx_pacientes_nome_cpf ON pacientes(nome, cpf);


      --             ######     Criação de View's) ######
-- 1 :  View da agenda dos médicos
CREATE VIEW vw_agenda_medica AS
SELECT 
    m.nome AS medico,
    m.crm,
    e.nome AS especialidade,
    c.data_consulta,
    p.nome AS paciente,
    IFNULL(cv.nome, 'Particular') AS convenio
FROM 
    consultas c
JOIN 
    medicos m ON c.medico_id = m.id
JOIN 
    pacientes p ON c.paciente_id = p.id
JOIN 
    especialidades e ON m.especialidade_id = e.id
LEFT JOIN 
    convenios cv ON c.convenio_id = cv.id
ORDER BY 
    m.nome, c.data_consulta;

-- Exemplo de uso:
-- Consultar a agenda médica do Dr carlos Silva e ordenar ela por data da consulta:
SELECT * FROM vw_agenda_medica
WHERE medico = 'Dr. Carlos Silva'
ORDER BY data_consulta;


-- 2 : -- View de pacientes internados e informações referente a internação. ( Passei como parametro o YEAR,e comparei a data de nascimento com a data atual CURDATE()).
CREATE VIEW vw_pacientes_internados AS
SELECT 
    p.nome AS paciente,
    p.data_nascimento,
    TIMESTAMPDIFF(YEAR, p.data_nascimento, CURDATE()) AS idade,
    i.quarto,
    i.data_entrada,
    i.data_saida,
    m.nome AS medico_responsavel,
    e.nome AS especialidade
FROM 
    internacoes i
JOIN 
    consultas c ON i.consulta_id = c.id
JOIN 
    pacientes p ON c.paciente_id = p.id
JOIN 
    medicos m ON c.medico_id = m.id
JOIN 
    especialidades e ON m.especialidade_id = e.id
WHERE 
    i.data_saida IS NULL;

-- Exemplo de uso:
-- Chamar o index pra retornar as informações dos internados.
SELECT * FROM vw_pacientes_internados;