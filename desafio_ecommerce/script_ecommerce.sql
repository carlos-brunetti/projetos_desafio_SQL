-- Criação e uso do banco de dados
drop database if exists ecommerce_desafio;
create database ecommerce_desafio;
use ecommerce_desafio;

-- Tabela de Clientes
create table clients (
    id_client int auto_increment primary key,
    first_name varchar(10),
    middle_initial char(3),
    last_name varchar(20),
    cpf char(11),
    cnpj char(14),
    address varchar(255),
    constraint unique_cpf unique (cpf),
    constraint unique_cnpj unique (cnpj),
    constraint chk_only_one_id check (
        (cpf is not null and cnpj is null) or 
        (cpf is null and cnpj is not null)
    )
);

-- Tabela de Pagamentos
create table payments (
    id_payment int auto_increment primary key,
    id_client int not null,
    type_payment enum('boleto', 'cartao', 'dois_cartoes') not null,
    limit_available float default 0,
    foreign key (id_client) references clients(id_client)
);

-- Tabela de Pedidos
create table orders (
    id_order int auto_increment primary key,
    id_client int not null,
    order_status enum('cancelado', 'confirmado', 'em_processamento') default 'em_processamento',
    order_description varchar(255),
    shipping_cost float default 10,
    payment_cash boolean default false,
    id_payment int,
    tracking_code varchar(20),
    foreign key (id_client) references clients(id_client),
    foreign key (id_payment) references payments(id_payment)
);

-- Trigger para gerar tracking_code automaticamente
DELIMITER //
create trigger trg_generate_tracking_code
before insert on orders
for each row
begin
  if new.tracking_code is null then
    set new.tracking_code = concat('TRK', lpad(cast(rand()*100000 as unsigned), 5, '0'));
  end if;
end;//
DELIMITER ;

-- Tabela de Produtos
create table product (
    id_product int auto_increment primary key,
    name varchar(30) not null,
    classification_kids boolean default false,
    category enum ('eletronico','vestuario','brinquedos','alimentos','moveis') not null,
    rating float default 0,
    size varchar(10)
);

-- Tabela de Estoque
create table product_storage (
    id_product_storage int auto_increment primary key,
    storage_location varchar(255),
    quantity int default 0
);

-- Tabela de Fornecedores
create table supplier (
    id_supplier int auto_increment primary key,
    social_name varchar(255) not null,
    cnpj char(14) not null,
    contact char(11) not null,
    constraint unique_supplier_cnpj unique (cnpj)
);

-- Tabela de Vendedores
create table seller (
    id_seller int auto_increment primary key,
    social_name varchar(255) not null,
    abstract_name varchar(255),
    cnpj char(14),
    cpf char(11),
    location varchar(255),
    contact char(11) not null,
    constraint unique_seller_cnpj unique (cnpj),
    constraint unique_seller_cpf unique (cpf),
    constraint chk_only_one_seller_id check (
        (cpf is not null and cnpj is null) or 
        (cpf is null and cnpj is not null)
    )
);

-- Tabela de relacionamento Produto-Vendedor (M:N)
create table product_seller (
    id_seller int,
    id_product int,
    prod_quantity int default 1,
    primary key (id_seller, id_product),
    foreign key (id_seller) references seller(id_seller),
    foreign key (id_product) references product(id_product)
);

-- Tabela de relacionamento Produto-Pedido (M:N)
create table product_order (
    id_product int,
    id_order int,
    quantity int default 1,
    status enum('disponivel','sem_estoque') default 'disponivel',
    primary key (id_product, id_order),
    foreign key (id_product) references product(id_product),
    foreign key (id_order) references orders(id_order)
);

-- Tabela de relacionamento Produto-Estoque
create table storage_location (
    id_product int,
    id_product_storage int,
    location varchar(255) not null,
    primary key (id_product, id_product_storage),
    foreign key (id_product) references product(id_product),
    foreign key (id_product_storage) references product_storage(id_product_storage)
);

-- Tabela de relacionamento Produto-Fornecedor
create table product_supplier (
    id_supplier int,
    id_product int,
    quantity int not null,
    primary key (id_supplier, id_product),
    foreign key (id_supplier) references supplier(id_supplier),
    foreign key (id_product) references product(id_product)
);

