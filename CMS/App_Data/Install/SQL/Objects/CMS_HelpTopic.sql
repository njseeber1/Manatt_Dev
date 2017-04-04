SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_HelpTopic](
	[HelpTopicID] [int] IDENTITY(1,1) NOT NULL,
	[HelpTopicUIElementID] [int] NOT NULL,
	[HelpTopicName] [nvarchar](200) NOT NULL,
	[HelpTopicLink] [nvarchar](1023) NOT NULL,
	[HelpTopicLastModified] [datetime2](7) NOT NULL,
	[HelpTopicGUID] [uniqueidentifier] NOT NULL,
	[HelpTopicOrder] [int] NULL,
 CONSTRAINT [PK_CMS_HelpTopic] PRIMARY KEY CLUSTERED 
(
	[HelpTopicID] ASC
)
)

GO
ALTER TABLE [dbo].[CMS_HelpTopic] ADD  CONSTRAINT [DEFAULT_CMS_HelpTopic_HelpTopicName]  DEFAULT (N'') FOR [HelpTopicName]
GO
ALTER TABLE [dbo].[CMS_HelpTopic] ADD  CONSTRAINT [DEFAULT_CMS_HelpTopic_HelpTopicLink]  DEFAULT (N'') FOR [HelpTopicLink]
GO
