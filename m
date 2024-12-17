Return-Path: <linux-can+bounces-2429-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E17EB9F561B
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 19:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA67168DEF
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 18:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D991F7562;
	Tue, 17 Dec 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="g6lQYOhK"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63751F8929
	for <linux-can@vger.kernel.org>; Tue, 17 Dec 2024 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459968; cv=none; b=N86eLlgj2d0ih2FSPwdqpHlh5JulHpITXmv/kkyICN6dXnFT5ZPPg986OuK5sogfhdbHpC97wABDzu6lzDWxgAznZUSctJ1fX1XJhwjd1NVnMnYiuhHXs8J06jN40C8O+fngn+vqbwA6o+GHPzv0xSlygbFI8esEq/61IJrJmFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459968; c=relaxed/simple;
	bh=d/t2kyRgv+k2+FvIOeBtBTu2kFk3k8D2pNVgglxnaVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFZXE8/Boo6CWYOW+Tc25hvWO4QcoPdAlPJbnGQLwmDPwklv6CISxRDyuznnKAfd7bdjFXv7WacE2ye0UkrZZa4gVnh/Rr3MaqhEeeEWA877HVwmQSaYxabNeJnl90Y2vlD1ZNrdygG6sjLqhSA+UPigUP5GpWLRuMzTbiF+d0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=g6lQYOhK; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id Nc84txGMZNbULNc86tHLv1; Tue, 17 Dec 2024 19:17:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1734459432;
	bh=NPcnAkamoEZh2aFXIah0bCY4kQ0ilMr+rFRU4L++b5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=g6lQYOhKvTRaLMa7Fkkpe7adrvrcgFW69894b7uiNT5pBa64zZHXCqsuhZfy+YKu0
	 T/dzgEYM2YEGFF1J42XI0hoCNyASXtjWc+bDr1pWRydI4+iwjcm3GJZCfzlVf/OU+n
	 DDRYvTEwKdWmm3bbG+/LQzDYgnA6CLCgGUbH0Ur5UlbpdA/EB6I5ZI0XdofqEz/9bC
	 MVmZYR3ufuTNfCFHFIUhO8DrkkPR0Fkua5fCIWkGKSO4BEFOehR/RSrTYWqy3NYPOQ
	 vXHQmMSdQqIskcXek+NUtX3Wa8i5u/1qUTL66Q+MqwxsHJofJHl/fVOP1sLVJdMoXd
	 iUm5s3oANT/6Q==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 17 Dec 2024 19:17:12 +0100
X-ME-IP: 124.33.176.97
Message-ID: <4acc968e-d30e-400f-bc40-d4fc9f5299de@wanadoo.fr>
Date: Wed, 18 Dec 2024 03:17:07 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
To: Oliver Hartkopp <socketcan@hartkopp.net>
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
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <2bd47866-a995-4359-9639-724cd8a90a43@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/12/2024 at 18:53, Oliver Hartkopp wrote:
> Hi Vincent,

(...)

>>> I assume it will follow the TDC pattern with
>>> CAN_CTRLMODE_XL_PWM_AUTO and CAN_CTRLMODE_XL_PWM_MANUAL
>>> or something similar?
>>
>> I am not sure why we would need a tristate here. The reason why I put
>> the tristate for the TDC is because some transceiver (the majority) will
>> automatically measure TDCV but some may give the option for the user to
>> manually set it.
>>
>>  From what I understand from the specification, PWMO is not something
>> which is dynamically measured. If I got it right, it is just the
>> remainder whenever the bit time is not a multiple of PWM. Something like
>> this:
>>
>>    pwmo = bit_time_in_minimum_time_quantum % pwm;
>>
>> Same for the PWMS and PWML. I am not yet sure how to calculate those
>> (more on this below) but these seem to be calculated once for all (like
>> any bittimming value other than the TDCs).
>>
>> Let me know if I missed something, the PWM is very new to me :)
>>
>>
>> So, for the implementation, I am thinking of:
> 
> The PWM stuff is some very CAN XL specific therefore I would suggest to
> bring this into the naming too:

It is specific to CAN XL for the moment. But if I do a parallel, before
CAN XL existed, the TDC was specific to CAN FD. But the structure was
named can_tdc, not can_fd_tdc, and now that the CAN XL reuses the TDC,
it comes in handy that the structure did not have fd in the name.

The CAN XL still have a resXL flag for potential future extension, if
one day there is a CAN XXL, then the PWM would not be specific to CAN XL
anymore.

My approach will be to:

  - name structures and entries within a netlink nest in a generic
    manner
  - name struct fields (e.g. in can_priv) and the top level netlink
    entries with an XL prefix.

>> 1. Add a CAN_CTRLMODE_PWM mode and a new nest for the PWM in netlink.h
> 
> CAN_CTRLMODE_XL_PWM or CAN_CTRLMODE_XLPWM

Ack. This flag is specific to CAN XL. I have a preference for
CAN_CTRLMODE_XL_PWM (with the underscore between XL and PWM).

>> 2. Add these to bittiming.c:
>>
>>    struct can_pwm {
> can_xl_pwm or can_xlpwm

NACK. I keep can_pwm, but in can_priv, I will name the field:

  struct can_pwm xl_pwm;

>>        u32 pwms; /* PWM short phase length */
>>        u32 pwml; /* PWM long phase length */
>>        u32 pwmo; /* PWM offset */
> that's fine
> 
>>    };
>>
>>    struct can_pwm_const {
> dito
> 
>>        u32 pwms_max;
>>        u32 pwml_max;
>>        u32 pwmo_max;
>>    };
>>
>>    static inline u32 can_get_pwm(const struct can_pwm *pwm)
>>    {
>>        return pwm->pwms + pwm->pwml;
>>    }
> ??

ISO 11898-1:2024 tells me that (quote):

  The PWM symbol length is the sum of PWMS and PWML.

This inline function was to calculate this PWM symbol length. That said,
on second thought, I doubt that the drivers will need this information.
I will remove it for the moment. If someone needs it, we can reintroduce
this later.

>> The minimum value of all those configurable ranges is already specified
>> to be one minimum time quantum (tq min), so I do not think we need a
>> field for the minimums.
>>
>>
>> At the moment, I am stuck on the PWM calculation. I do not know how to
>> derive good PWMS and PWML values out of the const ranges.
>>
>> The ISO 11898-1:2024 tells me that CiA 612-2 has recommendations on the
>> topic. But getting access to this document requires a subscription
>> (which I do not have):
>>
>>
>> https://www.can-cia.org/can-knowledge/cia-612-series-can-xl-
>> guidelines-and-application-notes
>>
>> Do any of you have access to this document? Or do any of you know a good
>> formula for the PWMS and PWML calculation?
> 
> I have to check for the referenced document.
> 
> Btw. this is some code that shows the idea of how to calculate the PWM
> values based on the CAN clock and the XL data bitrate:
> 
>     if (CanClock_mhz == 100 && XlDatarate_mbps == 5) {
>         // @5Mbit/s>         pwmo = 0;
>         pwms = 6;
>         pwml = 14;

one bit is 200 nano seconds.
one minimum time quantum is 10 ns.

pwm = pwms + pwml
    = 6 + 14
    = 20 minimum time quantum

So PWM duration is 20 * 10 = 200 ns. So there is only one PWM per bit.

>     } else if (CanClock_mhz == 100) {
>         // @10Mbit/s>         pwmo = 0;
>         pwms = 3;
>         pwml = 7;

1 bit is 100 ns.
one minimum time quantum is 10 ns.

pwm = pwms + pwml
    = 3 + 7
    = 10 minimum time quantum

So PWM duration is 10 * 10 = 100 ns. So here also, there is only one PWM
per bit.

>     } else if (CanClock_mhz == 160) {
>         // @10Mbit/s>         pwmo = 0;
>         pwms = 2;
>         pwml = 6;

1 bit is 100 ns.
one minimum time quantum is 6.25 ns.

pwm = pwms + pwml
    = 2 + 6
    = 8 minimum time quantum

So PWM duration is 8 * 6.25 = 50 ns. This time, there are two PWM per
bit. Interesting.
>     }

So from those value, I derived:

  pwms = round_down(30% * pwm)
  pwml = round_up(70% * pwm)

PWMO was already established as:

  pwmo = bit_time_in_minimum_time_quantum % pwm

(in your example, the bit time is a multiple of PWM, so the PWMO is zero).

This is some progress. What is not clear yet is how to find the number
of PWM per bit (i.e. why is it only one PWM per bit in your first two
examples, why is it two PWM per bit in your second example).

The ISO has one more formula that I did not yet used. Maybe that's the
solution. But it is 3 a.m. here, let's say that this is a problem for
the tomorrow me.

> For that reason I was thinking about some default calculation provided
> by the kernel (CAN_CTRLMODE_XL_PWM_AUTO) and some manual setting if
> people want to set the values analog to tseg1 and friends instead of
> setting a single bitrate.

Don't worry, we have the same final result in mind. It is just that I
believe that we can use a trick so that we can do it with a single flag :)

Let me illustrate in more details.

  Case 1: PWM off

    ip link set can0 (...) xl on pwm off

    - CAN_CTRLMODE_XL_PWM bit is false
    - IFLA_CAN_XL_PWM is not provided

  Case 2: PWM on auto

    ip link set can0 (...) xl on pwm on

    - CAN_CTRLMODE_XL_PWM bit is true
    - IFLA_CAN_XL_PWM is not provided

  Case 3: PWM on manual

    ip link set can0 (...) xl on pwm on pwms xxxx pwml yyyy

    - CAN_CTRLMODE_XL_PWM bit is false
    - IFLA_CAN_XL_PWM is provided (and contains a nest with both
      IFLA_CAN_PWMS and IFLA_CAN_PWML)

So, here, I use the presence or the absence of the IFLA_CAN_XL_PWM as an
hidden flag to know whether the calculation should be done or not.

Note that there is one more case:

  Case 4: full auto??? (let the kernel decide between PWM on or off)

    ip link set can0 (...) xl on

Here, the user does not tell if PWM should be on or off. I think that
this case should be banned (return error). For what I understand, if one
node uses PWM and the other doesn't, it just doesn't work. So, contrary
to TDC, there is no way to calculate if this should be on or off.

(side note: I will be busy for personal reasons until this Sunday, do
not be surprised if my next answer is delayed).


Yours sincerely,
Vincent Mailhol


