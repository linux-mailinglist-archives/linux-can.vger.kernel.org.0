Return-Path: <linux-can+bounces-5554-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE514C78255
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD71A365ED7
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E251833F8B1;
	Fri, 21 Nov 2025 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DvAJYo68";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="0efkZ7Df"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C19305946
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717023; cv=pass; b=A7jshjZpMhM2Jtd+Kb/pjhFzm/kPULlSPpK9DXGXx91BLtn5TfJMTXChdEO+5pMciSziEp4hs0sbAICx2PcSrB8P7rWUFbZp+uVZuwwMKKDfC2JzHQPgprgSf9G1iHzbayf0Ks8LnIfE1ZUk5e9+/iMNyZ8+3+xVHYNDKz13kmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717023; c=relaxed/simple;
	bh=9XVm6fyee0COMXDlW3LnnY7l1OVZPJPY1NYaM61sMXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S657P6umlcWWfF+ugOoyHJICogkkiH8lb17weS8PZ+Jkfhbf0m2m+KNtVcl2m7r4GafFTJQDMlaoX/XEo/+568AzQiJuiJpQlsu3d6KuRqv0riEXEweCSFOGmqG+g0oA2nvVXtvFaQuBad9yfezMtS8BP14RaEIi8rKirbb49/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DvAJYo68; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=0efkZ7Df; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763717009; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZnSlEVdOeu8dpdVrcTjVEL3umD/gx0PlQQGjXTj+QZzZ+6Oid8oJM22rF3XT3VWAY0
    9BuDfZbB/h07i6cG/dgOHBxKlsiQbjZhdZG+mpIk3DFSNR5/lHv12FSwWOUt2eWV3Qkf
    RRqVmpPTGLsKSjdyubrM5cUuyiu0z6INyz8dewm4PaUyAmxeANzEqa5NYg9B4tt9RL+I
    Cfw5H3WgN01Wri8lzDq6TACxnMtBR65Qp7ga1K8ENie37R2U77X5feqMJrqnwZjrNR5M
    cv4OUjJL1eHgtBkjzuRpyu4mN3S+SYh+hCoWGrf4/KryBS4MSzV9kPlDhb5GYN/BTRIf
    JFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763717009;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ApaZCS0/nN3D9RIzVSvK3o35CFJqS6z0KBWJZd7GELo=;
    b=kARTX1amzxNpBm410h5brPCV0m2NSyTFlVXmsCfuymCR7CC5UvMSl5NVEpkXwEc7Ai
    y0cI2havJLlEowh02gEPTOBLOSV6qRaoxLUXMV/mcOlslTvY7Y06vD2v+uvMoiY91vwX
    jf2g/Qpt7VVgRdQ0RvDdhD3bpEtL+Zud8GIOsE65yjcrTVxJpZjNB2G4DeFbZIwkx2Ib
    Cmb33XajVqL5JuoulLG0l+r6i7TA9SS8Maf6FjoxAiRNo3qpsKMWuRHix14ld9CBe7Qa
    o5DSS+sVka5a6417nToHZswmMBnoDOoTwGESbDbO5kdAJnpBhdxXWD96mEfLZKOk6K2e
    T3Jw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763717009;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ApaZCS0/nN3D9RIzVSvK3o35CFJqS6z0KBWJZd7GELo=;
    b=DvAJYo68wunXxODrktNNlm/eiKhm5w7LuFv1fFwuUhXvMN2fsSchGzJgYcrVw2HNto
    kec7r+KLiUT8RqtJ+NgQJuql1G14Lk8sGR+MmBXJfKheq3ivBjLyIElYtx3ZbJuIKuJN
    y0GngBojp6hDzAqVvY6MHV/RJ5ejKeFyq89WQB83fCbdmTrF0Tf+/d0GbKbGugBJeEBC
    2UIC/AuQeWgcNVKumDYeEXSoHybqMDRlfMLnDY1nGBtBryUb67VaCGmgwqzrzZCNWuJm
    NgNIl47iCJg48jb0mTTJW7y0otoGZLwtJ4ZRuEMjsJaYK+/MDlJqNDsxXmr6gkMWgIpK
    kxlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763717009;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ApaZCS0/nN3D9RIzVSvK3o35CFJqS6z0KBWJZd7GELo=;
    b=0efkZ7Df8eAGF5v+C3Uji4pa6oVvxUCM9xWFY+7qa8Z1ofASKm3PXgJFH49QGUjLtG
    v49BmHc9IuGvVyYyZ0AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL9NTAwk
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 10:23:29 +0100 (CET)
Message-ID: <6f54aa22-725f-4cea-a710-d000ebb40322@hartkopp.net>
Date: Fri, 21 Nov 2025 10:23:29 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v4 08/17] can: bittiming: add PWM validation
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
 <20251121083414.3642-9-socketcan@hartkopp.net>
 <20251121-garnet-ammonite-of-genius-7d6db2-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251121-garnet-ammonite-of-genius-7d6db2-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21.11.25 10:14, Marc Kleine-Budde wrote:
> On 21.11.2025 09:34:05, Oliver Hartkopp wrote:
>> From: Vincent Mailhol <mailhol@kernel.org>
>>
>> Add can_validate_pwm() to validate the values pwms, pwml and pwml.
>> Error messages are added to each of the checks to inform the user on
>> what went wrong. Refer to those error messages to understand the
>> validation logic.
>>
>> The boundary values CAN_PWM_DECODE_NS (the transceiver minimum
>> decoding margin) and CAN_PWM_NS_MAX (the maximum PWM symbol duration)
>> are hardcoded for the moment. Note that a transceiver capable of
>> bitrates higher than 20 Mbps may be able to handle a CAN_PWM_DECODE_NS
>> below 5 ns. If such transceivers become commercially available, this
>> code could be revisited to make this parameter configurable. For now,
>> leave it static.
>>
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/dev/bittiming.c | 63 +++++++++++++++++++++++++++++++++
>>   include/linux/can/bittiming.h   | 22 ++++++++++++
>>   2 files changed, 85 insertions(+)
>>
>> diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
>> index 0b93900b1dfa..730b1b254460 100644
>> --- a/drivers/net/can/dev/bittiming.c
>> +++ b/drivers/net/can/dev/bittiming.c
>> @@ -1,9 +1,10 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
>>    * Copyright (C) 2006 Andrey Volkov, Varma Electronics
>>    * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
>> + * Copyright (c) 2025 Vincent Mailhol <mailhol@kernel.org>
>>    */
>>
>>   #include <linux/can/dev.h>
>>
>>   void can_sjw_set_default(struct can_bittiming *bt)
>> @@ -149,5 +150,67 @@ int can_get_bittiming(const struct net_device *dev, struct can_bittiming *bt,
>>   		return can_validate_bitrate(dev, bt, bitrate_const,
>>   					    bitrate_const_cnt, extack);
>>
>>   	return -EINVAL;
>>   }
>> +
>> +int can_validate_pwm_bittiming(const struct net_device *dev,
>> +			       const struct can_pwm *pwm,
>> +			       struct netlink_ext_ack *extack)
>> +{
>> +	const struct can_priv *priv = netdev_priv(dev);
>> +	u32 xl_bit_time_tqmin = can_bit_time_tqmin(&priv->xl.data_bittiming);
>> +	u32 nom_bit_time_tqmin = can_bit_time_tqmin(&priv->bittiming);
>> +	u32 pwms_ns = can_tqmin_to_ns(pwm->pwms, priv->clock.freq);
>> +	u32 pwml_ns = can_tqmin_to_ns(pwm->pwml, priv->clock.freq);
>> +
>> +	if (pwms_ns + pwml_ns > CAN_PWM_NS_MAX) {
>> +		NL_SET_ERR_MSG_FMT(extack,
>> +				   "The PWM symbol duration: %u ns may no exceed %u ns",
>                                                                         not

Will fix it for v5.

Best regards,
Oliver

