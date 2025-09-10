Return-Path: <linux-can+bounces-4623-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD43B50F50
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 09:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68774E0CF0
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 07:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE2307482;
	Wed, 10 Sep 2025 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZOc1kUBr";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QlY1AK/R"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F912C2368
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489290; cv=pass; b=VtVt8wL2Iv19YAND2QO1+T41x06Yew5N0CW+3PldeO4fmXE9GUtSQ/s7hN1py40e1kQ9HEYSn+zV3AZwCwru3lHuls9YG0anjeAqCiWokP/6oO3aikVHL5jEwHDFeUeXKHX4IWXYmyRy9yKIEEPxztCPHToc9D8XNnnXulCj2G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489290; c=relaxed/simple;
	bh=d6j3uwcWJeHAD3u5Fu5KH+SDIu/ObMlP3O9ZqWu7qFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XYm/x1rjPk7pe+ivXRhTrovIUWWNUHQ5nPmfgKqtftV0+NKcxtbzGIm0aOHRY2I2Zh91btdlbtLMNkFCueUw5go68kbTHHSfdxyov+WBLDntH26OPHJzsJdZu1a1nS3kFiaFm7l3YONHI2jTblEgEZhK2s3hq+MzDnpap3pDRmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZOc1kUBr; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QlY1AK/R; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757489280; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IjGYcmeAECvOmGwDW2YZRhr8HMf2s05VLUjV218MA9qbnKnSooYoPc/ERIdDr+/5gc
    dUozguLAkE57DyEZdn7qkbukSv9q260kvucR0hL8gnvr6y5IEIZjhxXzxm7KpztN1brp
    +DGYhhu7lTCynGM90HAj9KKv+uVtyYJl8ksZSilcW70gP5NrijruWLDlobaxNJPvk+8K
    wzoaBZNJkyLWLFfGlv81Qv+q07wUpcFj3FjAEyXD07Ebe77GkGYoulY2VBmwAChAlUVe
    By48s/jwv+KzsBcTXKa52Pa74HrauhzCy2B+P/qnKFBd3x8shkR9DOCnwXeWlNr5z9lG
    XEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757489280;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=L1nDd/9kuk6mEBFcBdBlRBH92QCDuu24E0B4/UcnuJg=;
    b=dxCViuTeSTXyQsEZXNc4Fu+nyifvIAgQa1UqeGwYnc3aBBPgnVesNhE5BLOVqrmfix
    9FO/TCSPT/bOcdByXcJuUVYcGj8K2NAKTwG9kXktWYhS86ShsIKiJXpMcLcWGy4qBxKs
    azo4R0OHHPi1WDfsV8dvxVznjRHQUVQSkQwLBSMihkVFEijQmfDTEsMBKdBPpPjYm7K0
    0lkTwXGNIkYAa1uQs7TWHJAKefk9XsT9BggVVKnLsmhPE8ZsVdU4hWoHlXP82wk4cibb
    QTIBgSvDb5IrdOhWa0lSAvKwYlnu+oAweJFBd+K17kENd/8Qi5ywCeOorWnoXLh2x2Jv
    cGRw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757489280;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=L1nDd/9kuk6mEBFcBdBlRBH92QCDuu24E0B4/UcnuJg=;
    b=ZOc1kUBrsI2iwM7fpcp6yveBkz8YQo2ftaqh9p0hm+pFK5wWr6E8CKmXDS9PbLQhuR
    7vW52i/oOK6xlmMjDynUw3GPXQJsmKP5W0yh3AlCrZqVrA/X7seakfSyoyv2Zox/Zh6a
    UVRDJLd3JPG+LswZdjYsc74oCD/lSM0hh2B8W3blMecq3cVB5kpAktRvnSCn1sNs8uj8
    A9tb+Fx5syoBy+ghpLCtNE5+I73XxIWevotasSF0+lp6X6vxYjgztP6/rzTgG/HP7rAH
    TrEzDnRxA9zp4bgos+iVB8v4xc8xB1osUwmok/y8KEPgrUwPv1lOutMh86f45I8CrnkO
    mySw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757489280;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=L1nDd/9kuk6mEBFcBdBlRBH92QCDuu24E0B4/UcnuJg=;
    b=QlY1AK/R/VDOm7tlm4GSwlSCdEwHP7O1yO9/AnPvy74zPa/NxNlNOT/Mz+5naTFuqW
    /w9uWfRBg8TG85gkMKAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d36118A7S0nnZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Sep 2025 09:28:00 +0200 (CEST)
Message-ID: <20c5c885-0bab-4c42-82c6-e98571a5d19d@hartkopp.net>
Date: Wed, 10 Sep 2025 09:27:59 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/2] can: reject CAN FD content when disabled on
 CAN XL interfaces
To: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
References: <20250909092433.30546-1-socketcan@hartkopp.net>
 <20250909092433.30546-2-socketcan@hartkopp.net>
 <f7b59c7c-30ad-4cf4-ad0e-bff0e39b3337@hartkopp.net>
 <7578f44d-d85c-473e-8e7a-65d1fc974e68@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <7578f44d-d85c-473e-8e7a-65d1fc974e68@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10.09.25 07:13, Vincent Mailhol wrote:
> On 10/09/2025 at 01:36, Oliver Hartkopp wrote:
>> Hi Vincent,
>>
>> On 09.09.25 11:24, Oliver Hartkopp wrote:
>>
>>
>>> -static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff
>>> *skb, int mtu)
>>> +static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
>>> +                      struct net_device *dev)
>>>    {
>>>        /* Classical CAN -> no checks for flags and device capabilities */
>>>        if (can_is_can_skb(skb))
>>>            return CAN_MTU;
>>>    -    /* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
>>> -    if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb) &&
>>> -        (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
>>> -        return CANFD_MTU;
>>> +    /* CAN FD -> needs to be enabled in a CAN FD or CAN XL device */
>>> +    if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb)) {
>>> +        /* real/virtual CAN FD interface */
>>> +        if (dev->mtu == CANFD_MTU)
>>> +            return CANFD_MTU;
>>> +        if (can_is_canxl_dev_mtu(dev->mtu) &&
>>> +            can_dev_ctrlmode_fd_on(dev))
>>> +            return CANFD_MTU;
>>> +    }
>>
>> I've simplified the above code and rewrote the commit message in v6
>>
>>>        /* CAN XL -> needs to be enabled and a CAN XL device */
>>>        if (ro->xl_frames && can_is_canxl_skb(skb) &&
>>> -        can_is_canxl_dev_mtu(mtu))
>>> +        can_is_canxl_dev_mtu(dev->mtu))
>>>            return CANXL_MTU;
>>
>> We might also discuss if we create a can_dev_ctrlmode_xl_on(dev) function to
>> check if the CAN XL interface has CAN_CTRLMODE_XL enabled.
> 
> I checked ISO 11898-1:2024 again and the relevant wording I can found is in
> §6.6.21.4.1:
> 
>    When error signalling is disabled, the node shall transmit and
>    receive only XLFF frames. It shall not transmit EF, OF and RF, nor
>    DFs in CBFF, CEFF, FBFF and FEFF.
> 
> TLDR; Classical CAN is deactivated when error signaling is off.
> 
> So, I think that we also need the same logic for the Classical CAN. The nuance
> is that instead of using CAN_CTRLMODE_CC (which does not exist), we can check
> CAN_CTRLMODE_XL_ERR_SIGNAL. Note that CAN_CTRLMODE_XL_TMS implies that error
> signalling is off, so no need for extra checks on TMS. This is what I have in
> mind at the moment.
> 
>    static inline bool can_dev_cc_on(struct net_device *dev)
>    {
>    	struct can_priv *priv = safe_candev_priv(dev);
> 
>    	/* Classical CAN frames are always allowed on virtual interfaces */
>    	if (!priv)
>    		return true;
> 
>    	/* When error signalling is off only CAN XL frames are allowed */
>    	return !(priv->ctrlmode & CAN_CTRLMODE_XL) ||
>    		(priv->ctrlmode & CAN_CTRLMODE_XL_ERR_SIGNAL);
>    }
> 
>    static inline bool can_dev_fd_on(struct net_device *dev)
>    {
>    	struct can_priv *priv = safe_candev_priv(dev);
> 
> 	/* CAN FD is allowed on virtual interfaces if it fits the MTU */
>    	if (!priv)
>    		return dev->mtu == CANFD_MTU;
> 
>    	return can_dev_cc_on(dev) && (priv->ctrlmode & CAN_CTRLMODE_FD);
>    }
> 
>    static inline bool can_dev_xl_on(struct net_device *dev)
>    {
>    	struct can_priv *priv = safe_candev_priv(dev);
> 
> 	/* CAN XL is allowed on virtual interfaces if it fits the MTU */
>    	if (!priv)
>    		return dev->mtu == CANXL_MTU;

		return can_is_canxl_dev_mtu(mtu);

The MTU of CAN XL interfaces might vary.

> 
>    	return priv->ctrlmode & CAN_CTRLMODE_XL;
>    }
> 
> (the above is not yet tested, so beware of silly errors!)
> 
>> Currently my patches are based on Linus' rc5 tree where CAN_CTRLMODE_XL is not
>> defined. But I can rebase it on your b4/canxl-netlink branch if you like it.
> 
> I still want to finish the XL preparation series before moving to the actual thing.
> 
> You can do what is convinient for you:
> 
>    1/ rebase on b4/canxl-netlink branch but I take no claims if your code breaks
>       after one of my force push.

I will do this with my next attempt.

>    2/ add the flags you need in netlink.h. I will then chery pick your patches in
>       my series when ready and take care of any conflict for you!
> 
> I am going to send the v2 of my XL preparation series. Hopefully we can finalyse
> it soon so that we can focus on one sigle topic :)

ACK.

Best regards,
Oliver


