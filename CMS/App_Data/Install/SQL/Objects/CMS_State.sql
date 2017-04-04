SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_State](
	[StateID] [int] IDENTITY(1,1) NOT NULL,
	[StateDisplayName] [nvarchar](200) NOT NULL,
	[StateName] [nvarchar](200) NOT NULL,
	[StateCode] [nvarchar](100) NULL,
	[CountryID] [int] NOT NULL,
	[StateGUID] [uniqueidentifier] NOT NULL,
	[StateLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CMS_State] PRIMARY KEY NONCLUSTERED 
(
	[StateID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_State_CountryID_StateDisplayName] ON [dbo].[CMS_State]
(
	[StateDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_State_CountryID] ON [dbo].[CMS_State]
(
	[CountryID] ASC
)
GO
ALTER TABLE [dbo].[CMS_State] ADD  CONSTRAINT [DEFAULT_CMS_State_StateDisplayName]  DEFAULT ('') FOR [StateDisplayName]
GO
ALTER TABLE [dbo].[CMS_State] ADD  CONSTRAINT [DEFAULT_CMS_State_StateName]  DEFAULT ('') FOR [StateName]
GO
ALTER TABLE [dbo].[CMS_State] ADD  CONSTRAINT [DEFAULT_CMS_State_StateGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [StateGUID]
GO
ALTER TABLE [dbo].[CMS_State]  WITH NOCHECK ADD  CONSTRAINT [FK_CMS_State_CountryID_CMS_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CMS_Country] ([CountryID])
GO
ALTER TABLE [dbo].[CMS_State] CHECK CONSTRAINT [FK_CMS_State_CountryID_CMS_Country]
GO
