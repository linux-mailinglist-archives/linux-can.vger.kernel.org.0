Return-Path: <linux-can+bounces-5224-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C41BEA02F
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 17:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 502115A0A6A
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2564C32E144;
	Fri, 17 Oct 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+wcOdhZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F181B32E143;
	Fri, 17 Oct 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715049; cv=none; b=Vvi97ovhdTj0MAxCz+5mY9dHiA2ifyy1wdTjT0rNvlTwe3RmRL7zqe5bROfZwZd6lhTBhvaVnOhUXu+qFklrReakCpS63l5KkLIIkOv1xeChQXjiFVEWQ7hk7pKJ1B77xtfFKvkm0/nNqUA75z+YyFs+b4SP4tdmbpAfCX1uVVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715049; c=relaxed/simple;
	bh=p5RguzgCG4T4ocGPMm7TGRJ5ODbYr3O7fxpSuhMK/hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9Dx6i5o8rrsk0joR49jZFC+xG/PC96JUpIJCmKGBNtYAuZeRag0q48V4L5n6JAd9PCFKlY4GOf5lkfI5OcE1Ip7pHgAatsPjBoLzSuMuboNN2sHTpICcJTO1ecBXH4eE4zOA9TBn/CBVyf9vtnFi5wSHQ9c4iB4FfvEzbf1+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+wcOdhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768EFC4CEFE;
	Fri, 17 Oct 2025 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760715048;
	bh=p5RguzgCG4T4ocGPMm7TGRJ5ODbYr3O7fxpSuhMK/hE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g+wcOdhZ5jOfEzg9sMOg90LxWGDWzBVy0v1I7Unq3lR5sE/o66ZUq4FkT808KOXM4
	 iLTaKQ5k+0ZZD45agd7IHLWZecHpoOIvsXaD5IV//WXCTR7Muppw00eX7ngZ+/yA4Y
	 DRKk4Hihcfgg0ZwcZDpSHTzLzMpL7/Q4SRhrVUGfFCJKS8jzFsRhHpGeSWaZhiM7qu
	 pZF1cCYBOgV8XYpdD0IoWDxit+q870hn8JDpY2AjqPhJ6F3cMH1sIHa7ELc/M7JLZY
	 8oL6fJ4YPo8smfAUZuq3DZ59EoNC6XX+BcH9D2VmyeLdAZ+DV9V6lAIN+wOtGpwVe3
	 0sRTSbo0NHfTg==
Message-ID: <00e3d382-99e7-4b64-955a-cceffe9e471f@kernel.org>
Date: Sat, 18 Oct 2025 00:30:45 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD
 is off
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
 <20251013-canxl-netlink-v1-1-f422b7e2729f@kernel.org>
 <20251017-determined-jackdaw-of-painting-e2ff64-mkl@pengutronix.de>
 <20251017-bizarre-enchanted-quokka-f3c704-mkl@pengutronix.de>
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
In-Reply-To: <20251017-bizarre-enchanted-quokka-f3c704-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2025 at 22:27, Marc Kleine-Budde wrote:
> On 17.10.2025 10:28:38, Marc Kleine-Budde wrote:
>> On 13.10.2025 20:01:23, Vincent Mailhol wrote:
>>> Currently, the CAN FD skb validation logic is based on the MTU: the
>>> interface is deemed FD capable if and only if its MTU is greater or
>>> equal to CANFD_MTU.
>>>
>>> This logic is showing its limit with the introduction of CAN XL. For
>>> example, consider the two scenarios below:
>>>
>>>   1. An interface configured with CAN FD on and CAN XL on
>>>
>>>   2. An interface configured with CAN FD off and CAN XL on
>>>
>>> In those two scenarios, the interfaces would have the same MTU:
>>>
>>>   CANXL_MTU
>>>
>>> making it impossible to differentiate which one has CAN FD turned on
>>> and which one has it off.
>>>
>>> Because of the limitation, the only non-UAPI-breaking workaround is to
>>> do the check at the device level using the can_priv->ctrlmode flags.
>>> Unfortunately, the virtual interfaces (vcan, vxcan), which do not have
>>> a can_priv, are left behind.
>>>
>>> Add a check on the CAN_CTRLMODE_FD flag in can_dev_dropped_skb() and
>>> drop FD frames whenever the feature is turned off.
>>>
>>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>>
>> What about merging both can_dev_dropped_skb() an
>> can_dropped_invalid_skb() in the skb.c, so that there is no stub in the
>> header file anymore.
> 
> Ouch! Don't do this. We still need can_dropped_invalid_skb() for virtual
> interfaces. See commit ae64438be192 ("can: dev: fix skb drop check").

Exactly!

> But then I'm asking: Why is there the difference between virtual and
> non-virtual interface in the first place? Can we get rid of it?

The fact is that:

  - We need a function for the physical interfaces to check the
    CAN_CTRLMODE_LISTENONLY, i.e. with an access to struct can_priv.

  - We need a similar function but which work for the virtual
    interfaces which do not have a can_priv member.

So unless we do a major code refactor so that the virtual interfaces,
I do not see how we could get rid of it.

>> Someone (i.e. me) used can_dropped_invalid_skb() in a driver, that means
>> the check for CAN_CTRLMODE_LISTENONLY is missing :/ (I'll send a fix).

At least, this does not seem like a security breach like it was the
case for the missing net_device_ops->ndo_change_mtu().

> These drivers need this fix:
> 
> | drivers/net/can/bxcan.c:845:     if (can_dropped_invalid_skb(ndev, skb))
> | drivers/net/can/esd/esdacc.c:257:        if (can_dropped_invalid_skb(netdev, skb))
> | drivers/net/can/rockchip/rockchip_canfd-tx.c:75: if (can_dropped_invalid_skb(ndev, skb))

Yeah, I think that this is a pitfall, but at the same time, I do not
see how to get rid of this can_dev_dropped_skb() and
can_dropped_invalid_skb() pair. The best I can think of it to be
careful on this problem doing the code review now that we are aware
about it.


Yours sincerely,
Vincent Mailhol

