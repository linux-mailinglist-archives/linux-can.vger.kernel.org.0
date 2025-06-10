Return-Path: <linux-can+bounces-3796-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46225AD378B
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 14:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A69A3BEA3F
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 12:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA962C030D;
	Tue, 10 Jun 2025 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hZoQ3j3I"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFF2AF1E;
	Tue, 10 Jun 2025 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559588; cv=none; b=MGQ677CVh193UYci+sAXbQEuLIyB9F3zVkO1hemplgIiDAbIHo8mU5szHoDjofngSgdplR7vAizWkzqOe2FTKfucApe5OEWVgnmyESPD1B4DArcNDAdVt1UX5qdbmpDt07F88t4crfeNXqU3jgxSi4um8eO8NHbXIibDY9INEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559588; c=relaxed/simple;
	bh=mSF2gA5Qb1wekKI7B0KlNmhWLve3DeW+P+aVaydV8OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDG8xMUzv9NRdY4XlWSv0IwB5J7nFcOzF9MAgRwtEZJzdBb7gDbTiK/g+CU5K3SRqmYiaGuzKwP2iYkOlqrswD1AmpqLosfkURrvpHuS0cQbscFwmevbnfatASowfe0UIPmDT83sIRFaYqaXKwQ3GIhbD3DbdVMyll1g5ma2D48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hZoQ3j3I; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IxovBajuiG9VZJ3XmWy0NzjagqDViV1ywWm/ai8Bd1M=; b=hZoQ3j3IzpoxwljSwnB8bccPSM
	XRrBw7WFNZ8PxtzbiIXdJUnm/tkBx5fm8LE2KeugPzbPkZOxOSYZeqWHG27E/pZqa2VZB9z9EYDNc
	cwy1nsznvNnVMKnbEY13v7IRURpmJET03jHqxGcIuSW+kSzh3eWH+oyjvx03UBx9A2i8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uOyMc-00FGUL-0t; Tue, 10 Jun 2025 14:46:02 +0200
Date: Tue, 10 Jun 2025 14:46:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-can@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 4/4] net: phy: qca807x: use new GPIO line value setter
 callbacks
Message-ID: <5c9a127b-8538-4856-bdb3-cbee87993428@lunn.ch>
References: <20250610-gpiochip-set-rv-net-v1-0-35668dd1c76f@linaro.org>
 <20250610-gpiochip-set-rv-net-v1-4-35668dd1c76f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-gpiochip-set-rv-net-v1-4-35668dd1c76f@linaro.org>

> -static void qca807x_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
> +static int qca807x_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
>  {
>  	struct qca807x_gpio_priv *priv = gpiochip_get_data(gc);
>  	u16 reg;
> @@ -390,14 +390,12 @@ static void qca807x_gpio_set(struct gpio_chip *gc, unsigned int offset, int valu
>  	val |= QCA807X_GPIO_FORCE_EN;
>  	val |= FIELD_PREP(QCA807X_GPIO_FORCE_MODE_MASK, value);
>  
> -	phy_write_mmd(priv->phy, MDIO_MMD_AN, reg, val);
> +	return phy_write_mmd(priv->phy, MDIO_MMD_AN, reg, val);
>  }

The full function is:

static void qca807x_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
{
	struct qca807x_gpio_priv *priv = gpiochip_get_data(gc);
	u16 reg;
	int val;

	reg = QCA807X_MMD7_LED_FORCE_CTRL(offset);

	val = phy_read_mmd(priv->phy, MDIO_MMD_AN, reg);
	val &= ~QCA807X_GPIO_FORCE_MODE_MASK;
	val |= QCA807X_GPIO_FORCE_EN;
	val |= FIELD_PREP(QCA807X_GPIO_FORCE_MODE_MASK, value);

	phy_write_mmd(priv->phy, MDIO_MMD_AN, reg, val);
}

The phy_read_mmd() could also fail and return an error code.

    Andrew

---
pw-bot: cr

