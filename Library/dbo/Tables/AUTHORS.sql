CREATE TABLE [dbo].[AUTHORS] (
    [id]        INT           IDENTITY (1, 1) NOT NULL,
    [name]      VARCHAR (100) NOT NULL,
    [last_name] VARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO

