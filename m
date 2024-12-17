Return-Path: <linux-can+bounces-2430-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B637E9F576B
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 21:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C5F188E856
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 20:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD1F749C;
	Tue, 17 Dec 2024 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mu8mex5a";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dNPw+1s0"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B581531D5
	for <linux-can@vger.kernel.org>; Tue, 17 Dec 2024 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466533; cv=pass; b=fzkMtuRMS/Fmi3MXBTQYYmJFgXIITxSf91BVL3YIBuq3eCPPVboCM3uJE2pRhsu3Y2MjWnF2twhtPVvmsmnXijbQ1HeeY8V54ccHq1rYrOpH9ceXdYFVS3ddla0pDPPXxLOKoHPCC5ptrBjIodU8eSRGhVfhIlCrkaMNoq4Xgog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466533; c=relaxed/simple;
	bh=hpUWWR+M8KqgbeK+uphYX729G3yQVqTzY54c4PpBOIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eg4UEQ/5UtkLs70iPfsc208p2/IHE0rjQAqMRfBPadOCoXYICY1MWbnR3Uw4wxc9bh56xIZ0hA1S5qRJzOE290OOMICwc/WBlIQZuGR4zSc8IfqEkFPIgx2Wwpn0o6EjpxdZHYnfNonFofN1ToFam1qELo6dWFKdZnR8FLaGtfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mu8mex5a; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dNPw+1s0; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1734465803; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FN3d6ZuMPGwe7Ix7cS4SrNMLNCrn5/BXMfme82ixHgqqQ075AEvbzkCjzh4gKnznER
    LPEY0g/KtPbYTKjU2UBusKCbj2PVggM/Bsy9oDY2Snfmal8hbaB5nFH0a3szGTlv+Xu4
    LG8lVm1rPVYgXjbHcdofjK/w9WvIf8q2i2wpBNse1Pq7iWhwvu9EzrSW+CVtLBbWVYLw
    1kdbxPdZ0eocrlqGmgW6XDD4HD3aKuXQwgcjJ38n3YIOpBxnJ1UAwuVmK05TAlFGSG7S
    6yY+UH81bcBRNrQmGtr+wUpmi0+rrAXW7vzEi+f8YnRQOc32cPKi2vhTDjjJ0B86ABzQ
    FGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1734465803;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kqummsWQ2HeWgBeOoeRfV/0PNHYNWNus28ejkYWI9TU=;
    b=FfXY9yL4sB5eCYX6XeI2CNRxeAkNLaSUpKeO/ckTgWidOsRkKUxfidyey1LK0glkl+
    09MJ5h3GCGEeYK0w1GJjktAeVd3IXol1/BbGma11c/WQuOnx4KqbcgVtQYbHhfuQgB7E
    mYvGuDuzpfbgBlxmmjWxCPpCJRv1BeXfnwPJzaKxfmf/fcP1GgRuo1WVq2JyMBDHv7Bc
    78H1RIUKlgRY/pbJxnMXC+MoQhsSI/kcDNZmbAp8IU9CCZ9FGHna1clnpLrQDBxw5mN+
    vKhJDIm/DzJdV5F62FO962Y7Fi3G33PnjEFfUnaZneAJuGw1jhauYKqUapxHlqxpJz7p
    5gIg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1734465803;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kqummsWQ2HeWgBeOoeRfV/0PNHYNWNus28ejkYWI9TU=;
    b=mu8mex5amUXENrt5l6UVW0OYPlU4xt50ifxADr1QvsGeH+GNRTtRwTxVEcqAGgIeGB
    4d43OseREfDhXPGzhraMUj8DcI5Pg4GE7QTQY7coz7HDqHr9eaib9JUSbspReU8LwySV
    5XxnyMArBvDkpK7MBTwfSdyKBFxH+kXIS5C+1rX5tKPP4SNzdE18Dnm0LBYTIXjhq6E1
    56NtObuzeZZpD4yIjGPh6RUZ5F2nvDLehx5GVDlx3AhgmE05g7X77u23+BY5vIjFYue3
    2HdX7Y3X1OGeK/4CwNRWOIPl6pSayWr4yuxoAHANG7VoJ/N3waQD1MX4SemKl2LylXVk
    xJrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1734465803;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kqummsWQ2HeWgBeOoeRfV/0PNHYNWNus28ejkYWI9TU=;
    b=dNPw+1s0ZHGErxLXewG7Cd+hz87rUeU3ac0BKe68qoBXLzNQ91ppZnmd+gobQZmWOo
    QDd8LfOfh/9AeIv0cFAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5010::9f3]
    by smtp.strato.de (RZmta 51.2.15 AUTH)
    with ESMTPSA id K189d10BHK3N6Vq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Dec 2024 21:03:23 +0100 (CET)
Message-ID: <42b6acd2-dc9d-471b-b273-9b8094840935@hartkopp.net>
Date: Tue, 17 Dec 2024 21:03:23 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <4acc968e-d30e-400f-bc40-d4fc9f5299de@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 17.12.24 19:17, Vincent Mailhol wrote:
> On 17/12/2024 at 18:53, Oliver Hartkopp wrote:
> 
> (...)
> 
>>>> I assume it will follow the TDC pattern with
>>>> CAN_CTRLMODE_XL_PWM_AUTO and CAN_CTRLMODE_XL_PWM_MANUAL
>>>> or something similar?
>>>
>>> I am not sure why we would need a tristate here. The reason why I put
>>> the tristate for the TDC is because some transceiver (the majority) will
>>> automatically measure TDCV but some may give the option for the user to
>>> manually set it.
>>>
>>>   From what I understand from the specification, PWMO is not something
>>> which is dynamically measured. If I got it right, it is just the
>>> remainder whenever the bit time is not a multiple of PWM. Something like
>>> this:
>>>
>>>     pwmo = bit_time_in_minimum_time_quantum % pwm;
>>>
>>> Same for the PWMS and PWML. I am not yet sure how to calculate those
>>> (more on this below) but these seem to be calculated once for all (like
>>> any bittimming value other than the TDCs).
>>>
>>> Let me know if I missed something, the PWM is very new to me :)
>>>
>>>
>>> So, for the implementation, I am thinking of:
>>
>> The PWM stuff is some very CAN XL specific therefore I would suggest to
>> bring this into the naming too:
> 
> It is specific to CAN XL for the moment. But if I do a parallel, before
> CAN XL existed, the TDC was specific to CAN FD. But the structure was
> named can_tdc, not can_fd_tdc, and now that the CAN XL reuses the TDC,
> it comes in handy that the structure did not have fd in the name.
> 
> The CAN XL still have a resXL flag for potential future extension, if
> one day there is a CAN XXL, then the PWM would not be specific to CAN XL
> anymore.
> 
> My approach will be to:
> 
>    - name structures and entries within a netlink nest in a generic
>      manner
>    - name struct fields (e.g. in can_priv) and the top level netlink
>      entries with an XL prefix.
> 
>>> 1. Add a CAN_CTRLMODE_PWM mode and a new nest for the PWM in netlink.h
>>
>> CAN_CTRLMODE_XL_PWM or CAN_CTRLMODE_XLPWM
> 
> Ack. This flag is specific to CAN XL. I have a preference for
> CAN_CTRLMODE_XL_PWM (with the underscore between XL and PWM).

ACK


>>> 2. Add these to bittiming.c:
>>>
>>>     struct can_pwm {
>> can_xl_pwm or can_xlpwm
> 
> NACK. I keep can_pwm, but in can_priv, I will name the field:

Ok. Fine for me.
> 
>    struct can_pwm xl_pwm;
> 
>>>         u32 pwms; /* PWM short phase length */
>>>         u32 pwml; /* PWM long phase length */
>>>         u32 pwmo; /* PWM offset */
>> that's fine
>>
>>>     };
>>>
>>>     struct can_pwm_const {
>> dito
>>
>>>         u32 pwms_max;
>>>         u32 pwml_max;
>>>         u32 pwmo_max;
>>>     };
>>>
>>>     static inline u32 can_get_pwm(const struct can_pwm *pwm)
>>>     {
>>>         return pwm->pwms + pwm->pwml;
>>>     }
>> ??
> 
> ISO 11898-1:2024 tells me that (quote):
> 
>    The PWM symbol length is the sum of PWMS and PWML.
> 
> This inline function was to calculate this PWM symbol length. That said,
> on second thought, I doubt that the drivers will need this information.
> I will remove it for the moment. If someone needs it, we can reintroduce
> this later.
> 
>>> The minimum value of all those configurable ranges is already specified
>>> to be one minimum time quantum (tq min), so I do not think we need a
>>> field for the minimums.
>>>
>>>
>>> At the moment, I am stuck on the PWM calculation. I do not know how to
>>> derive good PWMS and PWML values out of the const ranges.
>>>
>>> The ISO 11898-1:2024 tells me that CiA 612-2 has recommendations on the
>>> topic. But getting access to this document requires a subscription
>>> (which I do not have):
>>>
>>>
>>> https://www.can-cia.org/can-knowledge/cia-612-series-can-xl-
>>> guidelines-and-application-notes
>>>
>>> Do any of you have access to this document? Or do any of you know a good
>>> formula for the PWMS and PWML calculation?
>>
>> I have to check for the referenced document.
>>
>> Btw. this is some code that shows the idea of how to calculate the PWM
>> values based on the CAN clock and the XL data bitrate:
>>
>>      if (CanClock_mhz == 100 && XlDatarate_mbps == 5) {
>>          // @5Mbit/s>         pwmo = 0;
>>          pwms = 6;
>>          pwml = 14;
> 
> one bit is 200 nano seconds.
> one minimum time quantum is 10 ns.
> 
> pwm = pwms + pwml
>      = 6 + 14
>      = 20 minimum time quantum
> 
> So PWM duration is 20 * 10 = 200 ns. So there is only one PWM per bit.
> 
>>      } else if (CanClock_mhz == 100) {
>>          // @10Mbit/s>         pwmo = 0;
>>          pwms = 3;
>>          pwml = 7;
> 
> 1 bit is 100 ns.
> one minimum time quantum is 10 ns.
> 
> pwm = pwms + pwml
>      = 3 + 7
>      = 10 minimum time quantum
> 
> So PWM duration is 10 * 10 = 100 ns. So here also, there is only one PWM
> per bit.
> 
>>      } else if (CanClock_mhz == 160) {
>>          // @10Mbit/s>         pwmo = 0;
>>          pwms = 2;
>>          pwml = 6;
> 
> 1 bit is 100 ns.
> one minimum time quantum is 6.25 ns.
> 
> pwm = pwms + pwml
>      = 2 + 6
>      = 8 minimum time quantum
> 
> So PWM duration is 8 * 6.25 = 50 ns. This time, there are two PWM per
> bit. Interesting.
>>      }
> 
> So from those value, I derived:
> 
>    pwms = round_down(30% * pwm)
>    pwml = round_up(70% * pwm)
> 
> PWMO was already established as:
> 
>    pwmo = bit_time_in_minimum_time_quantum % pwm
> 
> (in your example, the bit time is a multiple of PWM, so the PWMO is zero).
> 
> This is some progress. What is not clear yet is how to find the number
> of PWM per bit (i.e. why is it only one PWM per bit in your first two
> examples, why is it two PWM per bit in your second example).
> 
> The ISO has one more formula that I did not yet used. Maybe that's the
> solution. But it is 3 a.m. here, let's say that this is a problem for
> the tomorrow me.
> 
>> For that reason I was thinking about some default calculation provided
>> by the kernel (CAN_CTRLMODE_XL_PWM_AUTO) and some manual setting if
>> people want to set the values analog to tseg1 and friends instead of
>> setting a single bitrate.
> 
> Don't worry, we have the same final result in mind. It is just that I
> believe that we can use a trick so that we can do it with a single flag :)
> 
> Let me illustrate in more details.
> 
>    Case 1: PWM off
> 
>      ip link set can0 (...) xl on pwm off

Ugh.

Did you take a look into all my patches from 2024-12-04, e.g.

https://lore.kernel.org/linux-can/20241204075741.3727-3-socketcan@hartkopp.net/T/#u

which is introducing CAN_CTRLMODE_XL_TRX ??

We are talking about having a CAN XL capable/switchable transceiver 
attached to the CAN (XL) controller or not. IMO we should also name it 
accordingly with

ip link set can0 (...) xl on xltrx off

That the transceiver switching is done with PWM under the hood is 
nothing we should disclose to the user in this way IMHO.

> 
>      - CAN_CTRLMODE_XL_PWM bit is false
>      - IFLA_CAN_XL_PWM is not provided
> 
>    Case 2: PWM on auto
> 
>      ip link set can0 (...) xl on pwm on
> 
>      - CAN_CTRLMODE_XL_PWM bit is true
>      - IFLA_CAN_XL_PWM is not provided
> 
>    Case 3: PWM on manual
> 
>      ip link set can0 (...) xl on pwm on pwms xxxx pwml yyyy
> 
>      - CAN_CTRLMODE_XL_PWM bit is false
>      - IFLA_CAN_XL_PWM is provided (and contains a nest with both
>        IFLA_CAN_PWMS and IFLA_CAN_PWML)
> 
> So, here, I use the presence or the absence of the IFLA_CAN_XL_PWM as an
> hidden flag to know whether the calculation should be done or not.

Yes, that's a good idea. Excellent default behavior.

At least when reading IFLA_CAN_XL_PWM the provided or automatically 
calculated values would become visible.

> Note that there is one more case:
> 
>    Case 4: full auto??? (let the kernel decide between PWM on or off)
> 
>      ip link set can0 (...) xl on
> 
> Here, the user does not tell if PWM should be on or off. I think that
> this case should be banned (return error).

Yes! Good idea!

> For what I understand, if one
> node uses PWM and the other doesn't, it just doesn't work. So, contrary
> to TDC, there is no way to calculate if this should be on or off.
> 
> (side note: I will be busy for personal reasons until this Sunday, do
> not be surprised if my next answer is delayed).

No problem.

Best regards,
Oliver


