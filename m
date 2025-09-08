Return-Path: <linux-can+bounces-4507-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7C8B48801
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 11:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F18188766B
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 09:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226F81FF1BF;
	Mon,  8 Sep 2025 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qZOSjSzQ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jFkMYhKt"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40646224247
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322773; cv=pass; b=Y9ciESejEQPVK93IfZECSkWaNplufkC0jCg+GkGNuvIm7noAFV4oHBIGNmbNkHcWPiwBuAaFiOpJsV/3ez1INmrqOFalgOXiDSMWoKBSGW/d4WaKuo1YqQNxE/azVSKjsEmyA8RLOLnkHTFMiR98FoxvmUasfaxv1pgnaxa0AAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322773; c=relaxed/simple;
	bh=aRB8TyUeSvIn0ardUVYzya3ueO8l/gGj+se/rwqyXYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lY2lr9kIULW/vyHiOkeCJ13fUYGqkMBzg6k5gYcabXGhDYC5UO6oYRWGBy9i9GONDav5n8+X6dDxdbnlIf7Htxe9w2KEZgUHlg2iTGmhINWkbhSrm6MErdoMvKGBgMDIsQubHYxin6X4duk/UXuLHGvD1RuZ/3fiqhnzuMBOUik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qZOSjSzQ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jFkMYhKt; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757322045; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=R3zw44Ab2E9TmMV4vYNsJhuDtuzZtVyudxhEY8avXr7uRYtuWvR/uezWGBsWF3nxai
    np4uC60mqH6GHmsOTXXCm6Yja3FKKKd3vbFJ+TrKnb27nK3E6HsnSBnnERU/t0LZL6Qq
    h6t5h8RPrZJjAGwvgw/ftYK/1E6RCwv2iZCZBEJgVAag32L9hprCfGkH4y0QPjHk4S8s
    zRVNd9Kynm2WGo+bXVjx1lXetezMVXJRRspTWWy87z7+w8zxMJIvm4rvLijyhUJM7SW+
    wzvNLCekG17yZz3yTUcGrkSUSZV0Gb/gR30WkmT4cJH7PHDA1earvbikouIK225vRjXe
    oqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757322045;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hpM/+ZS3x2F59YmobnAQj/CODMTqb8xVBuGIO69YWmc=;
    b=di5474wSLhQRJ1GUiR0Zdx8xX6UsyASAPlPvHQyzebbFvfd+QpLY/tfV1uMPs1VVRe
    n/0ljIVMeAEZh6SsLZ2vAENmDadhuCpE1NYvt3BL1polAxc6Bg+poT3grf9fUKKzPfg0
    2g2F8M0eNYJ06lKOmdW1Icyp9Zf5FPWYqwbnZomGSSYS09LUB4wYFS4kaIBanN46+A4e
    yeQeoYkIvW4M67BIAZ+BRjlv5ayIJskN6rs7NypwX8+6NQKcBqz0jX2XPAYxPlZRego5
    xSb0X8TMcaq7mND2LDPuYmPCJpJa5TZsV+iBwfDzilo+vqLrlJrQ6/i+dhQqh3cVz12d
    iZng==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757322045;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hpM/+ZS3x2F59YmobnAQj/CODMTqb8xVBuGIO69YWmc=;
    b=qZOSjSzQZE3sPRWNg+zZRkpx4keX8xHxU05XkXsmqJ0BrfXj41xWe4TNthoYXXnrgg
    Q4Rc6WvcFNKq+76XNBNud6tHe7Qk/eH4ZcUPJjYA+REZQ3f1gwRlVyoF4PFwQ6Cvr/q9
    9pKbfoPxSkJoqAckEPFRyTXFzRMZGFocKQqOkwWq0Am5Uf6OVaFCOhutaANDhRq03DxC
    ssWAmCGgXKlgQ09hoZ87DnSVcrlmJMKVtAu3ajwamQySWM2vlD1Zt7tqku3IHwHtzkU7
    QYXTmsOqM+vgsBGwuS2MoYM7B5cWXA+GA+oHBfLnYSY4Q9ORVNM+IYTLyMLt0ezgZxEK
    iUiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757322045;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hpM/+ZS3x2F59YmobnAQj/CODMTqb8xVBuGIO69YWmc=;
    b=jFkMYhKtjC/Gx0wh7y3qyyH/2TB5doQu/tPnZGikhYGe1pU1b5X4tIKC5IiUOwBlBl
    L7YVt/c9vWTY597oCmAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d36118890jY4k
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 8 Sep 2025 11:00:45 +0200 (CEST)
Message-ID: <4e380c2b-f48d-4bd5-bc8d-3bfd85fc0d2f@hartkopp.net>
Date: Mon, 8 Sep 2025 11:00:39 +0200
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
 <49e0970f-1a10-438f-b9ae-afcc75edaccd@hartkopp.net>
 <5edbe004-767f-4a41-9454-f4bbf8f5b590@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <5edbe004-767f-4a41-9454-f4bbf8f5b590@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08.09.25 06:07, Vincent Mailhol wrote:
> On 08/09/2025 at 04:03, Oliver Hartkopp wrote:
>> Hi Vincent,
>>
>> can_dev_dropped_skb() is not what you are looking for.
>>
>> Whether a CAN frame fits to the CAN device is checked in raw_check_txframe() here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/can/
>> raw.c#n884
>>
>> Or do I miss anything?
> 
> My point is not if it fits or not. Of course, if CAN XL is activated, CAN FD
> frames would fit.
> 
> My point is that activating CAN XL should not imply that CAN FD is also
> activated. Having CAN FD off and CAN XL on is a valid configuration.
> 
> Let me take an example, imagine that I configure my device with CAN FD off and
> CAN XL on, for example:
> 
>    ip link set can0 up type can bitrate 500000 \
>       fd off \
>       xl on xbitrate 10000000 tms on
> 

Ah, ok.

> Where is the check that, with this configuration, the device is not CAN FD
> capable and that the FD frames should be dropped? When I try this under my dummy
> driver, the FD frames pass the raw_check_txframe() check, reach the driver's
> xmit function and pass the can_dev_dropped_skb() checks. And that is the problem.
> 
> So, yes, the frame "fits" in above configuration and no buffer overflows nor any
> other security problems occurred. But CAN FD is off so the frame should have
> been discarded at some point.

Yes. I think your original patch with

 > +	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb))
 > +		goto invalid_skb;

should do that job. Btw. I would also add a netdev_info_once() here too, 
so that we can give a heads up to the user.

> The same issue goes for probing. How do you detect if an interface is CAN FD
> capable? By checking that its MTU is at least CANFD_MTU? For example like this
> in cangen?
> 
>    https://github.com/linux-can/can-utils/blob/master/cangen.c#L802-L805
> 
> If I do this check, it would wrongly detect that my interface is CAN FD capable
> when in fact, it is turned off in the configuration. So, under my previous
> example, cangen is also fooled into believing that it can send CAN FD frames
> when in reality the option is turned off.
> 
> So, these are my point:
> 
>    - how do you configure a vcan so that CAN FD is off and CAN XL is on?

This is not possible due to the missing flags (netlink) infrastructure 
known from the real hardware drivers. And IMHO this is also not needed 
to be implemented for a virtual CAN interface which does not have those 
restrictions.

>    - when CAN FD is off and CAN XL is on, how do you drop CAN FD frames in the
>      kernel TX path ?

As you proposed in your extension for can_dev_dropped_skb() - with some 
more comments and a netdev_info_once(), of course ;-)

We might also try to access the CAN flags from the device in the network 
layer but this will become very ugly for a comparably unimportant 
use-case IMO. And it won't help for PF_PACKET users creating their own 
SKB content either.

>    - in the userland, how do you probe that an interface is CAN FD capable or
>      not?

Test ifr.ifr_mtu for

== CAN_MTU -> CC IF -> CAN CC
== CANFD_MTU -> FD IF -> CAN CC & CAN FD
 >= CANXL_MIN_MTU -> XL IF -> CAN CC & CAN FD & CAN XL

There is no way to have CAN CC with CAN XL without CAN FD right now as 
we can not detect this without accessing the netlink configuration.

Best regards,
Oliver


