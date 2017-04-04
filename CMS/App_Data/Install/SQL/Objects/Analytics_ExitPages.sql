SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Analytics_ExitPages](
	[SessionIdentificator] [nvarchar](200) NOT NULL,
	[ExitPageNodeID] [int] NOT NULL,
	[ExitPageLastModified] [datetime2](7) NOT NULL,
	[ExitPageSiteID] [int] NOT NULL,
	[ExitPageCulture] [nvarchar](10) NULL,
 CONSTRAINT [PK_Analytics_ExitPages] PRIMARY KEY CLUSTERED 
(
	[SessionIdentificator] ASC
)
)

GO
