Return-Path: <linux-can+bounces-5927-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8303CDAAD8
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 22:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 231203011A44
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 21:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAD6221554;
	Tue, 23 Dec 2025 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llgJuZfU"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF61200C2;
	Tue, 23 Dec 2025 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766525635; cv=none; b=FQGQCKiB/RbxnWvPeM80Xwg4t+hfcK1mhMLWt/UOWRbMtuKu+8sQ4KBMe1JbyRgwjMTmyj2Lye44bTngUM4haJFd5xo0dJBel7Ssyp5X+IP2IMiYZElfaLoF9lj6xPM/dy2nvdyM44sEv62wIDrNCOmmqXtQgfiKHrsvRw0eMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766525635; c=relaxed/simple;
	bh=Yd1r7EvvwBZDyF74Ev/wcb27opJoUMZE7SnmnADxxmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i86cJxgoA6XUtnyHWneok7CkOb7hEqx4E6h9el/lPuAvnH2zEHjmrvdQ5KHDpnp+p8Xixrq1Z/emLWmDsxiltj+9nIIgP83TFbucu3JH6cV9GpfVJBMXJ1k4QRfNG99lO+G+8/k1GQogG3Zsec4gZOB3piVHb/IQeYNBCSPxPvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llgJuZfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F4CC113D0;
	Tue, 23 Dec 2025 21:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766525635;
	bh=Yd1r7EvvwBZDyF74Ev/wcb27opJoUMZE7SnmnADxxmc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=llgJuZfUrApzkL6ogtqYL7GAX1IabRcyHd4o+3p2Gc9oIOHUECx0loEXLjvE/UfzK
	 tpfm1vBUT5E4Np82xagzdrOgmqEKgI5jD2wyMQZD21yWIkkDFHU4tFW6FdPOtF0NEU
	 G/ZJQHX+pL33ku/BjtQ/nmB9fJ9VCPsCJKtUirhgTbFncWBrmHO0vm9XtVBlwsSBZ1
	 dwMDAjT9LDALuK3N2nihtdajwJhPpS4kXsm9F8gVZmcO/OcTQzlX1T49fErXCQmD7Q
	 vmJRJof0j80CnfvPnWoLq6EfBm0sTLMyBT8lNKJqHnsje9zRoQZ+ZUrhk+0dnDNIAk
	 ZAM7CRJMUivZg==
Message-ID: <a85b8659-d4c8-443b-abb1-ae557a2a9896@kernel.org>
Date: Tue, 23 Dec 2025 22:33:50 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] can: dummy_can: add CAN termination support
To: Rakuram Eswaran <rakuram.e96@gmail.com>, linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, socketcan@hartkopp.net, mailhol@kernel.org,
 khalid@kernel.org, skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linux.dev
References: <20251127191808.144723-1-rakuram.e96@gmail.com>
 <20251127191808.144723-2-rakuram.e96@gmail.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20251127191808.144723-2-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rakuram,

Thanks for the patch. My comments are only on the cosmetic aspect.

Le 27/11/2025 à 20:18, Rakuram Eswaran a écrit :
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

When you test, do not forget to also try incorrect values ;)

  ip link set can0 type can termination 100
  ip link set can0 type can termination potato

(I think that the code is correct, just see this as a generic
comment).

>  drivers/net/can/dummy_can.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/net/can/dummy_can.c b/drivers/net/can/dummy_can.c
> index 41953655e3d3..2949173547e6 100644
> --- a/drivers/net/can/dummy_can.c
> +++ b/drivers/net/can/dummy_can.c
> @@ -23,6 +23,21 @@ struct dummy_can {
>  
>  static struct dummy_can *dummy_can;
>  
> +static const u16 dummy_can_termination_const[] = {
> +	CAN_TERMINATION_DISABLED,	/* 0 = off */
> +	120,				/* 120 Ohms */
> +};
> +
> +static int dummy_can_set_termination(struct net_device *dev, u16 term)
> +{
> +	struct dummy_can *priv = netdev_priv(dev);
> +
> +	netdev_dbg(dev, "set termination to %u Ohms\n", term);
> +	priv->can.termination = term;
> +
> +	return 0;
> +}

The driver has a kind of structure:

  - first the const bittiming struct declarations
  - then the dummy_can_print_*() functions
  - finally the actual code

Try to preserve this structure when adding your changes.

>  static const struct can_bittiming_const dummy_can_bittiming_const = {
>  	.name = "dummy_can CC",
>  	.tseg1_min = 2,
> @@ -250,6 +265,12 @@ static int __init dummy_can_init(void)
>  	priv->can.xl.data_bittiming_const = &dummy_can_xl_databittiming_const;
>  	priv->can.xl.tdc_const = &dummy_can_xl_tdc_const;
>  	priv->can.xl.pwm_const = &dummy_can_pwm_const;
> +	
> +	/* Advertise software termination support */

This comment doesn't add much value. You may omit it.

> +	priv->can.termination_const = dummy_can_termination_const;
> +	priv->can.termination_const_cnt = ARRAY_SIZE(dummy_can_termination_const);
> +	priv->can.do_set_termination = dummy_can_set_termination;

Here also try to maintain so kind of order: your declaration of
dummy_can_termination_const is before the other const struct
declarations, but the priv->can assignment is done after the other
assignments. Not a big deal but it is nicer to keep the declaration
and the assignments in the same order.

>  	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
>  		CAN_CTRLMODE_FD | CAN_CTRLMODE_TDC_AUTO |
>  		CAN_CTRLMODE_RESTRICTED | CAN_CTRLMODE_XL |


Yours sincerely,
Vincent Mailhol


