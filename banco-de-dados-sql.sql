CREATE DATABASE JustinoDB;
GO

USE JustinoDB;
GO

CREATE TABLE Usuarios (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(100) NOT NULL,
    tipo NVARCHAR(10) CHECK (tipo IN ('advogado', 'cidadao')) NOT NULL,
    OAB NVARCHAR(20) NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    senha NVARCHAR(255) NOT NULL,
    preferencias_notificacoes BIT DEFAULT 1,
    criado_em DATETIME DEFAULT GETDATE()
);

CREATE TABLE Servidores (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(100) NOT NULL,
    comarca NVARCHAR(100) NOT NULL,
    status_disponibilidade NVARCHAR(20) CHECK (status_disponibilidade IN ('disponivel', 'indisponivel')) NOT NULL,
    atualizado_em DATETIME DEFAULT GETDATE()
);

CREATE TABLE HistoricoInteracoes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    usuario_id INT NOT NULL FOREIGN KEY REFERENCES Usuarios(id),
    data DATETIME DEFAULT GETDATE(),
    tipo_interacao NVARCHAR(50) NOT NULL,
    detalhes NVARCHAR(MAX) NULL
);

CREATE TABLE Feedback (
    id INT IDENTITY(1,1) PRIMARY KEY,
    usuario_id INT NOT NULL FOREIGN KEY REFERENCES Usuarios(id),
    nota INT CHECK (nota BETWEEN 1 AND 5) NOT NULL,
    comentario NVARCHAR(MAX) NULL,
    data DATETIME DEFAULT GETDATE()
);

CREATE TABLE Notificacoes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    usuario_id INT NOT NULL FOREIGN KEY REFERENCES Usuarios(id),
    mensagem NVARCHAR(MAX) NOT NULL,
    data_envio DATETIME DEFAULT GETDATE(),
    status NVARCHAR(20) CHECK (status IN ('lida', 'nao lida')) DEFAULT 'nao lida'
);
GO
