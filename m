Return-Path: <linux-can+bounces-3737-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 221C8AC7E28
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 14:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD00118888BB
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC29288D6;
	Thu, 29 May 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sPwk5T8P";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LYkk1rt9"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD421E492
	for <linux-can@vger.kernel.org>; Thu, 29 May 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523012; cv=pass; b=fsFZFSUdrZLmx7bxMqSu3z7SfbjXbnkeUb7YNqchhpKTsOnGbo49/ES3tXnGx7rFPuBE2DYl4kR43sfzAXADoVMltykkLnbb1kW3bgifHssM5gWK4MiqXgTQ7a4JxjQ/SORCYmU/30+bCEWojIeIoU8S5/h2Duso4Dwa6rJDU3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523012; c=relaxed/simple;
	bh=2aRnAEIbDAlCzXpEcdgqZ25mQSEc2SiBfjNb35Uof3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siJlLaIEzYsxum85HoLHsbYa3pYpU+j+Ntbxsr86zDvXC2LZZVbAQt7ifO8s66dsMostXp7KR+1fmZfd/UEOS2+/+CgAl/q2Kn+zZ1MIrN81lXkpGX4xnHfSPBsPUz6f5L5Jiu+lN9+wmFsWCDqwEOTWfxWYXOuYxuT6WzbNUY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sPwk5T8P; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LYkk1rt9; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748523000; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LgUgcfg6O68AeCljWzjSh2oQ4VkVuuezL+hqqKn9FqJBa1airadZvOsYMBYg5Bo2Qt
    zKqspNcafeLXp4+WvFTlCwNGvKjpilzWC9DOlvQXvOR07U3JwjcoP62D29eku8UD+OzY
    pWWqOG2T9b/nngLiInBWaEoarxLqj6IHYr+Xs2Zw/cja0ITjWHxzpjje/lWPicJ0t6sp
    j87f7auc0Al9ERiSeUCaizjMoahXnS0HBeew1UgfF1Tly0Fa/aWk5J2buoUITDz3UEQL
    qBK8JIezXEhNZHU4QzYmNFhIMx032ny8FImf6Wp7oRkik2/SX1mubjrCJynAlc1swwH9
    MPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748523000;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0bKyd7Hwi1iSpa1CGAjlRl5sTwTQIZTx+wHRavJKupo=;
    b=ObQV5I+E3cQq5hTPlzkiNzBw64IHsyP8VhXrmdZTMT/RwJvlx1sihjooL5lALmatnv
    YEym+pW0AwwZnJ3B9ijFIZk9zZRZeszjS2uORjGQVi9vRyihDW309FqzrGMUFuhACfSh
    dnHsIsGvinG0+8hDuaVTv1VdvCszI2wF8ITMmvK2LTZvqZ+Ugv/0WxT1+YwKJNXF7yn9
    OO/jRZf3VnKDt5iUgkyclBEqz+oaCriBJEIVhjg9jn70jNkuwuxyRQkqadgeAuesydl+
    koP3eDeKfGhGN/p06UMh6S9j3RVKo3e5F8+2y69a9ujxEQOVV1PAwvVp7nAhe9FCgB98
    UxQw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748523000;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0bKyd7Hwi1iSpa1CGAjlRl5sTwTQIZTx+wHRavJKupo=;
    b=sPwk5T8PeI4y5UHLqLAGdBcq9EAmUPwAm7aV+s0s7pbpk/Op0f23DgsZY245xSTM6p
    /kRIGzM12hvIB40lNTnojXluPcjio+W3PFeD6niyrBOEt7Jlxmt+jtCdHF7Oigb3474P
    rUysKXyeQNrCuRfw+m1pzG7mfQv5xrKXSRthPiPZTHj96nnQEwDUNqRTnexK4DLsEbuG
    qgWhVFfiS++OKl9a1qRM6wiusIU1v6Vmp7A3//k0UqBoWvSY67058IFlagAJmRbOORfX
    D5FX8r2i/D1/lDcDdDk/UaXnX/8M2wAvQ+eQfKdVqqsTk/IEuI9QgY+23A3CT+UpwjXr
    3GxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748523000;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0bKyd7Hwi1iSpa1CGAjlRl5sTwTQIZTx+wHRavJKupo=;
    b=LYkk1rt9IWMFKM5OhP8XgSWG5qfcdxDpZnUESWe9W/n55M5N8jR7v4SbOHEQVOgI5I
    CyM7+KWmD2AC8vBfyOAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTRoMrpo2Pns16vsQmsxH3b3A5oy0KGyM7TrgJN59IqyYh1nkGNA="
Received: from [IPV6:2003:d5:571c:cd00:82fa:11eb:442c:d362]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514TCo0osu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 29 May 2025 14:50:00 +0200 (CEST)
Message-ID: <f52f5466-6a2d-4117-9f0d-f1c07e382a29@hartkopp.net>
Date: Thu, 29 May 2025 14:49:54 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] can: canxl: add PWM config support
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20250527195625.65252-1-socketcan@hartkopp.net>
 <20250527195625.65252-10-socketcan@hartkopp.net>
 <de950905-ad60-453d-b2bc-d1115234e273@wanadoo.fr>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <de950905-ad60-453d-b2bc-d1115234e273@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 29.05.25 03:17, Vincent Mailhol wrote:

> How do you want to move forward on this?
> 
> I stopped my work, waiting for my preparation patches to be merged and for the
> PWM calculation to be clarified. Now that those two blockers are removed, I was
> about to resume the work.
> 
> Do you plan to take over? It will be complicated if both of us work
> simultaneously on the feature.

I just try to get my CAN XL hardware setup to work. Therefore I 
thankfully took your patches and added some stuff that was missing,
e.g. the RRS handling, the TRX switch handling, the Error Signalling 
switch (which might be obsolete according to Stephane) and the option to 
simply set the three PWM values without calculation.

So besides the RRS & TRX switch patches the other stuff can be seen as 
"hacks" to get it working in the meanwhile. It's no plan to take it over ;-)

I still would like to get my setup working based on your patches and 
give my feedback. So I would appreciate when you continue your work.

Best regards,
Oliver

> 
> 
> On 28/05/2025 at 04:56, Oliver Hartkopp wrote:
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/dev/netlink.c    | 31 ++++++++++++++++++++++++++++++-
>>   include/linux/can/bittiming.h    | 25 +++++++++++++++++++++++++
>>   include/linux/can/dev.h          |  1 +
>>   include/uapi/linux/can/netlink.h | 15 +++++++++++++++
>>   4 files changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
>> index 1b798a7dcd64..685cceb74048 100644
>> --- a/drivers/net/can/dev/netlink.c
>> +++ b/drivers/net/can/dev/netlink.c
>> @@ -23,10 +23,11 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
>>   	[IFLA_CAN_TDC] = { .type = NLA_NESTED },
>>   	[IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
>>   	[IFLA_CAN_XL_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
>>   	[IFLA_CAN_XL_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
>>   	[IFLA_CAN_XL_TDC] = { .type = NLA_NESTED },
>> +	[IFLA_CAN_XL_PWM] = { .type = NLA_NESTED },
>>   };
>>   
>>   static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
>>   	[IFLA_CAN_TDC_TDCV_MIN] = { .type = NLA_U32 },
>>   	[IFLA_CAN_TDC_TDCV_MAX] = { .type = NLA_U32 },
>> @@ -37,10 +38,16 @@ static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
>>   	[IFLA_CAN_TDC_TDCV] = { .type = NLA_U32 },
>>   	[IFLA_CAN_TDC_TDCO] = { .type = NLA_U32 },
>>   	[IFLA_CAN_TDC_TDCF] = { .type = NLA_U32 },
>>   };
>>   
>> +static const struct nla_policy can_pwm_policy[IFLA_CAN_PWM_MAX + 1] = {
>> +	[IFLA_CAN_PWM_OFFSET] = { .type = NLA_U8 },
>> +	[IFLA_CAN_PWM_LONG] = { .type = NLA_U8 },
>> +	[IFLA_CAN_PWM_SHORT] = { .type = NLA_U8 },
>> +};
> 
> ISO 11898-1 uses the accronyms PWML, PWMO and PWMS. I would prefer to keep the
> exact same naming as the standard.
> 
> Also, +1 to what Marc said, u32 seems better here.
> 
>>   static int can_validate_bittiming(const struct can_bittiming *bt,
>>   				  struct netlink_ext_ack *extack)
>>   {
>>   	/* sample point is in one-tenth of a percent */
>>   	if (bt->sample_point >= 1000) {
>> @@ -464,10 +471,29 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>>   				 can_xl_tdc_is_enabled(priv),
>>   				 CAN_CTRLMODE_XL_TDC_MASK, extack);
>>   	if (err)
>>   		return err;
>>   
>> +	/* CAN XL transceiver PWM configuration */
>> +	if (data[IFLA_CAN_XL_PWM]) {
>> +		struct nlattr *tb_pwm[IFLA_CAN_PWM_MAX + 1];
>> +
>> +		err = nla_parse_nested(tb_pwm, IFLA_CAN_PWM_MAX, data[IFLA_CAN_XL_PWM],
>> +				       can_pwm_policy, extack);
>> +		if (err)
>> +			return err;
>> +
>> +		if (tb_pwm[IFLA_CAN_PWM_OFFSET])
>> +			priv->pwm.pwm_offset = nla_get_u8(tb_pwm[IFLA_CAN_PWM_OFFSET]) & 0x3F;
>> +
>> +		if (tb_pwm[IFLA_CAN_PWM_LONG])
>> +			priv->pwm.pwm_phase_long = nla_get_u8(tb_pwm[IFLA_CAN_PWM_LONG]) & 0x3F;
>> +
>> +		if (tb_pwm[IFLA_CAN_PWM_SHORT])
>> +			priv->pwm.pwm_phase_short = nla_get_u8(tb_pwm[IFLA_CAN_PWM_SHORT]) & 0x3F;
>> +	}
>> +
>>   	if (data[IFLA_CAN_TERMINATION]) {
>>   		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
>>   		const unsigned int num_term = priv->termination_const_cnt;
>>   		unsigned int i;
>>   
>> @@ -573,10 +599,11 @@ static size_t can_get_size(const struct net_device *dev)
>>   		size += nla_total_size(sizeof(*priv->xl.data_bitrate_const) *
>>   				       priv->xl.data_bitrate_const_cnt);
>>   	size += can_tdc_get_size(&priv->xl,			/* IFLA_CAN_XL_TDC */
>>   				 can_xl_tdc_is_enabled(priv),
>>   				 priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL);
>> +	size += nla_total_size(sizeof(struct can_pwm));
> 
> This looks wrong. Does this work? The size of a nested NLA is the sum of its NLA
> members. Look at can_tdc_get_size().
> 
>>   	return size;
>>   }
>>   
>>   static int can_tdc_fill_info(struct sk_buff *skb,  const struct net_device *dev,
>> @@ -734,11 +761,13 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
>>   		     priv->xl.data_bitrate_const_cnt,
>>   		     priv->xl.data_bitrate_const)) ||
>>   
>>   	    can_tdc_fill_info(skb, dev, &priv->xl, can_xl_tdc_is_enabled(priv),
>>   			      priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL,
>> -			      IFLA_CAN_XL_TDC)
>> +			      IFLA_CAN_XL_TDC) ||
>> +
>> +	    nla_put(skb, IFLA_CAN_XL_PWM, sizeof(priv->pwm), &priv->pwm)
> 
> Same as above.
> 
>>   	    )
>>   
>>   		return -EMSGSIZE;
>>   
>>   	return 0;
>> diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
>> index 2053b9dff0ad..47e266ab7486 100644
>> --- a/include/linux/can/bittiming.h
>> +++ b/include/linux/can/bittiming.h
>> @@ -114,10 +114,35 @@ struct can_tdc_const {
>>   	u32 tdco_max;
>>   	u32 tdcf_min;
>>   	u32 tdcf_max;
>>   };
>>   
>> +/*
>> + * struct can_pwm - PWM configuration for switchable CAN XL transceivers
>> + *
>> + * -+-- init-offset -+------- one bit in CAN XL data mode --------+- TX pin
>> + *  |<--- Offset --->|
>> + *                   |<-------- Long 1 -------->|<--- Short 0 --->|  level_1
>> + *                   |<--- Short 1 --->|<-------- Long 0 -------->|  level_0
>> + *                                          |
>> + *                                 (50/50 sample point)
>> + *
>> + * The duration of a complete PWM bit representation has to be < 200ns to
>> + * reliably switch the CAN XL transceiver into the CAN XL data mode.
>> + *
>> + * @pwm_offset: Offset before first PWM bit trasmmission to fill the ADH bit
>> + *
>> + * @pwm_phase_long: PWM Phase Long (ideally 75% of PWM bit representation)
>> + *
>> + * @pwm_phase_short: PWM Phase Short (ideally 25% of PWM bit representation)
>> + */
>> +struct can_pwm {
>> +	u8 pwm_offset;
>> +	u8 pwm_phase_long;
>> +	u8 pwm_phase_short;
>> +};
>> +
>>   #ifdef CONFIG_CAN_CALC_BITTIMING
>>   int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
>>   		       const struct can_bittiming_const *btc, struct netlink_ext_ack *extack);
>>   
>>   void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
>> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
>> index 1ac98914f351..6b65b3fccfd2 100644
>> --- a/include/linux/can/dev.h
>> +++ b/include/linux/can/dev.h
>> @@ -60,10 +60,11 @@ struct can_priv {
>>   	struct can_bittiming bittiming;
>>   	struct data_bittiming_params fd, xl;
>>   	unsigned int bitrate_const_cnt;
>>   	const u32 *bitrate_const;
>>   	u32 bitrate_max;
>> +	struct can_pwm pwm;
>>   	struct can_clock clock;
>>   
>>   	unsigned int termination_const_cnt;
>>   	const u16 *termination_const;
>>   	u16 termination;
>> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
>> index 163a6167264e..bd3706b37e04 100644
>> --- a/include/uapi/linux/can/netlink.h
>> +++ b/include/uapi/linux/can/netlink.h
>> @@ -146,16 +146,31 @@ enum {
>>   	IFLA_CAN_CTRLMODE_EXT,
>>   	IFLA_CAN_XL_DATA_BITTIMING,
>>   	IFLA_CAN_XL_DATA_BITTIMING_CONST,
>>   	IFLA_CAN_XL_DATA_BITRATE_CONST,
>>   	IFLA_CAN_XL_TDC,
>> +	IFLA_CAN_XL_PWM,
>>   
>>   	/* add new constants above here */
>>   	__IFLA_CAN_MAX,
>>   	IFLA_CAN_MAX = __IFLA_CAN_MAX - 1
>>   };
>>   
>> +/*
>> + * CAN XL Transceiver data mode switching PWM configuration
>> + */
>> +enum {
>> +	IFLA_CAN_PWM_UNSPEC,
>> +	IFLA_CAN_PWM_OFFSET,	/* u8 */
>> +	IFLA_CAN_PWM_LONG,	/* u8 */
>> +	IFLA_CAN_PWM_SHORT,	/* u8 */
>> +
>> +	/* add new constants above here */
>> +	__IFLA_CAN_PWM,
>> +	IFLA_CAN_PWM_MAX = __IFLA_CAN_PWM - 1
>> +};
>> +
>>   /*
>>    * CAN FD/XL Transmitter Delay Compensation (TDC)
>>    *
>>    * Please refer to struct can_tdc_const and can_tdc in
>>    * include/linux/can/bittiming.h for further details.
> 
> Yours sincerely,
> Vincent Mailhol
> 


