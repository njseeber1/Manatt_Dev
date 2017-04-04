SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporting_ReportTable](
	[TableID] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [nvarchar](100) NOT NULL,
	[TableDisplayName] [nvarchar](450) NOT NULL,
	[TableQuery] [nvarchar](max) NOT NULL,
	[TableQueryIsStoredProcedure] [bit] NOT NULL,
	[TableReportID] [int] NOT NULL,
	[TableSettings] [nvarchar](max) NULL,
	[TableGUID] [uniqueidentifier] NOT NULL,
	[TableLastModified] [datetime2](7) NOT NULL,
	[TableConnectionString] [nvarchar](100) NULL,
 CONSTRAINT [PK_Reporting_ReportTable] PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Reporting_ReportTable_TableReportID] ON [dbo].[Reporting_ReportTable]
(
	[TableReportID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Reporting_ReportTable_TableReportID_TableName] ON [dbo].[Reporting_ReportTable]
(
	[TableName] ASC,
	[TableReportID] ASC
)
GO
ALTER TABLE [dbo].[Reporting_ReportTable]  WITH NOCHECK ADD  CONSTRAINT [FK_Reporting_ReportTable_TableReportID_Reporting_Report] FOREIGN KEY([TableReportID])
REFERENCES [dbo].[Reporting_Report] ([ReportID])
GO
ALTER TABLE [dbo].[Reporting_ReportTable] CHECK CONSTRAINT [FK_Reporting_ReportTable_TableReportID_Reporting_Report]
GO
