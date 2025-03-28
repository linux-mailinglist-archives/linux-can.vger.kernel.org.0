Return-Path: <linux-can+bounces-3263-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D34AA74891
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D6617C0B7
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423521322B;
	Fri, 28 Mar 2025 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="B/3HxoVj"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF922135BB;
	Fri, 28 Mar 2025 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158603; cv=none; b=AmAa34SS/vxBV9WJF/KA20/VfSq2Ow8tLIDCxbCHt0oDmvDrw+n3NBtRgDu0jmIukY/uLKaEsfX19jqmxMWX2Yj/CLiKowJ8thqMmHX5HVMcyZ2dsYhDQOmuZYrdncHOsHOeS5mEUcfCJAvcdW+ysrUHppseFGpo+V3/Y+skg7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158603; c=relaxed/simple;
	bh=bffKTtaMqhmrwZrKNP7lJJ/4Q9eUQdxdN5IUCav0zyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blcWAtah6TY/TvLBCH9VbLoOfRAxmSfwufrKhau0muHuvVOxFopHRwYkGE0POXbXXZTvtAtxmkBH+YkZv5LQWSqazr141bPFTMFGpJVIrzzp5q+8FR3pUkev52cACgd2S3AEzlA3jul/Hqp2CnK2/Od67ZubkDjxAwqDgzcxcgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=B/3HxoVj; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y7B9tJctnhqDwy7BDtmSxi; Fri, 28 Mar 2025 11:43:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743158599;
	bh=h+L06X47729V5pMjb45e6wShqeH8a46mgG8d3/En6OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=B/3HxoVjizflzAZ2vUlmY/vsQFpeFxg8W3FP/Uaewq3D8J3mDa8zi52e5ebwbukmT
	 QwZ7E+6n4R+5i2PfW5P9m8C3zAUtXgcZWbBWa/bIYBgx4TN4XTsYz36Q4kLeibYHBx
	 d6o/ykOqo+YZFzKcvBd5ASZJ09Zi0w546Ac1f39BZzjFEi8op8ww2GHQCjQ6RL8eS5
	 pMbhw0bEyxrPg9+0IXP3okbnEyAqCsZQQLGNsUeVKT2G8loZz8pDm8yX1eMWV+EBQ8
	 wQIEsbObIh9V8xrWaonDMKuXJZR21pKyv4dAWtyZ/eSuc6odSG2fz/aDhyGp60lY7c
	 yTDPXeD9BemDA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 11:43:19 +0100
X-ME-IP: 124.33.176.97
Message-ID: <b486255e-4699-4ca2-a783-9c164eef3f24@wanadoo.fr>
Date: Fri, 28 Mar 2025 19:43:10 +0900
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
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
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
 <deffdc35-86cf-4282-ba6d-f36890bf9fcd@wanadoo.fr>
 <TY3PR01MB11346DA97D5F685D96A638DB086A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdUacYqUd_iPk95C3+bc64SeMbDj1=zdfLvuMHFbTRS39w@mail.gmail.com>
 <TY3PR01MB113464539C208D4A1AAF403A286A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY3PR01MB113464539C208D4A1AAF403A286A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/03/2025 at 19:15, Biju Das wrote:
> Hi Geert and Vincent,
> 
>> -----Original Message-----
>> From: Geert Uytterhoeven <geert@linux-m68k.org>
>> Sent: 28 March 2025 10:10
>> Subject: Re: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros in RCANFD_GERFL_ERR
>>
>> Hi Biju,
>>
>> On Fri, 28 Mar 2025 at 10:51, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>>>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr> On 28/03/2025 at
>>>> 18:21, Biju Das wrote:
>>>>>> -----Original Message-----
>>>>>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>>>> Sent: 28 March 2025 09:10
>>>>>> Subject: Re: [PATCH v7 05/18] can: rcar_canfd: Drop
>>>>>> RCANFD_GERFL_EEF* macros in RCANFD_GERFL_ERR
>>>>>>
>>>>>> On 26/03/2025 à 21:19, Biju Das wrote:
>>>>>>> The macros RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced
>>>>>>> by
>>>>>>> gpriv->channels_mask << 16.
>>>>>>>
>>>>>>> After this drop the macro RCANFD_GERFL_EEF0_7 as it is unused.
>>>>>>>
>>>>>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>>
>>>>>>> --- a/drivers/net/can/rcar/rcar_canfd.c
>>>>>>> +++ b/drivers/net/can/rcar/rcar_canfd.c
>>>>>>> @@ -74,7 +74,6 @@
>>>>>>>  #define RCANFD_GSTS_GNOPM                (BIT(0) | BIT(1) | BIT(2) | BIT(3))
>>>>>>>
>>>>>>>  /* RSCFDnCFDGERFL / RSCFDnGERFL */
>>>>>>> -#define RCANFD_GERFL_EEF0_7              GENMASK(23, 16)
>>>>>>>  #define RCANFD_GERFL_EEF(ch)             BIT(16 + (ch))
>>>>>>>  #define RCANFD_GERFL_CMPOF               BIT(3)  /* CAN FD only */
>>>>>>>  #define RCANFD_GERFL_THLES               BIT(2)
>>>>>>> @@ -82,9 +81,7 @@
>>>>>>>  #define RCANFD_GERFL_DEF         BIT(0)
>>>>>>>
>>>>>>>  #define RCANFD_GERFL_ERR(gpriv, x) \
>>>>>>> - ((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
>>>>>>> -                  RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
>>>>>>> -         RCANFD_GERFL_MES | \
>>>>>>> + ((x) & ((gpriv->channels_mask << 16) | RCANFD_GERFL_MES | \
>>>>>>
>>>>>> The previous RCANFD_GERFL_EEF0_7 macro documented that the
>>>>>> register was from bit index 16 to bit index 23. Here, we loose this piece of information.
>>>>>>
>>>>>> What about:
>>>>>>
>>>>>>    FIELD_PREP(RCANFD_GERFL_EEF0_7, gpriv->channels_mask)
>>>>>
>>>>> For all SoCs, ECC Error flag for Channel x (a.k.a. EEFx) starts from BIT position 16.
>>>>>
>>>>> By using gpriv->channels_mask, we allow only enabled channels and
>>>>> <<
>>>>> 16 says it is from Bit position 16.
>>>>
>>>> Yes, it starts at bit 16, but at which bit does it end?
>>>>
>>>> The GENMASK() helps to document the register names. Of course is
>>>> works if you replace the FIELD_PREP with a left shift, but you are
>>>> replacing some meaningful information about the register name,
>>>> register start bit and end bit by just a start bit value. See? You just lost the register name and
>> end bit info.
>>>>
>>>> FIELD_PREP() is not only about doing the correct shift but also
>>>> about documenting that you are putting the value into a specific register.
>>>>
>>>> When reading:
>>>>
>>>>   FIELD_PREP(RCANFD_GERFL_EEF0_7, gpriv->channels_mask)
>>>>
>>>> I immediately understand that you are putting the
>>>> gpriv->channels_mask value into the GERFL_EEF0_7 register and I can look at the datasheet for
>> details about that GERFL_EEF0_7 if I want to.
>>>
>>> Gen4 has 8 channels (GENMASK(16, 23)
>>> G3E has 6 channels  (GENMASK(16, 21)
>>> V4M has 4 channels  (GENMASK(16, 19)
>>> V3H_2 has 3 channels (GENMASK(16,18)
>>> All other SoCs has 2 channels (GENMASK(16,17)
>>>
>>> So you mean, I should replace RCANFD_GERFL_EEF0_7 with a
>>>
>>> Generic one RCANFD_GERFL_EEF(x) GENMASK(16, 16 + (x) - 1) to handle
>>> this differences
>>>
>>> Where x is the number of supported channels(info->max_channels)
>>>
>>> and then use
>>>
>>> FIELD_PREP(RCANFD_GERFL_EEF(x), gpriv->channels_mask)
>>
>> Just use
>>
>>     #define RCANFD_GERFL_EEF    GENMASK(23, 16)
>>
>> and
>>
>>     FIELD_PREP(RCANFD_GERFL_EEF, gpriv->channels_mask)

Ack. Pretty close to my initial suggestion of

  #define RCANFD_GERFL_EEF0_7              GENMASK(23, 16)
  FIELD_PREP(RCANFD_GERFL_EEF0_7, gpriv->channels_mask)

>> As channels_mask can never have bits set for non-existing channels, all reserved bits above EEF in the
>> GERFL register will be zero.
> 
> Agreed. Will add this change in next version

Thank you :)


Yours sincerely,
Vincent Mailhol


