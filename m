Return-Path: <linux-can+bounces-2116-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978D29D2C45
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 18:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209C31F2108F
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3041D0F5F;
	Tue, 19 Nov 2024 17:15:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3E1CF295;
	Tue, 19 Nov 2024 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036523; cv=none; b=uewj943XesWTKOv+syeazWP3Zp11NK/0Xd5/Ot7wzV2Z4FdhuJLYE4muZP4HrrZuBZRceAcfci9Gm1lzwosILDpRwJZOQBufUIU6PMX+/qvLMZzI7ctXhAFb51g+A/zEJVXgc5C41ChEIZGtBhPmR5jVaKswTWnaJlOHKqXOxKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036523; c=relaxed/simple;
	bh=8m3ZZi4o+QZHfGFuP6jLlTgPOar+DPpL7DY+1QJhrwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuitBaDRERqPopYfYRj9zssJUuqHVvOJAkuUSx8/DmAJEX9GILra30TZGOAQ0Dnwfxc68W3aqa1nnGO8Vu3+xtOF3lG1DvCUlt5GCKtFYOs1z4bpuNNNLd53p2tKuL3Cs8z+b6IXCEguFpo5wdK5MOBCJBhbroRIzP/u5nh0XiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 7AA7C102FA6;
	Tue, 19 Nov 2024 17:15:15 +0000 (UTC)
Message-ID: <4621cc30-92d7-4b07-8058-a1d677f28135@enpas.org>
Date: Wed, 20 Nov 2024 02:15:07 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] can: can327: Clean up payload encoding in
 can327_handle_prompt()
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241119003815.767004-1-max@enpas.org>
 <84998b1d-8b3e-4956-b7fd-323e4999dc7c@wanadoo.fr>
Content-Language: en-US
From: Max Staudt <max@enpas.org>
Autocrypt: addr=max@enpas.org; keydata=
 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
 PsRBqTJGs7jw5gOWMMchFaemEnEJtg==
In-Reply-To: <84998b1d-8b3e-4956-b7fd-323e4999dc7c@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/19/24 16:41, Vincent Mailhol wrote:
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> I left comments on the comments. If you have time, it would be wonderful
> if your comment on start_xmit() could be moved to can_dev_dropped_skb()
> in a separate patch.
> 
> The code is good, so if such rework is not feasible, I am happy to take
> it as-is.

Thanks for the review! Yes, if you are fine with taking it, I suggest 
doing so now, and if I ever get to rework the comments, then I can look 
into this as well.


The thing is, when writing this patch, I tried to put myself in Dan's 
shoes. That is, someone unfamiliar with the code who is now looking at 
it. There's some string manipulation going on (uh-oh!), and we need to 
ensure that no buffers are overrun. Naturally, as a reviewer, I'd like 
to know that indeed, frame->len <= 8. Hence why I added a comment to 
that effect.

But security is not about trusting me, it's about proof. That's where 
the comment in _xmit() comes in. And I have to say, while it's easy to 
see that can_dev_dropped_skb() ensures len <= 8 in case of ETH_P_CAN, 
the guarantee that we only receive ETH_P_CAN packets in the first place 
is a whole different story. The MTU checks took a while for me to track 
down and understand, so my intention is to leave some breadcrumbs for 
the next poor soul digging into can327. Frankly, I think that's a sign 
that the otherwise lean CAN stack has finally accumulated some tech debt 
(or maybe I'm just bad at reading code), but oh well.

Now, as you say, this is sort of valid for all CAN drivers, and hence it 
should be in some centralised documentation. Agreed. But then again, for 
this driver, I wanted to make a point that we're dealing with ETH_P_CAN 
only, so the comment is also written that way. If you really don't want 
that there, I can shorten it and move it, but if it's okay as-is, then 
let's leave it in, and at a later stage, we can use it as a template for 
some more generic documentation :)


>> -			snprintf(&local_txbuf[2 * i], sizeof(local_txbuf),
>> -				 "\r");
>> +			/* Send a regular CAN data frame.
>> +			 *
>> +			 * frame->len is guaranteed to be <= 8. Please refer
>> +			 * to the comment in can327_netdev_start_xmit().
>> +			 */
> 
> Nitpick, could be less verbose, e.g.:
> 
>    /* frame->len <= 8 enforced in can327_netdev_start_xmit() */

IMHO that's a matter of point of view - for you it may be obvious that 
the CAN stack only passes ETH_P_CAN to _xmit(), but to someone new it is 
not. And this particular detail is *not* enforced in _xmit(), but in 
can_send() in the CAN stack. I hope you can understand my wish to be 
precise about this comment, in order to avoid confusion when inevitably 
someone else comes looking for overflows. Or, well, if I want to touch 
can327 again in six months' time, when I have forgotten about all of this :)


>> +	/* Why this driver can rely on frame->len <= 8:
>> +	 *
>> +	 * While can_dev_dropped_skb() sanity checks the skb to contain a
>> +	 * CAN 2.0, CAN FD, or other CAN frame type supported by the CAN
>> +	 * stack, it does not restrict these types of CAN frames.
>> +	 *
>> +	 * Instead, this driver is guaranteed to receive only classic CAN 2.0
>> +	 * frames, with frame->len <= 8, by a chain of checks around the CAN
>> +	 * device's MTU (as of v6.12):
>> +	 *
>> +	 *  - can_changelink() sets the CAN device's MTU to CAN_MTU since we
>> +	 *    don't advertise CAN_CTRLMODE_FD support in ctrlmode_supported.
>> +	 *  - can_send() then refuses to pass any skb that exceeds CAN_MTU.
>> +	 *  - Since CAN_MTU is the smallest currently (v6.12) supported CAN
>> +	 *    MTU, it is clear that we are dealing with an ETH_P_CAN frame.
>> +	 *  - All ETH_P_CAN (classic CAN 2.0) frames have frame->len <= 8,
>> +	 *    as enforced by a call to can_is_can_skb() in can_send().
>> +	 *  - Thus for all CAN frames reaching this function, frame->len <= 8.
>> +	 */
> 
> Actually, none of this is really specific to your can327 driver.
> 
> While this is a valuable piece of information, I would rather like to
> see this added as a kdoc comment on top of can_dev_dropped_skb(). That
> function already has a one line documentation, but maybe it deserves a
> longer paragraph?

Agreed that the can_dev_dropped_skb() documentation should be improved. 
However, I wouldn't remove the comment in can327 entirely - see above.


> One of the key point is that the userland is able to bypass the CAN_RAW
> layer (or any other CAN layers) by sending AF_PACKET. In which case, the
> packet directly reaches the driver without any prior sanitization. So it
> is critical to highlight that drivers must call can_dev_dropped_skb() at
> the top of their start_xmit() function, typically to avoid buffer
> overflows because of an out of band frame->len.

Agreed, and that's exactly the rabbit hole I went down yesterday. Where 
would be the best place to document this? I guess that could go, er... 
in the CAN driver writer's guide? Do we have something like that?



A bit off-topic, but since CAN_RAW came up: Why does CAN_RAW even 
sanitise anything at all, instead of relying on checks on later layers? 
It seems like quite a few checks are duplicated. And all the while it's 
possible for userspace to do weird stuff like seemingly enabling CAN FD 
on the socket via setsockopt() CAN_RAW_FD_FRAMES, but that's only 
flipping a bit on the CAN_RAW socket, yet changes nothing underneath. It 
was quite confusing to read. I suppose the explanation is "legacy"?



Thanks for your review!

Max


