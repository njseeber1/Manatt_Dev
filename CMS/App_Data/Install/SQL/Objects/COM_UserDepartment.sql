SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_UserDepartment](
	[UserID] [int] NOT NULL,
	[DepartmentID] [int] NOT NULL,
 CONSTRAINT [PK_COM_UserDepartment] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[DepartmentID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_UserDepartment_DepartmentID] ON [dbo].[COM_UserDepartment]
(
	[DepartmentID] ASC
)
GO
ALTER TABLE [dbo].[COM_UserDepartment]  WITH CHECK ADD  CONSTRAINT [FK_COM_UserDepartment_DepartmentID_COM_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[COM_Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[COM_UserDepartment] CHECK CONSTRAINT [FK_COM_UserDepartment_DepartmentID_COM_Department]
GO
ALTER TABLE [dbo].[COM_UserDepartment]  WITH CHECK ADD  CONSTRAINT [FK_COM_UserDepartment_UserID_CMS_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[COM_UserDepartment] CHECK CONSTRAINT [FK_COM_UserDepartment_UserID_CMS_User]
GO
