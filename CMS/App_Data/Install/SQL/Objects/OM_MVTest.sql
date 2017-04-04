SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_MVTest](
	[MVTestID] [int] IDENTITY(1,1) NOT NULL,
	[MVTestName] [nvarchar](50) NOT NULL,
	[MVTestDescription] [nvarchar](max) NULL,
	[MVTestPage] [nvarchar](450) NOT NULL,
	[MVTestSiteID] [int] NOT NULL,
	[MVTestCulture] [nvarchar](50) NULL,
	[MVTestOpenFrom] [datetime2](7) NULL,
	[MVTestOpenTo] [datetime2](7) NULL,
	[MVTestMaxConversions] [int] NULL,
	[MVTestConversions] [int] NULL,
	[MVTestTargetConversionType] [nvarchar](100) NULL,
	[MVTestGUID] [uniqueidentifier] NOT NULL,
	[MVTestLastModified] [datetime2](7) NOT NULL,
	[MVTestEnabled] [bit] NOT NULL,
	[MVTestDisplayName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_OM_MVTest] PRIMARY KEY CLUSTERED 
(
	[MVTestID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_MVTest_MVTestSiteID] ON [dbo].[OM_MVTest]
(
	[MVTestSiteID] ASC
)
GO
ALTER TABLE [dbo].[OM_MVTest] ADD  CONSTRAINT [DEFAULT_OM_MVTest_MVTestName]  DEFAULT ('') FOR [MVTestName]
GO
ALTER TABLE [dbo].[OM_MVTest] ADD  CONSTRAINT [DEFAULT_OM_MVTest_MVTestPage]  DEFAULT ('') FOR [MVTestPage]
GO
ALTER TABLE [dbo].[OM_MVTest] ADD  CONSTRAINT [DEFAULT_OM_MVTest_MVTestSiteID]  DEFAULT ((0)) FOR [MVTestSiteID]
GO
ALTER TABLE [dbo].[OM_MVTest] ADD  CONSTRAINT [DEFAULT_OM_MVTest_MVTestTargetConversionType]  DEFAULT ('TOTAL') FOR [MVTestTargetConversionType]
GO
ALTER TABLE [dbo].[OM_MVTest] ADD  CONSTRAINT [DEFAULT_OM_MVTest_MVTestEnabled]  DEFAULT ((0)) FOR [MVTestEnabled]
GO
ALTER TABLE [dbo].[OM_MVTest] ADD  CONSTRAINT [DEFAULT_OM_MVTest_MVTestDisplayName]  DEFAULT ('') FOR [MVTestDisplayName]
GO
ALTER TABLE [dbo].[OM_MVTest]  WITH CHECK ADD  CONSTRAINT [FK_OM_MVTest_MVTestSiteID_CMS_Site] FOREIGN KEY([MVTestSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[OM_MVTest] CHECK CONSTRAINT [FK_OM_MVTest_MVTestSiteID_CMS_Site]
GO
