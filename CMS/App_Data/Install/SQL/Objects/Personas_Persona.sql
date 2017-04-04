SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas_Persona](
	[PersonaID] [int] IDENTITY(1,1) NOT NULL,
	[PersonaDisplayName] [nvarchar](200) NOT NULL,
	[PersonaName] [nvarchar](200) NOT NULL,
	[PersonaDescription] [nvarchar](max) NULL,
	[PersonaEnabled] [bit] NOT NULL,
	[PersonaGUID] [uniqueidentifier] NOT NULL,
	[PersonaSiteID] [int] NOT NULL,
	[PersonaScoreID] [int] NOT NULL,
	[PersonaPictureMetafileGUID] [uniqueidentifier] NULL,
	[PersonaPointsThreshold] [int] NOT NULL,
 CONSTRAINT [PK_Personas_Persona] PRIMARY KEY CLUSTERED 
(
	[PersonaID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Personas_Persona_PersonaScoreID] ON [dbo].[Personas_Persona]
(
	[PersonaScoreID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Personas_Persona_PersonaSiteID] ON [dbo].[Personas_Persona]
(
	[PersonaSiteID] ASC
)
GO
ALTER TABLE [dbo].[Personas_Persona] ADD  CONSTRAINT [DEFAULT_Personas_Persona_PersonaDisplayName]  DEFAULT (N'') FOR [PersonaDisplayName]
GO
ALTER TABLE [dbo].[Personas_Persona] ADD  CONSTRAINT [DEFAULT_Personas_Persona_PersonaName]  DEFAULT (N'[_][_]AUTO[_][_]') FOR [PersonaName]
GO
ALTER TABLE [dbo].[Personas_Persona] ADD  CONSTRAINT [DEFAULT_Personas_Persona_PersonaEnabled]  DEFAULT ((1)) FOR [PersonaEnabled]
GO
ALTER TABLE [dbo].[Personas_Persona] ADD  CONSTRAINT [DEFAULT_Personas_Persona_PersonaScoreID]  DEFAULT ((0)) FOR [PersonaScoreID]
GO
ALTER TABLE [dbo].[Personas_Persona] ADD  CONSTRAINT [DEFAULT_Personas_Persona_PersonaPointsThreshold]  DEFAULT ((100)) FOR [PersonaPointsThreshold]
GO
ALTER TABLE [dbo].[Personas_Persona]  WITH CHECK ADD  CONSTRAINT [FK_Personas_Persona_CMS_Site] FOREIGN KEY([PersonaSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Personas_Persona] CHECK CONSTRAINT [FK_Personas_Persona_CMS_Site]
GO
