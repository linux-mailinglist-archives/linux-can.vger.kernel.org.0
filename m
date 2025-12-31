Return-Path: <linux-can+bounces-5971-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8951DCEC4CC
	for <lists+linux-can@lfdr.de>; Wed, 31 Dec 2025 17:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DFCA3009400
	for <lists+linux-can@lfdr.de>; Wed, 31 Dec 2025 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739E296BB7;
	Wed, 31 Dec 2025 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BNZYR/XP";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="92UUlWCS"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE8F296BA8
	for <linux-can@vger.kernel.org>; Wed, 31 Dec 2025 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767200240; cv=pass; b=CyEonLwwSfu/pRWTn/6nIHzp1agRbXY9r6JjxMsUptm1f4L32F6I3IQzbiuw4XTdfW8701m1sHJPwW+gz2J1xOQLMhl4sV+LZU9/y/DmBzDjqovek/kdezAPlcO2B15cMtoH/absPGXZZAiQ2IYnS02/6rHBEdDrbXTMU1WCztY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767200240; c=relaxed/simple;
	bh=Cggd/LFu+f42SN05n2fiuhO6TpZ63aqW+5ZhcbiMlYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXFqBYeTwB4/qJWLw7VzY52EtcHaxaf8EMOBCtIyF3TUWvYpWNWcBg1trFKSisdy8TwByMvXLx0jrTOZkpgthvMXeJdVuUmvvwm/Af5Ncj0ILGHXfR45xbXaHoDzfM6jPMgwYFDsvZdL2FVuY8OubvCqbZlHiV1BDpm8zq+roKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BNZYR/XP; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=92UUlWCS; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767200044; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Vdf58vcGpmreGTTJmMTUCOEZOTWFo4izBCZrvVMc2m8Se9vFjgf/oNcu6N41m9Zufe
    00OE5TIgctxRC6pep5ZIWNMmtVz3cpXElqjjjg9ZjP5j+9HNul8YJjNIHoZY/49I/e7a
    k/ClJMfGw/fGbXhXJ/+224jwpHrhyw6xSb6dVdjLsG+DbUjYXfBBSpefRNf0t6HmnuPJ
    z5vTtI5gS75AKVhuPz6f3tsVps9ei40J1+lpT94TMw1HJU+KjOUIE0Bsv/IRsqSarDsP
    JIVTGffFs103ZqPzJWgVDaK8p0VP4FTB6fEOU8MFBeLwHO/f3w6xmSQ8j+AAmxi1xB+d
    tB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767200044;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=F9mOCnqWYUMTVk5o64vzSV7Q+OvUm1BySBXl3njVOgE=;
    b=gFBAATqhVqgWT+1QSCLeTA4FfK8qMRtis+Dpi3nO4D0W9pqV+X23doTuubttI4qpb2
    Uk+ND46ENKahK1VFLDiS3wYNBwfY8JVwbzc0USz8tG/xe9XGC/F+rN52dhG4m3k04m0N
    L7XNP4IxlwaAvjNwAcNg+nrjQqNrjzZs7jDAWI2kA9QzxikgS1qmgbdvumgAlf96ppGp
    zg9RJDr2X+arL3PZpxcdtPngA2X6NLENvCqkUrcuh4kU1Jb76JOI7L7FUoSzGUK3Q0rg
    QDmiB8Zpy6slUOTRTcF8st8f/1CrGoyloHgaJV/RZ8KJhcfAuwPMsmqqRbQR+EbiX4/E
    PNhQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767200044;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=F9mOCnqWYUMTVk5o64vzSV7Q+OvUm1BySBXl3njVOgE=;
    b=BNZYR/XPw3j5fXr7UoXpBuu94jFI2cUHRbLGCL/Vrr8Dv4K1X5WLOHJVISbHTJIMgp
    ODHahwD3qv5hMUUJjkuDQPj4DW1b56EcRtIqz57uRsMs2zi4BNNPQFNWceq7TEVHgyc2
    CuVpXJun4VyagKfez6WMNAEsRsJWtCRPUv3HyX4pjffaIx96bvep1LqNoqCTj5O1klqs
    1IEpBAYhrF35sich96cDrsD2gY4sNjft7Js0oBR55mz68eL9gu49XZoyqSTEz5vi/2jh
    CweZFspRk5Pi86Hk7u8ALbvf8pAEBNVzDmj/Pjjw+MAmH1YTQeQY8f3O7BCeds6At6Xm
    aU9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767200044;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=F9mOCnqWYUMTVk5o64vzSV7Q+OvUm1BySBXl3njVOgE=;
    b=92UUlWCSMOUV/cxjSSh/deTeBuM8UcE26dWIP9mZo7haFIBpwsHrnphUDmmvlnxSek
    o9wsLfU16kYhdbSfSWDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b1BVGs3aGB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 31 Dec 2025 17:54:03 +0100 (CET)
Message-ID: <e7958be4-5b81-4574-b47a-f5d4bc957871@hartkopp.net>
Date: Wed, 31 Dec 2025 17:53:58 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: propagate CAN device capabilities via ml_priv
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Vincent Mailhol <mailhol@kernel.org>
References: <20251231163356.1978-1-socketcan@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251231163356.1978-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31.12.25 17:33, Oliver Hartkopp wrote:

>   static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
> index fdc662aea279..76e6b7b5c6a1 100644
> --- a/drivers/net/can/vcan.c
> +++ b/drivers/net/can/vcan.c
> @@ -128,10 +128,23 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
>   		consume_skb(skb);
>   	}
>   	return NETDEV_TX_OK;
>   }
>   
> +static void vcan_set_cap_info(struct net_device *dev)
> +{
> +	u32 can_cap = CAN_CAP_CC;
> +
> +	if (dev->mtu > CAN_MTU)
> +		can_cap |= CAN_CAP_FD;
> +
> +	if (dev->mtu >= CANXL_MIN_MTU)
> +		can_cap |= CAN_CAP_XL;
> +
> +	can_set_cap(dev, can_cap);
> +}
> +
>   static int vcan_change_mtu(struct net_device *dev, int new_mtu)
>   {
>   	/* Do not allow changing the MTU while running */
>   	if (dev->flags & IFF_UP)
>   		return -EBUSY;
> @@ -139,10 +152,11 @@ static int vcan_change_mtu(struct net_device *dev, int new_mtu)
>   	if (new_mtu != CAN_MTU && new_mtu != CANFD_MTU &&
>   	    !can_is_canxl_dev_mtu(new_mtu))
>   		return -EINVAL;
>   
>   	WRITE_ONCE(dev->mtu, new_mtu);
> +	vcan_set_cap_info(dev);
>   	return 0;
>   }
>   
>   static const struct net_device_ops vcan_netdev_ops = {
>   	.ndo_start_xmit = vcan_tx,
> @@ -160,10 +174,11 @@ static void vcan_setup(struct net_device *dev)
>   	dev->hard_header_len	= 0;
>   	dev->addr_len		= 0;
>   	dev->tx_queue_len	= 0;
>   	dev->flags		= IFF_NOARP;
>   	can_set_ml_priv(dev, netdev_priv(dev));
> +	vcan_set_cap_info(dev);
>   
>   	/* set flags according to driver capabilities */
>   	if (echo)
>   		dev->flags |= IFF_ECHO;
>   
> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index b2c19f8c5f8e..3cc53ba0b8ff 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -165,10 +165,11 @@ static void vxcan_setup(struct net_device *dev)
>   	dev->ethtool_ops	= &vxcan_ethtool_ops;
>   	dev->needs_free_netdev	= true;
>   
>   	can_ml = netdev_priv(dev) + ALIGN(sizeof(struct vxcan_priv), NETDEV_ALIGN);
>   	can_set_ml_priv(dev, can_ml);
> +	can_set_cap(dev, CAN_CAP_CC | CAN_CAP_FD | CAN_CAP_XL);

vxcan can change its MTU analogue to vcan => v2 patch

Regards,
Oliver


