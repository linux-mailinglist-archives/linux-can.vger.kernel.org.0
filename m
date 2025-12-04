Return-Path: <linux-can+bounces-5821-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E368ACA5B15
	for <lists+linux-can@lfdr.de>; Fri, 05 Dec 2025 00:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24BAC30D78DA
	for <lists+linux-can@lfdr.de>; Thu,  4 Dec 2025 23:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840242E2299;
	Thu,  4 Dec 2025 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQFLA2OZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA182DF153;
	Thu,  4 Dec 2025 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764891020; cv=none; b=MQKmYde3woeg9PC7xlQ9R85BYPS26Nal7OZJX/ol3tcMqPxWYLUCvqRDvFWinlWzocfIZzGyzLc7B3XomAUnMGNA1s9BZkiskzDx4MYZgsq5GQBYnds77KZYz85wBB7AZUT1s8GYLDYqdRhjizhcdYVQoNQ8MRxXD1TXdr0h064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764891020; c=relaxed/simple;
	bh=b0bX+ipw72voahWBDdjBTh41r2Iakrsx9U8gyFYpvaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Utml5I7/Kmetb88j0LiTc2JuVUZXaCzonI3zZol3gdwx8OuTcp+Tfxp2s2uj9ExYe4LYoahM2CaKbLxO88lUnA9xolHa6FS/ISGsbKEs6bmrL3K7/hcBk+nWoA4KUWBTBhkabcKSAvv7NTCO3n4ftsTnhl/87aYj476HO9sQ4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQFLA2OZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F107CC113D0;
	Thu,  4 Dec 2025 23:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764891019;
	bh=b0bX+ipw72voahWBDdjBTh41r2Iakrsx9U8gyFYpvaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eQFLA2OZ99fVki33qRaREIDpmSvFjv+abfaC1oq3/192idkRIfpldxEpfJsrpDTvB
	 2d75AetKcWkIBFADgacvnD2pu55r9sipo1JeXdqcRUxeJ3FDuXuBv+HflCzuiMukXe
	 Dqmi8s5KR9sLwIWDMXuva8RUNXxi1S2NGXb9arP48BiPsKqse/2vbKIs54q7S++5H3
	 xcuJ8qSadZfhSbvWzcnMydTI+DwThR93RCC03qcz5/e6kGkZhfBhlkT3AdvZZGm4K+
	 Q3I1KhnsRaN7gTZQwjahOrxnQxmFlwjkm7VN+UL3RPlqcXD6jQ5bVteNNcysvoV+g5
	 G4DaSL/2GIQZA==
Message-ID: <5de9b33e-6129-4765-95a7-e3e12de1f8cd@kernel.org>
Date: Fri, 5 Dec 2025 00:30:14 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: can: fix build dependency
To: Arnd Bergmann <arnd@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Jimmy Assarsson <extja@kvaser.com>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251204100015.1033688-1-arnd@kernel.org>
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
In-Reply-To: <20251204100015.1033688-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Arnd,

Thanks for the fix!

On 04/12/2025 at 11:00, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent bugfix introduced a new problem with Kconfig dependencies:
> 
> WARNING: unmet direct dependencies detected for CAN_DEV
>   Depends on [n]: NETDEVICES [=n] && CAN [=m]
>   Selected by [m]:
>   - CAN [=m] && NET [=y]
> 
> Since the CAN core code now links into the CAN device code, that
> particular function needs to be available, though the rest of it
> does not.
> 
> Revert the incomplete fix and instead use Makefile logic to avoid
> the link failure.
> 
> Fixes: cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/can/Kconfig      | 4 ++--
>  drivers/net/can/Makefile     | 2 +-
>  drivers/net/can/dev/Makefile | 5 ++---
>  net/can/Kconfig              | 1 -
>  4 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index e15e320db476..bc074218d0ee 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
>  menuconfig CAN_DEV
> -	tristate "CAN Device Drivers"
> +	bool "CAN Device Drivers"
>  	default y
>  	depends on CAN
>  	help
> @@ -20,7 +20,7 @@ menuconfig CAN_DEV
>  	  To compile as a module, choose M here: the module will be called
                                  ^^^^^^^^
After this change, it is not possible to "choose M" for CAN_DEV anymore. I would
suggest to modify (or remove) the above sentence.

>  	  can-dev.> -if CAN_DEV
> +if CAN_DEV && CAN
              ^^^^^^
Is this needed? CAN_DEV depends on CAN, so the condition

  CAN_DEV && !CAN

should not be reachable.

>  config CAN_VCAN
>  	tristate "Virtual Local CAN Interface (vcan)"
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index d7bc10a6b8ea..37e2f1a2faec 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -7,7 +7,7 @@ obj-$(CONFIG_CAN_VCAN)		+= vcan.o
>  obj-$(CONFIG_CAN_VXCAN)		+= vxcan.o
>  obj-$(CONFIG_CAN_SLCAN)		+= slcan/
>  
> -obj-y				+= dev/
> +obj-$(CONFIG_CAN_DEV)		+= dev/
>  obj-y				+= esd/
>  obj-y				+= rcar/
>  obj-y				+= rockchip/
> diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
> index 633687d6b6c0..64226acf0f3d 100644
> --- a/drivers/net/can/dev/Makefile
> +++ b/drivers/net/can/dev/Makefile
> @@ -1,9 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -obj-$(CONFIG_CAN_DEV) += can-dev.o
> -
> -can-dev-y += skb.o
> +obj-$(CONFIG_CAN) += can-dev.o
>  
> +can-dev-$(CONFIG_CAN_DEV) += skb.o
>  can-dev-$(CONFIG_CAN_CALC_BITTIMING) += calc_bittiming.o
>  can-dev-$(CONFIG_CAN_NETLINK) += bittiming.o
>  can-dev-$(CONFIG_CAN_NETLINK) += dev.o
> diff --git a/net/can/Kconfig b/net/can/Kconfig
> index e4ccf731a24c..af64a6f76458 100644
> --- a/net/can/Kconfig
> +++ b/net/can/Kconfig
> @@ -5,7 +5,6 @@
>  
>  menuconfig CAN
>  	tristate "CAN bus subsystem support"
> -	select CAN_DEV
>  	help
>  	  Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
>  	  communications protocol. Development of the CAN bus started in


Yours sincerely,
Vincent Mailhol


