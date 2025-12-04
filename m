Return-Path: <linux-can+bounces-5820-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B68CA4D7C
	for <lists+linux-can@lfdr.de>; Thu, 04 Dec 2025 19:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B28B5303898D
	for <lists+linux-can@lfdr.de>; Thu,  4 Dec 2025 18:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFF62FFDE6;
	Thu,  4 Dec 2025 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bWIx5ghI";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lmXXx+kC"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47D36BCCE;
	Thu,  4 Dec 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871414; cv=pass; b=O/9hElNIHQq6SkEwrR9aNRQ8RzyqJG5lpR163oMAEeIyKUMgMWJWSNQmLM2sBj8sEnQ15tYx33ZWFvFdXCJjcGJI6bZuUGfRoANW3m995/xJDtqA36+42WlDG+RLMRS4HBMvFdwCGcBxofBBBVWrSoWghZ+o6lQqMVmNqUAAoPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871414; c=relaxed/simple;
	bh=6P0qnUcIOQGZkyGokg9bnaf2zGWX8aIPPvZ0o9Mc/YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrO02JL7fpXuDUH2Yp0wQXjd/l/B/yw4GuJuH17FARTKbvLOWA+U/Jj6Ef3jeQp8Y+56oC3UlJdSn4evhlvSRHPKI31CTIU5vehqHjfFOcZthVzrJoX+MrSswu8vRN3TQE5ReURyDtna68rRwE/4Q4ZOhHA93oybON5Jh+THonA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bWIx5ghI; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lmXXx+kC; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764871403; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=I6xI96awXA5Sm8769z9wZQpYYnybkghej748oXi0mBBtfIPsKLx5GDiLbuBpKtfyr1
    +s/gxS2o0QnaJVMsZSVnpYidYauypH3Dwv5zuit84+7M4Har0zTDAz3ZsCEAAdB2kygL
    1G4ejokQjngtAHoAnPf5U/TiGid7vMH7F5VSVbvJGktzlKNcOedA2XM9OJUMj9pgGs10
    qJfkdYpLI7pBJSSe5XWgJOqDAHRLUpML+IcylQpHhuhkyosqQ9H+fXv9sBMBrhcVkaBk
    B+g7YXFfYQMw+3ilYfP9l7H194hILgnbcFYYZ6KGLnWKY/ocOp8dUQMDXOBibR7rav/H
    SZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764871403;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=j6s8I3pqDNFpw53rqOo1q66UpfHQB+Vmp1966glopBU=;
    b=SVDB9TwQrY7yrfX+v5mLa4QKZhYSt3GjICN39Gc0zF2Z1w3Pa02DDCYrymlbiJ2Wc6
    +7CHB1fD9jpradT6CQ6I4+wZKiTt23YRafZigyOies2/ycAVWCh+F5PaJ2uDJ2Wup7v5
    1Q9JGMyg1j02I9JgOMYVq0ndXMp7hMdFPvz14CR9oug328wOJgqjGCwAtUmhYVrDF4Ws
    Tudj7K5deRsoj5Iy8H7LRwh7IDdq04zxyt8wsxDXRM/2hwpkpfLjcKIy3Sz+ymCAHJX/
    GuRfJkeZbE/eTN3BFuPfJA7xEoGdQ69yIwqNm9kZhOY3pv4KsXQH9bS3LywYGI2LeG0o
    wWLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764871403;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=j6s8I3pqDNFpw53rqOo1q66UpfHQB+Vmp1966glopBU=;
    b=bWIx5ghIENYvTjMyZSH1NhGlQJzPcuQfnbXRPbfibxTNmEx/GT/Z2OYRm9WW50G8gd
    XMy9LnHiO43NkpgyZEO/8JHx6sHDSQh7MSThnp4GbjYiqXYVMvm1Ug0XyN/+yKiKD2E2
    g8ke1ILT9TVwHirDk65iyMxu3Z4Fbs8Np1mZF90D6TLdlIjZIqZrZySHD4q//zW5XOWQ
    Wixm8hAMHgERYXA8dfLUGPTsbLkTTu5qArtqfl6LnD76B24h+rmKxXFKfdZtqrfEdB7A
    KpfxUeeoqJ99lHBziSCS6fHHb6ftnec2jRYb/hQoN9YnHbzs2wDNx5ST5qlv4QKzC9MU
    /DMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764871403;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=j6s8I3pqDNFpw53rqOo1q66UpfHQB+Vmp1966glopBU=;
    b=lmXXx+kCYZ/veJPj11LfB831HS4O/uCWln0SaSkvlyr7RJxnxfa1HSluP5Kx5zXqcg
    8wy9QvDdsqckdAX/RJDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461B4I3KHyx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 4 Dec 2025 19:03:20 +0100 (CET)
Message-ID: <cdcb2a82-e05f-4cdb-907b-15643f615a58@hartkopp.net>
Date: Thu, 4 Dec 2025 19:03:12 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: can: fix build dependency
To: Arnd Bergmann <arnd@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jimmy Assarsson <extja@kvaser.com>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251204100015.1033688-1-arnd@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251204100015.1033688-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Arnd,

On 04.12.25 11:00, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent bugfix introduced a new problem with Kconfig dependencies:
> 
> WARNING: unmet direct dependencies detected for CAN_DEV
>    Depends on [n]: NETDEVICES [=n] && CAN [=m]
>    Selected by [m]:
>    - CAN [=m] && NET [=y]
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

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

I'm still not sure what this patch really does but it works excellent 
and fits exactly what is intended! ;-)

Many thanks,
Oliver

> ---
>   drivers/net/can/Kconfig      | 4 ++--
>   drivers/net/can/Makefile     | 2 +-
>   drivers/net/can/dev/Makefile | 5 ++---
>   net/can/Kconfig              | 1 -
>   4 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index e15e320db476..bc074218d0ee 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
>   menuconfig CAN_DEV
> -	tristate "CAN Device Drivers"
> +	bool "CAN Device Drivers"
>   	default y
>   	depends on CAN
>   	help
> @@ -20,7 +20,7 @@ menuconfig CAN_DEV
>   	  To compile as a module, choose M here: the module will be called
>   	  can-dev.
>   
> -if CAN_DEV
> +if CAN_DEV && CAN
>   
>   config CAN_VCAN
>   	tristate "Virtual Local CAN Interface (vcan)"
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index d7bc10a6b8ea..37e2f1a2faec 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -7,7 +7,7 @@ obj-$(CONFIG_CAN_VCAN)		+= vcan.o
>   obj-$(CONFIG_CAN_VXCAN)		+= vxcan.o
>   obj-$(CONFIG_CAN_SLCAN)		+= slcan/
>   
> -obj-y				+= dev/
> +obj-$(CONFIG_CAN_DEV)		+= dev/
>   obj-y				+= esd/
>   obj-y				+= rcar/
>   obj-y				+= rockchip/
> diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
> index 633687d6b6c0..64226acf0f3d 100644
> --- a/drivers/net/can/dev/Makefile
> +++ b/drivers/net/can/dev/Makefile
> @@ -1,9 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> -obj-$(CONFIG_CAN_DEV) += can-dev.o
> -
> -can-dev-y += skb.o
> +obj-$(CONFIG_CAN) += can-dev.o
>   
> +can-dev-$(CONFIG_CAN_DEV) += skb.o
>   can-dev-$(CONFIG_CAN_CALC_BITTIMING) += calc_bittiming.o
>   can-dev-$(CONFIG_CAN_NETLINK) += bittiming.o
>   can-dev-$(CONFIG_CAN_NETLINK) += dev.o
> diff --git a/net/can/Kconfig b/net/can/Kconfig
> index e4ccf731a24c..af64a6f76458 100644
> --- a/net/can/Kconfig
> +++ b/net/can/Kconfig
> @@ -5,7 +5,6 @@
>   
>   menuconfig CAN
>   	tristate "CAN bus subsystem support"
> -	select CAN_DEV
>   	help
>   	  Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
>   	  communications protocol. Development of the CAN bus started in


