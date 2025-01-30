Return-Path: <linux-can+bounces-2708-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D128CA228A7
	for <lists+linux-can@lfdr.de>; Thu, 30 Jan 2025 06:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302A31641BA
	for <lists+linux-can@lfdr.de>; Thu, 30 Jan 2025 05:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D0E13D89D;
	Thu, 30 Jan 2025 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fv0Twgr6"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C65C1CFBC
	for <linux-can@vger.kernel.org>; Thu, 30 Jan 2025 05:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738215863; cv=none; b=fm1ux6cynI1ii1m4h8wNilA5v+n+D+WT2dNV6Mz2fDvTYf77MKbqcpHhWQJCkTSMI8bSNJGOpW3z7Fqu/0m7smsTPCdg7pIOkzwn0BmX9jjCtKWVIGFSTn7/k0MYRsXyEaaOtywIKftqI9I59tMfG+6ERDsBJXzX2SZnYxHwcsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738215863; c=relaxed/simple;
	bh=o31Oea2Eyql9Zm1yZQufr6uUaNY1hXJxpWlcFpajrYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kY9tGrdP47Qo+S6Go5g8EPTM/kUE7exrgiM2cJpJoRMcR6fXkK+/sxNfXTXmPQdCzbI9P+JFLr/coctjF7ZUT0K95tMjmLSNeujTbIaGZ/vqZu+4TQ1K498cNE2hYp9XObU4dAh/YDzj+rxACpKz1rWuetJyMpjTgj5nMfq9d8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fv0Twgr6; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id dNKOtm5FvARNLdNKTta8uG; Thu, 30 Jan 2025 06:43:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738215787;
	bh=6xnYrfOB0uA1lQ/5h8VupEmmA4XA7IJE5Tc135KGUWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=fv0Twgr6QgdkPW3e//lAWwEHt4vVDYrVaS/ANcqirsOgJQi47nWgVxHjVlpjcwvY9
	 mBsisOzdjx9PuubbniPITRMxMEXcjQ5gGOi8+65U9R7l5fmTGvpVWtfq1zE+Rhkvy7
	 B4AtdPU8EW4iHOLtn70YGnTeh9wj13cdoid2+7JGPmmSX2eWYFouAO12rL6cjcN1qv
	 Xcdk19Q7hzJ+oqp6MuNYwrgmrp0o1arLGgHq6JDvo1k0r2FoFDqi4xIpFjhyPQaw3M
	 6vIpCKVwtAokk1nLaLmvg2XCPPqaAVPO89kUfa9qoXw/8cPPIOTHQBrG+1vHx61bOU
	 ePafWFvRwvWIw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 30 Jan 2025 06:43:07 +0100
X-ME-IP: 124.33.176.97
Message-ID: <68e8c449-a6ab-4958-af3c-852ece2694c2@wanadoo.fr>
Date: Thu, 30 Jan 2025 14:42:59 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Robert Nawrath <mbro1689@gmail.com>
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
Content-Language: en-GB
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <42b6acd2-dc9d-471b-b273-9b8094840935@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oliver and Marc,

Sorry for the late feedback… Furthermore, I am coming back with some bad
news…

On 18/12/2024 at 05:03, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 17.12.24 19:17, Vincent Mailhol wrote:
>> On 17/12/2024 at 18:53, Oliver Hartkopp wrote:

(...)
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

So, because I am still stuck on the PWMS and PWML calculation, I
directly reached out to the CiA guys. In short, this is what I learned:

  - CiA 612-2 is a work draft, it is not available for purchase at the
    moment.

  - CiA 612-2 will be available for purchase once it reaches the Draft
    Specification stage.

  - CiA 612-2 will be published as ISO 16845-1 when ready.

  - The only method to get access to the current draft right now would
    be either to become a CiA member or an ISO Working Group 3 member.
    This would mean convincing my employer to become a member of one of
    these. None of which is feasible because I am doing all my kernel
    contribution as an hobbyist; my employer has no connections with
    this.

  - Fun fact, when pointing out that it was not feasible to become a
    member as an hobbyist, I got the reply that, I quote:

      why would not you look into CAN FD where the bit timing and other
      stuff is widely available especially for a hobbyist?

  - Finally, when trying to negotiate to just get access to the one
    relevant formula, I got replied that:

      That is not one formula but many things are involved.

Unless anyone of you is a CiA or ISO WG3 member, I am afraid that we are
stuck for the moment. And even if we have access, I am not even sure if
the formula we are looking for is actually ready for use :(

One way to move forward would be to just implement the manual PWM and
have the kernel return an error if automatic mode is requested. I am
still not at ease to do the implementation of something I do not fully
comprehend.

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
>> examples, why is it two PWM per bit in your third example).

For the context, this is the precise point were I am still stuck on: how
to find out how many PWM symbols we should have in one bit.

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
> 
> We are talking about having a CAN XL capable/switchable transceiver
> attached to the CAN (XL) controller or not. IMO we should also name it
> accordingly with
> 
> ip link set can0 (...) xl on xltrx off
> 
> That the transceiver switching is done with PWM under the hood is
> nothing we should disclose to the user in this way IMHO.

To be honest, all my brain cycle were consumed by the PWM calculation
topic. I was not yet in a phase where I was trying to think of the best
naming.

Back to the topic, when looking again at the ISO, there are actually
three modes, c.f. this table:

  CAN transceiver modes signalled	PMA operating modes for CAN SIC
  to the PMA sub-layer as specified	XL transceivers as specified in
  in CiA 610-1 & ISO 11898-2		CiA 610-3 & ISO 11898-2

      Arbitration mode				SIC mode
      Data TX mode				FAST TX mode
      Data RX mode				FAST RX mode

The table is also available at:

  https://www.can-cia.org/can-knowledge/can-xl

(the CiA and the ISO table are the exact same thing except for the
references).

I am not exactly sure how the thing is supposed to work when you enable
only one of the data TX or RX mode, but the table seems clear about the
fact that the data TX and RX mode can opperate separatly.

And on a side topic, I do not like the naming of the transceiver mode
(the left column of the table). If I say "Data TX mode on" or "Data TX
mode off", I am just thinking of a listen only mode, not of a PWM mode.

I think it is better to use the naming of the PMA operating modes (the
right column of the table): fast_rx and fast_tx. This naming better
conveys what the thing is about.


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


Yours sincerely,
Vincent Mailhol


