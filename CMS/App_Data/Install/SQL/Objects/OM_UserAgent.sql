SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_UserAgent](
	[UserAgentID] [int] IDENTITY(1,1) NOT NULL,
	[UserAgentString] [nvarchar](max) NOT NULL,
	[UserAgentActiveContactID] [int] NOT NULL,
	[UserAgentOriginalContactID] [int] NOT NULL,
	[UserAgentCreated] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_OM_UserAgent] PRIMARY KEY CLUSTERED 
(
	[UserAgentID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_UserAgent_UserAgentActiveContactID] ON [dbo].[OM_UserAgent]
(
	[UserAgentActiveContactID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_UserAgent_UserAgentOriginalContactID] ON [dbo].[OM_UserAgent]
(
	[UserAgentOriginalContactID] ASC
)
GO
ALTER TABLE [dbo].[OM_UserAgent] ADD  CONSTRAINT [DEFAULT_OM_UserAgent_UserAgentString]  DEFAULT ('') FOR [UserAgentString]
GO
ALTER TABLE [dbo].[OM_UserAgent]  WITH CHECK ADD  CONSTRAINT [FK_OM_UserAgent_OM_Contact_Active] FOREIGN KEY([UserAgentActiveContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_UserAgent] CHECK CONSTRAINT [FK_OM_UserAgent_OM_Contact_Active]
GO
ALTER TABLE [dbo].[OM_UserAgent]  WITH CHECK ADD  CONSTRAINT [FK_OM_UserAgent_OM_Contact_Original] FOREIGN KEY([UserAgentOriginalContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_UserAgent] CHECK CONSTRAINT [FK_OM_UserAgent_OM_Contact_Original]
GO
