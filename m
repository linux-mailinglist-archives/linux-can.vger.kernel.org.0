Return-Path: <linux-can+bounces-4526-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2006EB49550
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 18:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A498E1714BB
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26762205ABA;
	Mon,  8 Sep 2025 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOo4eJLP"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119E22069A
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349095; cv=none; b=P+fQsouk/JO6pQayOUBhrmhRpOOzDXtMcN9f5yH4rP02bEC5jaJ4MA8G+Z4+wjR0r22seIu9313KuIqGjdiY1Pby7KikdHqYGPnoc0Uee47aII8OIEnKmnEGg+qxF1UxtD8j8Po5aH7Y+L7470JCjXTipkX1y1dBAJNcxsY31U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349095; c=relaxed/simple;
	bh=DdFlehIi8iFHzoiS9e5lnqG0uRsSdiDHjWvVXU9Jrhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rc5u7Y/WTmSv/q616l9n86NwsYQDvedbpmG4RMPh0woToS4eGrnKuMch2UxwZw2MaznG2kyK7plaGuTRvf7DkQLjBkqFN2o1tV1gH6+2IVt9YJ2IKiyTsbhAjCDR3o3EqWhlT88nqvfZSJ1CgcfCQZf6ZysnFmVMdI1E71IjLWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOo4eJLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054F6C4CEF5;
	Mon,  8 Sep 2025 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349094;
	bh=DdFlehIi8iFHzoiS9e5lnqG0uRsSdiDHjWvVXU9Jrhs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dOo4eJLPU9rvQKUGGRR/PIjexgWMzda8KxaBIOJcXiPGT8QYRAUr26N2AcVoO351R
	 OGS8lQtHZTlk4zusTtTgOkIismOCZQOGxLBvt+/A40fPmQRD682N3e0hE6sqScOziw
	 p000tTej44BV7pJpM/APUj+0pWinc3Z00c6GysJ+hVXNq6iyZl3psspVKYTrhKjtBi
	 FwvrHVaRqAegbJsQiOXDHdbeFQ6ZnlvMtmJhDPxsZifg+S7tE916I4dbVjypjGy1Au
	 DMRk18oAXYxbQcsx8UT22J8Cv3ewLTqIkbXkZ18aqDBrGABynJwYlcJu5f1rYOn5V2
	 Sh25Ra/2UgQoQ==
Message-ID: <891c738e-f807-46a7-8e03-4223969c9002@kernel.org>
Date: Tue, 9 Sep 2025 01:31:32 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD
 is off
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20250907080504.598419-2-mailhol@kernel.org>
 <49e0970f-1a10-438f-b9ae-afcc75edaccd@hartkopp.net>
 <5edbe004-767f-4a41-9454-f4bbf8f5b590@kernel.org>
 <4e380c2b-f48d-4bd5-bc8d-3bfd85fc0d2f@hartkopp.net>
 <cc56cf68-49d4-4c94-844c-ec413307dedf@kernel.org>
 <fc1dfbf6-33e1-47a1-943d-806f146c5be6@hartkopp.net>
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
In-Reply-To: <fc1dfbf6-33e1-47a1-943d-806f146c5be6@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/09/2025 at 23:59, Oliver Hartkopp wrote:
> On 08.09.25 15:30, Vincent Mailhol wrote:
>> On 08/09/2025 at 18:00, Oliver Hartkopp wrote:

(...)

>>> There is no way to have CAN CC with CAN XL without CAN FD right now as we can
>>> not detect this without accessing the netlink configuration.
>>
>> This brings us to the next point I wanted to discuss. As you say, the only
>> solution is to access the ctlrmode flags which, at the moment, are only exposed
>> through the netlink interface.
>>
>> But using the netlink interface directly in your program is a bit troublesome,
>> to say the least, because of all the boilerplate code needed as illustrated in
>> the libsocketcan:
>>
>>    https://github.com/linux-can/libsocketcan/blob/master/src/libsocketcan.c
>>
>> So, my other idea would be to add a new socket option that would act as a
>> shortcut to priv->ctrlmode.
>>
>>    getsockopt(s, SOL_CAN_RAW, CAN_RAW_CTRLMODE, &ctrlmode, sizeof(ctrlmode));
>>
>> The interface would return an error if the interface is a virtual interface.
>> Otherwise, it would return the flags, allowing for an easier way to probe. As a
>> bonus, all the flags become easily accessible.
>>
>> It means that we would have two different ways to do the same thing (netlink and
>> getsockopt) but I do not see this as an issue.
>>
>> What do you think?
> 
> You are right with having two APIs for the same thing ...
> 
> If we would have such a getsockopt() I would suggest to provide the ctrlmode and
> the ctrlmode_supported to the user space.

Yes, and probably also the CAN_RAW_CTRLMODE_STATIC. I do not often use that one,
but for completeness, better to expose all three.

> And the bits are only valid when the interface is up. So additional to e.g. -
> EOPNOTSUPP for vcan's we should also be able to return -ENETDOWN.

Ack for the vcan.

For the real hardware, I think that the CAN_RAW_CTRLMODE_SUPPORTED and
CAN_RAW_CTRLMODE_STATIC should be always available. Only the CAN_RAW_CTRLMODE
would return -ENETDOWN if the interface is down.

> My biggest concern is whether such a getsockopt() is really needed.
> 
> Today you can enable CANFD and CANXL with setsockopt() and when you send frames
> that can not be sent to the interface you get an error.
>
> The only thing that is "not that nice" is the CANXL-only (without FD) possibility.

The fact that vcan can not be configured with FD off and XL on is what I would
call a "not that nice".

But the impossibility to reliably probe the FD state is worse than "not that
nice". When I see cangen sending CAN FD frames when it shouldn't, I call this a
bug. The impossibility to probe is a no-go to me.

An alternative would be to revive the libsocketcan to make it easier to use the
netlink interface but this is lot of effort and it means adding one userland
dependency. The getsockopt() seems a better alternative.


Yours sincerely,
Vincent Mailhol


