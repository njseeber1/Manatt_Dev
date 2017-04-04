SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification_TemplateText](
	[TemplateTextID] [int] IDENTITY(1,1) NOT NULL,
	[TemplateID] [int] NOT NULL,
	[GatewayID] [int] NOT NULL,
	[TemplateSubject] [nvarchar](250) NOT NULL,
	[TemplateHTMLText] [nvarchar](max) NOT NULL,
	[TemplatePlainText] [nvarchar](max) NOT NULL,
	[TemplateTextGUID] [uniqueidentifier] NOT NULL,
	[TemplateTextLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Notification_TemplateText] PRIMARY KEY CLUSTERED 
(
	[TemplateTextID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Notification_TemplateText_GatewayID] ON [dbo].[Notification_TemplateText]
(
	[GatewayID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Notification_TemplateText_TemplateID] ON [dbo].[Notification_TemplateText]
(
	[TemplateID] ASC
)
GO
ALTER TABLE [dbo].[Notification_TemplateText]  WITH CHECK ADD  CONSTRAINT [FK_Notification_TemplateText_GatewayID_Notification_Gateway] FOREIGN KEY([GatewayID])
REFERENCES [dbo].[Notification_Gateway] ([GatewayID])
GO
ALTER TABLE [dbo].[Notification_TemplateText] CHECK CONSTRAINT [FK_Notification_TemplateText_GatewayID_Notification_Gateway]
GO
ALTER TABLE [dbo].[Notification_TemplateText]  WITH CHECK ADD  CONSTRAINT [FK_Notification_TemplateText_TemplateID_Notification_Template] FOREIGN KEY([TemplateID])
REFERENCES [dbo].[Notification_Template] ([TemplateID])
GO
ALTER TABLE [dbo].[Notification_TemplateText] CHECK CONSTRAINT [FK_Notification_TemplateText_TemplateID_Notification_Template]
GO
