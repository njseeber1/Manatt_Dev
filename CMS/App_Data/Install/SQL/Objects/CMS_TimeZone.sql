SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_TimeZone](
	[TimeZoneID] [int] IDENTITY(1,1) NOT NULL,
	[TimeZoneName] [nvarchar](200) NOT NULL,
	[TimeZoneDisplayName] [nvarchar](200) NOT NULL,
	[TimeZoneGMT] [float] NOT NULL,
	[TimeZoneDaylight] [bit] NULL,
	[TimeZoneRuleStartIn] [datetime2](7) NOT NULL,
	[TimeZoneRuleStartRule] [nvarchar](200) NOT NULL,
	[TimeZoneRuleEndIn] [datetime2](7) NOT NULL,
	[TimeZoneRuleEndRule] [nvarchar](200) NOT NULL,
	[TimeZoneGUID] [uniqueidentifier] NOT NULL,
	[TimeZoneLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CMS_TimeZone] PRIMARY KEY NONCLUSTERED 
(
	[TimeZoneID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_CMS_TimeZone_TimeZoneDisplayName] ON [dbo].[CMS_TimeZone]
(
	[TimeZoneDisplayName] ASC
)
GO
ALTER TABLE [dbo].[CMS_TimeZone] ADD  CONSTRAINT [DEFAULT_CMS_TimeZone_TimeZoneGMT]  DEFAULT ((0)) FOR [TimeZoneGMT]
GO
ALTER TABLE [dbo].[CMS_TimeZone] ADD  CONSTRAINT [DEFAULT_CMS_TimeZone_TimeZoneDaylight]  DEFAULT ((0)) FOR [TimeZoneDaylight]
GO
