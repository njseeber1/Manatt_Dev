SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_Search](
	[SearchID] [int] IDENTITY(1,1) NOT NULL,
	[SearchActivityID] [int] NOT NULL,
	[SearchProvider] [nvarchar](250) NULL,
	[SearchKeywords] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_OM_Search] PRIMARY KEY CLUSTERED 
(
	[SearchID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_Search_SearchActivityID] ON [dbo].[OM_Search]
(
	[SearchActivityID] ASC
)
GO
ALTER TABLE [dbo].[OM_Search]  WITH CHECK ADD  CONSTRAINT [FK_OM_Search_OM_Activity] FOREIGN KEY([SearchActivityID])
REFERENCES [dbo].[OM_Activity] ([ActivityID])
GO
ALTER TABLE [dbo].[OM_Search] CHECK CONSTRAINT [FK_OM_Search_OM_Activity]
GO
