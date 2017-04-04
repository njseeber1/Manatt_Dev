SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reporting_ReportValue](
	[ValueID] [int] IDENTITY(1,1) NOT NULL,
	[ValueName] [nvarchar](100) NOT NULL,
	[ValueDisplayName] [nvarchar](450) NOT NULL,
	[ValueQuery] [nvarchar](max) NOT NULL,
	[ValueQueryIsStoredProcedure] [bit] NOT NULL,
	[ValueFormatString] [nvarchar](200) NULL,
	[ValueReportID] [int] NOT NULL,
	[ValueGUID] [uniqueidentifier] NOT NULL,
	[ValueLastModified] [datetime2](7) NOT NULL,
	[ValueSettings] [nvarchar](max) NULL,
	[ValueConnectionString] [nvarchar](100) NULL,
 CONSTRAINT [PK_Reporting_ReportValue] PRIMARY KEY CLUSTERED 
(
	[ValueID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Reporting_ReportValue_ValueName_ValueReportID] ON [dbo].[Reporting_ReportValue]
(
	[ValueName] ASC,
	[ValueReportID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Reporting_ReportValue_ValueReportID] ON [dbo].[Reporting_ReportValue]
(
	[ValueReportID] ASC
)
GO
ALTER TABLE [dbo].[Reporting_ReportValue]  WITH NOCHECK ADD  CONSTRAINT [FK_Reporting_ReportValue_ValueReportID_Reporting_Report] FOREIGN KEY([ValueReportID])
REFERENCES [dbo].[Reporting_Report] ([ReportID])
GO
ALTER TABLE [dbo].[Reporting_ReportValue] CHECK CONSTRAINT [FK_Reporting_ReportValue_ValueReportID_Reporting_Report]
GO
