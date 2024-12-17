Return-Path: <linux-can+bounces-2425-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B909F4818
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 10:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189B9167A7D
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90FF1DE2DB;
	Tue, 17 Dec 2024 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="GO32lB/H";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="/qy8gX1U"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DB48493
	for <linux-can@vger.kernel.org>; Tue, 17 Dec 2024 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429251; cv=pass; b=BDtzpyg4TOt2rxzNiUq48V58s4pU4lzKPUuaINvho000Vg/pu/6YxZpU7vFHe6YROm7Ok8CI6dSxpoKBihPYt+OI97ocSu/rIQ4z2uL+Qz/SnNBq5OZts5OhZrHrd0l8j5qLPdZ/97PTvbZQVCxZEVAqIIxTwp+yInBPiW1F0yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429251; c=relaxed/simple;
	bh=JGlxgQswzPC8bt5y8AhvSdfuKXKMeshJSpACeTR+6AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSdyzB8HZ6PhfYk1xqBN96zzIBJos3DZ2PXP5rbUc82+jBzgbdVz0e8gPtvraA4GmoBHsNavuscgkYrCFfBJoDMcjb56PAuJTLHXTeOuT/qC+uTEOSKWbqGpTx4h62POh7bM3Bjfu7iJeL6Vf23cWysiju41Xtea5U9+Kw1xGQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GO32lB/H; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=/qy8gX1U; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1734429238; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=l134V4gre+4dNnGqmGS/m2B2s3O4m9fONY/c3s0H/0Ya1dIHLlIYb3DZH5lVM/PvqV
    if63RMrGqN/sgMxlB+5d7hiidbTK+qdToPPw5PZqJbOY0ZjheDiropqSKRvRRmLaZiXa
    OhHKoThha3EVdCpMv25aK8+yNiaaBR3dhOOZJAsj+pwvulxHDj7PdckuWLHxs/jQdxHM
    qcwZ+mF2bi9P3J7cn8xeYqVGkZ0B6t12DmmVo/CG7TzXfpATXAOvfJYVEDejNPZEk+8O
    w1ZX38Oa9iIMp19coavUCQaQMddGceV4eXh7tHG9GElwf37cumv3EPAoHQyKMdsrlPP0
    VwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1734429238;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=X+BuOrMZDUVmvqC3a2GfAIYQdAfZGn5MbrcBjKv6aYo=;
    b=DzjntosRgDv9PBPbmNyCUSCpzA9CuQhTwKzCvYTfBoD93RLHrRdWIHoZYulzHURKy3
    9EHGEKIJlBpqWcPO9BwsY5Kx5ottLXBUz1lEj3irMs5hUc83Y4cCIRvcsqwjMB0+JG9r
    ULuq70fKvp3sa4PZxgINcpRpwjr09zUsnL1OzGmpO7Rnuyezo0eh124d50dX3u+yD9+0
    l4G2LZaCAv39MikZU80+Xd3E2MFOu6LOzqVCQVxeSj3MQ1b+dRzCx25a0mzXY/yCxoaG
    AGMNSvaRVnrEDw6Kv/x0C2Bs5R42qBrnEZav52GLmla2o7L5AkK8/GYjECGfreU/nkBS
    Mezg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1734429238;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=X+BuOrMZDUVmvqC3a2GfAIYQdAfZGn5MbrcBjKv6aYo=;
    b=GO32lB/HlcV34NzrAta3MoIIiqMosaFJSYJfYarjyQttHKCBqOdWJZD4Ts5T3gF4No
    DIjOJuv99m9C/w6aChPQQl6LjBIponuEZSMdCO20oaxMP2LYdMwCt7DrAsRnTACSipTb
    quhDTWtuoyz3R8GJ8oa/GbkKI0djSvWtfpW14imnvoKVvtb7Y3eFkvOcTbQo+ZghokDW
    5AJTAbd+ZXizFf5Fxb3KjtDBG8X3/FT27lCmpfQkTV/p73LBEiOUIhUupTIJWGYWqViB
    6LJu0vu1KxD2eKEt8v3V+/iPs/4aL7S+/gB/l9cNaWl/LZ2BRSAY0Kzsj9kuk1d0VnrL
    p/ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1734429238;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=X+BuOrMZDUVmvqC3a2GfAIYQdAfZGn5MbrcBjKv6aYo=;
    b=/qy8gX1UU4azRScDlHyepBvN0hJpKQ6jEe9rOAIWI/EirOSRZXuL7RPSH8JY6Jv6Yz
    Sjxq7A54zu8UY66V+sBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5010::9f3]
    by smtp.strato.de (RZmta 51.2.15 AUTH)
    with ESMTPSA id K189d10BH9rw44E
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Dec 2024 10:53:58 +0100 (CET)
Message-ID: <2bd47866-a995-4359-9639-724cd8a90a43@hartkopp.net>
Date: Tue, 17 Dec 2024 10:53:53 +0100
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <c4771c16-c578-4a6d-baee-918fe276dbe9@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 15.12.24 10:21, Vincent Mailhol wrote:

> I am done reading (and understanding) ISO 11898-1:2024, so let's resume
> the work!

Good! ;-)

> On 04/12/2024 at 16:56, Oliver Hartkopp wrote:
>> Hi Vincent,
>>
>> On 03.12.24 10:45, Vincent Mailhol wrote:
>>
>>>> https://lore.kernel.org/linux-can/20241201112333.6950-1-
>>>> socketcan@hartkopp.net/T/#u
>>>> https://lore.kernel.org/linux-can/20241201112230.6917-1-
>>>> socketcan@hartkopp.net/T/#t
>>
>>> Thanks for all the testing and the fixes. Because of the lack of
>>> testing of this RFC on my side, I was expecting such issues. But I
>>> really appreciate that you took time to investigate and debug, really
>>> helpful! I will make sure to incorporate these fixes in the next
>>> version.
>>
>> I'll send out an extended RFC V2 which is my current test base for you
>> in some minutes.
>>
>> Either for the kernel and iproute2 there are two new patches that add
>> new controlmode flags.
>>
>>> The next series I send will add the pwm and drop the RFC patch.
>>
>> Excellent!
>>
>> I assume it will follow the TDC pattern with
>> CAN_CTRLMODE_XL_PWM_AUTO and CAN_CTRLMODE_XL_PWM_MANUAL
>> or something similar?
> 
> I am not sure why we would need a tristate here. The reason why I put
> the tristate for the TDC is because some transceiver (the majority) will
> automatically measure TDCV but some may give the option for the user to
> manually set it.
> 
>  From what I understand from the specification, PWMO is not something
> which is dynamically measured. If I got it right, it is just the
> remainder whenever the bit time is not a multiple of PWM. Something like
> this:
> 
>    pwmo = bit_time_in_minimum_time_quantum % pwm;
> 
> Same for the PWMS and PWML. I am not yet sure how to calculate those
> (more on this below) but these seem to be calculated once for all (like
> any bittimming value other than the TDCs).
> 
> Let me know if I missed something, the PWM is very new to me :)
> 
> 
> So, for the implementation, I am thinking of:

The PWM stuff is some very CAN XL specific therefore I would suggest to 
bring this into the naming too:

> 
> 1. Add a CAN_CTRLMODE_PWM mode and a new nest for the PWM in netlink.h

CAN_CTRLMODE_XL_PWM or CAN_CTRLMODE_XLPWM
> 
> 2. Add these to bittiming.c:
> 
>    struct can_pwm {
can_xl_pwm or can_xlpwm

>    	u32 pwms; /* PWM short phase length */
>    	u32 pwml; /* PWM long phase length */
>    	u32 pwmo; /* PWM offset */
that's fine

>    };
> 
>    struct can_pwm_const {
dito

>    	u32 pwms_max;
>    	u32 pwml_max;
>    	u32 pwmo_max;
>    };
> 
>    static inline u32 can_get_pwm(const struct can_pwm *pwm)
>    {
>    	return pwm->pwms + pwm->pwml;
>    }
??

> 
> The minimum value of all those configurable ranges is already specified
> to be one minimum time quantum (tq min), so I do not think we need a
> field for the minimums.
> 
> 
> At the moment, I am stuck on the PWM calculation. I do not know how to
> derive good PWMS and PWML values out of the const ranges.
> 
> The ISO 11898-1:2024 tells me that CiA 612-2 has recommendations on the
> topic. But getting access to this document requires a subscription
> (which I do not have):
> 
> 
> https://www.can-cia.org/can-knowledge/cia-612-series-can-xl-guidelines-and-application-notes
> 
> Do any of you have access to this document? Or do any of you know a good
> formula for the PWMS and PWML calculation?

I have to check for the referenced document.

Btw. this is some code that shows the idea of how to calculate the PWM 
values based on the CAN clock and the XL data bitrate:

     if (CanClock_mhz == 100 && XlDatarate_mbps == 5) {
         // @5Mbit/s
         pwmo = 0;
         pwms = 6;
         pwml = 14;
     } else if (CanClock_mhz == 100) {
         // @10Mbit/s
         pwmo = 0;
         pwms = 3;
         pwml = 7;
     } else if (CanClock_mhz == 160) {
         // @10Mbit/s
         pwmo = 0;
         pwms = 2;
         pwml = 6;
     }

For that reason I was thinking about some default calculation provided 
by the kernel (CAN_CTRLMODE_XL_PWM_AUTO) and some manual setting if 
people want to set the values analog to tseg1 and friends instead of 
setting a single bitrate.

Best regards,
Oliver


