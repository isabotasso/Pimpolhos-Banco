create table categoria
(
	cod_categoria tinyint not null auto_increment,
	nome_categoria varchar(20) not null,
	primary key (cod_categoria)
)
;

create table fornecedor
(
	cod_fornecedor tinyint not null auto_increment,
	nome_fornecedor varchar(20) not null,
	primary key (cod_fornecedor)
)
;

create table produto
(
	cod_produto smallint not null auto_increment,
	nome varchar(100) not null,
	preco decimal(7, 2) not null,
	marca varchar(20) not null,
	sexo varchar(20) null,
	dimensao varchar(20) null,
	material varchar(50) not null,
	peso decimal(7, 2) not null,
	conteudo_produto varchar(255) not null,
	cod_fornecedor tinyint not null,
	cod_categoria tinyint not null,
	primary key (cod_produto),
	foreign key (cod_fornecedor) references fornecedor (cod_fornecedor),
	foreign key (cod_categoria) references categoria (cod_categoria)
)
;

create table estoque
(
	cod_produto smallint not null,
	quantidade int not null,
	primary key (cod_produto),
	foreign key (cod_produto) references produto (cod_produto)
)
;

create table cliente 
(
  cod_cliente smallint not null auto_increment,
  nome_cliente varchar(50) not null,
  cpf varchar(11) not null,
  data_nasc DATE not null,
  email varchar(50) not null,
  senha varchar(15) not null,
  primary key (cod_cliente)
);

create table tipo_telefone 
(
 cod_tipoTelefone smallint not null auto_increment,
 descricao_telefone varchar(7) not null,
 primary key (cod_tipoTelefone)
);

create table telefone 
(
  cod_telefone smallint not null auto_increment,
  ddd varchar(3) not null,
  numero_telefone varchar(9) not null,
  cod_tipoTelefone smallInt not null,
  primary key (cod_telefone),
  foreign key (cod_tipoTelefone) references tipo_telefone (cod_tipoTelefone)
);

create table cliente_telefone
(
	cod_cliente smallint not null,
	cod_telefone smallint not null,
	primary key (cod_cliente, cod_telefone), 
	foreign key (cod_telefone) references telefone (cod_telefone), 
	foreign key (cod_cliente) references cliente (cod_cliente)
);

create table estado
(
	cod_estado tinyint not null auto_increment, 
	descricao varchar(2) not null, 
	primary key (cod_estado)
);

create table endereco
(
	cod_endereco smallint not null auto_increment, 
	nome_cidade varchar(50) not null, 
	cep varchar(10) not null, 
	nome_rua varchar(50) not null,
	numero_casa varchar(5) not null, 
	complemento varchar(20) null, 
	bairro varchar(50) not null, 
	ponto_referencia varchar(50) null, 
	cod_estado tinyint not null,
	primary key (cod_endereco), 
	foreign key (cod_estado) references estado (cod_estado)
);

create table endereco_cliente
(
	cod_endereco smallint not null, 
	cod_cliente smallint not null, 
	primary key (cod_endereco, cod_cliente),  
	foreign key (cod_endereco) references endereco (cod_endereco), 
	foreign key (cod_cliente) references cliente (cod_cliente)
);

create table favoritos
(
	cod_cliente smallint not null,
	cod_produto smallint not null,
	primary key (cod_produto, cod_cliente),
	foreign key (cod_produto) references produto (cod_produto),
	foreign key (cod_cliente) references cliente (cod_cliente)
);

create table produtos_relacionados
(
	cod_relacionados smallint not null auto_increment,
	cod_produto smallint not null,
	primary key (cod_relacionados),
	foreign key (cod_produto) references produto (cod_produto)
);

create table status_pedido 
(
	cod_status smallint not null,
	descricao  varchar(30) not null,
	primary key (cod_status)
);

create table frete
(
	cod_frete tinyint not null auto_increment,
	descricao varchar(20) not null,
	valor_frete	decimal(5,2) not null,
	primary key (cod_frete)
);

create table pesquisa_satisfacao
(
	cod_pesquisa tinyint not null auto_increment,
	descricao varchar(20)not null,
	primary key (cod_pesquisa)
);

create table forma_pagamento
(
	cod_forma_pagamento tinyint not null auto_increment, 
	descricao varchar(10) not null, 
	primary key (cod_forma_pagamento)
);

create table tipo_pagamento
(
	cod_operacao smallint not null auto_increment,
	cod_forma_pagamento tinyint not null,
	primary key (cod_operacao, cod_forma_pagamento),
	foreign key (cod_forma_pagamento) references forma_pagamento (cod_forma_pagamento)
);

create table bandeira
(
	cod_bandeira tinyint not null auto_increment,
	descricao varchar(20) not null,
	primary key (cod_bandeira)
)
;

create table cartao
(
	cod_operacao smallint not null,	
	cod_forma_pagamento tinyint not null,
	numero_cartao varchar(20) not null,
	nome_titular varchar(50) not null,
	validade date not null,
	cod_seguranca varchar(4) not null, 
	cod_bandeira tinyint not null,
	cod_cliente smallint not null,
	primary key (cod_operacao, cod_forma_pagamento),
	foreign key (cod_bandeira) references bandeira (cod_bandeira),
	foreign key (cod_cliente) references cliente (cod_cliente),
	foreign key (cod_operacao) references tipo_pagamento (cod_operacao),
	foreign key (cod_forma_pagamento) references tipo_pagamento (cod_forma_Pagamento)
)
;

create table boleto
(
	cod_operacao smallint not null,
	cod_forma_pagamento tinyint not null,
	valor decimal(7, 2) not null,
	cod_barras varchar(50) not null,
	data_vencimento date not null,
	data_emissao date not null,
	beneficiario varchar(50) not null,
	emissor varchar(50) not null,
	primary key (cod_operacao, cod_forma_pagamento),
	foreign key (cod_operacao) references tipo_pagamento (cod_operacao),
	foreign key (cod_forma_pagamento) references tipo_pagamento (cod_forma_Pagamento)
)
;

create table pix
(
	cod_operacao smallint not null, 
	cod_forma_pagamento tinyint not null, 
	link_qr varchar(50) not null, 
	primary key (cod_operacao, cod_forma_pagamento), 
	foreign key (cod_operacao) references tipo_pagamento (cod_operacao), 
	foreign key (cod_forma_pagamento) references tipo_pagamento (cod_forma_pagamento)
);

create table pedido
(
	cod_pedido smallint not null auto_increment,
	cod_frete tinyint not null,
	cod_endereco smallint not null,
	cod_cliente smallint not null,
	cod_status smallint not null,
	cod_operacao smallint not null,
	cod_forma_pagamento tinyint not null,
	primary key (cod_pedido),
	foreign key (cod_frete) references frete (cod_frete),
	foreign key (cod_endereco) references endereco_cliente (cod_endereco),
	foreign key (cod_cliente) references endereco_cliente (cod_cliente),
	foreign key (cod_status) references status_pedido (cod_status),
	foreign key (cod_operacao) references tipo_pagamento (cod_operacao),
	foreign key (cod_forma_pagamento) references tipo_pagamento (cod_forma_pagamento)
);

create table item_pedido
(
	cod_pedido  smallint not null,
	cod_produto smallint not null,
	quantidade  tinyint  not null,
	primary key (cod_pedido, cod_produto),
	foreign key (cod_pedido) references  pedido(cod_pedido),
	foreign key (cod_produto) references produto(cod_produto)
); 

create table pedido_avaliacao
(
	cod_pedido smallint not null,
	cod_pesquisa tinyint not null,
	mensagem_avaliativa varchar(200) null,
	imagem_avaliacao varchar(50) null,
	primary key (cod_pedido),
	foreign key (cod_pesquisa) references pesquisa_satisfacao(cod_pesquisa),
	foreign key (cod_pedido) references pedido(cod_pedido)
);


create table destaques 
(
	cod_destaques smallint not null,
	cod_pedido smallint not null,
	primary key (cod_destaques),
	foreign key (cod_pedido) references pedido (cod_pedido)
);

create table natureza_operacao 
(
	cod_natureza_operacao tinyint not null,
	descricao varchar(20) not null,
	primary key (cod_natureza_operacao)

);

create table item_nf
(
	cod_produto smallint not null, 
	cod_item_nota smallint not null,
	valor_unitario decimal(7, 2) not null,
	valor_total decimal(7, 2) not null, 
	quantidade tinyint not null, 
	valor_icms_item decimal(5, 2) not null,
	INDEX (cod_produto),
 	INDEX (cod_item_nota),
	primary key (cod_produto, cod_item_nota),
	foreign key (cod_produto) references produto(cod_produto)
);

create table nf_e
(
	cod_nf int not null auto_increment,
	cod_pedido smallint not null,
	numero_nf int not null,
	chave_acesso varchar(44) not null,
	data_emissao date not null,
	valor_total_nf decimal(7,2)  not null,
	valor_total_produtos  decimal(7,2) not null,
	coo_nota int not null,
	valor_frete decimal(5,2) not null,
	inscricao_estadual varchar(15) not null,
	valor_icms_total decimal(5,2) not null,
	cod_produto smallint not null,
	cod_item_nota smallint not null,
	cod_natureza_operacao tinyint not null,
	cnpj_pimpolhos varchar(14) not null,
	razao_social varchar(15) not null,
	primary key (cod_nf),
	foreign key (cod_pedido) references pedido (cod_pedido),
	foreign key (cod_produto) references item_nf (cod_produto),
	foreign key (cod_item_nota) references item_nf (cod_item_nota),
	foreign key (cod_natureza_operacao) references natureza_operacao (cod_natureza_operacao)
);


alter table nf_e modify numero_nf bigint not null;



show tables;