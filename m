Return-Path: <linux-can+bounces-4770-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A90A4B8CE59
	for <lists+linux-can@lfdr.de>; Sat, 20 Sep 2025 19:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F73D163E13
	for <lists+linux-can@lfdr.de>; Sat, 20 Sep 2025 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6925A21FF4D;
	Sat, 20 Sep 2025 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2BQjxan"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444821E8836
	for <linux-can@vger.kernel.org>; Sat, 20 Sep 2025 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758391042; cv=none; b=X35kPWGasaPjc4Tr+eh8Rb4RwV50gm0QQuMi0Z5ExJsH9f6gne/JFzGqlNLl1WWEzzlohS2/nqdA7bSxTiHeHmW5lu6MYJgZOFoP/kTUkMXXrioGQ/0V8X1GHIgPHRomRhYLfDhsPHo9KK74jVxeSpRLrXT32AIb2xycyx4llhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758391042; c=relaxed/simple;
	bh=U5i+RuZ2HiMXEzANf8mIX2bIEkCFATZkvoryE4m1cjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWTBpRdsNGNrO0BAilYqTp+V6NidEjj326M87sSyfE82WffbIz2eL3ERjYxuC6K9ZzMTfDmbfHAFbkCTn6UcJZAWys9qYClgALqnz1WKEBamOuJXHq+je3szLyAK9xEDX3AuXymzbgpt497xADLRNSRzvxC5EPaMnc1X+JFExIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2BQjxan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B06C4CEEB;
	Sat, 20 Sep 2025 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758391041;
	bh=U5i+RuZ2HiMXEzANf8mIX2bIEkCFATZkvoryE4m1cjs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F2BQjxanEdkEMrhHnXxvPvW3Jo3fvCr8tkDBdrAiSfuTGYGR1hkLlPFXsXwNJqaak
	 UjXWH1E0CiwRTPXMFi+ZPZqEMw/0VsA4zpQ9sbZBBZY11jOpttSUBQLSGGNiISULl3
	 +Ogh9dlxM+KIdU48x91/Mv6fZwv762NEbvF8cMlh2DACiOYabPSaAb7iA2p2gTqBIm
	 p5lFaq3nulGkYvPzvXGZmi73jf4H0MWNf+fH/V0EpzFho3yaJNZJgI4fflBbjxY0mb
	 FaxZO2KNUBalSQQvRTKmiPyIUFbFD+hBEEfhcsAt31gy9wBsSbB8bcplFxUOU4Fhcn
	 cje6X09u4MQmw==
Message-ID: <bb4e0c44-1eb5-4df3-873c-9e666c8354ad@kernel.org>
Date: Sun, 21 Sep 2025 02:57:19 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/2] can: reject CAN FD content when disabled on
 CAN XL interfaces
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
References: <20250909092433.30546-1-socketcan@hartkopp.net>
 <20250909092433.30546-2-socketcan@hartkopp.net>
 <f7b59c7c-30ad-4cf4-ad0e-bff0e39b3337@hartkopp.net>
 <7578f44d-d85c-473e-8e7a-65d1fc974e68@kernel.org>
 <20c5c885-0bab-4c42-82c6-e98571a5d19d@hartkopp.net>
 <552631f3-15fe-4bb3-a512-1eaca57be5ca@kernel.org>
 <3a963548-faa9-4611-a3cf-e41b425968a8@hartkopp.net>
 <b6637b79-6377-4038-967f-0354a32eb2c3@kernel.org>
 <6afc7e2d-eecf-4c47-bcef-0e2cdd7f4a89@hartkopp.net>
 <67e0351c-b478-4938-a42d-77764b27b9d1@kernel.org>
 <3979cf15-6a08-44e3-a620-fe97d8218713@kernel.org>
 <1618e271-e052-4667-9a7f-c6672fe582c4@hartkopp.net>
 <fa15357e-4d08-4192-a0d7-46315cba6610@kernel.org>
 <034cad19-d04d-4b14-87b2-e8b2b7b14099@hartkopp.net>
 <204b2bbf-eeb6-492d-9842-4720ba6c055b@kernel.org>
 <a85dec20-e638-4069-8355-9cbf4d2d278e@hartkopp.net>
 <4430c1a1-5c03-45bb-a687-66e0a41050f6@kernel.org>
 <e845bb4d-32db-4a73-a4c0-2e43af3bc861@hartkopp.net>
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
In-Reply-To: <e845bb4d-32db-4a73-a4c0-2e43af3bc861@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/09/2025 at 02:38, Oliver Hartkopp wrote:
> On 18.09.25 11:18, Vincent Mailhol wrote:
>> On 18/09/2025 at 06:29, Oliver Hartkopp wrote:
> 
> 
>>> Will the user defined MTU for CAN XL survive the settings when xl is set to off
>>> and then set to on again?
>>
>> Unfortunately no. Or at least not without adding one additional field to save
>> the old value.
>>
>> But after turning FD or XL off, none on the bittiming parameters would survive
>> either. So I think it is coherent to say that the user has to set everything
>> again each time XL is switched on.
>>
> 
> Ok. IMO setting the CAN XL MTU lower than CANXL_MTU_MAX is a power user feature
> anyway. So setting the bitrates and the MTU in one sequence should be no problem.
> 
> 
>>> To sum it up for myself:
>>>
>>> 1. Setting the MTU from user space is only relevant for virtual CAN interfaces
>>> and CAN XL interfaces for values between CANXL_MIN_MTU and CANXL_MAX_MTU.
>>
>> Ack.
>>
>>> 2. Usually the MTU is set automatically by the netlink configuration process
>>> when fd/xl on/off are set.
>>
>> Ack.
>>
>> As you will see, I found some bug because a few drivers forgot to set their
>> can_change_mtu() and addressed the issue here:
>>
>> https://lore.kernel.org/linux-can/20250918-can-fix-mtu-
>> v1-0-0d1cada9393b@kernel.org/
>>
>> That series is just to fix things and is meant to be back ported to stable.
> 
> Nice cleanup!
> 
>> I will send a couple more patches as an RFC which will implement the actual
>> logic which we discussed here.
> 
> Fine!
> 
> I assume we will miss this merge window for the CAN XL support then.

Yes, but I hope that to have the preparation series merged. Marc already picked
the MTU fix series:

https://lore.kernel.org/linux-can/20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org/

Next week, I would like to merge the MTU rework:

https://lore.kernel.org/linux-can/20250918-can-fix-mtu-v1-0-471edb942295@kernel.org/

as well as the XL preparation:

https://lore.kernel.org/linux-can/20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org/

Both are ready locally, but I first need to wait for the MTU fix to appear in
net-next before re-sending.

> With all the things that need to be looked at carefully the next merge window is
> probably the better choice.

By the way, my latest test are all green.

I updated my WIP

https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/linux.git/log/?h=b4/canxl-netlink

I may still refactor a few things and I still need to write the patch comments,
but feature wise, I now implemented all what I had in mind.

But for next week, let's focus on the preparation series first, the discussion
on the actual XL code will be for the next merge window ;)


Yours sincerely,
Vincent Mailhol


