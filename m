Return-Path: <linux-can+bounces-3269-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441EFA74921
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 12:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C7817C139
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1F51BC9E2;
	Fri, 28 Mar 2025 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XCbCosMY"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-66.smtpout.orange.fr [193.252.22.66])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF6145B27;
	Fri, 28 Mar 2025 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743160871; cv=none; b=PM4Y+KrojxYdUsckQS7QfLyeagGSTzIax0w0i9s96eUFPRcBp/7xctef8jw4iwbBJ9Cmmp2mHv+GegAiiMzveKXLPChfXlZ+VGVvKjiE0Sjir2tVaijevutZQE79sr71iiynC3LsGGkhElzDbz+Mb8mRG7aJz9ub6hXx6RaFaVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743160871; c=relaxed/simple;
	bh=RGeJQ9mMg8hHHSqGIY/rsMD519Whp6064WbDYRicHm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fm9YSQ3PJTBczmCuPg2SQ8BLgAJz1vdPNUGzNQ9I8D6hlAPIBHgtD0wOcKp3iNwyu7cNOZbfXn4MFO/oO3XCE1v0z6ZNRi/mmX+TkK82xJ3VySjThnZVmi6nLQoQEoi3j98Naf8rPqVrD6soGDa+nYrjnixI/Qu8VznMlSheMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XCbCosMY; arc=none smtp.client-ip=193.252.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y7lbtKnX8e7tky7lft5GN0; Fri, 28 Mar 2025 12:21:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743160860;
	bh=DzUIip7wsywNDhjiVRuWF0jWsKfXaZouxsMiWCZkKwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XCbCosMYs8cuSdBEiceudtepFGnkeW7EMZxuaByVsrUFy64tJXMPVkY4ebVPzsAqV
	 16GjUK87W5QeyUza/ABz0XTRAV49jU7HYXELI1zqqjH/gOTorY1mv3Vqj7zdBGZ4kB
	 IPcutJF0B5nHksfDaF/Je+VzW7nT3EDfYxiXJwpl6WSGEWD9pd+7AY7pQ6VXsl2vUS
	 ySPEyMDl7phtQWcgX8QRP3yVfcMRGZS2OURyOaNz4h1hOGtSIsQxnnGBH2+eEVLfB1
	 LudbcELRIoLNMcAxBDFrf0VQWcZDJdCR9gJUGTBiL48pXdMom/ow14L9vLpf7la+9a
	 qtDWcCf/fpu4A==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 12:21:00 +0100
X-ME-IP: 124.33.176.97
Message-ID: <1c797eda-658e-4902-8257-5b24fce0274f@wanadoo.fr>
Date: Fri, 28 Mar 2025 20:20:50 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/18] can: rcar_canfd: Simplify RCANFD_GAFLCFG_SETRNC
 macro
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "biju.das.au" <biju.das.au@gmail.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-9-biju.das.jz@bp.renesas.com>
 <ee0f8bff-6dc4-4ddc-a2d2-89ed6fddcc8f@wanadoo.fr>
 <TY3PR01MB113467D894782F210DA15345E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY3PR01MB113467D894782F210DA15345E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/03/2025 at 19:54, Biju Das wrote:
> Hi Vincent,
> 
>> -----Original Message-----
>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> Sent: 28 March 2025 10:39
>> Subject: Re: [PATCH v7 08/18] can: rcar_canfd: Simplify RCANFD_GAFLCFG_SETRNC macro
>>
>> On 26/03/2025 at 21:19, Biju Das wrote:
>>> The shift values in RCANFD_GAFLCFG_SETRNC are dictated by the field width:
>>>   - R-Car Gen4 packs 2 values in a 32-bit word, using a field width
>>>     of 16 bits,
>>>   - R-Car Gen3 packs up to 4 values in a 32-bit word, using a field
>>>     width of 8 bits.
>>>
>>> Add rnc_field_width variable to struct rcar_canfd_hw_info to handle
>>> this difference and simplify the shift value in RCANFD_GAFLCFG_SETRNC
>>> macro by using a formula (32 - (n % rnc_stride + 1) * rnc_field_width).
>>>
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> ---
>>> v6->7:
>>>  * Collected tag.
>>> v5->6:
>>>  * Replaced RCANFD_RNC_PER_REG macro with rnc_stride variable.
>>>  * Updated commit description
>>>  * Dropped the Rb tag.
>>> v5:
>>>  * New patch.
>>> ---
>>>  drivers/net/can/rcar/rcar_canfd.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/can/rcar/rcar_canfd.c
>>> b/drivers/net/can/rcar/rcar_canfd.c
>>> index 0001c8043c25..62cde1efa0c0 100644
>>> --- a/drivers/net/can/rcar/rcar_canfd.c
>>> +++ b/drivers/net/can/rcar/rcar_canfd.c
>>> @@ -89,7 +89,7 @@
>>>  /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */  #define
>>> RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
>>>  	(((x) & ((gpriv)->info->num_supported_rules - 1)) << \
>>> -	 (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
>>> +	 (32 - (((n) % (gpriv)->info->rnc_stride + 1) *
>>> +(gpriv)->info->rnc_field_width)))
>>
>> I can not follow how this is the same. Let's take the gen4 as an example. Before:
>>
>>   (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8))) =
>>   16 - ((n & 1) * 16)
>>
>> So, I have:
>>
>> 	 n	shift value
>> 	---------------------------------
>> 	 0	16 - ((0 & 1) * 16) = 0
>> 	 1	16 - ((1 & 1) * 16) = 16
>> 	 2	16 - ((2 & 1) * 16) = 0
>> 	 3	16 - ((3 & 1) * 16) = 16
>> 	 4	16 - ((4 & 1) * 16) = 0
>>
>> After:
>>
>>   (32 - ((n % rnc_stride + 1)) * rnc_field_width) =
> 
> 32 - (n % rnc_stride) + 1 =
>>   32 - ((n % (2 + 1)) * 16) =
> 
> 
>>   32 - ((n % 3) * 16)
>  32 - ((n % 2) + 1)) * 16) =
> 
>>
>> 	 n	shift value
>> 	---------------------------------
>> 	 0	32 - ((0 % 3) * 16) = 32
>> 	 1	32 - ((1 % 3) * 16) = 16
>> 	 2	32 - ((2 % 3) * 16) = 0
>> 	 3	32 - ((3 % 3) * 16) = 32
>> 	 4	32 - ((4 % 3) * 16) = 16
>>
>> Is there something wrong in my calculation? What am I missing?
> 
> 0	32 - ((0 % 2) + 1) * 16) = 16
> 1	32 - ((1 % 2) + 1) * 16) = 0

OK. Thanks. I didn't parse the parenthesis correctly. It's been a long
week, sorry for the noise.

>> More generally, it is really hard to review and understand what this macro does.
> 
> Macro is doing a simple calculation.
> 
> (32 - (n % rnc_stride + 1) * rnc_field_width)

This is before adding the tons of parenthesis. I did my review of best
effort and got it wrong not because the calculation is complication but
because of the noise introduced by those parenthesis (plus admittedly
some fatigue from the long week…)

>> Can add one more patch:
>>
>>   can: rcar_canfd: turn RCANFD_GAFLCFG_SETRNC into a function
>>
>> and then apply your change?
>>
>> I do not see the reason why this needs to be a macro. If you make this a function, at least, it will
>> be easier to follow what is going on and the compiler optimizer will inline it anyway so you should
>> not get any penalty.
> 
> I am leaving Marc, Geert to provide their feedback on this.

The maintainers of the CAN drivers and Marc and myself. Of course, I do
appreciate Geert feedback here. But for doing this maintenance as a
volunteer, in exchange, I want you to make my review work (and the long
term maintenance) easier.

function-like macro are not welcome unless strictly needed and I am not
keen on dropping this ask.


Yours sincerely,
Vincent Mailhol


