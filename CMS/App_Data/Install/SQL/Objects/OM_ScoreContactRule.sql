SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_ScoreContactRule](
	[ScoreID] [int] NOT NULL,
	[ContactID] [int] NOT NULL,
	[RuleID] [int] NOT NULL,
	[Value] [int] NOT NULL,
	[Expiration] [datetime2](7) NULL,
	[ScoreContactRuleID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_OM_ScoreContactRule] PRIMARY KEY CLUSTERED 
(
	[ScoreContactRuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON),
 CONSTRAINT [UQ_OM_ScoreContactRule] UNIQUE NONCLUSTERED 
(
	[ScoreID] ASC,
	[ContactID] ASC,
	[RuleID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_ScoreContactRule_ContactID] ON [dbo].[OM_ScoreContactRule]
(
	[ContactID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_ScoreContactRule_RuleID] ON [dbo].[OM_ScoreContactRule]
(
	[RuleID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_ScoreContactRule_ScoreID] ON [dbo].[OM_ScoreContactRule]
(
	[ScoreID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_ScoreContactRule_ScoreID_Expiration_ContactID] ON [dbo].[OM_ScoreContactRule]
(
	[ScoreID] ASC,
	[Expiration] ASC
)
INCLUDE ( 	[ContactID])
GO
ALTER TABLE [dbo].[OM_ScoreContactRule]  WITH CHECK ADD  CONSTRAINT [FK_OM_ScoreContactRule_OM_Contact] FOREIGN KEY([ContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_ScoreContactRule] CHECK CONSTRAINT [FK_OM_ScoreContactRule_OM_Contact]
GO
ALTER TABLE [dbo].[OM_ScoreContactRule]  WITH CHECK ADD  CONSTRAINT [FK_OM_ScoreContactRule_OM_Rule] FOREIGN KEY([RuleID])
REFERENCES [dbo].[OM_Rule] ([RuleID])
GO
ALTER TABLE [dbo].[OM_ScoreContactRule] CHECK CONSTRAINT [FK_OM_ScoreContactRule_OM_Rule]
GO
ALTER TABLE [dbo].[OM_ScoreContactRule]  WITH CHECK ADD  CONSTRAINT [FK_OM_ScoreContactRule_OM_Score] FOREIGN KEY([ScoreID])
REFERENCES [dbo].[OM_Score] ([ScoreID])
GO
ALTER TABLE [dbo].[OM_ScoreContactRule] CHECK CONSTRAINT [FK_OM_ScoreContactRule_OM_Score]
GO
