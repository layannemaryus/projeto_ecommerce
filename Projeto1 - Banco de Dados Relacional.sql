CREATE TABLE IF NOT EXISTS public."Cliente"
(
	id_cliente serial NOT NULL UNIQUE,
    email character varying(100) NOT NULL,
    cpf character varying(20) NOT NULL UNIQUE,
    nome character varying(100)[] NOT NULL,
    rg character varying(20) NOT NULL,
    telefone character varying(100) NOT NULL,
    endereco character varying(255) NOT NULL,
    PRIMARY KEY (cpf, email)
);


INSERT INTO public."Cliente"(email,cpf,nome,rg,telefone,endereco)
VALUES
  ('a.felis@outlook.org','11.111.111-1','{Hikaru Yamanaka}','000.000.000-01','(614) 776-1318','Ap #548-7547 Commodo Avenue'),
  ('duis.risus.odio@aol.couk','11.111.111-2','{Layanne Mary}','000.000.000-02','(546) 479-5384','Ap #673-6494 Ac Rd.'),
  ('dados.carolyne@gmail.com','11.111.111-3','{Carolyne Oliveira}','000.000.000-03','1-473-553-0474','Ap #891-5968 Placerat Street'),
  ('facilisi@protonmail.edu','11.111.111-4','{Deise Pestana}','000.000.000-04','1-153-313-8753','199-3157 Risus. St.'),
  ('ipsum@outlook.edu','11.111.111-5','{Sacha Le}','000.000.000-05','(309) 850-6925','Ap #394-5985 Ut Street');



CREATE TABLE IF NOT EXISTS public."Pontos_Acumulados"
(
	id_pontosAcumulados SERIAL PRIMARY KEY,
    pontuacao integer NOT NULL,
	FOREIGN KEY (id_pontosAcumulados)
	REFERENCES public."Cliente" (id_cliente)
);



INSERT INTO "Pontos_Acumulados" (pontuacao)
VALUES
  (1000),
  (2000),
  (3000),
  (4000),
  (5000);


CREATE TABLE IF NOT EXISTS public."Pedido"
(
    id_pedido SERIAL UNIQUE,
	cod_pedido integer NOT NULL PRIMARY KEY,
    valor_total real NOT NULL,
    quantidade integer NOT NULL,
    data_pedido date NOT NULL,
    data_entrega date NOT NULL,
    status_pedido character varying(10) NOT NULL,
    forma_entrega character varying(20) NOT NULL,
	FOREIGN KEY (id_pedido)
	REFERENCES public."Cliente" (id_cliente)
);



INSERT INTO "Pedido" (cod_pedido, valor_total, quantidade, data_pedido, data_entrega, status_pedido, forma_entrega)
VALUES
  (1, 100, 2, '2024-01-01', '2024-01-02', 'Enviado', 'Entrega em domicílio'),
  (2, 200, 1, '2024-01-03', '2024-01-04', 'Pendente', 'Retirada na loja'),
  (3, 150, 3, '2024-01-05', '2024-01-06', 'Enviado', 'Entrega em domicílio'),
  (4, 300, 4, '2024-01-07', '2024-01-08', 'Pendente', 'Retirada na loja'),
  (5, 250, 5, '2024-01-09', '2024-01-10', 'Enviado', 'Entrega em domicílio');




CREATE TABLE IF NOT EXISTS public."Produto"
(
	id_produto SERIAL UNIQUE,
    cod_produto integer NOT NULL PRIMARY KEY,
    nome_produto character varying(50) NOT NULL,
    peso real NOT NULL,
    descricao_produto character varying(250) NOT NULL,
    quantidade integer NOT NULL,
    preco_produto real NOT NULL,
    FOREIGN KEY (id_produto)
	REFERENCES public."Pedido" (id_pedido)
);



INSERT INTO public."Produto"(cod_produto, nome_produto, peso, descricao_produto, quantidade, preco_produto)
VALUES
  (1, 'Hidratante Corporal', 500.0, 'Creme Hidratante Corporal Sem Cheiro', 3, 100.0),
  (2, 'Shampoo', 150.0, 'Shampoo para Cabelos mistos e oleosos', 1, 200.0),
  (3, 'Lip Gloss', 13.0, 'Brilho Labial sabor cereja', 10, 300.0),
  (4, 'Condicionador', 150.0, 'Condicionador para todos os tipos de cabelo', 4, 400.0),
  (5, 'Hidratante Facial', 80.0, 'Hidratante facial com vitamina E', 2, 500.0);



CREATE TABLE IF NOT EXISTS public."Estoque"
(
	id_estoque SERIAL UNIQUE,
    qtd_disponivel integer NOT NULL PRIMARY KEY,
	FOREIGN KEY (id_estoque)
	REFERENCES public."Produto" (id_produto)
);



INSERT INTO "Estoque" (qtd_disponivel)
VALUES
  (100),
  (2035),
  (300),
  (401),
  (50);

SELECT * FROM public."Estoque";


CREATE TABLE IF NOT EXISTS public."Categoria_Produto"
(
    id_categoria SERIAL NOT NULL UNIQUE,
    nome_categoria character varying(200) NOT NULL,
    desc_categoria character varying(200) NOT NULL,
    FOREIGN KEY (id_categoria)
	REFERENCES public."Produto" (id_produto)
);



INSERT INTO "Categoria_Produto" (nome_categoria, desc_categoria)
VALUES
  ('Cuidado Corporal', 'Hidratantes Corporal'),
  ('Cabelo', 'Cuidados Cabelos Mistos e Oleosos'),
  ('Maquiagem', 'Beleza'),
  ('Cabelo', 'Cuidados Para todos os tipo de Cabelos'),
  ('Cuidado Facial', 'Hidratante Facial');


CREATE INDEX idx_cliente_email ON public."Cliente" (email);

CREATE INDEX idx_cliente_cpf ON public."Cliente" (cpf);

CREATE INDEX idx_pedido_data_pedido ON public."Pedido" (data_pedido);

CREATE INDEX idx_produto_nome_produto ON public."Produto" (nome_produto);

CREATE INDEX idx_estoque_qtd_disponivel ON public."Estoque" (qtd_disponivel);

CREATE INDEX idx_categoria_produto_nome ON public."Categoria_Produto" (nome_categoria);




