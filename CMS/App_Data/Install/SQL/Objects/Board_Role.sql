SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Board_Role](
	[BoardID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_Board_Role] PRIMARY KEY CLUSTERED 
(
	[BoardID] ASC,
	[RoleID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_Board_Role_RoleID] ON [dbo].[Board_Role]
(
	[RoleID] ASC
)
GO
ALTER TABLE [dbo].[Board_Role]  WITH CHECK ADD  CONSTRAINT [FK_Board_Role_BoardID_Board_Board] FOREIGN KEY([BoardID])
REFERENCES [dbo].[Board_Board] ([BoardID])
GO
ALTER TABLE [dbo].[Board_Role] CHECK CONSTRAINT [FK_Board_Role_BoardID_Board_Board]
GO
ALTER TABLE [dbo].[Board_Role]  WITH CHECK ADD  CONSTRAINT [FK_Board_Role_RoleID_CMS_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[CMS_Role] ([RoleID])
GO
ALTER TABLE [dbo].[Board_Role] CHECK CONSTRAINT [FK_Board_Role_RoleID_CMS_Role]
GO
