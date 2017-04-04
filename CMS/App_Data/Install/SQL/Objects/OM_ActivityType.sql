SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OM_ActivityType](
	[ActivityTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ActivityTypeDisplayName] [nvarchar](250) NOT NULL,
	[ActivityTypeName] [nvarchar](250) NOT NULL,
	[ActivityTypeEnabled] [bit] NULL,
	[ActivityTypeIsCustom] [bit] NULL,
	[ActivityTypeDescription] [nvarchar](max) NULL,
	[ActivityTypeManualCreationAllowed] [bit] NULL,
	[ActivityTypeMainFormControl] [nvarchar](200) NULL,
	[ActivityTypeDetailFormControl] [nvarchar](200) NULL,
 CONSTRAINT [PK_OM_ActivityType] PRIMARY KEY CLUSTERED 
(
	[ActivityTypeID] ASC
)
)

GO
ALTER TABLE [dbo].[OM_ActivityType] ADD  CONSTRAINT [DEFAULT_OM_ActivityType_ActivityTypeEnabled]  DEFAULT ((1)) FOR [ActivityTypeEnabled]
GO
ALTER TABLE [dbo].[OM_ActivityType] ADD  CONSTRAINT [DEFAULT_OM_ActivityType_ActivityTypeIsCustom]  DEFAULT ((1)) FOR [ActivityTypeIsCustom]
GO
