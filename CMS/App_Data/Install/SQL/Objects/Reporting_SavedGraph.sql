SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporting_SavedGraph](
	[SavedGraphID] [int] IDENTITY(1,1) NOT NULL,
	[SavedGraphSavedReportID] [int] NOT NULL,
	[SavedGraphGUID] [uniqueidentifier] NOT NULL,
	[SavedGraphBinary] [varbinary](max) NOT NULL,
	[SavedGraphMimeType] [nvarchar](100) NOT NULL,
	[SavedGraphLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Reporting_SavedGraph] PRIMARY KEY CLUSTERED 
(
	[SavedGraphID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Reporting_SavedGraph_SavedGraphGUID] ON [dbo].[Reporting_SavedGraph]
(
	[SavedGraphGUID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Reporting_SavedGraph_SavedGraphSavedReportID] ON [dbo].[Reporting_SavedGraph]
(
	[SavedGraphSavedReportID] ASC
)
GO
ALTER TABLE [dbo].[Reporting_SavedGraph]  WITH CHECK ADD  CONSTRAINT [FK_Reporting_SavedGraph_SavedGraphSavedReportID_Reporting_SavedReport] FOREIGN KEY([SavedGraphSavedReportID])
REFERENCES [dbo].[Reporting_SavedReport] ([SavedReportID])
GO
ALTER TABLE [dbo].[Reporting_SavedGraph] CHECK CONSTRAINT [FK_Reporting_SavedGraph_SavedGraphSavedReportID_Reporting_SavedReport]
GO
