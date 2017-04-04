SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_UserSite](
	[UserSiteID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[UserPreferredCurrencyID] [int] NULL,
	[UserPreferredShippingOptionID] [int] NULL,
	[UserPreferredPaymentOptionID] [int] NULL,
 CONSTRAINT [PK_CMS_UserSite] PRIMARY KEY CLUSTERED 
(
	[UserSiteID] ASC
)
)

GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSite_SiteID] ON [dbo].[CMS_UserSite]
(
	[SiteID] ASC
)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CMS_UserSite_UserID_SiteID] ON [dbo].[CMS_UserSite]
(
	[UserID] ASC,
	[SiteID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSite_UserPreferredCurrencyID] ON [dbo].[CMS_UserSite]
(
	[UserPreferredCurrencyID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSite_UserPreferredPaymentOptionID] ON [dbo].[CMS_UserSite]
(
	[UserPreferredPaymentOptionID] ASC
)
GO
CREATE NONCLUSTERED INDEX [IX_CMS_UserSite_UserPreferredShippingOptionID] ON [dbo].[CMS_UserSite]
(
	[UserPreferredShippingOptionID] ASC
)
GO
ALTER TABLE [dbo].[CMS_UserSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_UserSite_COM_Currency] FOREIGN KEY([UserPreferredCurrencyID])
REFERENCES [dbo].[COM_Currency] ([CurrencyID])
GO
ALTER TABLE [dbo].[CMS_UserSite] CHECK CONSTRAINT [FK_CMS_UserSite_COM_Currency]
GO
ALTER TABLE [dbo].[CMS_UserSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_UserSite_COM_PaymentOption] FOREIGN KEY([UserPreferredPaymentOptionID])
REFERENCES [dbo].[COM_PaymentOption] ([PaymentOptionID])
GO
ALTER TABLE [dbo].[CMS_UserSite] CHECK CONSTRAINT [FK_CMS_UserSite_COM_PaymentOption]
GO
ALTER TABLE [dbo].[CMS_UserSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_UserSite_COM_ShippingOption] FOREIGN KEY([UserPreferredShippingOptionID])
REFERENCES [dbo].[COM_ShippingOption] ([ShippingOptionID])
GO
ALTER TABLE [dbo].[CMS_UserSite] CHECK CONSTRAINT [FK_CMS_UserSite_COM_ShippingOption]
GO
ALTER TABLE [dbo].[CMS_UserSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_UserSite_SiteID_CMS_Site] FOREIGN KEY([SiteID])
REFERENCES [dbo].[CMS_Site] ([SiteID])
GO
ALTER TABLE [dbo].[CMS_UserSite] CHECK CONSTRAINT [FK_CMS_UserSite_SiteID_CMS_Site]
GO
ALTER TABLE [dbo].[CMS_UserSite]  WITH CHECK ADD  CONSTRAINT [FK_CMS_UserSite_UserID_CMS_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[CMS_User] ([UserID])
GO
ALTER TABLE [dbo].[CMS_UserSite] CHECK CONSTRAINT [FK_CMS_UserSite_UserID_CMS_User]
GO
