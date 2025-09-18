Return-Path: <linux-can+bounces-4739-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9F8B83BD4
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 11:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1425405A2
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 09:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D9301029;
	Thu, 18 Sep 2025 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k39ezt/q"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17A2727EB
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187110; cv=none; b=TLmVD9m/cONrE/5dC4nnnf3d2FaprnpDZrz/OHbcP2Bei7VdkLhVKqiRFbczCzH/xZjD1eblmJ7V9YLSoY0Aj65TQzt5eWQNSOrDw1ZLhrEVPRO+flohIEC4XJ+EyeiGou4zhxk2QmvfDv+oGPRHuJgGjx/40Qx7gXSjQx62VQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187110; c=relaxed/simple;
	bh=l8AsJaBPfmbIjtRItODrMR9I5AIfliN/NV59RQ+J+Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ty7+sp4H9/Y54kB9UhC0gTOWX00XhWvqCePZJT72ThaVddv37JgYlNTOERkrDs4WEBjydqUatkA2EEfneTkZHnp70bZ6opO8WFAJCR5IP2UO24RZEEU+8vu6WiiBi8VDKJqxsaFOBOAIJaNkVUmCK28PGUZ7HYNcfm5+IY5/3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k39ezt/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57454C4CEE7;
	Thu, 18 Sep 2025 09:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758187109;
	bh=l8AsJaBPfmbIjtRItODrMR9I5AIfliN/NV59RQ+J+Ds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k39ezt/qGVcd9o48Cm23pLBiPjeBm57UJ/evAS5rM55QQyba908dU/SB1Gfn43bve
	 iiUhq6F7rvzNJ2/wvLoTqErT+Rc61T27ASSvbAQD8wq8yUamhRWOw6YYXPMhf7Mxk/
	 TR8Aed4nMyhD2n8wwfZGhnhQ/8Iq2HODG8e7zXamQNMgWelv8o8mJ6qE4WvU/FoRUp
	 HL+dX6F5gP6AXGHluMicFhkG9VtzDe6A1wM0pYgjdZ6dXxAmtD/2G5T1I+OFCDxtP9
	 uWA8RSdDc4cvGLyA7Ycxc11qrJb8/bUQ++G3/jMYFLgc3aA9IxsSO4+4vttgSEFB4o
	 5tthr9akMTW4w==
Message-ID: <4430c1a1-5c03-45bb-a687-66e0a41050f6@kernel.org>
Date: Thu, 18 Sep 2025 18:18:27 +0900
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
 <fa15357e-4d08-4192-a0d7-46315cba6610@kernel.org>
 <034cad19-d04d-4b14-87b2-e8b2b7b14099@hartkopp.net>
 <204b2bbf-eeb6-492d-9842-4720ba6c055b@kernel.org>
 <a85dec20-e638-4069-8355-9cbf4d2d278e@hartkopp.net>
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
In-Reply-To: <a85dec20-e638-4069-8355-9cbf4d2d278e@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/09/2025 at 06:29, Oliver Hartkopp wrote:
> On 16.09.25 15:17, Vincent Mailhol wrote:
>> On 16/09/2025 at 18:14, Oliver Hartkopp wrote:
>>> On 15.09.25 20:54, Vincent Mailhol wrote:
>>>> On 16/09/2025 at 03:08, Oliver Hartkopp wrote:
>>>
>>>>> I think the interface to set the MTU lacks a clear separation of how to set
>>>>> the
>>>>> MTU for real (hardware) CAN interfaces and virtual CAN interfaces.
>>>>
>>>> Ack.
>>>>
>>>>> 1. IMO we should be able to set the MTUs on virtual and real interfaces
>>>>> when the
>>>>> interface is down (as those MTUs have no effect at this time).
>>>>
>>>> Mostly agreed. It should not be possible to switch between the Classical CAN,
>>>> CAN FD or CAN XL MTUs. But I do not yet see an issue to change the MTU to
>>>> something in between CANXL_MIN_MTU and CANXL_MAX_MTU while a CAN XL node is
>>>> running.
>>>
>>> No, not while it is running (== up).
>>> My point was that you can set the MTU as long as the interface is not "up".
>>> Together with the default initial values (see below) this makes perfect sense to
>>> me.
>>>
>>>> I want to first study the other interfaces (e.g. ethernet) and the core net
>>>> infrastructure in order to make my mind. For the moment, I am just undecided.
>>>
>>> I'm not sure if ethernet is a good example for our use-case with different CAN
>>> protocols types (CC/FD/XL) which is more than having ethernet frames of
>>> different length.
>>
>> I agree that we should not switch between MTUs of different protocols while the
>> interface is up.
>>
>> My point is just to allow switching the MTU to anything between CANXL_MIN_MTU
>> and CANXL_MAX_MTU on a CAN XL interface which is up. So the use case is also
>> just one protocol type (CAN XL). And that, I think, is comparable to Ethernet
>> frames.
> 
> Ok. I did not know that it is possible to change the ethernet MTU on the fly
> when the interface is up. But this would indeed match the CAN XL MIN/MAX MTU
> pattern then. I'm fine with it.

Ack. Note that I am still testing here, so I reserve the right to back out on
this idea if I discover any conflict.

>>>>> 2. When a virtual interface is set to "up" the MTU is used and fixed.
>>>>
>>>> Same as above, mostly agreed aside from the CAN XL on which I do not yet
>>>> have my
>>>> final opinion.
>>>>
>>>>> 3. When a real interface is set to up the mtu is set to ...
>>>>>     a. mtu = CAN_MTU when fd off and xl off
>>>>>     b. mtu = CANFD_MTU when fd on and xl off
>>>>>     c. mtu = the configured CAN XL MTU (*) when xl on
>>>>>
>>>>> (*) when the configured mtu is not in the range of CANXL_MIN_MTU and
>>>>> CANXL_MAX_MTU the mtu is set to CANXL_MAX_MTU.
>>>>>
>>>>> By default the initial MTU of virtual CAN interfaces should be set to
>>>>> CANXL_MTU.
>>>>>
>>>>> By default the initial MTU of real CAN interfaces should be set to the maximum
>>>>> value which the real CAN interface is capable too:
>>>>>    a. CAN_CTRLMODE_XL supported -> CANXL_MTU.
>>>>>    b. CAN_CTRLMODE_FD supported -> CANFD_MTU.
>>>>>    c. default CAN_MTU
>>>>
>>>> I was thinking of the opposite:
>>>>
>>>>     a. if the device is CAN FD static it is CANFD_MTU
>>>>     b. if the device is CAN XL static it is CANXL_MTU
>>>>     c. otherwise, it is the CAN_MTU by default
>>>>
>>>> which, if you remove point b., happens to be the current logic. I do not see a
>>>> need to change this.
>>>
>>> I like that approach of having the supported MTUs as default and later reduce
>>> the MTU based on fd=off and xl=off, because it would be similar with the virtual
>>> CAN configuration then.
>>
>> vcan's MTU is set to CANFD_MTU. You still need to manually increase it to enable
>> xl. But fair enough, we could modify the vcan default to CANXL_MTU so that it
>> works as you just described.
> 
> Yes. I changed to initial value from CC to FD here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?
> id=97edec3a11cf6f73f2e45c3035b5ff8e4c3543dd
> 
> Therefore it makes sense to do this for CAN XL again.

Agreed. I will add one patch to change this as well (otherwise, I will not touch
the vcan logic, as discussed).

>> But I do not see the parallel. On vcan, FD is turned on by default. On real
>> interfaces, CAN_CTRLMODE_FD is turned off by default. Why should we be trying to
>> spot similarities on something which is different in the first place?
> 
> We should generally separate the configuration of interfaces with netlink
> ctrlmode support (real CAN interfaces) from virtual CAN interfaces that don't
> know about  CAN_CTRLMODE_FD. See my personal summary below.
> 
>> What I dislike the most is that there is an existing logic for the real
>> interfaces. The MTU is set by default to CAN_MTU here:
>>
>>    https://elixir.bootlin.com/linux/v6.16/source/drivers/net/can/dev/dev.c#L242
>>
>> and is modified only if the device is CAN FD static here:
>>
>>    https://elixir.bootlin.com/linux/v6.16/source/include/linux/can/dev.h#L144
>>
>> Here, we are not adding a new feature, but extending an existing one. So you
>> would need a strong argument to justify a change going in the opposite direction
>> of the current logic.
> 
> Ok. You convinced me. Please follow the current approach.
> Every CAN interface starts with CAN_MTU unless they are static FD/XL interfaces.

Thanks!

>> I see that can_change_mtu() is currently broken, so that's a strong enough
>> reason to change it. But the default MTU logic looks coherent to me so I do not
>> get why that should change.
>>
>>> I assume the initial MTU isn't looked at by the users anyway.
>>
>> The user may look at it. It is better not to make assumptions here.
>>
>> The design must be such that the netlink always reports a coherent configuration
>> at any point in time.
>>
>>>> If we set CANXL_MTU by default on XL capable devices, it means that at a moment
>>>> in time, we have a device with the CAN_CTRLMODE_XL off but with a CAN XL MTU.
>>>
>>> ???
>>>
>>> Maybe I was not clear enough:
>>>
>>> You intitialize the MTU to CANXL_MTU when CAN_CTRLMODE_XL is a "supported mode".
>>> The interface is not "up" at this time and therefore the MTU is not on active
>>> service.
>>>
>>> Then you configure the interface with bitrates and xl/fd on/off.
>>>
>>> And then you set the interface to "up" and in this process the MTU is set as a
>>> valid and activated value with a MTU based on the xl/fd on/off settings. This
>>> was my idea.
>>
>> Then, why do we need to set an MTU in the first place? The user must call the
>> netlink interface at least once.
>>
>> If I follow your point, we might as well set it to zero at the beginning to just
>> signal that the interface is not ready and that the MTU is unknown.
>>
>> Also, consider the following. If I connect a real device and do right away a:
>>
>>    ip link set can0 type can xl off
>>
>> then, what is supposed to happen?
> 
> Nothing. There is no bitrate configured.
> 
>> This is supposed to be NOP (the CAN_CTRLMODE_XL is off at the beginning).
>>
>> But then, should the MTU change? If yes, should it change to the CANFD_MTU or to
>> the CAN_MTU?
>>
>> That's why I am saying that having a disconnection between the MTU and the
>> control modes is bad. Your logic creates some edge cases for no valid reason.
>>
>> The simple logic would be this:
>>
>>         fd off, xl off        fd on, xl off        fd any, xl on
>>    ---------------------------------------------------------------------------
>>    default mtu    CAN_MTU            CANFD_MTU        CANXL_MTU
>>    min mtu    CAN_MTU            CANFD_MTU        CANXL_MIN_MTU
>>    max mtu    CAN_MTU            CANFD_MTU        CANXL_MAX_MTU
>>
>> Each time the user touches the fd and xl flags, the MTU, MTU MIN and MTU_MAX
>> triplet is modified accordingly in can_changelink() to the values in above table
>> and this way, you are always in a coherent state in which the MTU matches the
>> control mode flags.
>>
> 
> Yes, that's fine.
> 
> Will the user defined MTU for CAN XL survive the settings when xl is set to off
> and then set to on again?

Unfortunately no. Or at least not without adding one additional field to save
the old value.

But after turning FD or XL off, none on the bittiming parameters would survive
either. So I think it is coherent to say that the user has to set everything
again each time XL is switched on.

>>>> And this is inconsistent. For me, the MTU should always match the control mode
>>>> flags. Because all control modes are off at the beginning, the MTU is thus the
>>>> Classical CAN one.
>>>>
>>>>> I think this should make it clearer and fix the current inconsistency.
>>>>>
>>>>> Setting the CANFD_MTU via the ip set mtu feature and expect "fd on" being
>>>>> set at
>>>>> the same time is bad.
>>>>
>>>> OK. Aside of a few details, I think we agree on the big lines. The good
>>>> thing is
>>>> that the current can_change_mtu() only targets the real interfaces. The virtual
>>>> ones already have their own functions and so will not get impacted.
>>>
>>> Right. The virtual CAN stuff can stay as-is.
>>>
>>>> So I am just thinking of doing a full rewrite of can_change_mtu(). The old
>>>> logic
>>>> of being able to implicitly set the fd flag by providing an MTU will go to the
>>>> trash can.
>>>
>>> Yes. That was not consistent and clear in the usage.
>>>
>>> With my suggestion the can_change_mtu() will be just a simple setting of values
>>> which is the same for real and virtual interfaces.
>>> For real interfaces we might make some additional checks against the "supported
>>> modes" for FD and XL.
>>>
>>> And when the real interface is set to "up" the MTU is adjusted to the real cc/
>>> fd/xl configuration values. I hope this makes it clear now.
>>>
>>>> The new logic will try to follow as much as possible the intended MTU
>>>> logic of the core net framework (which I am still studying).
>>>
>>> Don't expect too much for our use-case there ;-)
>>
>> There is one feature that I would really like to use:
>>
>>    net_device->min_mtu
>>
>> and
>>
>>    net_device->max_mtu
>>
>> Once you set those, you automatically get:
>>
>>    - validation by the core infrastructure that the user's inputs are in range
>>    - reporting of those min and max MTU values through the netlink interface
>>
>> The first point is a nice to have. This way, the devices are not forced anymore
>> to populate net_device_ops->ndo_change_mtu.
>>
>> The second point is what looks the most important to me. I am incapable of
>> remembering what are the actual values of CANXL_MIN_MTU and CANXL_MAX_MTU. If we
>> advertise those through netlink, then I can easily confirm the range.
> 
> Ok. Nice.
> 
> To sum it up for myself:
> 
> 1. Setting the MTU from user space is only relevant for virtual CAN interfaces
> and CAN XL interfaces for values between CANXL_MIN_MTU and CANXL_MAX_MTU.

Ack.

> 2. Usually the MTU is set automatically by the netlink configuration process
> when fd/xl on/off are set.

Ack.

As you will see, I found some bug because a few drivers forgot to set their
can_change_mtu() and addressed the issue here:

https://lore.kernel.org/linux-can/20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org/

That series is just to fix things and is meant to be back ported to stable.

I will send a couple more patches as an RFC which will implement the actual
logic which we discussed here.


Yours sincerely,
Vincent Mailhol


