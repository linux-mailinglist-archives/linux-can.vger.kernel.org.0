Return-Path: <linux-can+bounces-4705-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B303B57E36
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283A17AA173
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF272FE571;
	Mon, 15 Sep 2025 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCdmCYb5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F81F4C8B
	for <linux-can@vger.kernel.org>; Mon, 15 Sep 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944791; cv=none; b=tzuTvEKyrKu1xCyYh9NPgqb5rYAshTVls9TyJFRE0l0qFshBrbdXVIKfjzaYLZ2tbVYl+kkePpXcO4gzkg6sgYk1CUG17Bh625H0W8JWnCJYwTOiz3EUkQZ8ckdDim0jG6cGqcdQRWQYmM/WZqozm/my8Z5Q8+gmTmbyyVYZc/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944791; c=relaxed/simple;
	bh=MjGBNSnZtWFSlFeWuU2JOiNfw2n+6c8eFX8G0TOmkUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=XD8l/1BdBf2r+hF57xrnrtUHxXyTRUVegDarncN0avOFx6fMsardvBmEgfoNW8tUSSa0+Ozx8xuUsLQnkHTXf7toHohPF5vMYQ2go03XkItEFDFfx6VGtbSp6xLt1S5heYzH/UDlR2r1FVkajdosUA1NAMeQGzzyNtJgQaukOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCdmCYb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DAEC4CEF1;
	Mon, 15 Sep 2025 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757944790;
	bh=MjGBNSnZtWFSlFeWuU2JOiNfw2n+6c8eFX8G0TOmkUI=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=CCdmCYb5DqLsLZtasEFMCJdC/JObGZ23UhHiYmUPQOPHBPbHf7UWKiNJAYeSdWZZd
	 pzlzULhxK4NxTdCkuo9vSYW/p7pFhing/r3dIR80jNGPoMdOiLEH449147xOe7sRVq
	 e7YQKBpIYZt53mymZ7gV6saV12S0AyAWt1kXxImcFric9NzENAsujsmX1vLU6cxkR8
	 K8aJrBPID6mhVox3pxk1WbkaP+yfA9dGdiz3FkaapR+iYoGuTFcYJHvgZKY6hyKoyP
	 ju0RfrxHz5xQD5yPTgFLpRxyqpSbDtlYg2ynZNQ/SEIq9rbEsIcAYHi4560Sj4CnBY
	 RyR/2PGa6R8ZA==
Message-ID: <3979cf15-6a08-44e3-a620-fe97d8218713@kernel.org>
Date: Mon, 15 Sep 2025 22:59:48 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/2] can: reject CAN FD content when disabled on
 CAN XL interfaces
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
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
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
In-Reply-To: <67e0351c-b478-4938-a42d-77764b27b9d1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+cc: Stéphane

On 15/09/2025 at 19:55, Vincent Mailhol wrote:
> On 11/09/2025 at 05:12, Oliver Hartkopp wrote:
>> On 10.09.25 18:19, Vincent Mailhol wrote:
>>> On 10/09/2025 at 17:48, Oliver Hartkopp wrote:
>>>> On 10.09.25 09:40, Vincent Mailhol wrote:
>>>>> On 10/09/2025 at 16:27, Oliver Hartkopp wrote:
>>>>
>>>>>>>       /* CAN XL is allowed on virtual interfaces if it fits the MTU */
>>>>>>>          if (!priv)
>>>>>>>              return dev->mtu == CANXL_MTU;
>>>>>>
>>>>>>           return can_is_canxl_dev_mtu(mtu);
>>>>>>
>>>>>> The MTU of CAN XL interfaces might vary.
>>>>>
>>>>> Maybe this is something that we discussed before, I do not remember, but how is
>>>>> it that the MTU can vary?
>>>>>
>>>>> MTU is the *Maximum* Transmission Unit. I understand that the size of a CAN XL
>>>>> frame is variable, but the MTU should be constant, right? Why can it vary?
>>>>
>>>> Depending on the realtime requirements the length of the CAN frames (and
>>>> therefore the time the bus is blocked) the MTU can be reduced. This is (like the
>>>> bitrate settings) a network architects decision which is enforced by setting the
>>>> MTU accordingly.
>>>
>>> Is this an extension we offer in Socket CAN?
>>
>> Yes.
>>
>>> The standard says nothing about
>>> having the MTU configurable.
>>>
>>> For CAN FD, we forcefully set the MTU in netlink.c
>>>
>>> https://elixir.bootlin.com/linux/v6.16/source/drivers/net/can/dev/netlink.c#L228
>>
>> Oh. I did not realize before that we can either modify the MTU with setting fd
>> on/off and via setting the MTU in can_change_mtu()
>>
>> https://elixir.bootlin.com/linux/v6.16/source/drivers/net/can/dev/dev.c#L313
>>
>> ?!?
>>
>> The two APIs problem for changing the MTU?!?
>>
>> I expected the default MTU for CAN FD capable interfaces to be CANFD_MTU which
>> is obviously not the case.
>>
>>> I will have to think of what are the implication for CAN XL.
>>
>> I would define a default CANXL MTU (CANXL_MTU 2060) which might be changed with
>> can_change_mtu().
>>
>> And when ever we switch xl on this value is selected as device MTU.
>>
>> Or the user can change the MTU as he needs it.
>> And when xl on is selected and the MTU is a can_is_canxl_dev_mtu() this value is
>> used. When can_is_canxl_dev_mtu() is not true we take CANXL_MTU.
>>
>> Something like this.
> 
> Yes. I was thinking of something similar. This is what I added locally at the
> moment:
> 
> 	if ((priv->ctrlmode & CAN_CTRLMODE_XL) &&
> 	    !can_is_canxl_dev_mtu(dev->mtu)) {
>   		/* Set CAN XL MTU to its max unless if already set by user */
> 		dev->mtu = CANXL_MAX_MTU;
> 	}
> 
> But I am still testing it.

I am looking at the code of can_change_mtu() but I can not understand the intent.

Back then, commit bc05a8944a34 ("can: allow to change the device mtu for CAN FD
capable devices") stated that:

  The configuration can be done either with the 'fd { on | off }' option in the
  'ip' tool from iproute2 or by setting the CAN netdevice MTU to CAN_MTU (16) or
  to CANFD_MTU (72).

  Link: https://git.kernel.org/torvalds/c/bc05a8944a34

But if I do something like:

  ip link set can0 mtu 72 type can bitrate 500000

the command is accepted and I am then left with a device which is in an
incoherent status (FD on, but no databittiming ?!)

I tested this on a device and it is just throwing me errors.

The same goes on when setting the mtu back to 16:

  ip link set can0 type can bitrate 500000 fd on dbitrate 5000000
  ip link set can0 mtu 16

and now I have a device in Classical CAN mode but iproute2 is still reporting me
the databittiming values (although this time, the device does not send me errors).

So, whatever I try, can_change_mtu() put the device in some incoherent state
with some more or less serious impact (either device errors or bad reporting).
And the only method to remediate is to use the 'fd { on | off }' option.

Am I missing something? If the feature is just broken, then I would like to
rewrite it but this time using the net_dev infrastructure by populating
net_device->min_mtu and net_device->max_mtu. IMHO, this should give us a way
more robust interface.


Yours sincerely,
Vincent Mailhol


