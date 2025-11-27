Return-Path: <linux-can+bounces-5757-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DF8C904CE
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 23:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1F014E3366
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 22:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6501131771B;
	Thu, 27 Nov 2025 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="o0nzz5NX";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+MiMqUEV"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746730DECA;
	Thu, 27 Nov 2025 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764282978; cv=pass; b=XyGGaO67mRGr+zxvebc06bhhEzSQxT9pkYU6ENEB6uWfRzll4jLBxhG6D90ytbrVYyGmyx5nJxcmWEhlioYhZvhaIMjHscdYVWcDVgLWYdvq+jeC36jwdctp59MmraJ4r+YRnFok2jUWz5nwHEx3iN+e4QjrfgRvKoV1SCmrDO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764282978; c=relaxed/simple;
	bh=u6mJN2vjdct+Bs6RnxMQNlulsQMLJcsDOD9vRrxNFUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7a7STGO2Tlbi2opgXTWMqR11GmFYb5ybRbpbVoDKoiAzG7aWIGRqi+rVaEHZee+uMtMfnxnxbQ9CLLfKiAqNFXUUU47YwQI6nEOmqSWAIh9/m4h8uD/4v97uxM8+1ZitE1cuNVcUISo5q5/XHH+HGE5RePyXEFSsCGsnwLiLDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=o0nzz5NX; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+MiMqUEV; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764282954; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fPpuMGqAtIUwBdunNeFqVDnZam/eaBEknZg4DO7xlyLT4uA74nK19BYA/mXsC6UBiM
    0OzlgooEc0l9AaNHoTNcTzjKzmsiTccH0uOwqVUBmXKUmCdHt93SvHBHQ2OgXizUbX3m
    Iop5xu3vGb+TS/2iCzZZEkn6cpD1LVekLljkred0GT+odGzVUbv6uVlkR4/+PdETW2j1
    XLXGRkYqqUXN4wVXD0DTKDtMOyR4BVgRmtsiJEKs8gRXDqSIXk1zGW4M4IdBWWVHKYbX
    fnNXXZUbbMV8LHkMTxsAuUJRCjVnBlMZxCJ+vXhPQdt/0TDtMNlE8IQmyLaHkZ+C5CnE
    ssFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764282954;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=d/2qhAn7ChobYccm13YIzYEeCkPvjItIpj3cWZ3sdc8=;
    b=Sls7dCrmmAyHNvx11SWrQvdi2M1Fl8KwBMVEbyRy6f9+yycY2r21Wx4x03/oDEX3tc
    kR+EdByeHKEfjzFrzDiJOCBt7iNIavnJR+P3L0wWVLkoymNMMv7Uw4Ek3PKGTJRg76gi
    hlBr/HcGfIDf1l6LFQHgZ6fPnp3hj7aWIThejFbvlePhg6P6bJ7jKbHOVzGtF/QnyWRL
    6zVnE0WGh58mTwU3aH5UCsEgx2sZnPGjlWkGdp4lYgnrTfouh00HSEcjOY+7FcRX5raw
    WCQNSSAu1riZzNzaIdk7ZM6jlhxvUwKhMNqiOclcri+kptwNW99HfcVWIpQ4o8C2i/UI
    gY5w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764282954;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=d/2qhAn7ChobYccm13YIzYEeCkPvjItIpj3cWZ3sdc8=;
    b=o0nzz5NXjkPiCZT2gTcf0O8mcu8QJhU83gmrrj2avkgS/Eh8q7ICK4jgEUYmIAZDq5
    UCEC0yB3e8RsYiHXcyuWwLwsNTv5iJMGiuIBDwP/lvavFmbBN1FQCiC3wm6FaHK6qBgm
    /FBazA6LdTd6Y6dr/C6r1KUG6KenK1GqkK1vRx9bXX46JU5IC5/HGMH90lpijUrpGXOW
    pRc876Jn+7zz6Bvd3znaJqP30B9DhTFWFrGqkxn6WRwTci9Cu9I97hsaoiFnGdjI5kYS
    S3+48VzvS6BgvfcvilmyXLm0YD8EsXgDsOFy9scbOwD2xJXSnm9+av+AdqE+k2JsADR1
    g9aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764282954;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=d/2qhAn7ChobYccm13YIzYEeCkPvjItIpj3cWZ3sdc8=;
    b=+MiMqUEVHNwHJVgxUJFMfxULpM3t1X+aWECtzbJGvD6C/1HW/AEMyVI/e66zYDJHJV
    fPAw7BfFR8qxPGPPp6AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ARMZsdI8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 27 Nov 2025 23:35:54 +0100 (CET)
Message-ID: <f3393f50-02a8-4076-9129-6e8a1b8356f2@hartkopp.net>
Date: Thu, 27 Nov 2025 23:35:48 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] can: raw: fix build without CONFIG_CAN_DEV
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>
References: <20251127210710.25800-1-socketcan@hartkopp.net>
 <20251127-inquisitive-vegan-boobook-abac0e-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251127-inquisitive-vegan-boobook-abac0e-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27.11.25 23:22, Marc Kleine-Budde wrote:
> On 27.11.2025 22:07:10, Oliver Hartkopp wrote:
>> The feature to instantly reject unsupported CAN frames makes use of CAN
>> netdevice specific flags which are only accessible when the CAN device
>> driver infrastructure is built.
>>
>> Therefore check for CONFIG_CAN_DEV and fall back to MTU testing when the
>> CAN device driver infrastructure is absent.
>>
>> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
>> Reported-by: Vincent Mailhol <mailhol@kernel.org>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> That's not sufficient. We can build the CAN_DEV as a module but compile
> CAN_RAW into the kernel.

Oh, yes that's better.

I had a fight with CONFIG_CAN_DEV with my first patch too.
That's why I sent a v2 some seconds ago.

> 
> This patch does the same as your's but only with a single ifdef in the
> header file.
> 
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 52c8be5c160e..14d58461430e 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -111,7 +111,14 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>   void free_candev(struct net_device *dev);
> 
>   /* a candev safe wrapper around netdev_priv */
> +#ifdef CONFIG_CAN_DEV
>   struct can_priv *safe_candev_priv(struct net_device *dev);
> +#else
> +static inline struct can_priv *safe_candev_priv(struct net_device *dev)
> +{
> +        return NULL;
> +}
> +#endif

Will send a v3 with your suggestion.

Many thanks,
Oliver

> 
>   int open_candev(struct net_device *dev);
>   void close_candev(struct net_device *dev);
> 
> Marc
> 


