SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_SearchIndex](
	[IndexID] [int] IDENTITY(1,1) NOT NULL,
	[IndexName] [nvarchar](200) NOT NULL,
	[IndexDisplayName] [nvarchar](200) NOT NULL,
	[IndexAnalyzerType] [nvarchar](200) NULL,
	[IndexIsCommunityGroup] [bit] NOT NULL,
	[IndexSettings] [nvarchar](max) NULL,
	[IndexGUID] [uniqueidentifier] NOT NULL,
	[IndexLastModified] [datetime2](7) NOT NULL,
	[IndexLastRebuildTime] [datetime2](7) NULL,
	[IndexType] [nvarchar](200) NOT NULL,
	[IndexStopWordsFile] [nvarchar](200) NULL,
	[IndexCustomAnalyzerAssemblyName] [nvarchar](200) NULL,
	[IndexCustomAnalyzerClassName] [nvarchar](200) NULL,
	[IndexBatchSize] [int] NULL,
	[IndexStatus] [nvarchar](10) NULL,
	[IndexLastUpdate] [datetime2](7) NULL,
	[IndexCrawlerUserName] [nvarchar](200) NULL,
	[IndexCrawlerFormsUserName] [nvarchar](200) NULL,
	[IndexCrawlerUserPassword] [nvarchar](200) NULL,
	[IndexCrawlerDomain] [nvarchar](200) NULL,
 CONSTRAINT [PK_CMS_SearchIndex] PRIMARY KEY NONCLUSTERED 
(
	[IndexID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_SearchIndex_IndexDisplayName] ON [dbo].[CMS_SearchIndex]
(
	[IndexDisplayName] ASC
)
GO
ALTER TABLE [dbo].[CMS_SearchIndex] ADD  CONSTRAINT [DEFAULT_CMS_SearchIndex_IndexIsCommunityGroup]  DEFAULT ((0)) FOR [IndexIsCommunityGroup]
GO
ALTER TABLE [dbo].[CMS_SearchIndex] ADD  CONSTRAINT [DEFAULT_CMS_SearchIndex_IndexType]  DEFAULT ('') FOR [IndexType]
GO
