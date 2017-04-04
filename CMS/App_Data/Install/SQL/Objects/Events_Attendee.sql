SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events_Attendee](
	[AttendeeID] [int] IDENTITY(1,1) NOT NULL,
	[AttendeeEmail] [nvarchar](250) NOT NULL,
	[AttendeeFirstName] [nvarchar](100) NULL,
	[AttendeeLastName] [nvarchar](100) NULL,
	[AttendeePhone] [nvarchar](50) NULL,
	[AttendeeEventNodeID] [int] NOT NULL,
	[AttendeeGUID] [uniqueidentifier] NOT NULL,
	[AttendeeLastModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Events_Attendee] PRIMARY KEY NONCLUSTERED 
(
	[AttendeeID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_Events_Attendee_AttendeeEmail_AttendeeFirstName_AttendeeLastName] ON [dbo].[Events_Attendee]
(
	[AttendeeEmail] ASC,
	[AttendeeFirstName] ASC,
	[AttendeeLastName] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_Events_Attendee_AttendeeEventNodeID] ON [dbo].[Events_Attendee]
(
	[AttendeeEventNodeID] ASC
)
GO
ALTER TABLE [dbo].[Events_Attendee] ADD  CONSTRAINT [DEFAULT_Events_Attendee_AttendeeEmail]  DEFAULT (N'') FOR [AttendeeEmail]
GO
ALTER TABLE [dbo].[Events_Attendee] ADD  CONSTRAINT [DEFAULT_Events_Attendee_AttendeeFirstName]  DEFAULT (N'') FOR [AttendeeFirstName]
GO
ALTER TABLE [dbo].[Events_Attendee] ADD  CONSTRAINT [DEFAULT_Events_Attendee_AttendeeLastName]  DEFAULT (N'') FOR [AttendeeLastName]
GO
ALTER TABLE [dbo].[Events_Attendee] ADD  CONSTRAINT [DEFAULT_Events_Attendee_AttendeePhone]  DEFAULT (N'') FOR [AttendeePhone]
GO
ALTER TABLE [dbo].[Events_Attendee] ADD  CONSTRAINT [DEFAULT_Events_Attendee_AttendeeGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [AttendeeGUID]
GO
ALTER TABLE [dbo].[Events_Attendee] ADD  CONSTRAINT [DEFAULT_Events_Attendee_AttendeeLastModified]  DEFAULT ('1/20/2015 8:52:25 AM') FOR [AttendeeLastModified]
GO
ALTER TABLE [dbo].[Events_Attendee]  WITH CHECK ADD  CONSTRAINT [FK_Events_Attendee_AttendeeEventNodeID_CMS_Tree] FOREIGN KEY([AttendeeEventNodeID])
REFERENCES [dbo].[CMS_Tree] ([NodeID])
GO
ALTER TABLE [dbo].[Events_Attendee] CHECK CONSTRAINT [FK_Events_Attendee_AttendeeEventNodeID_CMS_Tree]
GO
