Return-Path: <linux-can+bounces-1057-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1293FE3B
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 21:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011F71C2268F
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 19:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A3B18785A;
	Mon, 29 Jul 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QRQXKTf9"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924E187322;
	Mon, 29 Jul 2024 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281247; cv=none; b=VRYElihG7IVraTJ+R6JU3DC/8UT9kNy1KC/Kg/4bqA16bXgGIP6o+u0dQeRA+StAgxm+M8Fo51WWD9aoBMfNvAOi0TFP4sK37UT0RNjEXZLtUAQD+xSG2JOS4bVt3zyP4pVRps3iPYe18mgKSiZQn3MSjFkT7SR33c92z4yT2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281247; c=relaxed/simple;
	bh=Sx5GnLyFD86DhvvRIf0ymkAYo91m0ZR+VpQ3SCr3aCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnMZokLokaNgeBFj+kQEfZay1OGA5UJLd4lLOuCiib25ptZ6QpG4PoP5S3LE26kx/sUHogiB4wLF64s3NY4u1+8z2p6FKbyooycoMTCcUoGQPnBtZS3+5Vo8hFQus3173LO7xozIH2K/9dy3+duPwlq6ANhQ03g4UnK/CAZDizY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QRQXKTf9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SPWJtm427QjfDF7wPVvtx41fVv4rQ2hu/R2QSwgK83Y=; b=QRQXKTf95sTqQZ3pCXczu3HPxh
	RrNU7+s7H8s6ve3l50tTqcU2rL5khfEfGL/AvOQr9S5GNDw/42DnM04lR5C4UJFTcLPb1jM/EQ+eC
	HRdmjLpnAzt0R665oqXCIV+SMX3K7uAa3oPeQ2PCmRDlTGhovX7RsNC2Pw6ES6NVxYoQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYW1Q-003Uzh-5d; Mon, 29 Jul 2024 21:27:04 +0200
Date: Mon, 29 Jul 2024 21:27:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
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
Message-ID: <15424d0f-9538-402f-bc5d-cdd630c7c5e9@lunn.ch>
References: <20240729074135.3850634-1-msp@baylibre.com>
 <20240729074135.3850634-3-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729074135.3850634-3-msp@baylibre.com>

On Mon, Jul 29, 2024 at 09:41:30AM +0200, Markus Schneider-Pargmann wrote:
> In some devices the pins of the m_can module can act as a wakeup source.
> This patch helps do that by connecting the PHY_WAKE WoL option to
> device_set_wakeup_enable. By marking this device as being wakeup
> enabled, this setting can be used by platform code to decide which
> sleep or poweroff mode to use.
> 
> Also this prepares the driver for the next patch in which the pinctrl
> settings are changed depending on the desired wakeup source.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 81e05746d7d4..2e4ccf05e162 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2182,6 +2182,36 @@ static int m_can_set_coalesce(struct net_device *dev,
>  	return 0;
>  }
>  
> +static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
> +{
> +	struct m_can_classdev *cdev = netdev_priv(dev);
> +
> +	wol->supported = device_can_wakeup(cdev->dev) ? WAKE_PHY : 0;
> +	wol->wolopts = device_may_wakeup(cdev->dev) ? WAKE_PHY : 0;
> +}

It is nice to see Ethernet WoL mapped to CAN :-)

So will any activity on the CAN BUS wake the device? Or does it need
to be addresses to this device?

	Andrew

