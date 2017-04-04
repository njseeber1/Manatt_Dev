SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_Discount](
	[DiscountID] [int] IDENTITY(1,1) NOT NULL,
	[DiscountDisplayName] [nvarchar](200) NOT NULL,
	[DiscountName] [nvarchar](200) NOT NULL,
	[DiscountValue] [float] NOT NULL,
	[DiscountEnabled] [bit] NOT NULL,
	[DiscountGUID] [uniqueidentifier] NOT NULL,
	[DiscountLastModified] [datetime2](7) NOT NULL,
	[DiscountSiteID] [int] NULL,
	[DiscountDescription] [nvarchar](max) NULL,
	[DiscountValidFrom] [datetime2](7) NULL,
	[DiscountValidTo] [datetime2](7) NULL,
	[DiscountOrder] [float] NOT NULL,
	[DiscountProductCondition] [nvarchar](max) NULL,
	[DiscountRoles] [nvarchar](400) NULL,
	[DiscountCustomerRestriction] [nvarchar](200) NULL,
	[DiscountIsFlat] [bit] NOT NULL,
	[DiscountCartCondition] [nvarchar](max) NULL,
	[DiscountApplyTo] [nvarchar](100) NOT NULL,
	[DiscountApplyFurtherDiscounts] [bit] NOT NULL,
	[DiscountOrderAmount] [float] NULL,
	[DiscountUsesCoupons] [bit] NOT NULL,
 CONSTRAINT [PK_COM_Discount] PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_Discount_DiscountSiteID] ON [dbo].[COM_Discount]
(
	[DiscountSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_Discount] ADD  CONSTRAINT [DEFAULT_COM_Discount_DiscountDisplayName]  DEFAULT (N'') FOR [DiscountDisplayName]
GO
ALTER TABLE [dbo].[COM_Discount] ADD  CONSTRAINT [DEFAULT_COM_Discount_DiscountValue]  DEFAULT ((0)) FOR [DiscountValue]
GO
ALTER TABLE [dbo].[COM_Discount] ADD  CONSTRAINT [DEFAULT_COM_Discount_DiscountEnabled]  DEFAULT ((1)) FOR [DiscountEnabled]
GO
ALTER TABLE [dbo].[COM_Discount] ADD  CONSTRAINT [DEFAULT_COM_Discount_DiscountOrder]  DEFAULT ((1)) FOR [DiscountOrder]
GO
ALTER TABLE [dbo].[COM_Discount] ADD  CONSTRAINT [DEFAULT_COM_Discount_DiscountIsFlat]  DEFAULT ((0)) FOR [DiscountIsFlat]
GO
ALTER TABLE [dbo].[COM_Discount] ADD  CONSTRAINT [DEFAULT_COM_Discount_DiscountApplyTo]  DEFAULT ('Order') FOR [DiscountApplyTo]
GO
ALTER TABLE [dbo].[COM_Discount] ADD  CONSTRAINT [DEFAULT_COM_Discount_DiscountApplyFurtherDiscounts]  DEFAULT ((1)) FOR [DiscountApplyFurtherDiscounts]
GO
ALTER TABLE [dbo].[COM_Discount] ADD  CONSTRAINT [DEFAULT_COM_Discount_DiscountUsesCoupons]  DEFAULT ((0)) FOR [DiscountUsesCoupons]
GO
ALTER TABLE [dbo].[COM_Discount]  WITH CHECK ADD  CONSTRAINT [FK_COM_Discount_DiscountSiteID_CMS_Site] FOREIGN KEY([DiscountSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_Discount] CHECK CONSTRAINT [FK_COM_Discount_DiscountSiteID_CMS_Site]
GO
