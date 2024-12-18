Return-Path: <linux-can+bounces-2432-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698BC9F6134
	for <lists+linux-can@lfdr.de>; Wed, 18 Dec 2024 10:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC2E7A6C2D
	for <lists+linux-can@lfdr.de>; Wed, 18 Dec 2024 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B455B198A17;
	Wed, 18 Dec 2024 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CMPopr6V";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ANvRxeRK"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292018D656
	for <linux-can@vger.kernel.org>; Wed, 18 Dec 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513234; cv=pass; b=GQ5D1ztTBRmPBKLK0YgQ68EHQoxtPhF42nH2QktMnTxHfIKQUxAydueRsmmQ5gvW5L8p3iCayiE+NokQRNctB5O1olfruwhKOvmqMfK8bvOhLYArPU1RINS6K4aJmueB5Z4EaB/cwXEsR1emAaJP21dnRUH1iKoDlXruyc/YSwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513234; c=relaxed/simple;
	bh=Y18s+4VVT4dg36GTDZJKyU49pInsxZBFu06jZqbpO/0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RCEfScwWuizAJ99akcbUAY0+kYFPA9Lk/ZYsOk0vLywE9MiOtqYHjPjGE6o9pH4xVPjdLZ/Ipol/5bDqxCG9IGNYrCJN0UDdZPeuNXudDUe7rLwwye48WC5O0Ig1JzieYSphEg8y9sL4eWLCgTK9YhkBYSrHCuPpnT2aZJz93Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CMPopr6V; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ANvRxeRK; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1734513226; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kE8raTA/EnO5I+h5mUrw/W0UOUQRuesPjq4VaM8Lk4OA6V1cb6ztjzhonNUcHOddJp
    X44MEpTwx65kjl5rTqkUiF5MPZM0jJsi6dsnebUpbGtE9luHMma02W5fZC6m/kn/P4Tl
    xjqBfhR4NnkNML7Mrqu18ZEfSDX/iK4lGnjON84LpGUKCrLCHRhIW9tAGsP9iKnS2xUE
    Kpm5LEckT+F8EQHgi54BXMUA/Qp7zVzZoOy3MPjMQ7aav2q3q/m1SS9VRBZX22DaaVDf
    XW7+FWC1d7g+RfxTPG4f/VBo1ESodZ0jIik9RChnxgFYk6VRinsGcO3jWOQJZp/GLIBT
    5I3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1734513226;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QtyKHCmVGCHmoXHsCtu9Ao/ry7v/esFm36yjRNhUWDE=;
    b=eELVUqYEYZNDgWC2Xl4u8xJpRbvTT3IczS5HueG3uRnqJqC6IFKdluMVtBZx59k9Zn
    ZFjULOdL42ZOHYCpXeIFc1/OAbBhsedWOa3b//Mqn/ifuVYhTmVxbQOu19gp1Avok3Ti
    9B83B/4Q4aTcboUYIAV3yh3FTaVJkYZAeC9X+6tIofyj+ZgQ36P5aqVs8neO7WlMMoGI
    6FbS2lHSmQPhCKwfLbsJq/edkkCIcfUJuLwx04MjEO1GH++TYRai+2RmM+ENi27F8o+X
    /HsqXJWgS7neiB3boAF1G+/xt7dRDgR0PgxKq1tHFguPp31AxFKvpvay3YSVSbpOMNHO
    7qHQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1734513226;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QtyKHCmVGCHmoXHsCtu9Ao/ry7v/esFm36yjRNhUWDE=;
    b=CMPopr6V1NONTVI/syrnPQj1eDhR/Txm6qcQx3/8cLLOA8VKMBF9mtG7WXPdasJI5C
    hRlaFMSHeabnWSe2alvaMTi/UfaVnLjQ1ozMoY6M2om8GbN+AEyYBH+98zWQ4vozD2Cl
    feLb5sIcrpUq2+JWyJ69VL6V8tnk5583NQlr0qQOe9o0m6ecyq1FttRlA8IV8BkWsz6u
    60uiR+I/TmWChdE7FGcBwRZCXNAd3eJKkqUUnu9i2K70YEra4TCUnkwas70EjYuk4+r9
    DHiyWIPYRuA0DCuPmtp5BArClhouQhVv/ybe4xEKNYfloelYRKvqg9/cQYjUo+aYgVXy
    DIeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1734513226;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QtyKHCmVGCHmoXHsCtu9Ao/ry7v/esFm36yjRNhUWDE=;
    b=ANvRxeRKxf1HzHuuUcftTO1xcw1Qle2pwjNJYyISieQ/+Yy5ok1nqtVFFfwWtuzave
    e50p419o4+bnoRz2PgCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5010::9f3]
    by smtp.strato.de (RZmta 51.2.15 AUTH)
    with ESMTPSA id K189d10BI9DW7pD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 18 Dec 2024 10:13:32 +0100 (CET)
Message-ID: <73729742-e650-4e02-9e62-a5f8c945529f@hartkopp.net>
Date: Wed, 18 Dec 2024 10:13:27 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Robert Nawrath <mbro1689@gmail.com>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <ea52eb8f-c59d-445a-bf4d-26f2772f7426@hartkopp.net>
 <a9d8eb65-c88d-4bc9-b0c2-c0e0799ea5bd@wanadoo.fr>
 <23c914cf-0af2-4619-9f83-e4b6339ef65f@hartkopp.net>
 <12e013c2-d6ff-42b2-91ef-921db4e7ee0e@hartkopp.net>
 <77331a33-ac82-4cfb-9881-159d6d2daf58@hartkopp.net>
 <CAMZ6RqLi1oywkSZ=pVFnV04efwk8mJWmwP+FzSyMknR2d+9=RA@mail.gmail.com>
 <8be877db-028a-413f-b55d-71311e0c88c9@hartkopp.net>
 <c4771c16-c578-4a6d-baee-918fe276dbe9@wanadoo.fr>
 <2bd47866-a995-4359-9639-724cd8a90a43@hartkopp.net>
 <4acc968e-d30e-400f-bc40-d4fc9f5299de@wanadoo.fr>
 <42b6acd2-dc9d-471b-b273-9b8094840935@hartkopp.net>
Content-Language: en-US
In-Reply-To: <42b6acd2-dc9d-471b-b273-9b8094840935@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Addition ...

On 17.12.24 21:03, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 17.12.24 19:17, Vincent Mailhol wrote:
>> On 17/12/2024 at 18:53, Oliver Hartkopp wrote:
>>
>> (...)
>>
>>>>> I assume it will follow the TDC pattern with
>>>>> CAN_CTRLMODE_XL_PWM_AUTO and CAN_CTRLMODE_XL_PWM_MANUAL
>>>>> or something similar?
>>>>
>>>> I am not sure why we would need a tristate here. The reason why I put
>>>> the tristate for the TDC is because some transceiver (the majority) 
>>>> will
>>>> automatically measure TDCV but some may give the option for the user to
>>>> manually set it.
>>>>
>>>>   From what I understand from the specification, PWMO is not something
>>>> which is dynamically measured. If I got it right, it is just the
>>>> remainder whenever the bit time is not a multiple of PWM. Something 
>>>> like
>>>> this:
>>>>
>>>>     pwmo = bit_time_in_minimum_time_quantum % pwm;
>>>>
>>>> Same for the PWMS and PWML. I am not yet sure how to calculate those
>>>> (more on this below) but these seem to be calculated once for all (like
>>>> any bittimming value other than the TDCs).
>>>>
>>>> Let me know if I missed something, the PWM is very new to me :)
>>>>
>>>>
>>>> So, for the implementation, I am thinking of:
>>>
>>> The PWM stuff is some very CAN XL specific therefore I would suggest to
>>> bring this into the naming too:
>>
>> It is specific to CAN XL for the moment. But if I do a parallel, before
>> CAN XL existed, the TDC was specific to CAN FD. But the structure was
>> named can_tdc, not can_fd_tdc, and now that the CAN XL reuses the TDC,
>> it comes in handy that the structure did not have fd in the name.
>>
>> The CAN XL still have a resXL flag for potential future extension, if
>> one day there is a CAN XXL, then the PWM would not be specific to CAN XL
>> anymore.
>>
>> My approach will be to:
>>
>>    - name structures and entries within a netlink nest in a generic
>>      manner
>>    - name struct fields (e.g. in can_priv) and the top level netlink
>>      entries with an XL prefix.
>>
>>>> 1. Add a CAN_CTRLMODE_PWM mode and a new nest for the PWM in netlink.h
>>>
>>> CAN_CTRLMODE_XL_PWM or CAN_CTRLMODE_XLPWM
>>
>> Ack. This flag is specific to CAN XL. I have a preference for
>> CAN_CTRLMODE_XL_PWM (with the underscore between XL and PWM).
> 
> ACK
> 
> 
>>>> 2. Add these to bittiming.c:
>>>>
>>>>     struct can_pwm {
>>> can_xl_pwm or can_xlpwm
>>
>> NACK. I keep can_pwm, but in can_priv, I will name the field:
> 
> Ok. Fine for me.
>>
>>    struct can_pwm xl_pwm;
>>
>>>>         u32 pwms; /* PWM short phase length */
>>>>         u32 pwml; /* PWM long phase length */
>>>>         u32 pwmo; /* PWM offset */
>>> that's fine
>>>
>>>>     };
>>>>
>>>>     struct can_pwm_const {
>>> dito
>>>
>>>>         u32 pwms_max;
>>>>         u32 pwml_max;
>>>>         u32 pwmo_max;
>>>>     };
>>>>
>>>>     static inline u32 can_get_pwm(const struct can_pwm *pwm)
>>>>     {
>>>>         return pwm->pwms + pwm->pwml;
>>>>     }
>>> ??
>>
>> ISO 11898-1:2024 tells me that (quote):
>>
>>    The PWM symbol length is the sum of PWMS and PWML.
>>
>> This inline function was to calculate this PWM symbol length. That said,
>> on second thought, I doubt that the drivers will need this information.
>> I will remove it for the moment. If someone needs it, we can reintroduce
>> this later.
>>
>>>> The minimum value of all those configurable ranges is already specified
>>>> to be one minimum time quantum (tq min), so I do not think we need a
>>>> field for the minimums.
>>>>
>>>>
>>>> At the moment, I am stuck on the PWM calculation. I do not know how to
>>>> derive good PWMS and PWML values out of the const ranges.
>>>>
>>>> The ISO 11898-1:2024 tells me that CiA 612-2 has recommendations on the
>>>> topic. But getting access to this document requires a subscription
>>>> (which I do not have):
>>>>
>>>>
>>>> https://www.can-cia.org/can-knowledge/cia-612-series-can-xl-
>>>> guidelines-and-application-notes
>>>>
>>>> Do any of you have access to this document? Or do any of you know a 
>>>> good
>>>> formula for the PWMS and PWML calculation?
>>>
>>> I have to check for the referenced document.
>>>
>>> Btw. this is some code that shows the idea of how to calculate the PWM
>>> values based on the CAN clock and the XL data bitrate:
>>>
>>>      if (CanClock_mhz == 100 && XlDatarate_mbps == 5) {
>>>          // @5Mbit/s>         pwmo = 0;
>>>          pwms = 6;
>>>          pwml = 14;
>>
>> one bit is 200 nano seconds.
>> one minimum time quantum is 10 ns.
>>
>> pwm = pwms + pwml
>>      = 6 + 14
>>      = 20 minimum time quantum
>>
>> So PWM duration is 20 * 10 = 200 ns. So there is only one PWM per bit.
>>
>>>      } else if (CanClock_mhz == 100) {
>>>          // @10Mbit/s>         pwmo = 0;
>>>          pwms = 3;
>>>          pwml = 7;
>>
>> 1 bit is 100 ns.
>> one minimum time quantum is 10 ns.
>>
>> pwm = pwms + pwml
>>      = 3 + 7
>>      = 10 minimum time quantum
>>
>> So PWM duration is 10 * 10 = 100 ns. So here also, there is only one PWM
>> per bit.
>>
>>>      } else if (CanClock_mhz == 160) {
>>>          // @10Mbit/s>         pwmo = 0;
>>>          pwms = 2;
>>>          pwml = 6;
>>
>> 1 bit is 100 ns.
>> one minimum time quantum is 6.25 ns.
>>
>> pwm = pwms + pwml
>>      = 2 + 6
>>      = 8 minimum time quantum
>>
>> So PWM duration is 8 * 6.25 = 50 ns. This time, there are two PWM per
>> bit. Interesting.
>>>      }
>>
>> So from those value, I derived:
>>
>>    pwms = round_down(30% * pwm)
>>    pwml = round_up(70% * pwm)
>>
>> PWMO was already established as:
>>
>>    pwmo = bit_time_in_minimum_time_quantum % pwm
>>
>> (in your example, the bit time is a multiple of PWM, so the PWMO is 
>> zero).
>>
>> This is some progress. What is not clear yet is how to find the number
>> of PWM per bit (i.e. why is it only one PWM per bit in your first two
>> examples, why is it two PWM per bit in your second example).
>>
>> The ISO has one more formula that I did not yet used. Maybe that's the
>> solution. But it is 3 a.m. here, let's say that this is a problem for
>> the tomorrow me.
>>
>>> For that reason I was thinking about some default calculation provided
>>> by the kernel (CAN_CTRLMODE_XL_PWM_AUTO) and some manual setting if
>>> people want to set the values analog to tseg1 and friends instead of
>>> setting a single bitrate.
>>
>> Don't worry, we have the same final result in mind. It is just that I
>> believe that we can use a trick so that we can do it with a single 
>> flag :)
>>
>> Let me illustrate in more details.
>>
>>    Case 1: PWM off
>>
>>      ip link set can0 (...) xl on pwm off
> 
> Ugh.
> 
> Did you take a look into all my patches from 2024-12-04, e.g.
> 
> https://lore.kernel.org/linux-can/20241204075741.3727-3- 
> socketcan@hartkopp.net/T/#u
> 
> which is introducing CAN_CTRLMODE_XL_TRX ??

It would be nice if you implement the PWM stuff based on these patch 
sets from 2024-12-04. I introduced CAN_CTRLMODE_XL_TRX and 
CAN_CTRLMODE_XL_RRS either in the kernel and in the iproute2 which is 
already operational in my setup.

Thanks,
Oliver

> 
> We are talking about having a CAN XL capable/switchable transceiver 
> attached to the CAN (XL) controller or not. IMO we should also name it 
> accordingly with
> 
> ip link set can0 (...) xl on xltrx off
> 
> That the transceiver switching is done with PWM under the hood is 
> nothing we should disclose to the user in this way IMHO.
> 
>>
>>      - CAN_CTRLMODE_XL_PWM bit is false
>>      - IFLA_CAN_XL_PWM is not provided
>>
>>    Case 2: PWM on auto
>>
>>      ip link set can0 (...) xl on pwm on
>>
>>      - CAN_CTRLMODE_XL_PWM bit is true
>>      - IFLA_CAN_XL_PWM is not provided
>>
>>    Case 3: PWM on manual
>>
>>      ip link set can0 (...) xl on pwm on pwms xxxx pwml yyyy
>>
>>      - CAN_CTRLMODE_XL_PWM bit is false
>>      - IFLA_CAN_XL_PWM is provided (and contains a nest with both
>>        IFLA_CAN_PWMS and IFLA_CAN_PWML)
>>
>> So, here, I use the presence or the absence of the IFLA_CAN_XL_PWM as an
>> hidden flag to know whether the calculation should be done or not.
> 
> Yes, that's a good idea. Excellent default behavior.
> 
> At least when reading IFLA_CAN_XL_PWM the provided or automatically 
> calculated values would become visible.
> 
>> Note that there is one more case:
>>
>>    Case 4: full auto??? (let the kernel decide between PWM on or off)
>>
>>      ip link set can0 (...) xl on
>>
>> Here, the user does not tell if PWM should be on or off. I think that
>> this case should be banned (return error).
> 
> Yes! Good idea!
> 
>> For what I understand, if one
>> node uses PWM and the other doesn't, it just doesn't work. So, contrary
>> to TDC, there is no way to calculate if this should be on or off.
>>
>> (side note: I will be busy for personal reasons until this Sunday, do
>> not be surprised if my next answer is delayed).
> 
> No problem.
> 
> Best regards,
> Oliver
> 
> 


