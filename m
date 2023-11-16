Return-Path: <linux-can+bounces-23-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8167EE6BB
	for <lists+linux-can@lfdr.de>; Thu, 16 Nov 2023 19:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030991C20AD0
	for <lists+linux-can@lfdr.de>; Thu, 16 Nov 2023 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BA046444;
	Thu, 16 Nov 2023 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvrzIWe8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B330CE7;
	Thu, 16 Nov 2023 18:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5AAC433C9;
	Thu, 16 Nov 2023 18:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700159369;
	bh=CNm1AYvgH24i5zs7rXuhysROqKGaoDkC4TrTERZzmbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvrzIWe8wpTFrBo2kBoC3ir+8BuiR3x9ErONqHu5L3iLShOerbPK8QshrBqK5Ukyx
	 vlm93+L/ZIV5VqHX/+JyVZ6NgT+Ul9EbjTFFCgfE8BrWZLB1SMpn5ZeBKIpS0PMj65
	 rWi02IIdlaW/TmjIVmYD4iGEo3mznyxCPKzqLv3L42Kfl4OgIuDY7pQFcwHLXsjJfo
	 MKYDPwYmggEe+xKPCf31d/5+G7y6FnXO3Kz3hKjRYvc5/x4iVlHkwyJK9LOT8iSovv
	 busPkZWAl7t/h5t8qbv6eAxw4LJFJ8oI5dobE8RbeZ9+unbs3ONQC9ypaMkESTjXwP
	 BOXwyhwWFZUTQ==
Date: Thu, 16 Nov 2023 18:29:23 +0000
From: Simon Horman <horms@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
	Michal Simek <michal.simek@amd.com>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH] net: can: Use device_get_match_data()
Message-ID: <20231116182923.GH109951@vergenet.net>
References: <20231115210129.3739377-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115210129.3739377-1-robh@kernel.org>

On Wed, Nov 15, 2023 at 03:01:28PM -0600, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

...

> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index abe58f103043..f17fd43d03c0 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -20,8 +20,8 @@
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/skbuff.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
> @@ -1726,7 +1726,6 @@ static int xcan_probe(struct platform_device *pdev)
>  	struct net_device *ndev;
>  	struct xcan_priv *priv;
>  	struct phy *transceiver;
> -	const struct of_device_id *of_id;
>  	const struct xcan_devtype_data *devtype = &xcan_axi_data;

Hi Rob,

Here devtype is initialised.

>  	void __iomem *addr;
>  	int ret;
> @@ -1741,9 +1740,7 @@ static int xcan_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	of_id = of_match_device(xcan_of_match, &pdev->dev);
> -	if (of_id && of_id->data)
> -		devtype = of_id->data;

And in the old code devtype was conditionally re-initialised here,
if a match with data was found.

But in the new code devtype is re-initialised unconditionally.

Possibly I am missing something obvious, but it seems that either this
should somehow be made conditional, or the initialisation to &xcan_axi_data
should be dropped.

> +	devtype = device_get_match_data(&pdev->dev);
>  
>  	hw_tx_max_property = devtype->flags & XCAN_FLAG_TX_MAILBOXES ?
>  			     "tx-mailbox-count" : "tx-fifo-depth";
> -- 
> 2.42.0
> 

