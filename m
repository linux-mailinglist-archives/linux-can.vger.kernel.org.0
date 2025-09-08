Return-Path: <linux-can+bounces-4521-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB18B48F94
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD3616D1A4
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C099230BB84;
	Mon,  8 Sep 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYN9EH8/"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A42F30BB81
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338227; cv=none; b=DFU3SL8/9TYF3S1eraVI2SzovGISYvjw3xABPAGydf5LqGYVa9nWV9qKGU2pY4Nscxq62w+xQJBG0P9tJwtqUvjo46np6xBeAOhn+fsNxKqLvJVp/+3Tc7hG09XXlwLg1gqyEuOwMaX2JWCIU9334u54+5+EruzNotem+Vt7QyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338227; c=relaxed/simple;
	bh=Fc5n6+QeI0JyWKj9t3438PL9a0M0ra4XiPeRieJ8yl4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Uz2d1nI1CEZ0TghHBH5HZoK1ygrtpbZkEOYWhZWsDJTCDWU0i5V1Xl5OL9/oweLBGXd2fNTjrBPfGXO4HTVFu34rjFL4QP15uY10ANTxEr32vl3Qi9YkhVuQfY5vMCD8wh3tE0Nj5UFH5loD5JSzDR9jS73Jxbxu+XiwVgPMBQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYN9EH8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B496CC4CEF9;
	Mon,  8 Sep 2025 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757338227;
	bh=Fc5n6+QeI0JyWKj9t3438PL9a0M0ra4XiPeRieJ8yl4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=LYN9EH8/rSoEIYtcVnf6lnJtI0FOFfwKSd8BWavmnicXBndr4Iz++uNQOKaVUBgyN
	 aN/UZ5kHNvymbI259PFYDaGSX9jPz/ZN12nonszUQVxuNDVTiYPks6v59DBcc5zOf0
	 s8LHh7WPrv0UkdBkzooUyAifB5fnENS2KYUDrkeGomu2i8g0WsCZVu6daWvVUDxOrv
	 r/F6RE+6K+EoXZJ9gWfomAWk+CXq81FkUKze+xDYfGAz4g5Hvnu89USY55nr6tBPcn
	 GAGY/ME3X8T9mjPOsGrjI98GXdphrIlxDx571EptdMlgCLNcctQTnY9qVBFWGcWtbG
	 RgfrhNba98ldA==
Message-ID: <cc56cf68-49d4-4c94-844c-ec413307dedf@kernel.org>
Date: Mon, 8 Sep 2025 22:30:25 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [RFC PATCH] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD
 is off
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20250907080504.598419-2-mailhol@kernel.org>
 <49e0970f-1a10-438f-b9ae-afcc75edaccd@hartkopp.net>
 <5edbe004-767f-4a41-9454-f4bbf8f5b590@kernel.org>
 <4e380c2b-f48d-4bd5-bc8d-3bfd85fc0d2f@hartkopp.net>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <4e380c2b-f48d-4bd5-bc8d-3bfd85fc0d2f@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/09/2025 at 18:00, Oliver Hartkopp wrote:
> On 08.09.25 06:07, Vincent Mailhol wrote:
>> On 08/09/2025 at 04:03, Oliver Hartkopp wrote:
>>> Hi Vincent,
>>>
>>> can_dev_dropped_skb() is not what you are looking for.
>>>
>>> Whether a CAN frame fits to the CAN device is checked in raw_check_txframe()
>>> here:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/can/
>>> raw.c#n884
>>>
>>> Or do I miss anything?
>>
>> My point is not if it fits or not. Of course, if CAN XL is activated, CAN FD
>> frames would fit.
>>
>> My point is that activating CAN XL should not imply that CAN FD is also
>> activated. Having CAN FD off and CAN XL on is a valid configuration.
>>
>> Let me take an example, imagine that I configure my device with CAN FD off and
>> CAN XL on, for example:
>>
>>    ip link set can0 up type can bitrate 500000 \
>>       fd off \
>>       xl on xbitrate 10000000 tms on
>>
> 
> Ah, ok.
> 
>> Where is the check that, with this configuration, the device is not CAN FD
>> capable and that the FD frames should be dropped? When I try this under my dummy
>> driver, the FD frames pass the raw_check_txframe() check, reach the driver's
>> xmit function and pass the can_dev_dropped_skb() checks. And that is the problem.
>>
>> So, yes, the frame "fits" in above configuration and no buffer overflows nor any
>> other security problems occurred. But CAN FD is off so the frame should have
>> been discarded at some point.
> 
> Yes. I think your original patch with
> 
>> +    if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb))
>> +        goto invalid_skb;
> 
> should do that job. Btw. I would also add a netdev_info_once() here too, so that
> we can give a heads up to the user.

Ack. This patch will now go to my CAN XL WIP with the netdev_info_once() added
to it ;)

>> The same issue goes for probing. How do you detect if an interface is CAN FD
>> capable? By checking that its MTU is at least CANFD_MTU? For example like this
>> in cangen?
>>
>>    https://github.com/linux-can/can-utils/blob/master/cangen.c#L802-L805
>>
>> If I do this check, it would wrongly detect that my interface is CAN FD capable
>> when in fact, it is turned off in the configuration. So, under my previous
>> example, cangen is also fooled into believing that it can send CAN FD frames
>> when in reality the option is turned off.
>>
>> So, these are my point:
>>
>>    - how do you configure a vcan so that CAN FD is off and CAN XL is on?
> 
> This is not possible due to the missing flags (netlink) infrastructure known
> from the real hardware drivers. And IMHO this is also not needed to be
> implemented for a virtual CAN interface which does not have those restrictions.

I would say that it is not strictly needed but would have been a nice to have.
If you want to proxy between a virtual interface and a real hardware, I can see
how this can become annoying.

But I concede that there is not much that we can do and that it is probably
better to just say that having a virtual interface with CAN FD off and CAN XL on
is just impossible.

>>    - when CAN FD is off and CAN XL is on, how do you drop CAN FD frames in the
>>      kernel TX path ?
> 
> As you proposed in your extension for can_dev_dropped_skb() - with some more
> comments and a netdev_info_once(), of course ;-)
> 
> We might also try to access the CAN flags from the device in the network layer
> but this will become very ugly for a comparably unimportant use-case IMO. And it
> won't help for PF_PACKET users creating their own SKB content either.
>
>>    - in the userland, how do you probe that an interface is CAN FD capable or
>>      not?
> 
> Test ifr.ifr_mtu for
> 
> == CAN_MTU -> CC IF -> CAN CC
> == CANFD_MTU -> FD IF -> CAN CC & CAN FD
>>= CANXL_MIN_MTU -> XL IF -> CAN CC & CAN FD & CAN XL
> 
> There is no way to have CAN CC with CAN XL without CAN FD right now as we can
> not detect this without accessing the netlink configuration.

This brings us to the next point I wanted to discuss. As you say, the only
solution is to access the ctlrmode flags which, at the moment, are only exposed
through the netlink interface.

But using the netlink interface directly in your program is a bit troublesome,
to say the least, because of all the boilerplate code needed as illustrated in
the libsocketcan:

  https://github.com/linux-can/libsocketcan/blob/master/src/libsocketcan.c

So, my other idea would be to add a new socket option that would act as a
shortcut to priv->ctrlmode.

  getsockopt(s, SOL_CAN_RAW, CAN_RAW_CTRLMODE, &ctrlmode, sizeof(ctrlmode));

The interface would return an error if the interface is a virtual interface.
Otherwise, it would return the flags, allowing for an easier way to probe. As a
bonus, all the flags become easily accessible.

It means that we would have two different ways to do the same thing (netlink and
getsockopt) but I do not see this as an issue.

What do you think?


Yours sincerely,
Vincent Mailhol


