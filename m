Return-Path: <linux-can+bounces-5768-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6345C93CC4
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 12:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD7BA345E2B
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 11:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271022580F9;
	Sat, 29 Nov 2025 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwJ9oHcy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21421E3762;
	Sat, 29 Nov 2025 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764414596; cv=none; b=bJZoj7oE8R09FD+QVoFwKI3QJvQOZrMsLu4uBBSxItAoMqSxnh0x18wif9yJ8wjzrQqYI4EX2rSZhvR0JQxTljuw8uO0ALh7oFZDGpQTcsOwQtLk5xjDZF/UZ8FdV2lRliqJKMtV2o8qHMD6h/raKklo6yVWDQmtZVbdfokJgpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764414596; c=relaxed/simple;
	bh=zYSsqfjZfBUVSBOz7KoGmYYyFzxSQpPJ8UXVJfU4EUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6+587N7ujeRd5547xA26lTRa2ZGjnjISj2dJPMWGsWjp+MEK0hcyiKf7hh++aGmY/wlXvzINvyx4Y4YoNCgSer1lMKZQ49F91LGEyxPQeb3BAqNDDG8QRHzoV1+M4ZW5nDYFEEp/9FYeoGpSrmwGmjx3MXiU9jDx/Ga8RnR3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwJ9oHcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC32C4CEF7;
	Sat, 29 Nov 2025 11:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764414595;
	bh=zYSsqfjZfBUVSBOz7KoGmYYyFzxSQpPJ8UXVJfU4EUE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jwJ9oHcy0FrC5rYzahT0JfB5J3vEqnb5yKf8lbag9/EtWkULFjv/FIXj9yvbLWBP4
	 szwMtxmF6mv83JwHYxB3aUo11+GVEu/wukssSdXT5YWawOzj+EjZ3DhsE5EBYYInCf
	 dRucr7C8bMjzi+N5D4A12sLA16fTwlGAdwFfx3DXu95ny0jNqKz2rbHWZ7kLETMF8X
	 GW/AS3+Vkpj+/oA/6+vF6et6kRV14DmA/8oZkfK8NAo9zRa9LpuGXuhwuFfsMndfGC
	 UMhzmWRvJEGs0Lt80cundlP4PqV39g6J7DzhY127VuopM7ZDLXxCIPheRur/SRjzsW
	 6n3Y1zofY1D+Q==
Message-ID: <d9431d8c-5050-4b38-a61c-cba980255c4b@kernel.org>
Date: Sat, 29 Nov 2025 12:09:49 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next v3] can: Kconfig: select CAN driver infrastructure by
 default
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 kernel@pengutronix.de, mkl@pengutronix.de, kernel test robot <lkp@intel.com>
References: <20251129090500.17484-1-socketcan@hartkopp.net>
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
In-Reply-To: <20251129090500.17484-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 29/11/2025 at 10:05, Oliver Hartkopp wrote:
> The CAN bus support enabled with CONFIG_CAN provides a socket-based
> access to CAN interfaces. With the introduction of the latest CAN protocol
> CAN XL additional configuration status information needs to be exposed to
> the network layer than formerly provided by standard Linux network drivers.
> 
> This requires the CAN driver infrastructure to be selected by default.
> As the CAN network layer can only operate on CAN interfaces anyway all
> distributions and common default configs enable at least one CAN driver.
> 
> So selecting CONFIG_CAN_DEV when CONFIG_CAN is selected by the user has
> no effect on established configurations but solves potential build issues
> when CONFIG_CAN[_XXX]=y is set together with CANFIG_CAN_DEV=m
> 
> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
> Reported-by: Vincent Mailhol <mailhol@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511282325.uVQFRTkA-lkp@intel.com/
> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
> 
> v2: In fact CONFIG_CAN_NETLINK was missing too. Reported by kernel test robot.
> v3: With the change in dev.h the compilation of the of the netlink code can be
>     avoided when only virtual CAN interfaces (vcan, vxcan) are required.
> 
> ---
> 
>  include/linux/can/dev.h | 7 +++++++
>  net/can/Kconfig         | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 13b25b0dceeb..2514a5c942e5 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -109,11 +109,18 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>  #define alloc_candev_mq(sizeof_priv, echo_skb_max, count) \
>  	alloc_candev_mqs(sizeof_priv, echo_skb_max, count, count)
>  void free_candev(struct net_device *dev);
>  
>  /* a candev safe wrapper around netdev_priv */
> +#if IS_ENABLED(CONFIG_CAN_NETLINK)
>  struct can_priv *safe_candev_priv(struct net_device *dev);
> +#else
> +static inline struct can_priv *safe_candev_priv(struct net_device *dev)
> +{
> +	return NULL;
> +}
> +#endif

As far as I can see, safe_candev_priv() is only used in raw.c. I think it would
be cleaner to just move it there and turn it into a static function.

>  int open_candev(struct net_device *dev);
>  void close_candev(struct net_device *dev);
>  void can_set_default_mtu(struct net_device *dev);
>  int __must_check can_set_static_ctrlmode(struct net_device *dev,
> diff --git a/net/can/Kconfig b/net/can/Kconfig
> index af64a6f76458..e4ccf731a24c 100644
> --- a/net/can/Kconfig
> +++ b/net/can/Kconfig
> @@ -3,10 +3,11 @@
>  # Controller Area Network (CAN) network layer core configuration
>  #
>  
>  menuconfig CAN
>  	tristate "CAN bus subsystem support"
> +	select CAN_DEV
>  	help
>  	  Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
>  	  communications protocol. Development of the CAN bus started in
>  	  1983 at Robert Bosch GmbH, and the protocol was officially
>  	  released in 1986. The CAN bus was originally mainly for automotive,


Yours sincerely,
Vincent Mailhol


