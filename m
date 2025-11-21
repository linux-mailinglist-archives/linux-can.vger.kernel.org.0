Return-Path: <linux-can+bounces-5555-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D00D6C7825E
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9AF932D743
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949A030CDB5;
	Fri, 21 Nov 2025 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="C21ekkl3";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lDJ8PZof"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB733A6E6
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717080; cv=pass; b=GubkkZgERclRYO5jR0AXG4e5oHOKBy+OpL9vDf/Ps11tuwgG9I8DDV2n5pMwYwMcnthzmr6YwUjq4zAtQSln4muctStPnA/OOD26PcXYz6MLem+EYgUug6xUMpoFTFoKWIBhyhlO4BhV+d4duN1jYLkXhh2iN9oDxPaX4B8509E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717080; c=relaxed/simple;
	bh=sOVuNv9orA8yufw3oyxoabdTBm1wNMPThSnZwrhf+ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bB+iBaWzfvgTAAbnS5+oiBCTLPaxgEe0m+FvD4tOScl61KQrR5YKv5995OydpeKJ5YOyGipXoe9D4QPVKHW3DoKbce00k6ykjb3T1aU3efnN6kYv869zQF1H6O6vuRdg3gwJtKEo1b73Ro5tQ06/rts+UuciSTxq5hKbpL+yNJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=C21ekkl3; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lDJ8PZof; arc=pass smtp.client-ip=81.169.146.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763717072; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HkXM8RMoV9QXmD+8cxh1/LV9ji8q7K6Yr47j7/ip8OB9aSdF2OjsRIpIYY1TOAqjYH
    jKIDzeuZbYukvn9W0IgKPTi7RHMvrt1b1Jr7yTZx/1OgYgYkI2A5h+STJc9ZkILxSOML
    Fa2MUzvaeyrfJxrnYJeBXKjoi8rpM/lzIW90tZ+kMTtsvtawnNRkcF/Q6HkCz7prHzKJ
    /O5+QNxpHIQq1f03Fz5allukX51cz3CGwXqxDv1vW1QruWimscKadwewQL4+WNTT1dJO
    Xo2pT071CEc1Gbh+dSmoSaknPvO3Ib2752A1MFl1ksoudT9vKdBh1p5X/kp4UaYelsez
    +M/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763717072;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ePL/Aqir7BysyCCFoqve2EUvcC6DNWJ8fC/DflVwKmY=;
    b=SMUzIeQMIiVU9hBdxLVTadJ6vV0XKygtcZfzMreTtFEWUsWtsH6INRuWFDe6Ksufsd
    w/2i12jg1w1EfTBMPxAzeeNDlHlO2ZwI8SuAlvJy/HRISB9ouEQ+xQDX4aO6vW1rvyj6
    rO3mu/q3PHtfRt5I87vU/7Fiqsv4OSAKDclVcErkIvUqD34DrviFR+gzIq1fVHKv1Wnv
    rsGkfHmRIZ2n9A0zQ/WCJmnsGnQ0rJ3I+kQXZU5R6H6LwHqpkVs3uVuLWSvli5+3tb9d
    IHO0U7q+8t5iheAoEnQhnEvhIO3o2P3w6WCH87I0V2quGMYl/GW1Vgxd5c/v33TWeXek
    PZVw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763717072;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ePL/Aqir7BysyCCFoqve2EUvcC6DNWJ8fC/DflVwKmY=;
    b=C21ekkl324TaZCneVxysoiio3d3YBWzSTQ2xwV+yhw5055DbTAe0sBoLiZL/EjOhyS
    koC+qJt9V5QnS2mM4pUCCE1lv7iUbPsL6dayj4bG8URJRtZaVZ8wMCmR4UbhKk6f2oM/
    H3/EGOalm7n88+g00URLTR43j7JUvPUSMNiPQ8WJNbo6dyTDyrc/Z6cicmqRlLRmwroa
    VBEhdxDA29e3YVFPGMZv1cDddZIAp9c7FgnjdqgWrUAEIA0z1RxuVbu1VBSRrWjNwx3T
    +mrMfyib3DUc+9urE+iEzRdnGysIAYqfO9uxckxs4T3AC2m0ZUwNKTvjqSOqNTCjJJdZ
    r64g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763717072;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ePL/Aqir7BysyCCFoqve2EUvcC6DNWJ8fC/DflVwKmY=;
    b=lDJ8PZofEmL/dPtyM4moMX/TaaBVOtCEfGPMbU39NgWVOn7cBAbyCyB7qYmjaE22xp
    4vj8vKTdxshqylJza6BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL9OWAxC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 10:24:32 +0100 (CET)
Message-ID: <85714b83-2cc0-4ec6-b600-de143713b3b7@hartkopp.net>
Date: Fri, 21 Nov 2025 10:24:32 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v4 10/17] can: netlink: add PWM netlink interface
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
 <20251121083414.3642-11-socketcan@hartkopp.net>
 <20251121-cherubic-pearl-bittern-e54ab2-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251121-cherubic-pearl-bittern-e54ab2-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21.11.25 10:19, Marc Kleine-Budde wrote:
> On 21.11.2025 09:34:07, Oliver Hartkopp wrote:
>> From: Vincent Mailhol <mailhol@kernel.org>
>>
>> When the TMS is switched on, the node uses PWM (Pulse Width
>> Modulation) during the data phase instead of the classic NRZ (Non
>> Return to Zero) encoding.
>>
>> PWM is configured by three parameters:
>>
>>    - PWMS: Pulse Width Modulation Short phase
>>    - PWML: Pulse Width Modulation Long phase
>>    - PWMO: Pulse Width Modulation Offset time
>>
>> For each of these parameters, define three IFLA symbols:
>>
>>    - IFLA_CAN_PWM_PWM*_MIN: the minimum allowed value.
>>    - IFLA_CAN_PWM_PWM*_MAX: the maximum allowed value.
>>    - IFLA_CAN_PWM_PWM*: the runtime value.
>>
>> This results in a total of nine IFLA symbols which are all nested in a
>> parent IFLA_CAN_XL_PWM symbol.
>>
>> IFLA_CAN_PWM_PWM*_MIN and IFLA_CAN_PWM_PWM*_MAX define the range of
>> allowed values and will match the value statically configured by the
>> device in struct can_pwm_const.
>>
>> IFLA_CAN_PWM_PWM* match the runtime values stored in struct can_pwm.
>> Those parameters may only be configured when the tms mode is on. If
>> the PWMS, PWML and PWMO parameters are provided, check that all the
>> needed parameters are present using can_validate_pwm(), then check
>> their value using can_validate_pwm_bittiming(). PWMO defaults to zero
>> if omitted. Otherwise, if CAN_CTRLMODE_XL_TMS is true but none of the
>> PWM parameters are provided, calculate them using can_calc_pwm().
>>
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/dev/netlink.c    | 192 ++++++++++++++++++++++++++++++-
>>   include/uapi/linux/can/netlink.h |  25 ++++
>>   2 files changed, 215 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
>> index 5a628c629109..72b9a094ea83 100644
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
>> @@ -37,10 +38,22 @@ static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
>>   	[IFLA_CAN_TDC_TDCV] = { .type = NLA_U32 },
>>   	[IFLA_CAN_TDC_TDCO] = { .type = NLA_U32 },
>>   	[IFLA_CAN_TDC_TDCF] = { .type = NLA_U32 },
>>   };
>>
>> +static const struct nla_policy can_pwm_policy[IFLA_CAN_PWM_MAX + 1] = {
>> +	[IFLA_CAN_PWM_PWMS_MIN] = { .type = NLA_U32 },
>> +	[IFLA_CAN_PWM_PWMS_MAX] = { .type = NLA_U32 },
>> +	[IFLA_CAN_PWM_PWML_MIN] = { .type = NLA_U32 },
>> +	[IFLA_CAN_PWM_PWML_MAX] = { .type = NLA_U32 },
>> +	[IFLA_CAN_PWM_PWMO_MIN] = { .type = NLA_U32 },
>> +	[IFLA_CAN_PWM_PWMO_MAX] = { .type = NLA_U32 },
>> +	[IFLA_CAN_PWM_PWMS] = { .type = NLA_U32 },
>> +	[IFLA_CAN_PWM_PWML] = { .type = NLA_U32 },
>> +	[IFLA_CAN_PWM_PWMO] = { .type = NLA_U32 },
>> +};
>> +
>>   static int can_validate_bittiming(struct nlattr *data[],
>>   				  struct netlink_ext_ack *extack,
>>   				  int ifla_can_bittiming)
>>   {
>>   	struct can_bittiming *bt;
>> @@ -117,10 +130,44 @@ static int can_validate_tdc(struct nlattr *data_tdc,
>>   	}
>>
>>   	return 0;
>>   }
>>
>> +static int can_validate_pwm(struct nlattr *data[],
>> +			    struct netlink_ext_ack *extack, u32 flags)
>> +{
>> +	struct nlattr *tb_pwm[IFLA_CAN_PWM_MAX + 1];
>> +	int err;
>> +
>> +	if (!data[IFLA_CAN_XL_PWM])
>> +		return 0;
>> +
>> +	if (!(flags & CAN_CTRLMODE_XL_TMS)) {
>> +		NL_SET_ERR_MSG(extack, "PWM requires TMS");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	err = nla_parse_nested(tb_pwm, IFLA_CAN_PWM_MAX, data[IFLA_CAN_XL_PWM],
>> +			       can_pwm_policy, extack);
>> +	if (err)
>> +		return err;
>> +
>> +	if (!tb_pwm[IFLA_CAN_PWM_PWMS] != !tb_pwm[IFLA_CAN_PWM_PWML]) {
>> +		NL_SET_ERR_MSG(extack,
>> +			       "Provide either both PWMS and PWML, or none for automic calculation");
> 
>      ● checkpatch.pl: WARNING: 'automic' may be misspelled - perhaps 'atomic'?
>      ● checkpatch.pl: #188: FILE: drivers/net/can/dev/netlink.c:156:
>      ● checkpatch.pl: +                         "Provide either both PWMS and PWML, or none for automic calculation");
>      ● checkpatch.pl:
> 

automatic will help ;-)

Best regards,
Oliver

