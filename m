Return-Path: <linux-can+bounces-3254-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4FBA7466D
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875953ADB0C
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 09:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEED3214221;
	Fri, 28 Mar 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BtSSrL9E"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898661AA1EC;
	Fri, 28 Mar 2025 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743154653; cv=none; b=VJHKaZueVJWjXngMP7mwU6vaMK9ygi2u85JxhWHND2T2RuFonSBAw3QwfJmHQh/BUyzK4MKS99v99kPbU9DyHYhhrT7grGRr3FNgFx/IqlE9LSfNMLfYIVbTxaKXq7ka/hesXMpa0NqGjeG28Df03NaTbt1JbRTcHUFcFXjOBPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743154653; c=relaxed/simple;
	bh=OQkkY/sZMQ9C63cZBP/zWhzNTLduTNcv15gfFo+BHoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+T14ZR0x8GcVyjFy603pfb5dUsLqX4jj/w3C2qToJoeBnDybwX8FvKhB6MuppBHJMCtYYcFBNY6N7z9+QwLLnNFtrZJBGWlMK2umT9LCNJzZYo9hOer3Dlm6bgYChVhHmsB7OSGkkNSNs9Qm7trR5Mv3rR6Xnr2cM3dE1I0iV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=BtSSrL9E; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y69StcPTQVylty69VtKSen; Fri, 28 Mar 2025 10:37:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743154648;
	bh=XTZLV5Av5dLiPeFERoOtP7UQNCypM588vebDGjSETBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=BtSSrL9Eqh12Os12JG2YScHqEdVUapumPkLjAD5gvTsYC4S40riAqqs4QPxnCTSgV
	 XXpgMqm8grwhmadECmswKHaKeYZlXXyfNZWHEYVzaeQIRchYKmiESiKQXIXZo7IRgo
	 RhlnU0pVcv7MfICbmO/96uF1Gnymkc8laevgeasLeE3JnunCpJyqA19X9De95lwW5l
	 sM0HvA6EwJfBaohWej20J4Vj6fl707dGf8iyxZWFobQEUkZkieZXiZhIxD2LzyUIxx
	 XmN7ykM30JpDWO1Nl/Mm/moCYbDzMJQMueTGk5S/HiW6O8PIZ5Sf2g61ahBDqJHYPW
	 R8rQAQTXjW2vw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 10:37:28 +0100
X-ME-IP: 124.33.176.97
Message-ID: <deffdc35-86cf-4282-ba6d-f36890bf9fcd@wanadoo.fr>
Date: Fri, 28 Mar 2025 18:37:21 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
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
 <20250326122003.122976-6-biju.das.jz@bp.renesas.com>
 <40392a70-3be4-4d11-8614-eebd5d9d24a8@wanadoo.fr>
 <TY3PR01MB11346C091544B49A6C160712E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY3PR01MB11346C091544B49A6C160712E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/03/2025 at 18:21, Biju Das wrote:
> Hi Vincent,
> 
> Thanks for the feedback.
> 
>> -----Original Message-----
>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> Sent: 28 March 2025 09:10
>> Subject: Re: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros in RCANFD_GERFL_ERR
>>
>> On 26/03/2025 à 21:19, Biju Das wrote:
>>> The macros RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced by
>>> gpriv->channels_mask << 16.
>>>
>>> After this drop the macro RCANFD_GERFL_EEF0_7 as it is unused.
>>>
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> ---
>>> v6->v7:
>>>  * No change.
>>> v5->v6:
>>>  * Collected tag.
>>> v5:
>>>  * New patch.
>>> ---
>>>  drivers/net/can/rcar/rcar_canfd.c | 5 +----
>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/can/rcar/rcar_canfd.c
>>> b/drivers/net/can/rcar/rcar_canfd.c
>>> index 565a91c2ca83..a9e962a1510e 100644
>>> --- a/drivers/net/can/rcar/rcar_canfd.c
>>> +++ b/drivers/net/can/rcar/rcar_canfd.c
>>> @@ -74,7 +74,6 @@
>>>  #define RCANFD_GSTS_GNOPM		(BIT(0) | BIT(1) | BIT(2) | BIT(3))
>>>
>>>  /* RSCFDnCFDGERFL / RSCFDnGERFL */
>>> -#define RCANFD_GERFL_EEF0_7		GENMASK(23, 16)
>>>  #define RCANFD_GERFL_EEF(ch)		BIT(16 + (ch))
>>>  #define RCANFD_GERFL_CMPOF		BIT(3)	/* CAN FD only */
>>>  #define RCANFD_GERFL_THLES		BIT(2)
>>> @@ -82,9 +81,7 @@
>>>  #define RCANFD_GERFL_DEF		BIT(0)
>>>
>>>  #define RCANFD_GERFL_ERR(gpriv, x) \
>>> -	((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
>>> -			 RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
>>> -		RCANFD_GERFL_MES | \
>>> +	((x) & ((gpriv->channels_mask << 16) | RCANFD_GERFL_MES | \
>>
>> The previous RCANFD_GERFL_EEF0_7 macro documented that the register was from bit index 16 to bit index
>> 23. Here, we loose this piece of information.
>>
>> What about:
>>
>> 	FIELD_PREP(RCANFD_GERFL_EEF0_7, gpriv->channels_mask)
> 
> For all SoCs, ECC Error flag for Channel x (a.k.a. EEFx) starts from BIT position 16.
> 
> By using gpriv->channels_mask, we allow only enabled channels and << 16
> says it is from Bit position 16.

Yes, it starts at bit 16, but at which bit does it end?

The GENMASK() helps to document the register names. Of course is works
if you replace the FIELD_PREP with a left shift, but you are replacing
some meaningful information about the register name, register start bit
and end bit by just a start bit value. See? You just lost the register
name and end bit info.

FIELD_PREP() is not only about doing the correct shift but also about
documenting that you are putting the value into a specific register.

When reading:

  FIELD_PREP(RCANFD_GERFL_EEF0_7, gpriv->channels_mask)

I immediately understand that you are putting the gpriv->channels_mask
value into the GERFL_EEF0_7 register and I can look at the datasheet for
details about that GERFL_EEF0_7 if I want to.

When reading:

  gpriv->channels_mask << 16

I just see the magic number 16. No clue what this means at first glance.

> Gen4 has 7 channels
> G3E has 6 channels
> V4M has 4 channels
> V3H_2 has 3 channels
> All other SoCs has 2 channels
> 
> Am I missing anything here?

Yours sincerely,
Vincent Mailhol


