Return-Path: <linux-can+bounces-1521-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76FF97E27C
	for <lists+linux-can@lfdr.de>; Sun, 22 Sep 2024 18:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65932B20CCC
	for <lists+linux-can@lfdr.de>; Sun, 22 Sep 2024 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C050E2209B;
	Sun, 22 Sep 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jm9nwVxc"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3502581;
	Sun, 22 Sep 2024 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727022861; cv=none; b=oKX8gcT5F4l4gZz4NARRQ9gFVMDjuZJ4Duo9dvur6sXRPizjqBiAJFZNAiDRHmH7QKV6gwvMYW6bnvtQtbejg0cCpfR08oJ+ISMslhQdAkgYKWL3HfsnDNP8ypgtj0h9ygmbnVTWudNZ6qcdnBXspqxhMJqkfqW2KIVTusiXhHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727022861; c=relaxed/simple;
	bh=gFlVSCJab296RK5+Ai1YxYQl2rv5hxg3BElMeprdRII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nl7GyWkI58iZSBwCNs5P8kT0I3tYIQKouCyI/4eih/teDDZHV+SPs+RKOqM0maKBQld2nswJFavS3W3pmrnYqHHwvxT6w3h++ov1E/WgizF3uljXG0OyH5c14Y5H9jG8su2BeMppu9kM2rPRYRXm0CGdivblKe6LUQnNfEtvTug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jm9nwVxc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xGmipcPUvSFvCq++6VT9S82wVCnPIsh0kZdD2tTzbJM=; b=jm9nwVxcMCmtyeT6Oyx1bwlk5b
	QIt2JFKDn8FmrZFoi10orj33aeO2dLGY8ksjWgFZyWxgHm2j5wid8ZzC7QJ6anDx2t82kwpN088uc
	UjC91LJRO9zSM2MqYEf+s8dMNGJvEaYn9PgvYMghtzhOHXHeEou9YBad//2eQ5BdVrek=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ssPX3-0084MO-6x; Sun, 22 Sep 2024 18:33:57 +0200
Date: Sun, 22 Sep 2024 18:33:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	William Qiu <william.qiu@starfivetech.com>,
	devicetree@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
Message-ID: <cf17f15b-cbd7-4692-b3b2-065e549cb21e@lunn.ch>
References: <20240922145151.130999-1-hal.feng@starfivetech.com>
 <20240922145151.130999-4-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922145151.130999-4-hal.feng@starfivetech.com>

> +static inline u32 ccan_read_reg(const struct ccan_priv *priv, u8 reg)
> +{
> +	return ioread32(priv->reg_base + reg);
> +}
> +
> +static inline void ccan_write_reg(const struct ccan_priv *priv, u8 reg, u32 value)
> +{
> +	iowrite32(value, priv->reg_base + reg);
> +}

No inline functions in .c files please. Let the compiler decide.

> +static inline u8 ccan_read_reg_8bit(const struct ccan_priv *priv,
> +				    enum ccan_reg reg)
> +{
> +	u8 reg_down;
> +	union val {
> +		u8 val_8[4];
> +		u32 val_32;
> +	} val;
> +
> +	reg_down = ALIGN_DOWN(reg, 4);
> +	val.val_32 = ccan_read_reg(priv, reg_down);
> +	return val.val_8[reg - reg_down];

There is an ioread8(). Is it invalid to do a byte read for this
hardware? If so, it is probably worth a comment.

> +static int ccan_bittime_configuration(struct net_device *ndev)
> +{
> +	struct ccan_priv *priv = netdev_priv(ndev);
> +	struct can_bittiming *bt = &priv->can.bittiming;
> +	struct can_bittiming *dbt = &priv->can.data_bittiming;
> +	u32 bittiming, data_bittiming;
> +	u8 reset_test;
> +
> +	reset_test = ccan_read_reg_8bit(priv, CCAN_CFG_STAT);
> +
> +	if (!(reset_test & CCAN_RST_MASK)) {
> +		netdev_alert(ndev, "Not in reset mode, cannot set bit timing\n");
> +		return -EPERM;
> +	}


You don't see nedev_alert() used very often. If this is fatal then
netdev_err().

Also, EPERM? man 3 errno say:

       EPERM           Operation not permitted (POSIX.1-2001).

Why is this a permission issue?

> +static void ccan_tx_interrupt(struct net_device *ndev, u8 isr)
> +{
> +	struct ccan_priv *priv = netdev_priv(ndev);
> +
> +	/* wait till transmission of the PTB or STB finished */
> +	while (isr & (CCAN_TPIF_MASK | CCAN_TSIF_MASK)) {
> +		if (isr & CCAN_TPIF_MASK)
> +			ccan_reg_set_bits(priv, CCAN_RTIF, CCAN_TPIF_MASK);
> +
> +		if (isr & CCAN_TSIF_MASK)
> +			ccan_reg_set_bits(priv, CCAN_RTIF, CCAN_TSIF_MASK);
> +
> +		isr = ccan_read_reg_8bit(priv, CCAN_RTIF);
> +	}

Potentially endless loops like this are a bad idea. If the firmware
crashes, you are never getting out of here. Please use one of the
macros from iopoll.h

> +static irqreturn_t ccan_interrupt(int irq, void *dev_id)
> +{
> +	struct net_device *ndev = (struct net_device *)dev_id;

dev_id is a void *, so you don't need the cast.

	Andrew

