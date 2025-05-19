-- Tabela de Administradores
CREATE TABLE administradores (
    id_administrador UUID PRIMARY KEY NOT NULL,
    nome_completo VARCHAR(100),
    email VARCHAR(150) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL
 
);

-- Tabela de Endereços
CREATE TABLE enderecos (
    id_endereco UUID PRIMARY KEY NOT NULL,
    estado VARCHAR(50),
    cidade VARCHAR(100),
    bairro VARCHAR(100),
    cep VARCHAR(20),
    rua VARCHAR(100),
    numero VARCHAR(10),
    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6)
);

-- Tabela de Serviços
CREATE TABLE servicos (
    id_servico UUID PRIMARY KEY NOT NULL,
    id_administrador UUID NOT NULL,
    id_endereco UUID NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(500),
    categoria_localidade VARCHAR(100),
    horario_funcionamento VARCHAR(100),
    genero VARCHAR(30),
    faixa_etaria VARCHAR(30),


    -- Chave estrangeira: referência ao endereço do serviço
    CONSTRAINT fk_servicos_endereco
        FOREIGN KEY (id_endereco)
        REFERENCES enderecos(id_endereco)
        ON DELETE CASCADE,

    -- Validação dos valores permitidos para o campo genero
    CONSTRAINT chk_genero
        CHECK (genero IN ('Masculino', 'Feminino', 'Outro', 'Todos')),

    -- Validação dos valores permitidos para o campo faixa_etaria
    CONSTRAINT chk_faixa_etaria
        CHECK (faixa_etaria IN ('Infantil', 'Adolescente', 'Adulto', 'Idoso', 'Todos'))
);



-- Inserir um administrador
INSERT INTO administradores (id_administrador, nome_completo, email, senha)
VALUES (
    gen_random_uuid(), 
    'Ana Silva', 
    'ana.silva@email.com', 
    'senha123segura'
);

-- Inserir um endereço
INSERT INTO enderecos (id_endereco, estado, cidade, bairro, cep, rua, numero, latitude, longitude)
VALUES (
    gen_random_uuid(), 
    'SP', 
    'São Paulo', 
    'Centro', 
    '01000-000', 
    'Rua da Saúde', 
    '123', 
    -23.550520, 
    -46.633308
);

-- Inserir um serviço
INSERT INTO servicos (
    id_servico, id_administrador, id_endereco, nome, descricao, 
    categoria_localidade, horario_funcionamento, genero, faixa_etaria
)
VALUES (
    gen_random_uuid(),
    'UUID_DO_ADMINISTRADOR',
    'UUID_DO_ENDERECO',
    'Atendimento Psicológico Gratuito',
    'Serviço voltado ao público jovem em situação de vulnerabilidade.',
    'Clínica Comunitária',
    'Seg-Sex: 09h às 17h',
    'Todos',
    'Adolescente'
);


SELECT id_administrador, nome_completo
FROM administradores;

SELECT id_endereco, cidade, rua, numero
FROM enderecos;

SELECT id_administrador
FROM administradores
WHERE email = 'ana.silva@email.com';

SELECT id_endereco
FROM enderecos
WHERE cidade = 'São Paulo' AND rua = 'Rua da Saúde';

-- Atualizar o nome e o email de um administrador
UPDATE administradores
SET nome_completo = 'Ana Carolina Silva', email = 'ana.carolina@email.com'
WHERE id_administrador = 'UUID_DO_ADMINISTRADOR';

-- Atualizar a cidade e rua de um endereço
UPDATE enderecos
SET cidade = 'Campinas', rua = 'Avenida da Paz'
WHERE id_endereco = 'UUID_DO_ENDERECO';

-- Atualizar a descrição e horário de um serviço
UPDATE servicos
SET descricao = 'Serviço psicológico para jovens e adultos.',
    horario_funcionamento = 'Seg a Sáb: 08h às 18h'
WHERE id_servico = 'UUID_DO_SERVICO';


-- Deletar um serviço específico
DELETE FROM servicos
WHERE id_servico = 'UUID_DO_SERVICO';

-- Deletar um endereço (irá remover também os serviços ligados, por causa do ON DELETE CASCADE)
DELETE FROM enderecos
WHERE id_endereco = 'UUID_DO_ENDERECO';

-- Deletar um administrador 
DELETE FROM administradores
WHERE id_administrador = 'UUID_DO_ADMINISTRADOR';
