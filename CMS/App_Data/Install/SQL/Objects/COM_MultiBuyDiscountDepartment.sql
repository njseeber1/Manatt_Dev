SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_MultiBuyDiscountDepartment](
	[MultiBuyDiscountID] [int] NOT NULL,
	[DepartmentID] [int] NOT NULL,
 CONSTRAINT [PK_COM_MultiBuyDiscountDepartment] PRIMARY KEY CLUSTERED 
(
	[MultiBuyDiscountID] ASC,
	[DepartmentID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_MultiBuyDiscountDepartment_DepartmentID] ON [dbo].[COM_MultiBuyDiscountDepartment]
(
	[DepartmentID] ASC
)
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscountDepartment] ADD  CONSTRAINT [DEFAULT_COM_MultiBuyDiscountDepartment_DepartmentID]  DEFAULT ((0)) FOR [DepartmentID]
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscountDepartment]  WITH CHECK ADD  CONSTRAINT [FK_COM_MultiBuyDiscountDepartment_DepartmentID_COM_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[COM_Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscountDepartment] CHECK CONSTRAINT [FK_COM_MultiBuyDiscountDepartment_DepartmentID_COM_Department]
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscountDepartment]  WITH CHECK ADD  CONSTRAINT [FK_COM_MultiBuyDiscountDepartment_MultiBuyDiscountID_COM_MultiBuyDiscount] FOREIGN KEY([MultiBuyDiscountID])
REFERENCES [dbo].[COM_MultiBuyDiscount] ([MultiBuyDiscountID])
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscountDepartment] CHECK CONSTRAINT [FK_COM_MultiBuyDiscountDepartment_MultiBuyDiscountID_COM_MultiBuyDiscount]
GO
