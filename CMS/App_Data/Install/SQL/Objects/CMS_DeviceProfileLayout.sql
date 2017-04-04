SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_DeviceProfileLayout](
	[DeviceProfileLayoutID] [int] IDENTITY(1,1) NOT NULL,
	[DeviceProfileID] [int] NOT NULL,
	[SourceLayoutID] [int] NOT NULL,
	[TargetLayoutID] [int] NOT NULL,
	[DeviceProfileLayoutGUID] [uniqueidentifier] NOT NULL,
	[DeviceProfileLayoutLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CMS_DeviceProfileLayout] PRIMARY KEY CLUSTERED 
(
	[DeviceProfileLayoutID] ASC
)
)

GO
