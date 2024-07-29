Return-Path: <linux-can+bounces-1059-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52593FE60
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 21:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FB61F23B59
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C092B18787A;
	Mon, 29 Jul 2024 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Nc7pAAjw"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B9F85947;
	Mon, 29 Jul 2024 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281897; cv=none; b=Z0wu4wk1tx824QSib2dHrLGVz1vdMfWLCaksLW0QO7E/zMnJT8mRhJ2dgh3CiUWvJZS2jTyBpB2tLoZDwJYBSjTqmaSdQ4np5eXVLKUY13M2YGfv5bfRMjIQ3TaPZJ9H3rTC8IS2LQ0YgfuEIRQHsMtmTZ6cSvEJ8MdwsgkunOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281897; c=relaxed/simple;
	bh=sZVi+2wk7bs9BELhyd1J9soxIby8FIm+O1C2MvOrn7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ik2cre8WLLkIym/9fAZeRgLhrUxgl1+WveTOvNju5HR+qvpFs/PyL4D7DhjpINDabMU8p7QTD20Va02rupGchIan6HheSZF8qCkAGdaVVtW6JkTmxd7Ub7vf4GROizjqtY1BhBiW4ubrItbTxF9um1WSWTwoyyFghFuGN0LpWcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Nc7pAAjw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aViOeWOAFrCQc+pd2oF31G+/p4LxlFN55RgNCh7Jk5c=; b=Nc7pAAjwiZSEtGfijJYK2n6kSW
	a7mD6m7J/OH21Y7MP1yIpC3Qokf2FBxgcf2LbupjQd2VeWtDwIUfDoUhH9DBIGslCxTuNmLaMy4ii
	LmSaA7eZMEovPkK1ppis1zatH+N3bEXQHdewidKOy/UFrVMQSawBfj5DRL0oEmfcYHSE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYWBw-003V3O-KA; Mon, 29 Jul 2024 21:37:56 +0200
Date: Mon, 29 Jul 2024 21:37:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	Conor Dooley <conor@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/7] can: m_can: Map WoL to device_set_wakeup_enable
Message-ID: <3d2a2b51-356f-4a9c-940e-df58be8d2cf3@lunn.ch>
References: <20240729074135.3850634-1-msp@baylibre.com>
 <20240729074135.3850634-3-msp@baylibre.com>
 <15424d0f-9538-402f-bc5d-cdd630c7c5e9@lunn.ch>
 <20240729-blue-cockle-of-vigor-7d7670-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-blue-cockle-of-vigor-7d7670-mkl@pengutronix.de>

> > > +static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
> > > +{
> > > +	struct m_can_classdev *cdev = netdev_priv(dev);
> > > +
> > > +	wol->supported = device_can_wakeup(cdev->dev) ? WAKE_PHY : 0;
> > > +	wol->wolopts = device_may_wakeup(cdev->dev) ? WAKE_PHY : 0;
> > > +}
> > 
> > It is nice to see Ethernet WoL mapped to CAN :-)
> > 
> > So will any activity on the CAN BUS wake the device? Or does it need
> > to be addresses to this device?
> 
> Unless you have a special filtering transceiver, which is the CAN
> equivalent of a PHY, CAN interfaces usually wake up on the first
> message on the bus. That message is usually lost.

Thanks for the info. WAKE_PHY does seem the most appropriate then.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

