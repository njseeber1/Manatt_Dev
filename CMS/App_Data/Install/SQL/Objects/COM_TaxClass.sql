SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_TaxClass](
	[TaxClassID] [int] IDENTITY(1,1) NOT NULL,
	[TaxClassName] [nvarchar](200) NOT NULL,
	[TaxClassDisplayName] [nvarchar](200) NOT NULL,
	[TaxClassZeroIfIDSupplied] [bit] NULL,
	[TaxClassGUID] [uniqueidentifier] NOT NULL,
	[TaxClassLastModified] [datetime2](7) NOT NULL,
	[TaxClassSiteID] [int] NULL,
 CONSTRAINT [PK_COM_TaxClass] PRIMARY KEY NONCLUSTERED 
(
	[TaxClassID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_TaxClass_TaxClassDisplayName] ON [dbo].[COM_TaxClass]
(
	[TaxClassDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_TaxClass_TaxClassSiteID] ON [dbo].[COM_TaxClass]
(
	[TaxClassSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_TaxClass] ADD  CONSTRAINT [DEFAULT_COM_TaxClass_TaxClassName]  DEFAULT (N'') FOR [TaxClassName]
GO
ALTER TABLE [dbo].[COM_TaxClass] ADD  CONSTRAINT [DEFAULT_COM_TaxClass_TaxClassDisplayName]  DEFAULT (N'') FOR [TaxClassDisplayName]
GO
ALTER TABLE [dbo].[COM_TaxClass] ADD  CONSTRAINT [DEFAULT_COM_TaxClass_TaxClassZeroIfIDSupplied]  DEFAULT ((0)) FOR [TaxClassZeroIfIDSupplied]
GO
ALTER TABLE [dbo].[COM_TaxClass] ADD  CONSTRAINT [DEFAULT_COM_TaxClass_TaxClassGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [TaxClassGUID]
GO
ALTER TABLE [dbo].[COM_TaxClass] ADD  CONSTRAINT [DEFAULT_COM_TaxClass_TaxClassLastModified]  DEFAULT ('9/20/2012 1:31:27 PM') FOR [TaxClassLastModified]
GO
ALTER TABLE [dbo].[COM_TaxClass]  WITH CHECK ADD  CONSTRAINT [FK_COM_TaxClass_TaxClassSiteID_CMS_Site] FOREIGN KEY([TaxClassSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_TaxClass] CHECK CONSTRAINT [FK_COM_TaxClass_TaxClassSiteID_CMS_Site]
GO
