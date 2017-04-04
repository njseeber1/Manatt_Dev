SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_SearchEngine](
	[SearchEngineID] [int] IDENTITY(1,1) NOT NULL,
	[SearchEngineDisplayName] [nvarchar](200) NOT NULL,
	[SearchEngineName] [nvarchar](200) NOT NULL,
	[SearchEngineDomainRule] [nvarchar](450) NOT NULL,
	[SearchEngineKeywordParameter] [nvarchar](200) NULL,
	[SearchEngineGUID] [uniqueidentifier] NOT NULL,
	[SearchEngineLastModified] [datetime2](7) NOT NULL,
	[SearchEngineCrawler] [nvarchar](200) NULL,
 CONSTRAINT [PK_CMS_SearchEngine] PRIMARY KEY CLUSTERED 
(
	[SearchEngineID] ASC
)
)

GO
