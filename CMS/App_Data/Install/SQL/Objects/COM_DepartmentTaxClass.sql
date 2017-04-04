SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_DepartmentTaxClass](
	[DepartmentID] [int] NOT NULL,
	[TaxClassID] [int] NOT NULL,
 CONSTRAINT [PK_COM_TaxClassDepartment] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC,
	[TaxClassID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_DepartmentTaxClass_TaxClassID] ON [dbo].[COM_DepartmentTaxClass]
(
	[TaxClassID] ASC
)
GO
ALTER TABLE [dbo].[COM_DepartmentTaxClass]  WITH CHECK ADD  CONSTRAINT [FK_COM_TaxClassDepartment_DepartmentID_COM_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[COM_Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[COM_DepartmentTaxClass] CHECK CONSTRAINT [FK_COM_TaxClassDepartment_DepartmentID_COM_Department]
GO
ALTER TABLE [dbo].[COM_DepartmentTaxClass]  WITH CHECK ADD  CONSTRAINT [FK_COM_TaxClassDepartment_TaxClassID_COM_TaxClass] FOREIGN KEY([TaxClassID])
REFERENCES [dbo].[COM_TaxClass] ([TaxClassID])
GO
ALTER TABLE [dbo].[COM_DepartmentTaxClass] CHECK CONSTRAINT [FK_COM_TaxClassDepartment_TaxClassID_COM_TaxClass]
GO
