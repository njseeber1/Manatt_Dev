SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_TaxClassState](
	[TaxClassStateID] [int] IDENTITY(1,1) NOT NULL,
	[TaxClassID] [int] NOT NULL,
	[StateID] [int] NOT NULL,
	[TaxValue] [float] NOT NULL,
 CONSTRAINT [PK_COM_TaxClassState] PRIMARY KEY CLUSTERED 
(
	[TaxClassStateID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_TaxClassState_StateID] ON [dbo].[COM_TaxClassState]
(
	[StateID] ASC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_COM_TaxClassState_TaxClassID_StateID] ON [dbo].[COM_TaxClassState]
(
	[TaxClassID] ASC,
	[StateID] ASC
)
GO
ALTER TABLE [dbo].[COM_TaxClassState]  WITH CHECK ADD  CONSTRAINT [FK_COM_TaxClassState_StateID_CMS_State] FOREIGN KEY([StateID])
REFERENCES [dbo].[CMS_State] ([StateID])
GO
ALTER TABLE [dbo].[COM_TaxClassState] CHECK CONSTRAINT [FK_COM_TaxClassState_StateID_CMS_State]
GO
ALTER TABLE [dbo].[COM_TaxClassState]  WITH CHECK ADD  CONSTRAINT [FK_COM_TaxClassState_TaxClassID_COM_TaxClass] FOREIGN KEY([TaxClassID])
REFERENCES [dbo].[COM_TaxClass] ([TaxClassID])
GO
ALTER TABLE [dbo].[COM_TaxClassState] CHECK CONSTRAINT [FK_COM_TaxClassState_TaxClassID_COM_TaxClass]
GO
