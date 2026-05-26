CREATE TABLE [dbo].[BOOKS] (
    [id]        INT             IDENTITY (1, 1) NOT NULL,
    [title]     VARCHAR (200)   NOT NULL,
    [author]    INT             NOT NULL,
    [genre]     INT             NOT NULL,
    [available] BIT             DEFAULT ((1)) NULL,
    [isbn]      VARCHAR (20)    NULL,
    [price]     DECIMAL (10, 2) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    FOREIGN KEY ([author]) REFERENCES [dbo].[AUTHORS] ([id]),
    FOREIGN KEY ([genre]) REFERENCES [dbo].[GENRES] ([id])
);


GO

