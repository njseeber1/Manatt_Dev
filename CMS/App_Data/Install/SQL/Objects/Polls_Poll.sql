SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Polls_Poll](
	[PollID] [int] IDENTITY(1,1) NOT NULL,
	[PollCodeName] [nvarchar](200) NOT NULL,
	[PollDisplayName] [nvarchar](200) NOT NULL,
	[PollTitle] [nvarchar](100) NULL,
	[PollOpenFrom] [datetime2](7) NULL,
	[PollOpenTo] [datetime2](7) NULL,
	[PollAllowMultipleAnswers] [bit] NOT NULL,
	[PollQuestion] [nvarchar](450) NOT NULL,
	[PollAccess] [int] NOT NULL,
	[PollResponseMessage] [nvarchar](450) NULL,
	[PollGUID] [uniqueidentifier] NOT NULL,
	[PollLastModified] [datetime2](7) NOT NULL,
	[PollGroupID] [int] NULL,
	[PollSiteID] [int] NULL,
	[PollLogActivity] [bit] NULL,
 CONSTRAINT [PK_Polls_Poll] PRIMARY KEY NONCLUSTERED 
(
	[PollID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Polls_Poll_PollSiteID_PollDisplayName] ON [dbo].[Polls_Poll]
(
	[PollSiteID] ASC,
	[PollDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Polls_Poll_PollGroupID] ON [dbo].[Polls_Poll]
(
	[PollGroupID] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_Polls_Poll_PollSiteID_PollCodeName] ON [dbo].[Polls_Poll]
(
	[PollSiteID] ASC,
	[PollCodeName] ASC
)
GO
ALTER TABLE [dbo].[Polls_Poll] ADD  CONSTRAINT [DEFAULT_Polls_Poll_PollCodeName]  DEFAULT (N'') FOR [PollCodeName]
GO
ALTER TABLE [dbo].[Polls_Poll] ADD  CONSTRAINT [DEFAULT_Polls_Poll_PollDisplayName]  DEFAULT (N'') FOR [PollDisplayName]
GO
ALTER TABLE [dbo].[Polls_Poll] ADD  CONSTRAINT [DEFAULT_Polls_Poll_PollTitle]  DEFAULT (N'') FOR [PollTitle]
GO
ALTER TABLE [dbo].[Polls_Poll] ADD  CONSTRAINT [DEFAULT_Polls_Poll_PollQuestion]  DEFAULT (N'') FOR [PollQuestion]
GO
ALTER TABLE [dbo].[Polls_Poll] ADD  CONSTRAINT [DEFAULT_Polls_Poll_PollResponseMessage]  DEFAULT (N'') FOR [PollResponseMessage]
GO
ALTER TABLE [dbo].[Polls_Poll]  WITH CHECK ADD  CONSTRAINT [FK_Polls_Poll_PollGroupID_Community_Group] FOREIGN KEY([PollGroupID])
REFERENCES [dbo].[Community_Group] ([GroupID])
GO
ALTER TABLE [dbo].[Polls_Poll] CHECK CONSTRAINT [FK_Polls_Poll_PollGroupID_Community_Group]
GO
ALTER TABLE [dbo].[Polls_Poll]  WITH CHECK ADD  CONSTRAINT [FK_Polls_Poll_PollSiteID_CMS_Site] FOREIGN KEY([PollSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[Polls_Poll] CHECK CONSTRAINT [FK_Polls_Poll_PollSiteID_CMS_Site]
GO
