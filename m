Return-Path: <linux-can+bounces-598-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B989B8BFD7B
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 14:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7626D2834D6
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 12:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA12A53E27;
	Wed,  8 May 2024 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMqHaLHI"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD226F068;
	Wed,  8 May 2024 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172245; cv=none; b=VuZpWnPdkQ/wV5EiFRO2KunPaFpI2zL9rqoxIBUHV0wlh+h9GTfuBcGlpZNfveNeHyiYulWj+fzFiPqLrzaKQjILa4MjS8+K/9JSwbhanV8rAjnDhLfLX4GxhuzHMefFlK6ge+gOxyd+O1nBZDEJXI73Wd+TVjK+tEfoK7hdlTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172245; c=relaxed/simple;
	bh=D/MdFRhwmEy4kwhpm2dB7s4ocO/FTSaGT0pU8iZ/zdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeRkjDm1PcSH/FRUcUMhjopwOKD31r1wKBBsMaABv2QX+L4iRDJAf5q/LB90MEtBmo6TjW9frleFg05eUGf40pO5NcvimEqCrIZdkodfeGbo73c6TMAGaITthCZWeY/KUy9R6zXTq0hyRkt74sWpw7/3/2Ulla3NsQY7Yb/gb5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMqHaLHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB38FC113CC;
	Wed,  8 May 2024 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715172245;
	bh=D/MdFRhwmEy4kwhpm2dB7s4ocO/FTSaGT0pU8iZ/zdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMqHaLHIOUTJC21oahLKMiVt2A2dBKLs/VMXaV9KeWKBqfivSLtUqXe3iQIvUxHky
	 Ziku1RlKVNgkAWcT3SqlLfO0wtrFhKY2/SHDmu22Fs2rtGXxVCtNs5zQQKCohv0Y3N
	 n9C1d8OuYDmEkYzc+AHi3ZPsyPMsfsqrnd/5CYg+FFHoS0Ouw5V/es1kebzvew+du0
	 8sE6wqM0gKmEbBv+6jqV7WqVbB6r07bHkPlNimO5jLElCVdPgBEkfLo6I6wFY/TNuE
	 eU2P3wrqNzyL3CExm422j1H2JJXfUtQn5bbKZnCsbJ7x5npm41jw0DxJp0MgXAgJk/
	 MjfQcWDZ0E0oQ==
Date: Wed, 8 May 2024 13:44:00 +0100
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
Subject: Re: [PATCH v2] can: m_can: don't enable transceiver when probing
Message-ID: <20240508124400.GE1736038@kernel.org>
References: <20240501124204.3545056-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501124204.3545056-1-martin@geanix.com>

On Wed, May 01, 2024 at 02:42:03PM +0200, Martin Hundebøll wrote:
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
> 
> Changes since v1:
>  * Implement Markus review comments:
>    - Rename m_can_cccr_wait_bits() to m_can_cccr_update_bits()
>    - Explicitly set CCCR_INIT bit in m_can_dev_setup()
>    - Revert to 5 timeouts/tries to 10
>    - Use m_can_config_{en|dis}able() in m_can_niso_supported()
>    - Revert move of call to m_can_enable_all_interrupts()
>    - Return -EBUSY on failure to enter normal mode
>    - Use tcan4x5x_clear_interrupts() in tcan4x5x_can_probe()
> 
>  drivers/net/can/m_can/m_can.c         | 131 +++++++++++++++-----------
>  drivers/net/can/m_can/tcan4x5x-core.c |  13 ++-
>  2 files changed, 85 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c

...

> @@ -1694,8 +1708,12 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
>  		return -EINVAL;
>  	}
>  
> -	if (cdev->ops->init)
> -		cdev->ops->init(cdev);
> +	/* Forcing standby mode should be redunant, as the chip should be in

Hi Martin,

A minor nit, to consider fixing if you send a v3 for some other reason:
redunant -> redundant.

> +	 * standby after a reset. Write the INIT bit anyways, should the chip
> +	 * be configured by previous stage.
> +	 */
> +	if (!m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT))
> +		return -EBUSY;
>  
>  	return 0;
>  }

...

