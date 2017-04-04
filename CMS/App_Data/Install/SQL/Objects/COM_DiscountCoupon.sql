SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COM_DiscountCoupon](
	[DiscountCouponID] [int] IDENTITY(1,1) NOT NULL,
	[DiscountCouponDisplayName] [nvarchar](200) NOT NULL,
	[DiscountCouponIsExcluded] [bit] NOT NULL,
	[DiscountCouponValidFrom] [datetime2](7) NULL,
	[DiscountCouponValidTo] [datetime2](7) NULL,
	[DiscountCouponValue] [float] NOT NULL,
	[DiscountCouponIsFlatValue] [bit] NOT NULL,
	[DiscountCouponCode] [nvarchar](200) NOT NULL,
	[DiscountCouponGUID] [uniqueidentifier] NULL,
	[DiscountCouponLastModified] [datetime2](7) NULL,
	[DiscountCouponSiteID] [int] NULL,
 CONSTRAINT [PK_COM_DiscountCoupon] PRIMARY KEY NONCLUSTERED 
(
	[DiscountCouponID] ASC
)
)

GO
SET ANSI_PADDING ON

GO
CREATE CLUSTERED INDEX [IX_COM_DiscountCoupon_DiscoutCouponDisplayName] ON [dbo].[COM_DiscountCoupon]
(
	[DiscountCouponDisplayName] ASC
)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_COM_DiscountCoupon_DiscountCouponCode] ON [dbo].[COM_DiscountCoupon]
(
	[DiscountCouponCode] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_COM_DiscountCoupon_DiscountCouponSiteID] ON [dbo].[COM_DiscountCoupon]
(
	[DiscountCouponSiteID] ASC
)
GO
ALTER TABLE [dbo].[COM_DiscountCoupon] ADD  CONSTRAINT [DEFAULT_COM_DiscountCoupon_DiscountCouponDisplayName]  DEFAULT (N'') FOR [DiscountCouponDisplayName]
GO
ALTER TABLE [dbo].[COM_DiscountCoupon] ADD  CONSTRAINT [DEFAULT_COM_DiscountCoupon_DiscountCouponIsExcluded]  DEFAULT ((0)) FOR [DiscountCouponIsExcluded]
GO
ALTER TABLE [dbo].[COM_DiscountCoupon] ADD  CONSTRAINT [DEFAULT_COM_DiscountCoupon_DiscountCouponValue]  DEFAULT ((0)) FOR [DiscountCouponValue]
GO
ALTER TABLE [dbo].[COM_DiscountCoupon] ADD  CONSTRAINT [DEFAULT_COM_DiscountCoupon_DiscountCouponIsFlatValue]  DEFAULT ((0)) FOR [DiscountCouponIsFlatValue]
GO
ALTER TABLE [dbo].[COM_DiscountCoupon] ADD  CONSTRAINT [DEFAULT_COM_DiscountCoupon_DiscountCouponCode]  DEFAULT (N'') FOR [DiscountCouponCode]
GO
ALTER TABLE [dbo].[COM_DiscountCoupon]  WITH CHECK ADD  CONSTRAINT [FK_COM_DiscountCoupon_DiscountCouponSiteID_CMS_Site] FOREIGN KEY([DiscountCouponSiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[COM_DiscountCoupon] CHECK CONSTRAINT [FK_COM_DiscountCoupon_DiscountCouponSiteID_CMS_Site]
GO
