--             ######     Consultas  ######
-- 1 - Essa consulta lista todas consultas retornando informações do médico e do paciente
SELECT 
    c.id AS consulta_id,
    c.data_consulta,
    m.nome AS medico,
    m.crm,
    p.nome AS paciente,
    esp.nome AS especialidade,
    c.valor
FROM 
    consultas c
JOIN 
    medicos m ON c.medico_id = m.id
JOIN 
    pacientes p ON c.paciente_id = p.id
JOIN 
    especialidades esp ON c.especialidade_id = esp.id;
    
    
-- 2 - Essa consulta retorna os Pacientes com convênio e seus respectivos convênios. (Se o convenio é nulo, coloquei um IFNULL pra retornar já um "Particular").
SELECT 
    p.nome AS paciente,
    p.cpf,
    IFNULL(cv.nome, 'Particular') AS convenio
FROM 
    pacientes p
LEFT JOIN 
    convenios cv ON p.convenio_id = cv.id;
    
    --  3 - Retorna o valor total recebido por convênio
SELECT 
    IFNULL(cv.nome, 'Particular') AS convenio,
    SUM(c.valor) AS total_recebido,
    COUNT(c.id) AS quantidade_consultas
FROM 
    consultas c
LEFT JOIN 
    convenios cv ON c.convenio_id = cv.id
GROUP BY 
    cv.nome;
    
    --             ######     Consultas Avançadas  ######
    
    -- 1 - Retorna os Médicos com mais consultas realizadas (ordenado pra retornar com quem tem mais consulta, ao quem tem menos)
SELECT 
    m.nome AS medico,
    m.crm,
    esp.nome AS especialidade,
    COUNT(c.id) AS total_consultas,
    SUM(c.valor) AS valor_total
FROM 
    medicos m
JOIN 
    consultas c ON m.id = c.medico_id
JOIN 
    especialidades esp ON m.especialidade_id = esp.id
GROUP BY 
    m.id
ORDER BY 
    total_consultas DESC;
    
    -- 2 - retorna os pacientes internados e tempo de internação (Usei o TIMESTAMPDIFF pra calcular automaticamente o data_entrada - data_saida, como parametro o "DAY")
SELECT 
    p.nome AS paciente,
    i.quarto,
    i.data_entrada,
    i.data_saida,
    TIMESTAMPDIFF(DAY, i.data_entrada, i.data_saida) AS dias_internado,
    c.valor AS valor_consulta
FROM 
    internacoes i
JOIN 
    consultas c ON i.consulta_id = c.id
JOIN 
    pacientes p ON c.paciente_id = p.id;