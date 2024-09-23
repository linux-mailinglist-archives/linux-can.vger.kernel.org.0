Return-Path: <linux-can+bounces-1543-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B08297EB5E
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 14:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55701F2200D
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99537197A87;
	Mon, 23 Sep 2024 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="szWKbCKc"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76018002A;
	Mon, 23 Sep 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093583; cv=none; b=ro65iHbDjL2b2Ixdvn+oBeqSPuDMaYCcawBxDHfC/qH9TOtW/l3SKGyCvbcWPao3m3Ow7d7+a4ZXCr0xD2j3l1kfGpMrWoCmLLH1+LNHjWbtEJX28v98j1Yobryh3o8CSi6XvvYHv644GoFALivhKntO4afQ6ibawfl8bxWqfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093583; c=relaxed/simple;
	bh=mtUlxP0PeHJOjX6toxYU5t+iAgcA2Ki1i79is5A/tzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrR6IR+v46RESeqpR6YaFm05IWWF+iWp6syz0uvDcBGEU/N/bs7wXWItBrFsSY3jDuTjXtuXF//G8Ba3A7KxlGh7zI4abHHY0Al2kHfhvBLUyVPNNF6rFeA3K3Tv2bttv49amfUHCAgIEp207s7lXJAcvShV1Xe85McKGmVL4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=szWKbCKc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Eq1Kj2dvKOSMfRsPuAE8w645hcxyoP4nvyUZ3L3dadU=; b=szWKbCKcaTKaRdtijfzBwrt+0g
	nzZYalFp99LmsUhBcVHcE368+GrOSM7Pu5kpVlK+LttedoxNLPMLv6udFAkPD0vOqhNNhTJ+Y2qN+
	oRfGZE5NsaLP2yGEZgxOHEEXuABvcyN2CVi3lqJiKW1O78IAiz3wmyYYCkw102QSS6PA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sshvj-0087dk-SM; Mon, 23 Sep 2024 14:12:39 +0200
Date: Mon, 23 Sep 2024 14:12:39 +0200
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
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
Message-ID: <9cf40a68-a07f-46d5-bc2c-302ae0e99ab0@lunn.ch>
References: <20240922145151.130999-1-hal.feng@starfivetech.com>
 <20240922145151.130999-4-hal.feng@starfivetech.com>
 <cf17f15b-cbd7-4692-b3b2-065e549cb21e@lunn.ch>
 <ZQ2PR01MB13071A093EB33F48340F753EE66F2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ2PR01MB13071A093EB33F48340F753EE66F2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>

> > > +	reset_test = ccan_read_reg_8bit(priv, CCAN_CFG_STAT);
> > > +
> > > +	if (!(reset_test & CCAN_RST_MASK)) {
> > > +		netdev_alert(ndev, "Not in reset mode, cannot set bit
> > timing\n");
> > > +		return -EPERM;
> > > +	}
> > 
> > 
> > You don't see nedev_alert() used very often. If this is fatal then netdev_err().
> > 
> > Also, EPERM? man 3 errno say:
> > 
> >        EPERM           Operation not permitted (POSIX.1-2001).
> > 
> > Why is this a permission issue?
> 
> Will use netdev_err() and return -EWOULDBLOCK instead.

I'm not sure that is any better.

       EAGAIN          Resource  temporarily unavailable (may be the same value
                       as EWOULDBLOCK) (POSIX.1-2001).

This is generally used when the kernel expects user space to try a
system call again, and it might then work. Is that what you expect
here?

> > > +static irqreturn_t ccan_interrupt(int irq, void *dev_id) {
> > > +	struct net_device *ndev = (struct net_device *)dev_id;
> > 
> > dev_id is a void *, so you don't need the cast.
> 
> OK, drop it.

Please look at the whole patch. There might be other instances where a
void * is used with a cast, which can be removed. This was just the
first i spotted.

	Andrew

