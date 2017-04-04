SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporting_ReportGraph](
	[GraphID] [int] IDENTITY(1,1) NOT NULL,
	[GraphName] [nvarchar](100) NOT NULL,
	[GraphDisplayName] [nvarchar](450) NOT NULL,
	[GraphQuery] [nvarchar](max) NOT NULL,
	[GraphQueryIsStoredProcedure] [bit] NOT NULL,
	[GraphType] [nvarchar](50) NOT NULL,
	[GraphReportID] [int] NOT NULL,
	[GraphTitle] [nvarchar](200) NULL,
	[GraphXAxisTitle] [nvarchar](200) NULL,
	[GraphYAxisTitle] [nvarchar](200) NULL,
	[GraphWidth] [int] NULL,
	[GraphHeight] [int] NULL,
	[GraphLegendPosition] [int] NULL,
	[GraphSettings] [nvarchar](max) NULL,
	[GraphGUID] [uniqueidentifier] NOT NULL,
	[GraphLastModified] [datetime2](7) NOT NULL,
	[GraphIsHtml] [bit] NULL,
	[GraphConnectionString] [nvarchar](100) NULL,
 CONSTRAINT [PK_Reporting_ReportGraph] PRIMARY KEY CLUSTERED 
(
	[GraphID] ASC
)
)

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Reporting_ReportGraph_GraphGUID] ON [dbo].[Reporting_ReportGraph]
(
	[GraphGUID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Reporting_ReportGraph_GraphReportID_GraphName] ON [dbo].[Reporting_ReportGraph]
(
	[GraphReportID] ASC,
	[GraphName] ASC
)
GO
ALTER TABLE [dbo].[Reporting_ReportGraph]  WITH NOCHECK ADD  CONSTRAINT [FK_Reporting_ReportGraph_GraphReportID_Reporting_Report] FOREIGN KEY([GraphReportID])
REFERENCES [dbo].[Reporting_Report] ([ReportID])
GO
ALTER TABLE [dbo].[Reporting_ReportGraph] CHECK CONSTRAINT [FK_Reporting_ReportGraph_GraphReportID_Reporting_Report]
GO
