SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_PageVisit](
	[PageVisitID] [int] IDENTITY(1,1) NOT NULL,
	[PageVisitDetail] [nvarchar](max) NULL,
	[PageVisitActivityID] [int] NOT NULL,
	[PageVisitABVariantName] [nvarchar](200) NULL,
	[PageVisitMVTCombinationName] [nvarchar](200) NULL,
 CONSTRAINT [PK_OM_PageVisit] PRIMARY KEY CLUSTERED 
(
	[PageVisitID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_OM_PageVisit_PageVisitActivityID] ON [dbo].[OM_PageVisit]
(
	[PageVisitActivityID] ASC
)
GO
ALTER TABLE [dbo].[OM_PageVisit]  WITH NOCHECK ADD  CONSTRAINT [FK_OM_PageVisit_OM_Activity] FOREIGN KEY([PageVisitActivityID])
REFERENCES [dbo].[OM_Activity] ([ActivityID])
GO
ALTER TABLE [dbo].[OM_PageVisit] CHECK CONSTRAINT [FK_OM_PageVisit_OM_Activity]
GO
