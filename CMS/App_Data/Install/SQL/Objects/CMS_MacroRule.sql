SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_MacroRule](
	[MacroRuleID] [int] IDENTITY(1,1) NOT NULL,
	[MacroRuleName] [nvarchar](200) NOT NULL,
	[MacroRuleText] [nvarchar](1000) NOT NULL,
	[MacroRuleParameters] [nvarchar](max) NULL,
	[MacroRuleResourceName] [nvarchar](100) NULL,
	[MacroRuleLastModified] [datetime2](7) NOT NULL,
	[MacroRuleGUID] [uniqueidentifier] NOT NULL,
	[MacroRuleCondition] [nvarchar](max) NOT NULL,
	[MacroRuleDisplayName] [nvarchar](500) NOT NULL,
	[MacroRuleIsCustom] [bit] NULL,
	[MacroRuleRequiresContext] [bit] NOT NULL,
	[MacroRuleDescription] [nvarchar](450) NULL,
	[MacroRuleRequiredData] [nvarchar](2500) NULL,
	[MacroRuleEnabled] [bit] NULL,
 CONSTRAINT [PK_CMS_MacroRule] PRIMARY KEY CLUSTERED 
(
	[MacroRuleID] ASC
)
)

GO
ALTER TABLE [dbo].[CMS_MacroRule] ADD  CONSTRAINT [DEFAULT_CMS_MacroRule_MacroRuleLastModified]  DEFAULT ('5/1/2012 8:46:33 AM') FOR [MacroRuleLastModified]
GO
ALTER TABLE [dbo].[CMS_MacroRule] ADD  CONSTRAINT [DEFAULT_CMS_MacroRule_MacroRuleGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [MacroRuleGUID]
GO
ALTER TABLE [dbo].[CMS_MacroRule] ADD  CONSTRAINT [DEFAULT_CMS_MacroRule_MacroRuleCondition]  DEFAULT (N'') FOR [MacroRuleCondition]
GO
ALTER TABLE [dbo].[CMS_MacroRule] ADD  CONSTRAINT [DEFAULT_CMS_MacroRule_MacroRuleDisplayName]  DEFAULT ('') FOR [MacroRuleDisplayName]
GO
ALTER TABLE [dbo].[CMS_MacroRule] ADD  CONSTRAINT [DEFAULT_CMS_MacroRule_MacroRuleIsCustom]  DEFAULT ((0)) FOR [MacroRuleIsCustom]
GO
ALTER TABLE [dbo].[CMS_MacroRule] ADD  CONSTRAINT [DEFAULT_CMS_MacroRule_MacroRuleRequiresContext]  DEFAULT ((0)) FOR [MacroRuleRequiresContext]
GO
ALTER TABLE [dbo].[CMS_MacroRule] ADD  CONSTRAINT [DEFAULT_CMS_MacroRule_MacroRuleEnabled]  DEFAULT ((1)) FOR [MacroRuleEnabled]
GO
