SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BadWords_Word](
	[WordID] [int] IDENTITY(1,1) NOT NULL,
	[WordGUID] [uniqueidentifier] NOT NULL,
	[WordLastModified] [datetime2](7) NOT NULL,
	[WordExpression] [nvarchar](200) NOT NULL,
	[WordReplacement] [nvarchar](200) NULL,
	[WordAction] [int] NULL,
	[WordIsGlobal] [bit] NOT NULL,
	[WordIsRegularExpression] [bit] NOT NULL,
	[WordMatchWholeWord] [bit] NULL,
 CONSTRAINT [PK_BadWords_Word] PRIMARY KEY NONCLUSTERED 
(
	[WordID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_BadWords_Word_WordExpression] ON [dbo].[BadWords_Word]
(
	[WordExpression] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_BadWords_Word_WordIsGlobal] ON [dbo].[BadWords_Word]
(
	[WordIsGlobal] ASC
)
GO
ALTER TABLE [dbo].[BadWords_Word] ADD  CONSTRAINT [DEFAULT_BadWords_Word_WordExpression]  DEFAULT (N'') FOR [WordExpression]
GO
ALTER TABLE [dbo].[BadWords_Word] ADD  CONSTRAINT [DEFAULT_BadWords_Word_WordIsGlobal]  DEFAULT ((0)) FOR [WordIsGlobal]
GO
ALTER TABLE [dbo].[BadWords_Word] ADD  CONSTRAINT [DEFAULT_BadWords_Word_WordIsRegularExpression]  DEFAULT ((0)) FOR [WordIsRegularExpression]
GO
