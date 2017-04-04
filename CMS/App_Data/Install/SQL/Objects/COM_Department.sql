SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_Department](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](200) NOT NULL,
	[DepartmentDisplayName] [nvarchar](200) NOT NULL,
	[DepartmentDefaultTaxClassID] [int] NULL,
	[DepartmentGUID] [uniqueidentifier] NOT NULL,
	[DepartmentLastModified] [datetime2](7) NOT NULL,
	[DepartmentSiteID] [int] NULL,
 CONSTRAINT [PK_COM_Department] PRIMARY KEY NONCLUSTERED 
(
	[DepartmentID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_Department_DepartmentDisplayName] ON [dbo].[COM_Department]
(
	[DepartmentDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Department_DepartmentDefaultTaxClassID] ON [dbo].[COM_Department]
(
	[DepartmentDefaultTaxClassID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_Department_DepartmentSiteID] ON [dbo].[COM_Department]
(
	[DepartmentSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_Department] ADD  CONSTRAINT [DEFAULT_COM_Department_DepartmentName]  DEFAULT (N'') FOR [DepartmentName]
GO
ALTER TABLE [dbo].[COM_Department] ADD  CONSTRAINT [DEFAULT_COM_Department_DepartmentDisplayName]  DEFAULT (N'') FOR [DepartmentDisplayName]
GO
ALTER TABLE [dbo].[COM_Department] ADD  CONSTRAINT [DEFAULT_COM_Department_DepartmentGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [DepartmentGUID]
GO
ALTER TABLE [dbo].[COM_Department]  WITH CHECK ADD  CONSTRAINT [FK_COM_Department_DepartmentDefaultTaxClassID_COM_TaxClass] FOREIGN KEY([DepartmentDefaultTaxClassID])
REFERENCES [dbo].[COM_TaxClass] ([TaxClassID])
GO
ALTER TABLE [dbo].[COM_Department] CHECK CONSTRAINT [FK_COM_Department_DepartmentDefaultTaxClassID_COM_TaxClass]
GO
ALTER TABLE [dbo].[COM_Department]  WITH CHECK ADD  CONSTRAINT [FK_COM_Department_DepartmentSiteID_CMS_Site] FOREIGN KEY([DepartmentSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_Department] CHECK CONSTRAINT [FK_COM_Department_DepartmentSiteID_CMS_Site]
GO
