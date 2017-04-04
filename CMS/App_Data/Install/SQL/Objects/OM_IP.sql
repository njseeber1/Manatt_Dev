SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_IP](
	[IPID] [int] IDENTITY(1,1) NOT NULL,
	[IPActiveContactID] [int] NOT NULL,
	[IPOriginalContactID] [int] NOT NULL,
	[IPAddress] [nvarchar](100) NULL,
	[IPCreated] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_OM_IP] PRIMARY KEY CLUSTERED 
(
	[IPID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_IP_IPActiveContactID] ON [dbo].[OM_IP]
(
	[IPActiveContactID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_OM_IP_IPOriginalContactID] ON [dbo].[OM_IP]
(
	[IPOriginalContactID] ASC
)
GO
ALTER TABLE [dbo].[OM_IP]  WITH CHECK ADD  CONSTRAINT [FK_OM_IP_OM_Contact_Active] FOREIGN KEY([IPActiveContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_IP] CHECK CONSTRAINT [FK_OM_IP_OM_Contact_Active]
GO
ALTER TABLE [dbo].[OM_IP]  WITH CHECK ADD  CONSTRAINT [FK_OM_IP_OM_Contact_Original] FOREIGN KEY([IPOriginalContactID])
REFERENCES [dbo].[OM_Contact] ([ContactID])
GO
ALTER TABLE [dbo].[OM_IP] CHECK CONSTRAINT [FK_OM_IP_OM_Contact_Original]
GO
