Return-Path: <linux-can+bounces-1634-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0226F99AC53
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 21:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76BD0B21202
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 19:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9310F1D078A;
	Fri, 11 Oct 2024 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahY7ztNv"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE041BD4E7;
	Fri, 11 Oct 2024 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673206; cv=none; b=qUla/OqQzFRtl0J2ez8OdZaSXuOdi04VGA7auIfr5adFnXYj1q0w2QjenNlhPbr2NX1eaLa4HKmltEF8M3XW2JY//Q7zBGcUnenHfNgQWvQrefUNPLH7LrvEdli6p1ePUns+E4nRsXrcEc1POT0///vssfEjXbEiNqmipfl25/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673206; c=relaxed/simple;
	bh=a84u9nTZ3sCDcURG6NNOgGWd1sDBA3xGdpK8P8jUnag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apUH4Tn8KDvcB1B99GSBR3qCi2McDAltGEcY3IIIpYEyKHPI8IdNF2/fqalkWUkOYw/gyGSrjSKOySiSZEK5mlpa4G0J9s50Pu9FQA+HRx4mHdiY1YJyoPaxaU1wCqqEkt2cDgKIPEOo7GEx12yrBv5Tk/rSnqgAOdyf6ws4ekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahY7ztNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8944AC4CEC3;
	Fri, 11 Oct 2024 19:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728673205;
	bh=a84u9nTZ3sCDcURG6NNOgGWd1sDBA3xGdpK8P8jUnag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahY7ztNvTTetEplHcaY8bCL4JU7+eKJkpcwiGJvQZaC4cMapaXfQuxagwMLLJxHha
	 xFjwj5ikLuNRcLJ1pNrhpQnsSEkP5vtKx7JYcTJ4M5MIjmGBg0lTSfqL5l39Qkeik8
	 L4pjhKvmt+LcIpUsGysVpSOKc2LDX3aQmg+ZleHnz/qY4VQ7w5rhmFmzYrHE970D1N
	 WJiIi43l5zjrUe5CjN3uz0vw7JfExbvfGxCXVeQ/L6tU7K97WawMsMSeU+yetPaeeg
	 ivMmF7eM08D+Jk88NwhxzhkxPAgh8iT8k+RavqfWFA5zF5h043w4gZ3x3bm61/3jui
	 Fecn1nuqgCTBw==
Date: Fri, 11 Oct 2024 19:59:29 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Vishal Mahaveer <vishalm@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 3/9] can: m_can: Map WoL to device_set_wakeup_enable
Message-ID: <20241011185929.GA53629@kernel.org>
References: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
 <20241011-topic-mcan-wakeup-source-v6-12-v3-3-9752c714ad12@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-topic-mcan-wakeup-source-v6-12-v3-3-9752c714ad12@baylibre.com>

On Fri, Oct 11, 2024 at 03:16:40PM +0200, Markus Schneider-Pargmann wrote:
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
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index a978b960f1f1e1e8273216ff330ab789d0fd6d51..29accadc20de7e9efa509f14209cc62e599f03bb 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2185,6 +2185,36 @@ static int m_can_set_coalesce(struct net_device *dev,
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
> +
> +static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
> +{
> +	struct m_can_classdev *cdev = netdev_priv(dev);
> +	bool wol_enable = !!wol->wolopts & WAKE_PHY;

Hi Markus,

I suspect there is an order of operations issue here.
Should the line above be like this?

	bool wol_enable = !!(wol->wolopts & WAKE_PHY);

> +	int ret;
> +
> +	if ((wol->wolopts & WAKE_PHY) != wol->wolopts)
> +		return -EINVAL;
> +
> +	if (wol_enable == device_may_wakeup(cdev->dev))
> +		return 0;
> +
> +	ret = device_set_wakeup_enable(cdev->dev, wol_enable);
> +	if (ret) {
> +		netdev_err(cdev->net, "Failed to set wakeup enable %pE\n",
> +			   ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +

...

