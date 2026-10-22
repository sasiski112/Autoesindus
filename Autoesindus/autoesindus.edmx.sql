
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 10/22/2026 11:21:29
-- Generated from EDMX file: C:\Users\opilane\source\repos\Autoesindus\Autoesindus\Model1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [autoesindus];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------


-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'TootajaSet'
CREATE TABLE [dbo].[TootajaSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [eesnimi] nvarchar(max)  NOT NULL,
    [perenimi] nvarchar(max)  NOT NULL,
    [isikukood] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'ametSet'
CREATE TABLE [dbo].[ametSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [nimetus] nvarchar(max)  NOT NULL,
    [kirjeldus] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'ametiMaaratusSet'
CREATE TABLE [dbo].[ametiMaaratusSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [alguskuupaev] datetime  NOT NULL,
    [amet_Id] int  NOT NULL,
    [Tootaja_Id] int  NOT NULL
);
GO

-- Creating table 'lisavarustusSet'
CREATE TABLE [dbo].[lisavarustusSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [nimetus] nvarchar(max)  NOT NULL,
    [lisahind] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'autoLisavarustusSet'
CREATE TABLE [dbo].[autoLisavarustusSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [lisavarustus_Id] int  NOT NULL,
    [auto_Id] int  NOT NULL
);
GO

-- Creating table 'autoSet'
CREATE TABLE [dbo].[autoSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [nimetus] nvarchar(max)  NOT NULL,
    [kirjeldus] nvarchar(max)  NOT NULL,
    [hind] nvarchar(max)  NOT NULL,
    [mark_Id] int  NOT NULL,
    [Kategooria_Id] int  NOT NULL
);
GO

-- Creating table 'markSet'
CREATE TABLE [dbo].[markSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [nimetus] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'KategooriaSet'
CREATE TABLE [dbo].[KategooriaSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [nimetus] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'salongSet'
CREATE TABLE [dbo].[salongSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [number] nvarchar(max)  NOT NULL,
    [kohtadeArv] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'TellimusSet'
CREATE TABLE [dbo].[TellimusSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [kuupaev] datetime  NOT NULL,
    [kellaaeg] time  NOT NULL,
    [staatus] nvarchar(max)  NOT NULL,
    [salong_Id] int  NOT NULL,
    [Klient_Id] int  NOT NULL
);
GO

-- Creating table 'TellimusAutoSet'
CREATE TABLE [dbo].[TellimusAutoSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Tellimus_Id] int  NOT NULL,
    [auto_Id] int  NOT NULL
);
GO

-- Creating table 'KlientSet'
CREATE TABLE [dbo].[KlientSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [eesnimi] nvarchar(max)  NOT NULL,
    [perenimi] nvarchar(max)  NOT NULL,
    [telefon] nvarchar(max)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'TootajaSet'
ALTER TABLE [dbo].[TootajaSet]
ADD CONSTRAINT [PK_TootajaSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ametSet'
ALTER TABLE [dbo].[ametSet]
ADD CONSTRAINT [PK_ametSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ametiMaaratusSet'
ALTER TABLE [dbo].[ametiMaaratusSet]
ADD CONSTRAINT [PK_ametiMaaratusSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'lisavarustusSet'
ALTER TABLE [dbo].[lisavarustusSet]
ADD CONSTRAINT [PK_lisavarustusSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'autoLisavarustusSet'
ALTER TABLE [dbo].[autoLisavarustusSet]
ADD CONSTRAINT [PK_autoLisavarustusSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'autoSet'
ALTER TABLE [dbo].[autoSet]
ADD CONSTRAINT [PK_autoSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'markSet'
ALTER TABLE [dbo].[markSet]
ADD CONSTRAINT [PK_markSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'KategooriaSet'
ALTER TABLE [dbo].[KategooriaSet]
ADD CONSTRAINT [PK_KategooriaSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'salongSet'
ALTER TABLE [dbo].[salongSet]
ADD CONSTRAINT [PK_salongSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'TellimusSet'
ALTER TABLE [dbo].[TellimusSet]
ADD CONSTRAINT [PK_TellimusSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'TellimusAutoSet'
ALTER TABLE [dbo].[TellimusAutoSet]
ADD CONSTRAINT [PK_TellimusAutoSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'KlientSet'
ALTER TABLE [dbo].[KlientSet]
ADD CONSTRAINT [PK_KlientSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [amet_Id] in table 'ametiMaaratusSet'
ALTER TABLE [dbo].[ametiMaaratusSet]
ADD CONSTRAINT [FK_ametametiMaaratus]
    FOREIGN KEY ([amet_Id])
    REFERENCES [dbo].[ametSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ametametiMaaratus'
CREATE INDEX [IX_FK_ametametiMaaratus]
ON [dbo].[ametiMaaratusSet]
    ([amet_Id]);
GO

-- Creating foreign key on [Tootaja_Id] in table 'ametiMaaratusSet'
ALTER TABLE [dbo].[ametiMaaratusSet]
ADD CONSTRAINT [FK_TootajaametiMaaratus]
    FOREIGN KEY ([Tootaja_Id])
    REFERENCES [dbo].[TootajaSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TootajaametiMaaratus'
CREATE INDEX [IX_FK_TootajaametiMaaratus]
ON [dbo].[ametiMaaratusSet]
    ([Tootaja_Id]);
GO

-- Creating foreign key on [lisavarustus_Id] in table 'autoLisavarustusSet'
ALTER TABLE [dbo].[autoLisavarustusSet]
ADD CONSTRAINT [FK_lisavarustusautoLisavarustus]
    FOREIGN KEY ([lisavarustus_Id])
    REFERENCES [dbo].[lisavarustusSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_lisavarustusautoLisavarustus'
CREATE INDEX [IX_FK_lisavarustusautoLisavarustus]
ON [dbo].[autoLisavarustusSet]
    ([lisavarustus_Id]);
GO

-- Creating foreign key on [mark_Id] in table 'autoSet'
ALTER TABLE [dbo].[autoSet]
ADD CONSTRAINT [FK_markauto]
    FOREIGN KEY ([mark_Id])
    REFERENCES [dbo].[markSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_markauto'
CREATE INDEX [IX_FK_markauto]
ON [dbo].[autoSet]
    ([mark_Id]);
GO

-- Creating foreign key on [auto_Id] in table 'autoLisavarustusSet'
ALTER TABLE [dbo].[autoLisavarustusSet]
ADD CONSTRAINT [FK_autoautoLisavarustus]
    FOREIGN KEY ([auto_Id])
    REFERENCES [dbo].[autoSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_autoautoLisavarustus'
CREATE INDEX [IX_FK_autoautoLisavarustus]
ON [dbo].[autoLisavarustusSet]
    ([auto_Id]);
GO

-- Creating foreign key on [Kategooria_Id] in table 'autoSet'
ALTER TABLE [dbo].[autoSet]
ADD CONSTRAINT [FK_Kategooriaauto]
    FOREIGN KEY ([Kategooria_Id])
    REFERENCES [dbo].[KategooriaSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Kategooriaauto'
CREATE INDEX [IX_FK_Kategooriaauto]
ON [dbo].[autoSet]
    ([Kategooria_Id]);
GO

-- Creating foreign key on [salong_Id] in table 'TellimusSet'
ALTER TABLE [dbo].[TellimusSet]
ADD CONSTRAINT [FK_salongTellimus]
    FOREIGN KEY ([salong_Id])
    REFERENCES [dbo].[salongSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_salongTellimus'
CREATE INDEX [IX_FK_salongTellimus]
ON [dbo].[TellimusSet]
    ([salong_Id]);
GO

-- Creating foreign key on [Tellimus_Id] in table 'TellimusAutoSet'
ALTER TABLE [dbo].[TellimusAutoSet]
ADD CONSTRAINT [FK_TellimusTellimusAuto]
    FOREIGN KEY ([Tellimus_Id])
    REFERENCES [dbo].[TellimusSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TellimusTellimusAuto'
CREATE INDEX [IX_FK_TellimusTellimusAuto]
ON [dbo].[TellimusAutoSet]
    ([Tellimus_Id]);
GO

-- Creating foreign key on [auto_Id] in table 'TellimusAutoSet'
ALTER TABLE [dbo].[TellimusAutoSet]
ADD CONSTRAINT [FK_autoTellimusAuto]
    FOREIGN KEY ([auto_Id])
    REFERENCES [dbo].[autoSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_autoTellimusAuto'
CREATE INDEX [IX_FK_autoTellimusAuto]
ON [dbo].[TellimusAutoSet]
    ([auto_Id]);
GO

-- Creating foreign key on [Klient_Id] in table 'TellimusSet'
ALTER TABLE [dbo].[TellimusSet]
ADD CONSTRAINT [FK_KlientTellimus]
    FOREIGN KEY ([Klient_Id])
    REFERENCES [dbo].[KlientSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_KlientTellimus'
CREATE INDEX [IX_FK_KlientTellimus]
ON [dbo].[TellimusSet]
    ([Klient_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------