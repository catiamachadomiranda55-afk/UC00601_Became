-- =====================================================
-- CobraFácil - criação de tabelas + dados de teste
-- PostgreSQL (pgAdmin)
-- =====================================================

-- (Opcional) Apagar tabelas existentes para recomeçar do zero
-- DROP TABLE IF EXISTS cobrancas CASCADE;
-- DROP TABLE IF EXISTS empresas  CASCADE;
-- DROP TABLE IF EXISTS clientes  CASCADE;

-- -----------------------------------------------------
-- 1) TABELAS (ordem importa por causa das chaves estrangeiras)
-- -----------------------------------------------------

CREATE TABLE clientes (
    id_cliente    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    cidade        VARCHAR(80),
    pais          VARCHAR(80),
    email         VARCHAR(120) UNIQUE,
    data_registo  DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE empresas (
    id_empresas   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cliente    INTEGER NOT NULL
                  REFERENCES clientes (id_cliente)
                  ON UPDATE CASCADE ON DELETE CASCADE,
    empresa_nome  VARCHAR(100) NOT NULL,
    cliente_nome  VARCHAR(100),
    pais          VARCHAR(80),
    cidade        VARCHAR(80),
    email         VARCHAR(120),
    data_registo  DATE NOT NULL DEFAULT CURRENT_DATE,
    valor         NUMERIC(12,2) DEFAULT 0
);

CREATE TABLE cobrancas (
    id_cobrancas  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cliente    INTEGER NOT NULL
                  REFERENCES clientes (id_cliente)
                  ON UPDATE CASCADE ON DELETE CASCADE,
    id_empresas   INTEGER NOT NULL
                  REFERENCES empresas (id_empresas)
                  ON UPDATE CASCADE ON DELETE CASCADE,
    valor         NUMERIC(12,2) NOT NULL CHECK (valor >= 0),
    prazo         DATE NOT NULL,
    estado        VARCHAR(20) NOT NULL DEFAULT 'pendente'
                  CHECK (estado IN ('pendente', 'pago', 'atrasado', 'cancelado'))
);

-- -----------------------------------------------------
-- 2) DADOS DE TESTE
-- -----------------------------------------------------

INSERT INTO clientes (nome, cidade, pais, email, data_registo) VALUES
('Ana Silva',       'Porto',          'Portugal', 'ana.silva@example.com',       '2026-01-10'),
('João Pereira',    'Lisboa',         'Portugal', 'joao.pereira@example.com',    '2026-01-22'),
('Maria Santos',    'Braga',          'Portugal', 'maria.santos@example.com',    '2026-02-05'),
('Carlos Oliveira', 'São Paulo',      'Brasil',   'carlos.oliveira@example.com', '2026-02-18'),
('Sofia Costa',     'Coimbra',        'Portugal', 'sofia.costa@example.com',     '2026-03-03'),
('Pedro Almeida',   'Faro',           'Portugal', 'pedro.almeida@example.com',   '2026-03-27'),
('Laura Fernández', 'Madrid',         'Espanha',  'laura.fernandez@example.com', '2026-04-14'),
('Miguel Rocha',    'Rio de Janeiro', 'Brasil',   'miguel.rocha@example.com',    '2026-05-09');

INSERT INTO empresas (id_cliente, empresa_nome, cliente_nome, pais, cidade, email, data_registo, valor) VALUES
(1, 'TechNova Lda',       'Ana Silva',       'Portugal', 'Porto',   'geral@technova.example.com',      '2026-01-12', 1820.50),
(2, 'Lisboa Digital Lda', 'João Pereira',    'Portugal', 'Lisboa',  'info@lisboadigital.example.com',  '2026-01-25', 3230.00),
(3, 'Minho Têxteis SA',   'Maria Santos',    'Portugal', 'Braga',   'contacto@minhotexteis.example.com','2026-02-08', 6380.75),
(4, 'Brasil Soluções',    'Carlos Oliveira', 'Brasil',   'São Paulo','contato@brasilsolucoes.example.com','2026-02-20', 4290.00),
(7, 'Iberia Consulting',  'Laura Fernández', 'Espanha',  'Madrid',  'hola@iberiaconsulting.example.com','2026-04-16', 2860.30),
(5, 'Coimbra Eventos',    'Sofia Costa',     'Portugal', 'Coimbra', 'eventos@coimbraeventos.example.com','2026-03-05', 2590.00);

-- id_cliente, id_empresas, valor, prazo, estado
INSERT INTO cobrancas (id_cliente, id_empresas, valor, prazo, estado) VALUES
(1, 1, 1500.00, '2026-11-30', 'pendente'),
(1, 1,  320.50, '2026-10-15', 'pago'),
(2, 2, 2750.00, '2026-12-10', 'pendente'),
(2, 2,  480.00, '2026-09-30', 'atrasado'),
(3, 3, 5200.00, '2026-11-20', 'pendente'),
(3, 3, 1180.75, '2026-08-31', 'pago'),
(4, 4,  890.00, '2026-10-05', 'atrasado'),
(4, 4, 3400.00, '2026-12-31', 'pendente'),
(7, 5, 2100.00, '2026-11-25', 'pendente'),
(7, 5,  760.30, '2026-09-15', 'pago'),
(5, 6, 1950.00, '2026-12-15', 'pendente'),
(5, 6,  640.00, '2026-10-20', 'atrasado');

-- -----------------------------------------------------
-- 3) VERIFICAÇÃO RÁPIDA
-- -----------------------------------------------------
-- SELECT * FROM clientes;
-- SELECT * FROM empresas;
-- SELECT * FROM cobrancas;

-- SELECT c.id_cobrancas, cl.nome AS cliente, e.empresa_nome, c.valor, c.prazo, c.estado
-- FROM cobrancas c
-- JOIN clientes cl ON cl.id_cliente  = c.id_cliente
-- JOIN empresas e  ON e.id_empresas  = c.id_empresas
-- ORDER BY c.prazo;

select * from clientes

select * from empresas

select * from cobrancas