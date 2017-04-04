SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Integration_Connector](
	[ConnectorID] [int] IDENTITY(1,1) NOT NULL,
	[ConnectorName] [nvarchar](100) NOT NULL,
	[ConnectorDisplayName] [nvarchar](440) NOT NULL,
	[ConnectorAssemblyName] [nvarchar](400) NOT NULL,
	[ConnectorClassName] [nvarchar](400) NOT NULL,
	[ConnectorEnabled] [bit] NOT NULL,
	[ConnectorLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Integration_Connector] PRIMARY KEY NONCLUSTERED 
(
	[ConnectorID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Integration_Connector_ConnectorDisplayName] ON [dbo].[Integration_Connector]
(
	[ConnectorDisplayName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Integration_Connector_ConnectorEnabled] ON [dbo].[Integration_Connector]
(
	[ConnectorEnabled] ASC
)
GO
ALTER TABLE [dbo].[Integration_Connector] ADD  CONSTRAINT [DEFAULT_Integration_Connector_ConnectorEnabled]  DEFAULT ((1)) FOR [ConnectorEnabled]
GO
