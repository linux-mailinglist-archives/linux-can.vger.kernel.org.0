Return-Path: <linux-can+bounces-4657-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C497BB521A4
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 22:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2ED51C2529B
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 20:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDC72EDD65;
	Wed, 10 Sep 2025 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="I53NiApP";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FEKZze4X"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A32EE5E1
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535143; cv=pass; b=G0p+51dCfsLLmeByjQidhf1yATHR2VuSCkwzOvs2GFdfq685cbKiOz72HV93+MRDWw4/WVDclDv5nlTMoPm3OxPpVWpSCSwlsTZjU48xWqeztjucebZUnhYCoi2QjIwCAsRTzC5BVwt41MqzD17w0VnBM7NEMNVbl9yz09UBPAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535143; c=relaxed/simple;
	bh=foWJiF3qH0RX9271bQSpHb/4p5L5quWBB9NuBDqbJVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n2qAgqzFIgG/3FcETf5Po3JyYxeuL2FH5YVxaAuqboPNM4GyvvxEjSpoQuvJHmp9s0x1nqZhIQgJvg6Nngdp59LaH9KqJZ/Z92O0Yjl5a0QvEo0TAPHTyI/IK3jEQBdJgHm8wog6+cTtQ5oOAOXZJcNKEGL5hrpvoDhgsW0noJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=I53NiApP; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FEKZze4X; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757535138; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Inio9FYoPEzg2XGobOsIzqyUtDx3GbFsU06DWjOdwkBjQjlzGJkPv3/7NxvOKiFb3z
    3JprXN8YYpwJkQsD20s+nH1E11RnerdXdlw3Jd6DNV5c3mnGwKJyj3iMQUYnPmv5c6JR
    VfgdgpiJwMeLKIg3qK2+6rHCchSrFbxwn8QhZ5SDEwY0TdDCN+ayRFPbeAk10gCDzma5
    5ClJ6Aqr4jby7CjF4n45TyVafklobxzF6joa0hA6Xo33UbyUOG2ljrS7ERIuqhVLyokN
    ouU4eatDBKTdWypR6AnjsoDGzaaKR/88CPYvr5PqmhJ8+it3Nqz9TU4kvEq58o+6dTw/
    sfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757535138;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=zi8GN8fUMRwOprouxcAU/yyYGXAJT82oItGUdIFwaEQ=;
    b=jAGjtz7Vd4rxqFT8Ffp+sU8zBB4qCoNkCmTonwbzCiU0tKWltLHTzR7ERjlA0EE637
    +aqvycMR2zixML+orSaQOMjKGWe6uL4UzNE4/JZMjL53U4dpsGwR58u8ZaB1jizv6QWq
    xYEbcniEIv6491VU/+KdjiqR8uobc1WZzqdR1lCoogfjw8dIxXFQtqrkPw2yMlT1gcyF
    BPmhUwbsbf6Naxu3EzFNptV6Mon0i4OMS/jJYDnXzhlsNVwG1zpih6acOEVjKpobN6o7
    iX2kd6F1mFRnb+OEV1q0lQekaj6KRIHqC2coD/Xctlh/LsBRah0AhyaQ7vjCj8jcrAsx
    6NCQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757535138;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=zi8GN8fUMRwOprouxcAU/yyYGXAJT82oItGUdIFwaEQ=;
    b=I53NiApPoY+awSu1HVYZ/kFuPse/ZB23QMiNvVJQgVoJMtaR7MUAw0q/QmUlVPBphY
    SA8ag8BZWqomKUzjpRbWPyszGwBcqPq6V81xMG99QMiWVFY/yjR/lntsFM7Lw1DZe2RM
    x003YnHt+gi3YYHt7zOrkzqkRBAVI3/TF130b07Vl/5v4NA7gieptV6K/NG+NPTTE3pp
    ZNbI2l+OQ0gVwzXcQBf83eNGae1uJuZXVpj0Q8KzqIj4dGAcusf1Uetg7nqrmaIQmsgr
    P86VcYax3B1ROL84RedDpn1BL47qyoGaVkdIYJjxWfLRABjv0RCCCuPYGQp/Uv/kGH1M
    +cXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757535138;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=zi8GN8fUMRwOprouxcAU/yyYGXAJT82oItGUdIFwaEQ=;
    b=FEKZze4XA/LZSZAFqVvTjphsxTjW4oDLhi0I1FXtESXMyX2zVlspc6hFB0agjV73xn
    o6ArCR3E3wXhoGCy9WDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d36118AKCIzZL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Sep 2025 22:12:18 +0200 (CEST)
Message-ID: <6afc7e2d-eecf-4c47-bcef-0e2cdd7f4a89@hartkopp.net>
Date: Wed, 10 Sep 2025 22:12:13 +0200
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
References: <20250909092433.30546-1-socketcan@hartkopp.net>
 <20250909092433.30546-2-socketcan@hartkopp.net>
 <f7b59c7c-30ad-4cf4-ad0e-bff0e39b3337@hartkopp.net>
 <7578f44d-d85c-473e-8e7a-65d1fc974e68@kernel.org>
 <20c5c885-0bab-4c42-82c6-e98571a5d19d@hartkopp.net>
 <552631f3-15fe-4bb3-a512-1eaca57be5ca@kernel.org>
 <3a963548-faa9-4611-a3cf-e41b425968a8@hartkopp.net>
 <b6637b79-6377-4038-967f-0354a32eb2c3@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <b6637b79-6377-4038-967f-0354a32eb2c3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10.09.25 18:19, Vincent Mailhol wrote:
> On 10/09/2025 at 17:48, Oliver Hartkopp wrote:
>> On 10.09.25 09:40, Vincent Mailhol wrote:
>>> On 10/09/2025 at 16:27, Oliver Hartkopp wrote:
>>
>>>>>       /* CAN XL is allowed on virtual interfaces if it fits the MTU */
>>>>>          if (!priv)
>>>>>              return dev->mtu == CANXL_MTU;
>>>>
>>>>           return can_is_canxl_dev_mtu(mtu);
>>>>
>>>> The MTU of CAN XL interfaces might vary.
>>>
>>> Maybe this is something that we discussed before, I do not remember, but how is
>>> it that the MTU can vary?
>>>
>>> MTU is the *Maximum* Transmission Unit. I understand that the size of a CAN XL
>>> frame is variable, but the MTU should be constant, right? Why can it vary?
>>
>> Depending on the realtime requirements the length of the CAN frames (and
>> therefore the time the bus is blocked) the MTU can be reduced. This is (like the
>> bitrate settings) a network architects decision which is enforced by setting the
>> MTU accordingly.
> 
> Is this an extension we offer in Socket CAN?

Yes.

> The standard says nothing about
> having the MTU configurable.
> 
> For CAN FD, we forcefully set the MTU in netlink.c
> 
> https://elixir.bootlin.com/linux/v6.16/source/drivers/net/can/dev/netlink.c#L228

Oh. I did not realize before that we can either modify the MTU with 
setting fd on/off and via setting the MTU in can_change_mtu()

https://elixir.bootlin.com/linux/v6.16/source/drivers/net/can/dev/dev.c#L313

?!?

The two APIs problem for changing the MTU?!?

I expected the default MTU for CAN FD capable interfaces to be CANFD_MTU 
which is obviously not the case.

> I will have to think of what are the implication for CAN XL.

I would define a default CANXL MTU (CANXL_MTU 2060) which might be 
changed with can_change_mtu().

And when ever we switch xl on this value is selected as device MTU.

Or the user can change the MTU as he needs it.
And when xl on is selected and the MTU is a can_is_canxl_dev_mtu() this 
value is used. When can_is_canxl_dev_mtu() is not true we take CANXL_MTU.

Something like this.

Best regards,
Oliver


