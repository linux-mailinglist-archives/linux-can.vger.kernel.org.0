Return-Path: <linux-can+bounces-694-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0154A8D6FF2
	for <lists+linux-can@lfdr.de>; Sat,  1 Jun 2024 15:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952AF1F21C85
	for <lists+linux-can@lfdr.de>; Sat,  1 Jun 2024 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7D21509AC;
	Sat,  1 Jun 2024 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1WV53eh"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF0E150999;
	Sat,  1 Jun 2024 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247459; cv=none; b=EerjX9rMtuBDQHP/DoXtnPt8Et24ILUR6WgEQjEObT8Ypvu1wwJ0YUjekNt/mkvg7v0WokuycEZiVHtOZpYPtLtQUp7VcUjA7Pw19s+Sp2XbeCzIpbDH+G41V5stxr/pl+JQ186dmZk+t87jfw0vTEuAmT8gysiD5FH5+SjDebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247459; c=relaxed/simple;
	bh=yvirPWICtc2QO7WKfB/iVO5Zi8WPqbGY2CUGPPTKTgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfGB5fxTb6HTQdbXthGHqUflOKWN9MKvTscMhKHHlsSPXZMP+GS83BySO20qRNjAP20ToGCKLAa1dNAhTrq+gxjcxLf3Icwh4ifVA05zqlvHTp3r/war1TYTdHZ4SdK3egMMqXYYrnM8IQUbBOfHZSXqE2uMIocuwuTczI5TccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1WV53eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95C1C116B1;
	Sat,  1 Jun 2024 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717247458;
	bh=yvirPWICtc2QO7WKfB/iVO5Zi8WPqbGY2CUGPPTKTgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1WV53eh1n81m2udc9OuBCt0KFuPBHRwk5fkRV4wNsbu+WrEfgbfmAEZhkmVRA2Zv
	 CgSP5lySgLwPxnPnXG0xDQs86mifJ1pRdAaF8XpUE7tEDwjuWLg7cfH7CbpadeW6Bc
	 WJOqi5Ezrc2B8ytpAfhXe0gUOJfvPF7jmuoKZ89rZCzuiRrwaB2Y6Nr5uqhhdBc/Nw
	 D6XmAfbECyD9Dr+JdoughBdHVodQPnsOx92x6nBuoX6vVVP0SVBUYHv7dlCUb/zgIP
	 PA0QFzUU9O3DSh2vgB0mYUixEyLVPQifeZRjRGIPNUOE2yII1dhAX/mHIIup0iHNJI
	 VlnYR6hSjMwVQ==
Date: Sat, 1 Jun 2024 14:10:53 +0100
From: Simon Horman <horms@kernel.org>
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] can: m_can: don't enable transceiver when probing
Message-ID: <20240601131053.GL491852@kernel.org>
References: <20240530105801.3930087-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240530105801.3930087-1-martin@geanix.com>

On Thu, May 30, 2024 at 12:57:58PM +0200, Martin Hundebøll wrote:
> The m_can driver sets and clears the CCCR.INIT bit during probe (both
> when testing the NON-ISO bit, and when configuring the chip). After
> clearing the CCCR.INIT bit, the transceiver enters normal mode, where it
> affects the CAN bus (i.e. it ACKs frames). This can cause troubles when
> the m_can node is only used for monitoring the bus, as one cannot setup
> listen-only mode before the device is probed.
> 
> Rework the probe flow, so that the CCCR.INIT bit is only cleared when
> upping the device. First, the tcan4x5x driver is changed to stay in
> standby mode during/after probe. This in turn requires changes when
> setting bits in the CCCR register, as its CSR and CSA bits are always
> high in standby mode.
> 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
>  drivers/net/can/m_can/m_can.c         | 169 ++++++++++++++++----------
>  drivers/net/can/m_can/tcan4x5x-core.c |  13 +-
>  2 files changed, 116 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c

...

> @@ -1694,21 +1732,26 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
>  		return -EINVAL;
>  	}
>  
> -	if (cdev->ops->init)
> -		cdev->ops->init(cdev);
> -
> -	return 0;
> +	/* Forcing standby mode should be redunant, as the chip should be in

Hi Martin,

A minor nit from my side as it looks like there will be another revision
anyway.

redunant -> redundant

> +	 * standby after a reset. Write the INIT bit anyways, should the chip
> +	 * be configured by previous stage.
> +	 */
> +	return m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
>  }

...

