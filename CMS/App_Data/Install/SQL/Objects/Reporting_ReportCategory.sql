SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporting_ReportCategory](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryDisplayName] [nvarchar](200) NOT NULL,
	[CategoryCodeName] [nvarchar](200) NOT NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL,
	[CategoryLastModified] [datetime2](7) NOT NULL,
	[CategoryParentID] [int] NULL,
	[CategoryImagePath] [nvarchar](450) NULL,
	[CategoryPath] [nvarchar](450) NOT NULL,
	[CategoryOrder] [int] NULL,
	[CategoryLevel] [int] NULL,
	[CategoryChildCount] [int] NULL,
	[CategoryReportChildCount] [int] NULL,
 CONSTRAINT [PK_Reporting_ReportCategory] PRIMARY KEY NONCLUSTERED 
(
	[CategoryID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE CLUSTERED INDEX [IX_Reporting_ReportCategory_CategoryPath] ON [dbo].[Reporting_ReportCategory]
(
	[CategoryPath] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Reporting_ReportCategory_CategoryParentID] ON [dbo].[Reporting_ReportCategory]
(
	[CategoryParentID] ASC
)
GO
ALTER TABLE [dbo].[Reporting_ReportCategory] ADD  CONSTRAINT [DEFAULT_Reporting_ReportCategory_CategoryDisplayName]  DEFAULT ('') FOR [CategoryDisplayName]
GO
ALTER TABLE [dbo].[Reporting_ReportCategory] ADD  CONSTRAINT [DEFAULT_Reporting_ReportCategory_CategoryCodeName]  DEFAULT ('') FOR [CategoryCodeName]
GO
ALTER TABLE [dbo].[Reporting_ReportCategory] ADD  CONSTRAINT [DEFAULT_Reporting_ReportCategory_CategoryPath]  DEFAULT ('') FOR [CategoryPath]
GO
ALTER TABLE [dbo].[Reporting_ReportCategory]  WITH NOCHECK ADD  CONSTRAINT [FK_Reporting_ReportCategory_CategoryID_Reporting_ReportCategory_ParentCategoryID] FOREIGN KEY([CategoryParentID])
REFERENCES [dbo].[Reporting_ReportCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[Reporting_ReportCategory] CHECK CONSTRAINT [FK_Reporting_ReportCategory_CategoryID_Reporting_ReportCategory_ParentCategoryID]
GO
