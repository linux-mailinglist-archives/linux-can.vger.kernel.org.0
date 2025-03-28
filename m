Return-Path: <linux-can+bounces-3273-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E24CA749EE
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 13:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33CD17A892
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA453214;
	Fri, 28 Mar 2025 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="CHrtMN0j"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-67.smtpout.orange.fr [193.252.22.67])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF598C07;
	Fri, 28 Mar 2025 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743165689; cv=none; b=ZxyilCoRREaqz5DSV7MQZbxQ1JZ1aCAzi2YStBfFpVPP7GHOjvqS4zQX4HzgP1+3y91D75xH4OdDOV0n0jTIOHOdc0jWzfE0uWD1j/sixX3bit5qISbX3QwJfK8ig9pzausOKbiKn8Kz82GJzUMgAW6SlkmvPbzm6Ac6mjNcFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743165689; c=relaxed/simple;
	bh=41eHdbr+jgjgJYRtpsxRz4YCBx5H6SSfV6H5Xf4IjJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpDYedPPg3sf5fkvXTJ06VYUDpo9lRZk0pSM4JkG3LBpGoXzvxJ6aquNFYJ/2y9W7yjx3oy2jIvLSVGBkwK20kppRaO/UYpSYMlIFOkisrLSlh2RlbIK+DDbPGObH2BhhxS34tTKVJAPu68Nea1LGf9UzQTcKqC8yJ0daaVAqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=CHrtMN0j; arc=none smtp.client-ip=193.252.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y91QtgAWu6Qtky91Ut1pdD; Fri, 28 Mar 2025 13:41:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743165684;
	bh=N57LXiofcz/T32oEj9o6qWnPOGUmbRrphsg1Ams3AkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=CHrtMN0jzAwS5WhMvdq96D5QlhAQB3NS3pL06XSi7l/0d1pSbGvw5N7kfn/FsZcZh
	 FKWsBN09a6EPpqO/qjZc8RgC98AgRTgomkfF8cfz7AADxkURlajtmJYHHTmE1M8kIY
	 h0JOYWD+08e0/VldQp9YHXOenjdVaNSw+Exh8/yXVBchm+uviphURmZyiXupexf5+Z
	 14ouqJ8mlC3qPesNhr+UgudJGP8oqo7u6ZVX05SDvdY43s8/yMqGCyPFlOOGBoWyo9
	 sJtcjlwdu1SmAhPWvU8l0zodP1WZnJ9bdH417FKOh+cBctrlpcPZshJ6zB/SRI74wY
	 jsKW9VAV0nhMQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 13:41:24 +0100
X-ME-IP: 124.33.176.97
Message-ID: <ba276015-b649-4e5e-a69f-93830812c59a@wanadoo.fr>
Date: Fri, 28 Mar 2025 21:41:15 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/18] can: rcar_canfd: Add max_aflpn variable to
 struct rcar_canfd_hw_info
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
 <20250326122003.122976-10-biju.das.jz@bp.renesas.com>
 <98b10d18-89ae-4fef-b9e3-f548b88c616f@wanadoo.fr>
 <TY3PR01MB113466234D837B22985BBCE0D86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY3PR01MB113466234D837B22985BBCE0D86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/03/2025 at 20:17, Biju Das wrote:
> Hi Vincent,
> 
>> -----Original Message-----
>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> Sent: 28 March 2025 11:06
>> To: Biju Das <biju.das.jz@bp.renesas.com>; Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>; Geert Uytterhoeven <geert+renesas@glider.be>; Uwe
>> Kleine-König <u.kleine-koenig@baylibre.com>; linux-can@vger.kernel.org; Prabhakar Mahadev Lad
>> <prabhakar.mahadev-lad.rj@bp.renesas.com>; biju.das.au <biju.das.au@gmail.com>; linux-renesas-
>> soc@vger.kernel.org
>> Subject: Re: [PATCH v7 09/18] can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
>>
>> On 26/03/2025 at 21:19, Biju Das wrote:
>>> R-Car Gen3 has maximum acceptance filter list page number of 31
>>> whereas on R-Car Gen4 it is 127. Add max_aflpn variable to struct
>>> rcar_canfd_hw_info in order to support RZ/G3E that has max AFLPN of 63.
>>>
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>>
>> With below nitpick addressed, you can add my:
>>
>> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>
>>> ---
>>> v6->v7:
>>>  * Collected tag.
>>> v6:
>>>  * New patch.
>>> ---
>>>  drivers/net/can/rcar/rcar_canfd.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/can/rcar/rcar_canfd.c
>>> b/drivers/net/can/rcar/rcar_canfd.c
>>> index 62cde1efa0c0..7cef0673fbc8 100644
>>> --- a/drivers/net/can/rcar/rcar_canfd.c
>>> +++ b/drivers/net/can/rcar/rcar_canfd.c
>>> @@ -93,7 +93,7 @@
>>>
>>>  /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
>>>  #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
>>> -#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
>>> +#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & (gpriv)->info->max_aflpn)
>>                                         ^ While at it, can you rename that x to page_num in the next
>> version? I don't mind if you do it in the same patch.
>>
>> I understand it was here before, but that's will be a nice quality of life improvement.
>>
>> Please do the same for the other macro which you are modifying  in this series (I am not asking you to
>> rewrite the full driver, so only do local improvement on the parts you are touching).
> 
> Is it ok, if I send a separate patch for that conversion for all macros
> which will avoid inconsistency in the driver as some macros will have x and
> some macros with meaning full name?

This also works! Also OK if you prefer to send this in a separate series
together with the removal of the unused macros.

> Cheers,
> Biju

(...)

Yours sincerely,
Vincent Mailhol


