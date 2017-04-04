SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporting_Report](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
	[ReportName] [nvarchar](200) NOT NULL,
	[ReportDisplayName] [nvarchar](440) NOT NULL,
	[ReportLayout] [nvarchar](max) NULL,
	[ReportParameters] [nvarchar](max) NULL,
	[ReportCategoryID] [int] NOT NULL,
	[ReportAccess] [int] NOT NULL,
	[ReportGUID] [uniqueidentifier] NOT NULL,
	[ReportLastModified] [datetime2](7) NOT NULL,
	[ReportEnableSubscription] [bit] NULL,
	[ReportConnectionString] [nvarchar](100) NULL,
 CONSTRAINT [PK_Reporting_Report] PRIMARY KEY NONCLUSTERED 
(
	[ReportID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Reporting_Report_ReportCategoryID_ReportDisplayName] ON [dbo].[Reporting_Report]
(
	[ReportDisplayName] ASC,
	[ReportCategoryID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Reporting_Report_ReportCategoryID] ON [dbo].[Reporting_Report]
(
	[ReportCategoryID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Reporting_Report_ReportGUID_ReportName] ON [dbo].[Reporting_Report]
(
	[ReportGUID] ASC,
	[ReportName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Reporting_Report_ReportName] ON [dbo].[Reporting_Report]
(
	[ReportName] ASC
)
GO
ALTER TABLE [dbo].[Reporting_Report] ADD  CONSTRAINT [DEFAULT_Reporting_Report_ReportName]  DEFAULT ('') FOR [ReportName]
GO
ALTER TABLE [dbo].[Reporting_Report] ADD  CONSTRAINT [DEFAULT_Reporting_Report_ReportDisplayName]  DEFAULT ('') FOR [ReportDisplayName]
GO
ALTER TABLE [dbo].[Reporting_Report] ADD  CONSTRAINT [DEFAULT_Reporting_Report_ReportAccess]  DEFAULT ((1)) FOR [ReportAccess]
GO
ALTER TABLE [dbo].[Reporting_Report] ADD  CONSTRAINT [DEFAULT_Reporting_Report_ReportGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ReportGUID]
GO
ALTER TABLE [dbo].[Reporting_Report] ADD  CONSTRAINT [DEFAULT_Reporting_Report_ReportEnableSubscription]  DEFAULT ((0)) FOR [ReportEnableSubscription]
GO
ALTER TABLE [dbo].[Reporting_Report]  WITH NOCHECK ADD  CONSTRAINT [FK_Reporting_Report_ReportCategory_Reporting_ReportCategory] FOREIGN KEY([ReportCategoryID])
REFERENCES [dbo].[Reporting_ReportCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[Reporting_Report] CHECK CONSTRAINT [FK_Reporting_Report_ReportCategory_Reporting_ReportCategory]
GO
ALTER TABLE [dbo].[Reporting_Report]  WITH NOCHECK ADD  CONSTRAINT [FK_Reporting_Report_ReportCategoryID_Reporting_ReportCategory] FOREIGN KEY([ReportCategoryID])
REFERENCES [dbo].[Reporting_ReportCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[Reporting_Report] CHECK CONSTRAINT [FK_Reporting_Report_ReportCategoryID_Reporting_ReportCategory]
GO
