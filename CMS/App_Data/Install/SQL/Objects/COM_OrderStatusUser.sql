SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_OrderStatusUser](
	[OrderStatusUserID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[FromStatusID] [int] NULL,
	[ToStatusID] [int] NOT NULL,
	[ChangedByUserID] [int] NULL,
	[Date] [datetime2](7) NOT NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_COM_OrderStatusUser] PRIMARY KEY NONCLUSTERED 
(
	[OrderStatusUserID] ASC
)
)

GO
CREATE CLUSTERED INDEX [IX_COM_OrderStatusUser_OrderID_Date] ON [dbo].[COM_OrderStatusUser]
(
	[OrderID] ASC,
	[Date] DESC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_OrderStatusUser_ChangedByUserID] ON [dbo].[COM_OrderStatusUser]
(
	[ChangedByUserID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_OrderStatusUser_FromStatusID] ON [dbo].[COM_OrderStatusUser]
(
	[FromStatusID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_OrderStatusUser_ToStatusID] ON [dbo].[COM_OrderStatusUser]
(
	[ToStatusID] ASC
)
GO
ALTER TABLE [dbo].[COM_OrderStatusUser]  WITH CHECK ADD  CONSTRAINT [FK_COM_OrderStatusUser_ChangedByUserID_CMS_User] FOREIGN KEY([ChangedByUserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[COM_OrderStatusUser] CHECK CONSTRAINT [FK_COM_OrderStatusUser_ChangedByUserID_CMS_User]
GO
ALTER TABLE [dbo].[COM_OrderStatusUser]  WITH CHECK ADD  CONSTRAINT [FK_COM_OrderStatusUser_FromStatusID_COM_Status] FOREIGN KEY([FromStatusID])
REFERENCES [dbo].[COM_OrderStatus] ([StatusID])
GO
ALTER TABLE [dbo].[COM_OrderStatusUser] CHECK CONSTRAINT [FK_COM_OrderStatusUser_FromStatusID_COM_Status]
GO
ALTER TABLE [dbo].[COM_OrderStatusUser]  WITH CHECK ADD  CONSTRAINT [FK_COM_OrderStatusUser_OrderID_COM_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[COM_Order] ([OrderID])
GO
ALTER TABLE [dbo].[COM_OrderStatusUser] CHECK CONSTRAINT [FK_COM_OrderStatusUser_OrderID_COM_Order]
GO
ALTER TABLE [dbo].[COM_OrderStatusUser]  WITH CHECK ADD  CONSTRAINT [FK_COM_OrderStatusUser_ToStatusID_COM_Status] FOREIGN KEY([ToStatusID])
REFERENCES [dbo].[COM_OrderStatus] ([StatusID])
GO
ALTER TABLE [dbo].[COM_OrderStatusUser] CHECK CONSTRAINT [FK_COM_OrderStatusUser_ToStatusID_COM_Status]
GO
