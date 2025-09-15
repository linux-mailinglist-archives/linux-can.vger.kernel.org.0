Return-Path: <linux-can+bounces-4709-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F46BB584FF
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 20:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29221201E47
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 18:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0727BF80;
	Mon, 15 Sep 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpG9Flv3"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06FC215F42
	for <linux-can@vger.kernel.org>; Mon, 15 Sep 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757962475; cv=none; b=tYQn17ZA1D0fjx+XDp28eJaCUqaLBS5Uts9YVAnutzKhBPC6uekVFINWvWpGhJVV/7ZkNv3cKphDjmQtzdX5QYnFM+rWtFM4VA/FU2wgcrR1m0puj4kP9uTIafJvDTHiUCvjuQfNV3H1SyQl4uN+Wo3Te89OhvuQm+YmXReQs5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757962475; c=relaxed/simple;
	bh=rXDRg2LdTJYTC9cbgD/6xAMk5nLemuDshs80wiB0P0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpHLj8K4SvcOC2QjtQfnc20Ugpck0x+9dOzC+DeWdQTwivXWzKtoZozeAKrv7JvogUdaVFcPIIlc/r2GzZte9e5AQ1MevNEdlD1kG5z2KDctwl9FKVkmaxH3M1KbBXx551C6+09UmNLbELafGY5FvrVfphGZ6lfytpbUiZfkEkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpG9Flv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F67C4CEF1;
	Mon, 15 Sep 2025 18:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757962475;
	bh=rXDRg2LdTJYTC9cbgD/6xAMk5nLemuDshs80wiB0P0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OpG9Flv3lheICAfGuwThuOn25LJ8qXnRa1GwVxUL5bN1vEq+d5uvNbFaBMtGEQNjl
	 2TzsyP8Y/V0V0h5gD6EyLie0XUHzgPhaP+VO5iDV0k5KSf2hZeLW0/yohJ2Ve3qcnj
	 1d2o0VwYr8L7wvB514N5OfKvuolzx9cgZrOjRHDO6Bnj7APP/pJhwrKZfV+AoedDNP
	 nDADngRe7UD5oQHEuN5EGqTXB15cHvP4X3SN/2O6LIrZbWjMLVAah18woyUFBgr317
	 3y4Dmx2ANvbpPeoHwJJ3zC/rb0thRJ+YtaQ8Ox5rWR8ASbT9QH+uSYDE89T5syN0CQ
	 y6hOmZIOMWUTg==
Message-ID: <fa15357e-4d08-4192-a0d7-46315cba6610@kernel.org>
Date: Tue, 16 Sep 2025 03:54:33 +0900
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
In-Reply-To: <1618e271-e052-4667-9a7f-c6672fe582c4@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/09/2025 at 03:08, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 15.09.25 15:59, Vincent Mailhol wrote:
>> +cc: Stéphane
>>
>> On 15/09/2025 at 19:55, Vincent Mailhol wrote:
>>> On 11/09/2025 at 05:12, Oliver Hartkopp wrote:
>>>> On 10.09.25 18:19, Vincent Mailhol wrote:
>>>>> On 10/09/2025 at 17:48, Oliver Hartkopp wrote:
>>>>>> On 10.09.25 09:40, Vincent Mailhol wrote:
>>>>>>> On 10/09/2025 at 16:27, Oliver Hartkopp wrote:
>>>>>>
>>>>>>>>>        /* CAN XL is allowed on virtual interfaces if it fits the MTU */
>>>>>>>>>           if (!priv)
>>>>>>>>>               return dev->mtu == CANXL_MTU;
>>>>>>>>
>>>>>>>>            return can_is_canxl_dev_mtu(mtu);
>>>>>>>>
>>>>>>>> The MTU of CAN XL interfaces might vary.
>>>>>>>
>>>>>>> Maybe this is something that we discussed before, I do not remember, but
>>>>>>> how is
>>>>>>> it that the MTU can vary?
>>>>>>>
>>>>>>> MTU is the *Maximum* Transmission Unit. I understand that the size of a
>>>>>>> CAN XL
>>>>>>> frame is variable, but the MTU should be constant, right? Why can it vary?
>>>>>>
>>>>>> Depending on the realtime requirements the length of the CAN frames (and
>>>>>> therefore the time the bus is blocked) the MTU can be reduced. This is
>>>>>> (like the
>>>>>> bitrate settings) a network architects decision which is enforced by
>>>>>> setting the
>>>>>> MTU accordingly.
>>>>>
>>>>> Is this an extension we offer in Socket CAN?
>>>>
>>>> Yes.
>>>>
>>>>> The standard says nothing about
>>>>> having the MTU configurable.
>>>>>
>>>>> For CAN FD, we forcefully set the MTU in netlink.c
>>>>>
>>>>> https://elixir.bootlin.com/linux/v6.16/source/drivers/net/can/dev/
>>>>> netlink.c#L228
>>>>
>>>> Oh. I did not realize before that we can either modify the MTU with setting fd
>>>> on/off and via setting the MTU in can_change_mtu()
>>>>
>>>> https://elixir.bootlin.com/linux/v6.16/source/drivers/net/can/dev/dev.c#L313
>>>>
>>>> ?!?
>>>>
>>>> The two APIs problem for changing the MTU?!?
>>>>
>>>> I expected the default MTU for CAN FD capable interfaces to be CANFD_MTU which
>>>> is obviously not the case.
>>>>
>>>>> I will have to think of what are the implication for CAN XL.
>>>>
>>>> I would define a default CANXL MTU (CANXL_MTU 2060) which might be changed with
>>>> can_change_mtu().
>>>>
>>>> And when ever we switch xl on this value is selected as device MTU.
>>>>
>>>> Or the user can change the MTU as he needs it.
>>>> And when xl on is selected and the MTU is a can_is_canxl_dev_mtu() this
>>>> value is
>>>> used. When can_is_canxl_dev_mtu() is not true we take CANXL_MTU.
>>>>
>>>> Something like this.
>>>
>>> Yes. I was thinking of something similar. This is what I added locally at the
>>> moment:
>>>
>>>     if ((priv->ctrlmode & CAN_CTRLMODE_XL) &&
>>>         !can_is_canxl_dev_mtu(dev->mtu)) {
>>>            /* Set CAN XL MTU to its max unless if already set by user */
>>>         dev->mtu = CANXL_MAX_MTU;
>>>     }
>>>
>>> But I am still testing it.
>>
>> I am looking at the code of can_change_mtu() but I can not understand the intent.
>>
>> Back then, commit bc05a8944a34 ("can: allow to change the device mtu for CAN FD
>> capable devices") stated that:
>>
>>    The configuration can be done either with the 'fd { on | off }' option in the
>>    'ip' tool from iproute2 or by setting the CAN netdevice MTU to CAN_MTU (16) or
>>    to CANFD_MTU (72).
>>
>>    Link: https://git.kernel.org/torvalds/c/bc05a8944a34
>>
>> But if I do something like:
>>
>>    ip link set can0 mtu 72 type can bitrate 500000
>>
>> the command is accepted and I am then left with a device which is in an
>> incoherent status (FD on, but no databittiming ?!)
>>
>> I tested this on a device and it is just throwing me errors.
>>
>> The same goes on when setting the mtu back to 16:
>>
>>    ip link set can0 type can bitrate 500000 fd on dbitrate 5000000
>>    ip link set can0 mtu 16
>>
>> and now I have a device in Classical CAN mode but iproute2 is still reporting me
>> the databittiming values (although this time, the device does not send me
>> errors).
>>
>> So, whatever I try, can_change_mtu() put the device in some incoherent state
>> with some more or less serious impact (either device errors or bad reporting).
>> And the only method to remediate is to use the 'fd { on | off }' option.
>>
>> Am I missing something? If the feature is just broken, then I would like to
>> rewrite it but this time using the net_dev infrastructure by populating
>> net_device->min_mtu and net_device->max_mtu. IMHO, this should give us a way
>> more robust interface.
> 
> I think the interface to set the MTU lacks a clear separation of how to set the
> MTU for real (hardware) CAN interfaces and virtual CAN interfaces.

Ack.

> 1. IMO we should be able to set the MTUs on virtual and real interfaces when the
> interface is down (as those MTUs have no effect at this time).

Mostly agreed. It should not be possible to switch between the Classical CAN,
CAN FD or CAN XL MTUs. But I do not yet see an issue to change the MTU to
something in between CANXL_MIN_MTU and CANXL_MAX_MTU while a CAN XL node is running.

I want to first study the other interfaces (e.g. ethernet) and the core net
infrastructure in order to make my mind. For the moment, I am just undecided.

> 2. When a virtual interface is set to "up" the MTU is used and fixed.

Same as above, mostly agreed aside from the CAN XL on which I do not yet have my
final opinion.

> 3. When a real interface is set to up the mtu is set to ...
>   a. mtu = CAN_MTU when fd off and xl off
>   b. mtu = CANFD_MTU when fd on and xl off
>   c. mtu = the configured CAN XL MTU (*) when xl on
> 
> (*) when the configured mtu is not in the range of CANXL_MIN_MTU and
> CANXL_MAX_MTU the mtu is set to CANXL_MAX_MTU.
> 
> By default the initial MTU of virtual CAN interfaces should be set to CANXL_MTU.
> 
> By default the initial MTU of real CAN interfaces should be set to the maximum
> value which the real CAN interface is capable too:
>  a. CAN_CTRLMODE_XL supported -> CANXL_MTU.
>  b. CAN_CTRLMODE_FD supported -> CANFD_MTU.
>  c. default CAN_MTU

I was thinking of the opposite:

  a. if the device is CAN FD static it is CANFD_MTU
  b. if the device is CAN XL static it is CANXL_MTU
  c. otherwise, it is the CAN_MTU by default

which, if you remove point b., happens to be the current logic. I do not see a
need to change this.

If we set CANXL_MTU by default on XL capable devices, it means that at a moment
in time, we have a device with the CAN_CTRLMODE_XL off but with a CAN XL MTU.
And this is inconsistent. For me, the MTU should always match the control mode
flags. Because all control modes are off at the beginning, the MTU is thus the
Classical CAN one.

> I think this should make it clearer and fix the current inconsistency.
> 
> Setting the CANFD_MTU via the ip set mtu feature and expect "fd on" being set at
> the same time is bad.

OK. Aside of a few details, I think we agree on the big lines. The good thing is
that the current can_change_mtu() only targets the real interfaces. The virtual
ones already have their own functions and so will not get impacted.

So I am just thinking of doing a full rewrite of can_change_mtu(). The old logic
of being able to implicitly set the fd flag by providing an MTU will go to the
trash can. The new logic will try to follow as much as possible the intended MTU
logic of the core net framework (which I am still studying).


Yours sincerely,
Vincent Mailhol


