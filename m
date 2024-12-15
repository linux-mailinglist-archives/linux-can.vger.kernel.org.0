Return-Path: <linux-can+bounces-2410-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910DD9F22F4
	for <lists+linux-can@lfdr.de>; Sun, 15 Dec 2024 10:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FF116567D
	for <lists+linux-can@lfdr.de>; Sun, 15 Dec 2024 09:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3393A17BD6;
	Sun, 15 Dec 2024 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WrgxqFU8"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1628FD
	for <linux-can@vger.kernel.org>; Sun, 15 Dec 2024 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734254491; cv=none; b=LMj7s7m7dOq/r1IOZ5WMa8RgblCP93Cp/tvIRRKE0CHYVWasrTPoocVa5ndlFL9VhpOnlXv1rYCb41ZFZR6eZW2nzRvu2YAKhPH7atH+hW495BBckPtl84Px7lIFYh9tQXrSh11BwyhlsRKkzLW9qLeXteRH4T2y2OePyBHzxiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734254491; c=relaxed/simple;
	bh=hmhPaO5Uom2cmSb4SBARsu1B0Q1mGQUZEnUbqNicF60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYyMyKqpl6y2M7+zjdcGhqIuZ0ccrbd6aTT1EsjjwN6Qg0sVQFGSmY5PPUd1ifzZlR47RExAK6LliXbW6RPkvjY4ZjESprfgXrMXN9KJTP3YN1Jnt0r24rFANsF308F65HzvjP4og4hlpbjZDmpzR8mp3eK3E1HGtfU5/DSPhOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=WrgxqFU8; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id MkoPtNrV1cbRjMkoQtOwsH; Sun, 15 Dec 2024 10:21:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1734254480;
	bh=ramSMkFtd03zhqtwQf+JI7t2NtaO9O/lGR/Bm3nG8eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=WrgxqFU8FGssL+NcbMzC3vYSNJfNpkdEdIAUEKZnT2+VFd3ayRqwHzF2BjzKxyKF9
	 c5QBzcSci1dam2/VBk44MPrFGs4pcSi7Ofks3v1fHuMkY7w2t7gKaNu0ZHFILtxtQu
	 KHQw99Sj4ge1//j35oxQTAoDrhQQrPBAYRPdWBMqaOtCK3QAQUMa7DV5KyVCx0LGqw
	 jjWwk4UQCxkXdigXcux762bufUiY7n33xbthAT9StklUdRwgVJUCJJBKxnpAvDCdWb
	 s7ETt31CcylvlxsV6a3P0JvSg4DaQJM7d6ro8vw5HutalB83bNB5P2vR1AFsc1XA1k
	 RsaX9HnqqvjJQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 15 Dec 2024 10:21:20 +0100
X-ME-IP: 124.33.176.97
Message-ID: <c4771c16-c578-4a6d-baee-918fe276dbe9@wanadoo.fr>
Date: Sun, 15 Dec 2024 18:21:16 +0900
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
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <8be877db-028a-413f-b55d-71311e0c88c9@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I am done reading (and understanding) ISO 11898-1:2024, so let's resume
the work!

On 04/12/2024 at 16:56, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 03.12.24 10:45, Vincent Mailhol wrote:
> 
>>> https://lore.kernel.org/linux-can/20241201112333.6950-1-
>>> socketcan@hartkopp.net/T/#u
>>> https://lore.kernel.org/linux-can/20241201112230.6917-1-
>>> socketcan@hartkopp.net/T/#t
> 
>> Thanks for all the testing and the fixes. Because of the lack of
>> testing of this RFC on my side, I was expecting such issues. But I
>> really appreciate that you took time to investigate and debug, really
>> helpful! I will make sure to incorporate these fixes in the next
>> version.
> 
> I'll send out an extended RFC V2 which is my current test base for you
> in some minutes.
> 
> Either for the kernel and iproute2 there are two new patches that add
> new controlmode flags.
> 
>> The next series I send will add the pwm and drop the RFC patch.
> 
> Excellent!
> 
> I assume it will follow the TDC pattern with
> CAN_CTRLMODE_XL_PWM_AUTO and CAN_CTRLMODE_XL_PWM_MANUAL
> or something similar?

I am not sure why we would need a tristate here. The reason why I put
the tristate for the TDC is because some transceiver (the majority) will
automatically measure TDCV but some may give the option for the user to
manually set it.

From what I understand from the specification, PWMO is not something
which is dynamically measured. If I got it right, it is just the
remainder whenever the bit time is not a multiple of PWM. Something like
this:

  pwmo = bit_time_in_minimum_time_quantum % pwm;

Same for the PWMS and PWML. I am not yet sure how to calculate those
(more on this below) but these seem to be calculated once for all (like
any bittimming value other than the TDCs).

Let me know if I missed something, the PWM is very new to me :)


So, for the implementation, I am thinking of:

1. Add a CAN_CTRLMODE_PWM mode and a new nest for the PWM in netlink.h

2. Add these to bittiming.c:

  struct can_pwm {
  	u32 pwms; /* PWM short phase length */
  	u32 pwml; /* PWM long phase length */
  	u32 pwmo; /* PWM offset */
  };

  struct can_pwm_const {
  	u32 pwms_max;
  	u32 pwml_max;
  	u32 pwmo_max;
  };

  static inline u32 can_get_pwm(const struct can_pwm *pwm)
  {
  	return pwm->pwms + pwm->pwml;
  }

The minimum value of all those configurable ranges is already specified
to be one minimum time quantum (tq min), so I do not think we need a
field for the minimums.


At the moment, I am stuck on the PWM calculation. I do not know how to
derive good PWMS and PWML values out of the const ranges.

The ISO 11898-1:2024 tells me that CiA 612-2 has recommendations on the
topic. But getting access to this document requires a subscription
(which I do not have):


https://www.can-cia.org/can-knowledge/cia-612-series-can-xl-guidelines-and-application-notes

Do any of you have access to this document? Or do any of you know a good
formula for the PWMS and PWML calculation?

Thank you,


Yours sincerely,
Vincent Mailhol


