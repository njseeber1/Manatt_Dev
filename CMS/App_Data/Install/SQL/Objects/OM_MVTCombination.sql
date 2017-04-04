SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_MVTCombination](
	[MVTCombinationID] [int] IDENTITY(1,1) NOT NULL,
	[MVTCombinationName] [nvarchar](200) NOT NULL,
	[MVTCombinationCustomName] [nvarchar](200) NULL,
	[MVTCombinationPageTemplateID] [int] NOT NULL,
	[MVTCombinationEnabled] [bit] NOT NULL,
	[MVTCombinationGUID] [uniqueidentifier] NOT NULL,
	[MVTCombinationLastModified] [datetime2](7) NOT NULL,
	[MVTCombinationIsDefault] [bit] NULL,
	[MVTCombinationConversions] [int] NULL,
	[MVTCombinationDocumentID] [int] NULL,
 CONSTRAINT [PK_OM_MVTCombination] PRIMARY KEY CLUSTERED 
(
	[MVTCombinationID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_MVTCombination_MVTCombinationPageTemplateID] ON [dbo].[OM_MVTCombination]
(
	[MVTCombinationPageTemplateID] ASC
)
GO
ALTER TABLE [dbo].[OM_MVTCombination] ADD  CONSTRAINT [DEFAULT_OM_MVTCombination_MVTCombinationIsDefault]  DEFAULT ((0)) FOR [MVTCombinationIsDefault]
GO
