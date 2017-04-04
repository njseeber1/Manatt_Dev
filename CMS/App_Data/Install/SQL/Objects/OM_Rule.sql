SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_Rule](
	[RuleID] [int] IDENTITY(1,1) NOT NULL,
	[RuleScoreID] [int] NOT NULL,
	[RuleDisplayName] [nvarchar](200) NOT NULL,
	[RuleName] [nvarchar](200) NOT NULL,
	[RuleValue] [int] NOT NULL,
	[RuleIsRecurring] [bit] NULL,
	[RuleMaxPoints] [int] NULL,
	[RuleValidUntil] [datetime2](7) NULL,
	[RuleValidity] [nvarchar](50) NULL,
	[RuleValidFor] [int] NULL,
	[RuleType] [int] NOT NULL,
	[RuleParameter] [nvarchar](250) NULL,
	[RuleCondition] [nvarchar](max) NOT NULL,
	[RuleLastModified] [datetime2](7) NOT NULL,
	[RuleGUID] [uniqueidentifier] NOT NULL,
	[RuleSiteID] [int] NOT NULL,
	[RuleBelongsToPersona] [bit] NOT NULL,
 CONSTRAINT [PK_OM_Rule] PRIMARY KEY CLUSTERED 
(
	[RuleID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_Rule_RuleScoreID] ON [dbo].[OM_Rule]
(
	[RuleScoreID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_Rule_RuleSiteID] ON [dbo].[OM_Rule]
(
	[RuleSiteID] ASC
)
GO
ALTER TABLE [dbo].[OM_Rule] ADD  CONSTRAINT [DEFAULT_OM_Rule_RuleDisplayName]  DEFAULT (N'') FOR [RuleDisplayName]
GO
ALTER TABLE [dbo].[OM_Rule] ADD  CONSTRAINT [DEFAULT_OM_Rule_RuleName]  DEFAULT (N'[_][_]AUTO[_][_]') FOR [RuleName]
GO
ALTER TABLE [dbo].[OM_Rule] ADD  CONSTRAINT [DEFAULT_OM_Rule_RuleValue]  DEFAULT ((0)) FOR [RuleValue]
GO
ALTER TABLE [dbo].[OM_Rule] ADD  CONSTRAINT [DEFAULT_OM_Rule_RuleType]  DEFAULT ((1)) FOR [RuleType]
GO
ALTER TABLE [dbo].[OM_Rule] ADD  CONSTRAINT [DEFAULT_OM_Rule_RuleBelongsToPersona]  DEFAULT ((0)) FOR [RuleBelongsToPersona]
GO
ALTER TABLE [dbo].[OM_Rule]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_Rule_CMS_Site] FOREIGN KEY([RuleSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[OM_Rule] CHECK CONSTRAINT [FK_OM_Rule_CMS_Site]
GO
ALTER TABLE [dbo].[OM_Rule]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_Rule_OM_Score] FOREIGN KEY([RuleScoreID])
REFERENCES [dbo].[OM_Score] ([ScoreID])
GO
ALTER TABLE [dbo].[OM_Rule] CHECK CONSTRAINT [FK_OM_Rule_OM_Score]
GO
