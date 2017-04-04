SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_MultiBuyDiscount](
	[MultiBuyDiscountID] [int] IDENTITY(1,1) NOT NULL,
	[MultiBuyDiscountDisplayName] [nvarchar](200) NOT NULL,
	[MultiBuyDiscountName] [nvarchar](200) NOT NULL,
	[MultiBuyDiscountDescription] [nvarchar](max) NULL,
	[MultiBuyDiscountEnabled] [bit] NOT NULL,
	[MultiBuyDiscountGUID] [uniqueidentifier] NOT NULL,
	[MultiBuyDiscountLastModified] [datetime2](7) NOT NULL,
	[MultiBuyDiscountSiteID] [int] NULL,
	[MultiBuyDiscountPriority] [float] NULL,
	[MultiBuyDiscountApplyFurtherDiscounts] [bit] NOT NULL,
	[MultiBuyDiscountMinimumBuyCount] [int] NOT NULL,
	[MultiBuyDiscountValidFrom] [datetime2](7) NULL,
	[MultiBuyDiscountValidTo] [datetime2](7) NULL,
	[MultiBuyDiscountCustomerRestriction] [nvarchar](200) NOT NULL,
	[MultiBuyDiscountRoles] [nvarchar](400) NULL,
	[MultiBuyDiscountApplyToSKUID] [int] NULL,
	[MultiBuyDiscountLimitPerOrder] [int] NULL,
	[MultiBuyDiscountUsesCoupons] [bit] NULL,
	[MultiBuyDiscountValue] [float] NULL,
	[MultiBuyDiscountIsFlat] [bit] NULL,
	[MultiBuyDiscountAutoAddEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_COM_MultiBuyDiscount] PRIMARY KEY CLUSTERED 
(
	[MultiBuyDiscountID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_COM_MultiBuyDiscount_MultiBuyDiscountApplyToSKUID] ON [dbo].[COM_MultiBuyDiscount]
(
	[MultiBuyDiscountApplyToSKUID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_MultiBuyDiscount_MultiBuyDiscountSiteID] ON [dbo].[COM_MultiBuyDiscount]
(
	[MultiBuyDiscountSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscount] ADD  CONSTRAINT [DEFAULT_COM_MultiBuyDiscount_MultiBuyDiscountEnabled]  DEFAULT ((1)) FOR [MultiBuyDiscountEnabled]
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscount] ADD  CONSTRAINT [DEFAULT_COM_MultiBuyDiscount_MultiBuyDiscountApplyFurtherDiscounts]  DEFAULT ((1)) FOR [MultiBuyDiscountApplyFurtherDiscounts]
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscount] ADD  CONSTRAINT [DEFAULT_COM_MultiBuyDiscount_MultiBuyDiscountMinimumBuyCount]  DEFAULT ((1)) FOR [MultiBuyDiscountMinimumBuyCount]
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscount] ADD  CONSTRAINT [DEFAULT_COM_MultiBuyDiscount_MultiBuyDiscountCustomerRestriction]  DEFAULT (N'All') FOR [MultiBuyDiscountCustomerRestriction]
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscount] ADD  CONSTRAINT [DEFAULT_COM_MultiBuyDiscount_MultiBuyDiscountUsesCoupons]  DEFAULT ((0)) FOR [MultiBuyDiscountUsesCoupons]
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscount] ADD  CONSTRAINT [DEFAULT_COM_MultiBuyDiscount_MultiBuyDiscountIsFlat]  DEFAULT ((1)) FOR [MultiBuyDiscountIsFlat]
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscount] ADD  CONSTRAINT [DEFAULT_COM_MultiBuyDiscount_MultiBuyDiscountAutoAddEnabled]  DEFAULT ((1)) FOR [MultiBuyDiscountAutoAddEnabled]
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscount]  WITH CHECK ADD  CONSTRAINT [FK_COM_MultiBuyDiscount_MultiBuyDiscountApplyToSKUID_COM_SKU] FOREIGN KEY([MultiBuyDiscountApplyToSKUID])
REFERENCES [dbo].[COM_SKU] ([SKUID])
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscount] CHECK CONSTRAINT [FK_COM_MultiBuyDiscount_MultiBuyDiscountApplyToSKUID_COM_SKU]
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscount]  WITH CHECK ADD  CONSTRAINT [FK_COM_MultiBuyDiscount_MultiBuyDiscountSiteID_CMS_Site] FOREIGN KEY([MultiBuyDiscountSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_MultiBuyDiscount] CHECK CONSTRAINT [FK_COM_MultiBuyDiscount_MultiBuyDiscountSiteID_CMS_Site]
GO
