SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporting_SavedReport](
	[SavedReportID] [int] IDENTITY(1,1) NOT NULL,
	[SavedReportReportID] [int] NOT NULL,
	[SavedReportGUID] [uniqueidentifier] NOT NULL,
	[SavedReportTitle] [nvarchar](200) NULL,
	[SavedReportDate] [datetime2](7) NOT NULL,
	[SavedReportHTML] [nvarchar](max) NOT NULL,
	[SavedReportParameters] [nvarchar](max) NOT NULL,
	[SavedReportCreatedByUserID] [int] NULL,
	[SavedReportLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Reporting_SavedReport] PRIMARY KEY NONCLUSTERED 
(
	[SavedReportID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_Reporting_SavedReport_SavedReportReportID_SavedReportDate] ON [dbo].[Reporting_SavedReport]
(
	[SavedReportReportID] ASC,
	[SavedReportDate] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_Reporting_SavedReport_SavedReportCreatedByUserID] ON [dbo].[Reporting_SavedReport]
(
	[SavedReportCreatedByUserID] ASC
)
GO
ALTER TABLE [dbo].[Reporting_SavedReport]  WITH CHECK ADD  CONSTRAINT [FK_Reporting_SavedReport_SavedReportCreatedByUserID_CMS_User] FOREIGN KEY([SavedReportCreatedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[Reporting_SavedReport] CHECK CONSTRAINT [FK_Reporting_SavedReport_SavedReportCreatedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[Reporting_SavedReport]  WITH CHECK ADD  CONSTRAINT [FK_Reporting_SavedReport_SavedReportReportID_Reporting_Report] FOREIGN KEY([SavedReportReportID])
REFERENCES [dbo].[Reporting_Report] ([ReportID])
GO
ALTER TABLE [dbo].[Reporting_SavedReport] CHECK CONSTRAINT [FK_Reporting_SavedReport_SavedReportReportID_Reporting_Report]
GO
