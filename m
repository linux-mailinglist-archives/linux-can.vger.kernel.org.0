Return-Path: <linux-can+bounces-3948-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B322CAF9706
	for <lists+linux-can@lfdr.de>; Fri,  4 Jul 2025 17:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AACB171579
	for <lists+linux-can@lfdr.de>; Fri,  4 Jul 2025 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E841DF265;
	Fri,  4 Jul 2025 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iNMtAyOc"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758616A956;
	Fri,  4 Jul 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751643495; cv=none; b=oVZ3MdLjvS+PmP+V5IkKAkVvLWQbjWLTp9PD5mkYOo5GitWrpteJm1+BcowOX+AmHg6aKIoHlYruhRVW1Q22cyi1yOvf+QaSpt9yrKCFbhYhU0rfbjeF16E6P9S48aDc4655DEK6rsIP8DoDEfVOYOJiULOqboY2isDiLDsa44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751643495; c=relaxed/simple;
	bh=fLdCLesqPacgf6orQ0Uqw8B1XsjZdu9oN9xPwsD81Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgOEKMbj9DW5KancJANScdB3wZhs9/ryC6owfB54FpIUUki9enLg5vaoXG0T56LGWMLtYXckLwUIHhjOP13WEFmTrgKfKA/pCU496AlOuviFjwt29Rxbj6NLiOF26T982ItHftaNhNu2EgpSyAqSOPIq5YxgiAtph6y2r9XE06c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iNMtAyOc; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id XiUAuz93nEUkqXiUBupcKk; Fri, 04 Jul 2025 17:38:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751643483;
	bh=VFAGn/xp+0VJ34DC7Qp3JQGD2Wi25TG8w1j1f/AjtMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=iNMtAyOcf6i1q07uJhYENLIWKJg107ulG3DNvDtH5QLKEkMssA1FKe0iYDB+n7U+H
	 CdWP7qPw9fiDooP0EvcstzhR1OkF67BhDp7RFByXSuuMISefRSdaT0VeW7Viw/GrOx
	 1Z98U+00kQZ//kvIkBNc8gB7t3eCJlym9qHAe4tLbSxZ3AwOgQjl6JYzNd3X+tGjEK
	 2oxMqXHa38taaSzrInBIIMxz9iS1gNScYzgKBfMy1LzQtoOgC6iHTx6vd4731ZbhFJ
	 v/HFMwWx1KrUZEyv9eGxwy1/suYPNzJ+46CNZg8AuRBjmbhar4VtCSUnu6dR2o2Faf
	 I9YrnZSXAInmw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 04 Jul 2025 17:38:03 +0200
X-ME-IP: 124.33.176.97
Message-ID: <c9693c60-3dad-4970-ad99-264592f427d8@wanadoo.fr>
Date: Sat, 5 Jul 2025 00:37:57 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] can: rcar_canfd: Replace RCANFD_CFG_* macros with
 FIELD_PREP
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "biju.das.au" <biju.das.au@gmail.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20250703183411.332828-1-biju.das.jz@bp.renesas.com>
 <20250703183411.332828-5-biju.das.jz@bp.renesas.com>
 <dc6d1cdf-0c93-4d7a-b3c4-722d1e58f5cf@wanadoo.fr>
 <TY3PR01MB113461B3528C3057DA03F6E808642A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
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
In-Reply-To: <TY3PR01MB113461B3528C3057DA03F6E808642A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2025 at 19:12, Biju Das wrote:
> Hi Vincent,
> 
> Thanks for the feedback.
> 
>> -----Original Message-----
>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> Sent: 04 July 2025 03:25
>> Subject: Re: [PATCH 4/4] can: rcar_canfd: Replace RCANFD_CFG_* macros with FIELD_PREP
>>
>> Hi Biju,
>>
>> On 04/07/2025 at 03:34, Biju Das wrote:
>>> Replace RCANFD_CFG_* macros with simpler FIELD_PREP macro.
>>>
>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> ---
>>>  drivers/net/can/rcar/rcar_canfd.c | 10 ++--------
>>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
>>> index b5b059e83374..dd87b4e8e688 100644
>>> --- a/drivers/net/can/rcar/rcar_canfd.c
>>> +++ b/drivers/net/can/rcar/rcar_canfd.c
>>> @@ -102,12 +102,6 @@
>>>
>>>  /* Channel register bits */
>>>
>>> -/* RSCFDnCmCFG - Classical CAN only */
>>> -#define RCANFD_CFG_SJW(x)		(((x) & 0x3) << 24)
>>> -#define RCANFD_CFG_TSEG2(x)		(((x) & 0x7) << 20)
>>> -#define RCANFD_CFG_TSEG1(x)		(((x) & 0xf) << 16)
>>> -#define RCANFD_CFG_BRP(x)		(((x) & 0x3ff) << 0)
>>> -
>>>  /* RSCFDnCFDCmCTR / RSCFDnCmCTR */
>>>  #define RCANFD_CCTR_CTME		BIT(24)
>>>  #define RCANFD_CCTR_ERRD		BIT(23)
>>> @@ -1418,8 +1412,8 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
>>>  	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
>>>  		cfg = rcar_canfd_compute_nominal_bit_rate_cfg(gpriv->info, tseg1, brp, sjw, tseg2);
>>>  	} else {
>>> -		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
>>> -		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
>>> +		cfg = FIELD_PREP(GENMASK(19, 16), tseg1) | FIELD_PREP(GENMASK(9, 0), brp) |
>>> +		      FIELD_PREP(GENMASK(25, 24), sjw) | FIELD_PREP(GENMASK(22, 20), tseg2);
>>>  	}
>>
>> You can still keep the macro definition to give a meaning to the magic number:
>>
>>   #define RCANFD_CFG_SJW_MASK GENMASK(25, 24)
>>
>> and do a:
>>
>>   FIELD_PREP(RCANFD_CFG_SJW_MASK, sjw)
> 
> Are you ok for the below change to reduce the changes minimum??
> 
> -#define RCANFD_CFG_SJW(x)		(((x) & 0x3) << 24)
> +#define RCANFD_CFG_SJW(x)		FIELD_PREP(GENMASK(25, 24), x))

No more function-like macro please :)

Normal macro definitions are totally welcome. These allow to attach a name to
otherwise totally meaningless magic numbers.

When it goes to the actual calculation, functions are best.

> Or
> 
> you want RCANFD_CFG_SJW_MASK as separate one as you suggested?

This please :)


Yours sincerely,
Vincent Mailhol


