Return-Path: <linux-can+bounces-3287-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57CFA74E19
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 16:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751BA3AC384
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964401C2324;
	Fri, 28 Mar 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ogrzb8S4"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7631D514F;
	Fri, 28 Mar 2025 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743177097; cv=none; b=Zx7lbEaHFKmvA1AW+EiGsmfr4KeLQ6344VrJgYhhQhWrLmItJaYmzXAxIUoJTQhKr5QH1PzG4sTO2RiccBiLvdmRu3IOPDEnTue+qxhuiLeHnL+aMXvTA8L83dlz9MmUJGEPvkQH2HSeLLUmFsWBVpVe3/QuIJj9IsQv2bMGhJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743177097; c=relaxed/simple;
	bh=ghsZaAuBTkXE9CE7Wr7rOgOKqs0KjC2f39qNSlSBiAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hnc3jDghvW+XXq92QLS77qJuMUMU9HIIjXTS/JdsD6AWTrq2h7V/ZTkdBWQTQ2Fef5QblnrF/VtL8r1Dq2RipM51bTp1sCNC1o8PGRDJTFZE5pmQwy9wwqzNMLnWLFyVhdgbEn7kWFO2ROMSWgFX605oryNcRxAizIv35iWgs2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Ogrzb8S4; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id yBzPtUQnhKYSDyBzTtreOl; Fri, 28 Mar 2025 16:51:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743177091;
	bh=Nn9U1fjytFH/G7ihiliNcL9ekzdD+EhZivT4FvgCs3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Ogrzb8S4UcjZv8JCj4D92t2n5Oy/9Vs5EFAzleIjttBP8ZtouGwZ4XgqxE9RHlfXj
	 tmnqPEIv7s9jX94i80FnOeqWwevL3rhaXvSWpOYg5bCLg05uVOTUR+EfDvtcmxah8m
	 bPi+mxixzX30NSz8qmBMTCU1R1D+Uo5GxxZljSBI0yrKmjE42+xpxb9vpetNVK8MvI
	 q6xOl8Wptc4OpXQGlScttRxHHOpOsIszAgqyDE39l9j3sRGKnFd6PIwyGVMryoNEJR
	 fC9NCECiAbCe3Q5o/3ZNCBMZ5ze56vs5IBki7mB5nrnGxAsB91efEpkWZDGD5VXhWf
	 IwngluZzOlC0w==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 16:51:31 +0100
X-ME-IP: 124.33.176.97
Message-ID: <98fe6fbc-60ce-42fb-9740-2c66aaa2ef8f@wanadoo.fr>
Date: Sat, 29 Mar 2025 00:51:22 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/18] can: rcar_canfd: Add rnc_stride variable to
 struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "biju.das.au" <biju.das.au@gmail.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-8-biju.das.jz@bp.renesas.com>
 <3bf3ec05-d900-494a-954e-633828b4c984@wanadoo.fr>
 <TY3PR01MB113461BFAD846313BD0584A8A86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY3PR01MB113461BFAD846313BD0584A8A86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/03/2025 at 00:39, Biju Das wrote:
> Hi Vincent,
> 
> Thanks for the feedback.
> 
>> -----Original Message-----
>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> Sent: 28 March 2025 10:37
>> Subject: Re: [PATCH v7 07/18] can: rcar_canfd: Add rnc_stride variable to struct rcar_canfd_hw_info
>>
>> On 26/03/2025 at 21:19, Biju Das wrote:
>>> R-Car Gen4 packs 2 RNC values in a 32-bit word, whereas R-Car Gen3
>>> packs up to 4 values in a 32-bit word. Handle this difference by
>>> adding rnc_stride variable to struct rcar_canfd_hw_info and update the
>>> macro RCANFD_GAFLCFG.
>>>
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> ---
>>> v6->v7:
>>>  * Collected tag.
>>> v5->v6:
>>>  * Replaced RCANFD_RNC_PER_REG macro with rnc_stride variable.
>>>  * Updated commit description
>>>  * Dropped Rb tag.
>>> v5:
>>>  * New patch.
>>> ---
>>>  drivers/net/can/rcar/rcar_canfd.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/can/rcar/rcar_canfd.c
>>> b/drivers/net/can/rcar/rcar_canfd.c
>>> index 32d700962d69..0001c8043c25 100644
>>> --- a/drivers/net/can/rcar/rcar_canfd.c
>>> +++ b/drivers/net/can/rcar/rcar_canfd.c
>>> @@ -291,7 +291,7 @@
>>>  /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
>>>  #define RCANFD_GAFLECTR			(0x0098)
>>>  /* RSCFDnCFDGAFLCFG / RSCFDnGAFLCFG */
>>> -#define RCANFD_GAFLCFG(ch)		(0x009c + (0x04 * ((ch) / 2)))
>>> +#define RCANFD_GAFLCFG(gpriv, ch)	(0x009c + (0x04 * ((ch) / (gpriv)->info->rnc_stride)))
>>
>> I find it rather hard to follow the logic here. Your are multiplying by four and then dividing again
>> to get the good results. Here, I guess that
>> 0x04 represents sizeof(u32), but this needs some thinking to figure that out.
>>
>> Wouldn't it be more intuitive to instead store the size in bytes of the RNC value?
>>
>> #define RCANFD_GAFLCFG(gpriv, ch) \
>> 	(0x009c + (gpriv)->info->sizeof_rnc * (ch))
>>
>> This way, no more 0x04 magic number and it is easier to process a multiplication than a division in
>> your head when reading the code.
> 
> Now the macro simplified as after introducing setrnc() [1]
> #define RCANFD_GAFLCFG(w)		(0x009c + (0x04 * (w)))
> 
> Where "w" is the index mentioned in the hardware manual.
> 
>>
>>>  /* RSCFDnCFDRMNB / RSCFDnRMNB */
>>>  #define RCANFD_RMNB			(0x00a4)
>>>  /* RSCFDnCFDRMND / RSCFDnRMND */
>>> @@ -505,6 +505,7 @@ struct rcar_canfd_global;
>>>
>>>  struct rcar_canfd_hw_info {
>>>  	u16 num_supported_rules;
>>> +	u8 rnc_stride;
>>>  	u8 max_channels;
>>>  	u8 postdiv;
>>>  	/* hardware features */
>>> @@ -582,6 +583,7 @@ static const struct can_bittiming_const
>>> rcar_canfd_bittiming_const = {
>>>
>>>  static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>>>  	.num_supported_rules = 256,
>>> +	.rnc_stride = 4,
>>>  	.max_channels = 2,
>>>  	.postdiv = 2,
>>>  	.shared_global_irqs = 1,
>>> @@ -589,6 +591,7 @@ static const struct rcar_canfd_hw_info
>>> rcar_gen3_hw_info = {
>>>
>>>  static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>>>  	.num_supported_rules = 512,
>>> +	.rnc_stride = 2,
>>>  	.max_channels = 8,
>>>  	.postdiv = 2,
>>>  	.shared_global_irqs = 1,
>>> @@ -596,6 +599,7 @@ static const struct rcar_canfd_hw_info
>>> rcar_gen4_hw_info = {
>>>
>>>  static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>>>  	.num_supported_rules = 256,
>>> +	.rnc_stride = 4,
>>>  	.max_channels = 2,
>>>  	.postdiv = 1,
>>>  	.multi_channel_irqs = 1,
>>> @@ -797,7 +801,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
>>>  			    RCANFD_GAFLECTR_AFLDAE));
>>>
>>>  	/* Write number of rules for channel */
>>> -	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch),
>>> +	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(gpriv, ch),
>>>  			   RCANFD_GAFLCFG_SETRNC(gpriv, ch, num_rules));
> 
> By introducing setrnc(), this patch is no more needed as
> rnc_stride is local variable inside strnc(). So I would like to drop this
> patch in next version.
> 
> [1]
> static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, u32 ch,
> 			      int num_rules)
> {
> 	u32 shift, rnc, offset, w, rnc_stride;
> 
> 	rnc_stride = 32 / gpriv->info->rnc_field_width;
> 	shift = 32 - ((ch % rnc_stride + 1) * gpriv->info->rnc_field_width);
> 	rnc = (num_rules & (gpriv->info->num_supported_rules - 1)) << shift;
> 	w = ch / rnc_stride;
> 	offset = RCANFD_GAFLCFG(w);
> 	rcar_canfd_set_bit(gpriv->base, offset, rnc);
> }

Yes, yes, yes!

See, that's way better that the previous macros!

No more parenthesis madness, the intermediate variables get a proper
name, you do not need so separately store the rnc_field_width and the
rnc_stride. All good.

Sorry for the poor feedback earlier on, but I am glad that I insisted
now that I see the nice improvement.


Yours sincerely,
Vincent Mailhol


