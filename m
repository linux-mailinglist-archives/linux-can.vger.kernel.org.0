Return-Path: <linux-can+bounces-4503-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB21B47D03
	for <lists+linux-can@lfdr.de>; Sun,  7 Sep 2025 21:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831E11898376
	for <lists+linux-can@lfdr.de>; Sun,  7 Sep 2025 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACE727A462;
	Sun,  7 Sep 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kcAQ99rC";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tCIYdycn"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303FA10F1
	for <linux-can@vger.kernel.org>; Sun,  7 Sep 2025 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757273257; cv=pass; b=Z2Dv9OrfGFzdsh+JFIzVrfVX5+0FGwYEnLsLrmF9LWaAjYmveStouQAZLiYMa3IbBIW0jTaUd5eTX5Izn9XzlOKDQbMTxh14Ye8c8iKGhqXnzkzKz52/YAaSyWbQWR2SjXcn57UrEcfjScn9BzTjwaQnFh4sK2uU1jW/wey+DUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757273257; c=relaxed/simple;
	bh=FIE1z2CLqR8b/wAJTmo8lcF5jmX8GuB+JcSFD79j9eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lH/1QSi1Xbcfv3Ko4x79EunVnH751JgXpAlBOvYmXLrJ2c2iLdVpR0RZz3K5OBS7bE8YcVAnEVu40mvHLBH4ljKTwJ8jEJcL5NOqXgz6H00pxlEBJnbq174x4PbJgIdAFV+/Pz/jqf7So9Tm4GygtGN7/9DtoBBh26Or6m3CVEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kcAQ99rC; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tCIYdycn; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757271808; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=K2QfPhR6PX0uLEY/HAJSPPGKZi4QuCMY42kCToHZQw2YVBdtXT+yIvSaQJglaTIfWX
    R4W2Ib+ICGto87Z+uv2JB8GKSemDX1mPyQQ0tRtaQSDh91bc4JQoNcCPG7uDjW/fSo4N
    2RM4aO2McWXzu2O9inw/01mlPxcLCBmHCeRL41YGzzPi+NlyL+kjb4rRaxQ2KnZ5nRoq
    tOodp9wG2CrhnIcJW8Y3c6Hp3bD6QNJECrdzOLhdOyXLSnvEeHvi/Xe0refxfLAc1oBp
    vAen2uRMzyQ7PAaG+RmGLI22BVxasiPMqO5fCrt+hAYam6V5AJtgXSqV0trsyEJGLgsg
    HI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757271808;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ywjbaAfWih6F7T5CkWIs7T1JQoiJ2vvokWN1bN00Ohs=;
    b=Ub2S8z9rCO8lmm51mUBHtBoZDmq+HAY3bTgM0iYcjp85N+J4AuwtLpxo2e+hirllri
    HZxt2gmOm2LSSoQCbL22K8+WyqicL+kyaQisSY57YZDm67GRxsYH5wBXQeRupEpYRovJ
    N93wRCaUE2vQwoKOmUQ8iPJgNv++qXDs43T/JLMocjlN73LmBxh7v6xSCA8xNDqlDuXj
    9J8Hp3vdCVnPAYTZgkWS2iB/Qk1t/eS/N1N5G0zBYk8Kl2LqXp9YfFpmrioPMqBZg6Ms
    hD+hTd5Wo+f13cXeeAmD6IFmBrMjEuCN7uoWsd8Koy/vgBFETCX/hM2RDh5ShEAsen9C
    3/Og==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757271808;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ywjbaAfWih6F7T5CkWIs7T1JQoiJ2vvokWN1bN00Ohs=;
    b=kcAQ99rCrUIwrxcAcDsQfQgzos9Sur2plzNAsCOvWBSk8RyrBIckZ3dwChZhw/rYSD
    S1AEgTLunwRVxLTASlkVdh0Ut4nNMy/p9w8BrlpkqHli30aQsw8FLEOd58vSNVCD15Uk
    u0fhi+VzfF6PVg3lrxQsarbU7g5pqRcT3Js8jVv5HsD18ujW32/zxIJZ91tYy0WWHfyL
    KskLJd5U7qeTqUAsxl1V5RBZeBr52Txohzdr+AkYQxS6pXKJFrQlRAww/4oVeFxMQ6JJ
    W1w3jWnGJi+uPU2a9AVlV4UpWsdc4vcdmXwgZfpeHfYqly0H+ygTCzogfOYuAXi9oqvK
    Tzxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757271808;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ywjbaAfWih6F7T5CkWIs7T1JQoiJ2vvokWN1bN00Ohs=;
    b=tCIYdycnmu4eNyapam3J4HyrlghoUTEEB+uf30Qm2UFLKXy22AcYDpanSjphmqO8ED
    lKtj+gY1tmRBlV4qrkDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d361187J3SVvY
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 7 Sep 2025 21:03:28 +0200 (CEST)
Message-ID: <49e0970f-1a10-438f-b9ae-afcc75edaccd@hartkopp.net>
Date: Sun, 7 Sep 2025 21:03:22 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD
 is off
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20250907080504.598419-2-mailhol@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250907080504.598419-2-mailhol@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

can_dev_dropped_skb() is not what you are looking for.

Whether a CAN frame fits to the CAN device is checked in 
raw_check_txframe() here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/can/raw.c#n884

Or do I miss anything?

Best regards,
Oliver

On 07.09.25 10:05, Vincent Mailhol wrote:
> Currently, the CAN FD skb validation logic is based on the MTU: the
> interface is deemed FD capable if and only if its MTU is greater or
> equal to CANFD_MTU.
> 
> This logic is showing its limits since the introduction of CAN XL.
> Indeed, an interface which is configured to support CAN XL but not CAN
> FD would have its MTU set to CANXL_MIN_MTU which is greater than
> CANFD_MTU, thus fulfilling the CAN FD check condition. That is to say,
> any CAN XL interface currently appears as CAN FD capable with no way
> of configuring or probing this at the skb level.
> 
> Because of the limitation, the only non-UAPI-breaking workaround is to
> perform the check at the device level using the CAN_CTRLMODE_FD flag.
> Unfortunately, the virtual interfaces (vcan, vxcan) are left behind
> with this approach.
> 
> Add a check on the CAN_CTRLMODE_FD flag in can_dev_dropped_skb() and
> drop FD frames whenever the feature is turned off.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> While testing, I encountered a potential issue when:
> 
>    - CAN FD is off
>    - CAN XL is on
> 
> My understanding is that this is allowed and, even more, it is
> sometimes mandatory when, for example, disabling error signalling or
> when using the transceiver mode switch (TMS) or both.
> 
> It seems to me that the current implementation is incapable of
> handling this case at the skb level for the reasons listed in the
> patch body.
> 
> I have two ideas to fix this issue:
> 
>    1. above patch which assumes that we are OK not being able to set
>       CAN XL on and FD off on virtual interfaces
> 
>    2. add some information to the skb itself. I have not looked at this
>       in detail. One potential idea would be to use:
> 
>         sk_buff->protocol
> 
>       as a bitfield. Whenever the MTU is greater than CANFD_MTU, below
>       logic would apply:
> 
>         - if sk_buff->protocol & CAN_SKB_CC is true, classical CAN is
>           supported
> 
>         - if sk_buff->protocol & CAN_SKB_FD is true, CAN FD is
>           supported
> 
>         - if sk_buff->protocol & CAN_SKB_XL is true, CAN XL is
>           supported
> 
>       with any of the combinations above accepted.
> 
>       Of course, because this comes as an afterthought, it is an UAPI
>       breaking change for any existing CAN XL code. Also,
>       sk_buff->protocol was not designed for this, making this solution
>       an ugly hack.
> 
> Thanks for your comments.
> ---
>   include/linux/can/dev.h | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 9a92cbe5b2cb7..5053d5bc20c99 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -164,12 +164,18 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
>   	if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
>   		netdev_info_once(dev,
>   				 "interface in listen only mode, dropping skb\n");
> -		kfree_skb(skb);
> -		dev->stats.tx_dropped++;
> -		return true;
> +		goto invalid_skb;
>   	}
>   
> +	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb))
> +		goto invalid_skb;
> +
>   	return can_dropped_invalid_skb(dev, skb);
> +
> +invalid_skb:
> +	kfree_skb(skb);
> +	dev->stats.tx_dropped++;
> +	return true;
>   }
>   
>   void can_setup(struct net_device *dev);


