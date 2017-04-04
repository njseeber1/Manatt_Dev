SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_OrderItemSKUFile](
	[OrderItemSKUFileID] [int] IDENTITY(1,1) NOT NULL,
	[Token] [uniqueidentifier] NOT NULL,
	[OrderItemID] [int] NOT NULL,
	[FileID] [int] NOT NULL,
	[FileDownloads] [int] NOT NULL,
 CONSTRAINT [PK_COM_OrderItemSKUFile] PRIMARY KEY CLUSTERED 
(
	[OrderItemSKUFileID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_OrderItemSKUFile_FileID] ON [dbo].[COM_OrderItemSKUFile]
(
	[FileID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_OrderItemSKUFile_OrderItemID] ON [dbo].[COM_OrderItemSKUFile]
(
	[OrderItemID] ASC
)
GO
ALTER TABLE [dbo].[COM_OrderItemSKUFile]  WITH CHECK ADD  CONSTRAINT [FK_COM_OrderItemSKUFile_COM_OrderItem] FOREIGN KEY([OrderItemID])
REFERENCES [dbo].[COM_OrderItem] ([OrderItemID])
GO
ALTER TABLE [dbo].[COM_OrderItemSKUFile] CHECK CONSTRAINT [FK_COM_OrderItemSKUFile_COM_OrderItem]
GO
ALTER TABLE [dbo].[COM_OrderItemSKUFile]  WITH CHECK ADD  CONSTRAINT [FK_COM_OrderItemSKUFile_COM_SKUFile] FOREIGN KEY([FileID])
REFERENCES [dbo].[COM_SKUFile] ([FileID])
GO
ALTER TABLE [dbo].[COM_OrderItemSKUFile] CHECK CONSTRAINT [FK_COM_OrderItemSKUFile_COM_SKUFile]
GO
