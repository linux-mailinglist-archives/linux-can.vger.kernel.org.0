Return-Path: <linux-can+bounces-4725-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B9AB81F85
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 23:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382937212AB
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4C72749CE;
	Wed, 17 Sep 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UtVKNtDB"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1966817BB21
	for <linux-can@vger.kernel.org>; Wed, 17 Sep 2025 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144564; cv=pass; b=Nbw1aHsf7e3h/ps9N1KMnaPm+TjU1sGZC+PvT1N12ACGuFvxgZ9eETAwM/l5QmR5xaatUx57K9aLETChFwco7I7SWV32cmBTovanKZjvM1TLaRla2Y01UIYK7ZFFDs3CKIS7rlHSc/va6wb9RrWLNCtjOEFdYbA34F7cSdVZZLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144564; c=relaxed/simple;
	bh=qSYRO+xeuDBJauXGNUvEisprRWbZA9EWSbXHUNykNbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxoMdVBAKJsTsOqmqnzKaXIGdj45om9xuTm/FRWs45tHztR35oTWNYdtblTFFNPXeJ1o2yCguAHVZBdU3NAYYYirsqyX9Xt911/jTPFPR2/Wy8aN+fV+3gMMXe4IEUNQ7sZSl20f8TW65r4mA73B4+nVpG6tR619T33VLWgER2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UtVKNtDB; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1758144551; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JxZ4YrUczp6hjwD2ZCtVuhC2QIoptO9a3URzG92jna73oJqflEVxPByzL3CTcwUDNN
    aamxYeTfv/Hi+BrhepMSDmjSWgErHbd94xrRlDthJ8lnrPuwFxU1WoWTBihPAyhOkuDP
    g6KqgWqGHRwMM42GwXyu9k2h2ZW0GX+EZsbLNdFmbDTd/QaxwZr/c6g852Ca47rTY/MY
    eR1AXD1xVPPPevD+yyBLSQ0VyYZOrwm5u3vFumQ4cXdiuJmsJWEkJbJAN50Por1L9ubm
    /M3aDjjJ+zOrRbd/jxMJg5eDjOj6f0y9OUt5YnajVJYCTUB7QGNCptFVTrdApdVnqA3U
    mSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1758144551;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bXlRHXE7l7fApGcCbA69C6cEbgjAmGL7tMAyQ2KiEzQ=;
    b=B+fxm9wyPBK2Y8Uh4sKlQhdxp5KywOYorOA2Zar79o7M5RIDetZmCCpf0J0j47Ft16
    99QGP2C/e2IACVXcY/h1azeKdtbQmMwkYUiPko9N2VEQCDI10XwcuvDz6JoABaw9gmYo
    WbUY6SJR0aD6wfHk4mX+qz9TTv4ABlhv7mykIXD1AP2HoMjQbNbL+yAOj+aNWwe6rH/m
    33hl37BOeip3ReVMl+qpUif0XN+rVZPQowqAg9WFzfMEiqUHziIFqeuVCXV6zzP1moZW
    dOCP5ocOhvY6ZaZdCq7RIV7NSRfeyC/SPMd5+0nHU2VGsw5cQxDIFd/8ZGAgrU5rtaCv
    AETQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1758144551;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bXlRHXE7l7fApGcCbA69C6cEbgjAmGL7tMAyQ2KiEzQ=;
    b=UtVKNtDBTR2hHZUzBVzQ8I55MALNrnUUVgAr2bON/3O4Fu1Aq3cxMdI/C4C2I0sygK
    FHNmZkMxqNJsm8vSnt/w2RdMCMaZYjmuN4IhYgg8EAa/xMWSNWZtPHZEM78vKbr2UXHa
    ibcdjneMNzWD0nZkPPdHbHUotn257JFFe7C3uKq3wUnVdM0L+Z/hAQYjE67T6IDolrow
    DtuUO9htQdhTl+XB4F6GNJKQE2+M4jxzjMKxRw/tW3v7/Gd45wu2Qg9eDDldEhClerWC
    aXGFCdZbDbbXiLbsP5butIAsJv4cYNY2Pr4xh8cgNcBQlY3mY7buxHDFA+Hrzwr5Ky81
    yl7A==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tR5FgtOb3TQGXSU4="
Received: from [192.168.23.131]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K2a23218HLTBCEY
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 17 Sep 2025 23:29:11 +0200 (CEST)
Message-ID: <a85dec20-e638-4069-8355-9cbf4d2d278e@hartkopp.net>
Date: Wed, 17 Sep 2025 23:29:04 +0200
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <204b2bbf-eeb6-492d-9842-4720ba6c055b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.09.25 15:17, Vincent Mailhol wrote:
> On 16/09/2025 at 18:14, Oliver Hartkopp wrote:
>> On 15.09.25 20:54, Vincent Mailhol wrote:
>>> On 16/09/2025 at 03:08, Oliver Hartkopp wrote:
>>
>>>> I think the interface to set the MTU lacks a clear separation of how to set the
>>>> MTU for real (hardware) CAN interfaces and virtual CAN interfaces.
>>>
>>> Ack.
>>>
>>>> 1. IMO we should be able to set the MTUs on virtual and real interfaces when the
>>>> interface is down (as those MTUs have no effect at this time).
>>>
>>> Mostly agreed. It should not be possible to switch between the Classical CAN,
>>> CAN FD or CAN XL MTUs. But I do not yet see an issue to change the MTU to
>>> something in between CANXL_MIN_MTU and CANXL_MAX_MTU while a CAN XL node is
>>> running.
>>
>> No, not while it is running (== up).
>> My point was that you can set the MTU as long as the interface is not "up".
>> Together with the default initial values (see below) this makes perfect sense to
>> me.
>>
>>> I want to first study the other interfaces (e.g. ethernet) and the core net
>>> infrastructure in order to make my mind. For the moment, I am just undecided.
>>
>> I'm not sure if ethernet is a good example for our use-case with different CAN
>> protocols types (CC/FD/XL) which is more than having ethernet frames of
>> different length.
> 
> I agree that we should not switch between MTUs of different protocols while the
> interface is up.
> 
> My point is just to allow switching the MTU to anything between CANXL_MIN_MTU
> and CANXL_MAX_MTU on a CAN XL interface which is up. So the use case is also
> just one protocol type (CAN XL). And that, I think, is comparable to Ethernet
> frames.

Ok. I did not know that it is possible to change the ethernet MTU on the 
fly when the interface is up. But this would indeed match the CAN XL 
MIN/MAX MTU pattern then. I'm fine with it.

>>>> 2. When a virtual interface is set to "up" the MTU is used and fixed.
>>>
>>> Same as above, mostly agreed aside from the CAN XL on which I do not yet have my
>>> final opinion.
>>>
>>>> 3. When a real interface is set to up the mtu is set to ...
>>>>     a. mtu = CAN_MTU when fd off and xl off
>>>>     b. mtu = CANFD_MTU when fd on and xl off
>>>>     c. mtu = the configured CAN XL MTU (*) when xl on
>>>>
>>>> (*) when the configured mtu is not in the range of CANXL_MIN_MTU and
>>>> CANXL_MAX_MTU the mtu is set to CANXL_MAX_MTU.
>>>>
>>>> By default the initial MTU of virtual CAN interfaces should be set to CANXL_MTU.
>>>>
>>>> By default the initial MTU of real CAN interfaces should be set to the maximum
>>>> value which the real CAN interface is capable too:
>>>>    a. CAN_CTRLMODE_XL supported -> CANXL_MTU.
>>>>    b. CAN_CTRLMODE_FD supported -> CANFD_MTU.
>>>>    c. default CAN_MTU
>>>
>>> I was thinking of the opposite:
>>>
>>>     a. if the device is CAN FD static it is CANFD_MTU
>>>     b. if the device is CAN XL static it is CANXL_MTU
>>>     c. otherwise, it is the CAN_MTU by default
>>>
>>> which, if you remove point b., happens to be the current logic. I do not see a
>>> need to change this.
>>
>> I like that approach of having the supported MTUs as default and later reduce
>> the MTU based on fd=off and xl=off, because it would be similar with the virtual
>> CAN configuration then.
> 
> vcan's MTU is set to CANFD_MTU. You still need to manually increase it to enable
> xl. But fair enough, we could modify the vcan default to CANXL_MTU so that it
> works as you just described.

Yes. I changed to initial value from CC to FD here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=97edec3a11cf6f73f2e45c3035b5ff8e4c3543dd

Therefore it makes sense to do this for CAN XL again.

> But I do not see the parallel. On vcan, FD is turned on by default. On real
> interfaces, CAN_CTRLMODE_FD is turned off by default. Why should we be trying to
> spot similarities on something which is different in the first place?

We should generally separate the configuration of interfaces with 
netlink ctrlmode support (real CAN interfaces) from virtual CAN 
interfaces that don't know about  CAN_CTRLMODE_FD. See my personal 
summary below.

> What I dislike the most is that there is an existing logic for the real
> interfaces. The MTU is set by default to CAN_MTU here:
> 
>    https://elixir.bootlin.com/linux/v6.16/source/drivers/net/can/dev/dev.c#L242
> 
> and is modified only if the device is CAN FD static here:
> 
>    https://elixir.bootlin.com/linux/v6.16/source/include/linux/can/dev.h#L144
> 
> Here, we are not adding a new feature, but extending an existing one. So you
> would need a strong argument to justify a change going in the opposite direction
> of the current logic.

Ok. You convinced me. Please follow the current approach.
Every CAN interface starts with CAN_MTU unless they are static FD/XL 
interfaces.

> I see that can_change_mtu() is currently broken, so that's a strong enough
> reason to change it. But the default MTU logic looks coherent to me so I do not
> get why that should change.
> 
>> I assume the initial MTU isn't looked at by the users anyway.
> 
> The user may look at it. It is better not to make assumptions here.
> 
> The design must be such that the netlink always reports a coherent configuration
> at any point in time.
> 
>>> If we set CANXL_MTU by default on XL capable devices, it means that at a moment
>>> in time, we have a device with the CAN_CTRLMODE_XL off but with a CAN XL MTU.
>>
>> ???
>>
>> Maybe I was not clear enough:
>>
>> You intitialize the MTU to CANXL_MTU when CAN_CTRLMODE_XL is a "supported mode".
>> The interface is not "up" at this time and therefore the MTU is not on active
>> service.
>>
>> Then you configure the interface with bitrates and xl/fd on/off.
>>
>> And then you set the interface to "up" and in this process the MTU is set as a
>> valid and activated value with a MTU based on the xl/fd on/off settings. This
>> was my idea.
> 
> Then, why do we need to set an MTU in the first place? The user must call the
> netlink interface at least once.
> 
> If I follow your point, we might as well set it to zero at the beginning to just
> signal that the interface is not ready and that the MTU is unknown.
> 
> Also, consider the following. If I connect a real device and do right away a:
> 
>    ip link set can0 type can xl off
> 
> then, what is supposed to happen?

Nothing. There is no bitrate configured.

> This is supposed to be NOP (the CAN_CTRLMODE_XL is off at the beginning).
> 
> But then, should the MTU change? If yes, should it change to the CANFD_MTU or to
> the CAN_MTU?
> 
> That's why I am saying that having a disconnection between the MTU and the
> control modes is bad. Your logic creates some edge cases for no valid reason.
> 
> The simple logic would be this:
> 
> 		fd off, xl off		fd on, xl off		fd any, xl on
>    ---------------------------------------------------------------------------
>    default mtu	CAN_MTU			CANFD_MTU		CANXL_MTU
>    min mtu	CAN_MTU			CANFD_MTU		CANXL_MIN_MTU
>    max mtu	CAN_MTU			CANFD_MTU		CANXL_MAX_MTU
> 
> Each time the user touches the fd and xl flags, the MTU, MTU MIN and MTU_MAX
> triplet is modified accordingly in can_changelink() to the values in above table
> and this way, you are always in a coherent state in which the MTU matches the
> control mode flags.
> 

Yes, that's fine.

Will the user defined MTU for CAN XL survive the settings when xl is set 
to off and then set to on again?

>>> And this is inconsistent. For me, the MTU should always match the control mode
>>> flags. Because all control modes are off at the beginning, the MTU is thus the
>>> Classical CAN one.
>>>
>>>> I think this should make it clearer and fix the current inconsistency.
>>>>
>>>> Setting the CANFD_MTU via the ip set mtu feature and expect "fd on" being set at
>>>> the same time is bad.
>>>
>>> OK. Aside of a few details, I think we agree on the big lines. The good thing is
>>> that the current can_change_mtu() only targets the real interfaces. The virtual
>>> ones already have their own functions and so will not get impacted.
>>
>> Right. The virtual CAN stuff can stay as-is.
>>
>>> So I am just thinking of doing a full rewrite of can_change_mtu(). The old logic
>>> of being able to implicitly set the fd flag by providing an MTU will go to the
>>> trash can.
>>
>> Yes. That was not consistent and clear in the usage.
>>
>> With my suggestion the can_change_mtu() will be just a simple setting of values
>> which is the same for real and virtual interfaces.
>> For real interfaces we might make some additional checks against the "supported
>> modes" for FD and XL.
>>
>> And when the real interface is set to "up" the MTU is adjusted to the real cc/
>> fd/xl configuration values. I hope this makes it clear now.
>>
>>> The new logic will try to follow as much as possible the intended MTU
>>> logic of the core net framework (which I am still studying).
>>
>> Don't expect too much for our use-case there ;-)
> 
> There is one feature that I would really like to use:
> 
>    net_device->min_mtu
> 
> and
> 
>    net_device->max_mtu
> 
> Once you set those, you automatically get:
> 
>    - validation by the core infrastructure that the user's inputs are in range
>    - reporting of those min and max MTU values through the netlink interface
> 
> The first point is a nice to have. This way, the devices are not forced anymore
> to populate net_device_ops->ndo_change_mtu.
> 
> The second point is what looks the most important to me. I am incapable of
> remembering what are the actual values of CANXL_MIN_MTU and CANXL_MAX_MTU. If we
> advertise those through netlink, then I can easily confirm the range.

Ok. Nice.

To sum it up for myself:

1. Setting the MTU from user space is only relevant for virtual CAN 
interfaces and CAN XL interfaces for values between CANXL_MIN_MTU and 
CANXL_MAX_MTU.

2. Usually the MTU is set automatically by the netlink configuration 
process when fd/xl on/off are set.

Right?

Best regards,
Oliver


