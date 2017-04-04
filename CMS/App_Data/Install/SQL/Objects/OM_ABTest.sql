SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_ABTest](
	[ABTestID] [int] IDENTITY(1,1) NOT NULL,
	[ABTestName] [nvarchar](50) NOT NULL,
	[ABTestDescription] [nvarchar](max) NULL,
	[ABTestCulture] [nvarchar](50) NULL,
	[ABTestOriginalPage] [nvarchar](450) NOT NULL,
	[ABTestOpenFrom] [datetime2](7) NULL,
	[ABTestOpenTo] [datetime2](7) NULL,
	[ABTestSiteID] [int] NOT NULL,
	[ABTestGUID] [uniqueidentifier] NOT NULL,
	[ABTestLastModified] [datetime2](7) NOT NULL,
	[ABTestDisplayName] [nvarchar](100) NOT NULL,
	[ABTestIncludedTraffic] [int] NOT NULL,
	[ABTestVisitorTargeting] [nvarchar](max) NULL,
	[ABTestConversions] [nvarchar](max) NULL,
	[ABTestWinnerGUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_OM_ABTest] PRIMARY KEY CLUSTERED 
(
	[ABTestID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_ABTest_SiteID] ON [dbo].[OM_ABTest]
(
	[ABTestSiteID] ASC
)
GO
ALTER TABLE [dbo].[OM_ABTest] ADD  CONSTRAINT [DEFAULT_OM_ABTest_ABTestName]  DEFAULT (N'') FOR [ABTestName]
GO
ALTER TABLE [dbo].[OM_ABTest] ADD  CONSTRAINT [DEFAULT_OM_ABTest_ABTestOriginalPage]  DEFAULT (N'') FOR [ABTestOriginalPage]
GO
ALTER TABLE [dbo].[OM_ABTest] ADD  CONSTRAINT [DEFAULT_OM_ABTest_ABTestDisplayName]  DEFAULT ('') FOR [ABTestDisplayName]
GO
ALTER TABLE [dbo].[OM_ABTest] ADD  CONSTRAINT [DEFAULT_OM_ABTest_ABTestIncludedTraffic]  DEFAULT ((100)) FOR [ABTestIncludedTraffic]
GO
ALTER TABLE [dbo].[OM_ABTest]  WITH CHECK ADD  CONSTRAINT [FK_OM_ABTest_SiteID_CMS_Site] FOREIGN KEY([ABTestSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[OM_ABTest] CHECK CONSTRAINT [FK_OM_ABTest_SiteID_CMS_Site]
GO
