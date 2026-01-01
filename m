Return-Path: <linux-can+bounces-5978-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70119CECFFC
	for <lists+linux-can@lfdr.de>; Thu, 01 Jan 2026 13:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D413005195
	for <lists+linux-can@lfdr.de>; Thu,  1 Jan 2026 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361C22C0F62;
	Thu,  1 Jan 2026 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7yqcYB1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057782773D8;
	Thu,  1 Jan 2026 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767269559; cv=none; b=T66RBO66FSocASR0Aa6JUGaNpG5Pd9IkXc1ecwlJs1UQfRv96g1ZMiJxNjiy6WgdLy6d1PEYP0boHLYHExPdfVupunyuPr8TVowKbA9RUOi1LlgBwLuTLKz9DIStlmeHpQuqTNl8krF94jk4R+3rIxRBZ47Bxp1rLR7iwqhQw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767269559; c=relaxed/simple;
	bh=twTmdX32akwxQI5NUrmsrOlchdtaTJjigYNdzguzqyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXvunZ3XXMmIMVHO7vvW6OR1GzcnBqib+fs2JYHXKeF+k5Dt3N9wiWr/6j/vdgncMia0Dx6mbDharXHKH/d7OnSvsxY4/YSPGn0MLjTQEx2poGhFWfeNSHXEV/EQmxSi1WvfiBUJB1IXXWnAlU6yhckNC0XHd9x6bHx6AMqY9Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7yqcYB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07044C4CEF7;
	Thu,  1 Jan 2026 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767269558;
	bh=twTmdX32akwxQI5NUrmsrOlchdtaTJjigYNdzguzqyY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h7yqcYB1+jYcqUlJ76scSrm+NGJoxw1RAu0N7hHs7ZzoRhWMZkuUCIq07xtPUXBkw
	 lZV4aR8gR+UZ9yI2jrHR210iIgmdryDO+iwT0YZy20TkwReHLAi07Wl+JqcpcwnT1m
	 w73HfTYgZjWTUoYenkwpcGeraNjWbFKpy6owoUfb59RyYZWuabNpP3w0K/Ua/gClZl
	 zdAEpaeGiFcT9Km5mhh9ANsHDLHboacFr+ANOTjs0tPGF6R7xtKh4F+6/tEnRPaNS0
	 wzGF/N9iETezQd+MTdrwdQGqvjkjhzMqkKzLJBToLGtQI9TzvAKl6tl3HsosoYH/te
	 341MPKI3lVMWA==
Message-ID: <d058f82b-2e2f-4353-8518-2cc9e15f7a98@kernel.org>
Date: Thu, 1 Jan 2026 13:12:32 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] can: dummy_can: add CAN termination support
To: Rakuram Eswaran <rakuram.e96@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org
References: <20251231-can_doc_update_v1-v1-0-97aac5c20a35@gmail.com>
 <20251231-can_doc_update_v1-v1-1-97aac5c20a35@gmail.com>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20251231-can_doc_update_v1-v1-1-97aac5c20a35@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/12/2025 at 19:13, Rakuram Eswaran wrote:
> Add support for configuring bus termination in the dummy_can driver.
> This allows users to emulate a properly terminated CAN bus when
> setting up virtual test environments.
> 
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---
> Tested the termination setting using below iproute commands:
> 
>   ip link set can0 type can termination 120
>   ip link set can0 type can termination off
>   ip link set can0 type can termination potato
>   ip link set can0 type can termination 10000
>   
>  drivers/net/can/dummy_can.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/dummy_can.c b/drivers/net/can/dummy_can.c
> index 41953655e3d3c9187d6574710e6aa90fc01c92a7..418d9e25bfca1c7af924ad451c8dd8ae1bca78a3 100644
> --- a/drivers/net/can/dummy_can.c
> +++ b/drivers/net/can/dummy_can.c
> @@ -86,6 +86,11 @@ static const struct can_pwm_const dummy_can_pwm_const = {
>  	.pwmo_max = 16,
>  };
>  
> +static const u16 dummy_can_termination_const[] = {
> +	CAN_TERMINATION_DISABLED,	/* 0 = off */
> +	120,				/* 120 Ohms */

Nitpick: no need to explain that disabled means "off", the first comment
can be removed. Also, to be consistent with how the can.bitrate_max and
can.clock.freq are declared, you can add the unit just next to the value.

	static const u16 dummy_can_termination_const[] = {
		CAN_TERMINATION_DISABLED,
		120 /* Ohms */,
	};

(above comment is notwithstanding).

> +};
> +
>  static void dummy_can_print_bittiming(struct net_device *dev,
>  				      struct can_bittiming *bt)
>  {
> @@ -179,6 +184,16 @@ static void dummy_can_print_bittiming_info(struct net_device *dev)
>  	netdev_dbg(dev, "\n");
>  }
>  
> +static int dummy_can_set_termination(struct net_device *dev, u16 term)
> +{
> +	struct dummy_can *priv = netdev_priv(dev);
> +
> +	netdev_dbg(dev, "set termination to %u Ohms\n", term);
> +	priv->can.termination = term;
> +
> +	return 0;
> +}
> +
>  static int dummy_can_netdev_open(struct net_device *dev)
>  {
>  	int ret;
> @@ -243,17 +258,23 @@ static int __init dummy_can_init(void)
>  	dev->ethtool_ops = &dummy_can_ethtool_ops;
>  	priv = netdev_priv(dev);
>  	priv->can.bittiming_const = &dummy_can_bittiming_const;
> -	priv->can.bitrate_max = 20 * MEGA /* BPS */;
> -	priv->can.clock.freq = 160 * MEGA /* Hz */;

Don't add unrelated changes to your patch. Your patch should do one
thing (here: add the resistance termination). If you want to reorder the
existing lines, that should go in a separate clean-up patch. But here,
there is no need to touch those lines, so just drop this reorder.

>  	priv->can.fd.data_bittiming_const = &dummy_can_fd_databittiming_const;
>  	priv->can.fd.tdc_const = &dummy_can_fd_tdc_const;
>  	priv->can.xl.data_bittiming_const = &dummy_can_xl_databittiming_const;
>  	priv->can.xl.tdc_const = &dummy_can_xl_tdc_const;
>  	priv->can.xl.pwm_const = &dummy_can_pwm_const;
> +	priv->can.bitrate_max = 20 * MEGA /* BPS */;
> +	priv->can.clock.freq = 160 * MEGA /* Hz */;
> +	priv->can.termination_const_cnt = ARRAY_SIZE(dummy_can_termination_const);
> +	priv->can.termination_const = dummy_can_termination_const;
> +
>  	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
>  		CAN_CTRLMODE_FD | CAN_CTRLMODE_TDC_AUTO |
>  		CAN_CTRLMODE_RESTRICTED | CAN_CTRLMODE_XL |
>  		CAN_CTRLMODE_XL_TDC_AUTO | CAN_CTRLMODE_XL_TMS;
> +
> +	priv->can.do_set_termination = dummy_can_set_termination;
> +
>  	priv->dev = dev;
>  
>  	ret = register_candev(priv->dev);

Aside from the above remark this is OK. Please send a v2 with that last
remark addressed. You can also add my review tag:

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


