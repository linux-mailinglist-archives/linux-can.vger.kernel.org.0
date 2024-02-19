Return-Path: <linux-can+bounces-306-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891D585ACEA
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 21:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193661F23ED0
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496BF535B9;
	Mon, 19 Feb 2024 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="SqjkG1t9";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="p64tVpe9"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DF53818;
	Mon, 19 Feb 2024 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373742; cv=pass; b=aj411x3BcjBZh9HzG+jO1wv6WnSAnqpW9ys8Aqz8yVcon21+eAbZWo5AfxYJtEG+XGVUFUZLmVjLNAwkrioF53cks6rdKEkKop7JcPLA5nM8KAZN1Q4A+Ixdk5kCZrowmqLLsx//erXjfEao2gpDwjrvtitULtKPtDLuJ/e/T1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373742; c=relaxed/simple;
	bh=aHzupC5gYOA/lyzN5j2yFyKr70HX34y1FyZ90RCgONI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFn6lajvwV5Be7LLQ31KAhNA7tzb6Qh7lNQlMfYcL3xPcdG9a0KVWy66DK2+5+pbk8WsTOd/3wXFCfMMTOTUWsEvnQx2bfTATzCVz7j9msoBw4Cmu4hda5KADn0NhC+6VRagJsKynPWN2H7cHVnIs8679zaPlaPbmrdcjhI4+9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=SqjkG1t9; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=p64tVpe9; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1708373727; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RpoR/vKnYmxDsLpntIjaWpXv9D5I68cPRMJkLXo62im717EZS+FW9bZqBsveUz8cYq
    CSFrqLrvF57SH7DpzVzmPXtg66sbxD7kSGuIhhDlcN5wlJalveP/ecWEILn1Z/dNfNrP
    ma84C1jzPqLgcWHzKonVjRkOv6cTyj8/P7iAfMKRO5KU8zFc07dk9LePBdAPyD7ZQ+ID
    udD/ddMc+cKWVz98tTEhEYjG6WlORIZV1iviDOhQjw3lZvA28WT81TQsc2dKLvN6vtdU
    rjQdtBFPIkgcYTYcLsgv+w6U7kYscMPq/mESKyQ6cXMeRNhHZOXatNT8xDvzpf/WDB61
    Rinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708373727;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CEZCINTGBTCcsox1nU55T0ngzd4ltlNj1PSCmMr9nDs=;
    b=CFbO+ef4ZSxm2tq/nGObs7y7ndltYTe6tboiC+QfHh/8g1tXHNXr1pPRY/zuIkbhmn
    LT9AvVZiLZ4SFL6CGe48duVeSxT8jLmDYlWJCF17wG8A2WqtAyYkFGOYx23qFZDWCM5W
    K45sAWj5FUx7DIKRLeP3/KwQZY3MDvT1I7YdtLw8Xn4Xh/QF19Eg5uuT/ZC7gf3F9/pa
    5K30QsEIdyGNDR6j34yd6oxfMxgqPQcKU/ZfTwyMusf59gzqxM9AevELEhYRR+pg+kB+
    MIxzXWEqgjYUqLqp9lEZxPFefwMJAUpV6imM24guTJ1KJ2067pa383gVcbbnrM+tNitr
    NJBw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708373727;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CEZCINTGBTCcsox1nU55T0ngzd4ltlNj1PSCmMr9nDs=;
    b=SqjkG1t93/aoRU43WWTNS23p4r4Kv8rhUi+n67Bo409uq3dovPLpo2HaM9WyKEJHkW
    pN+ialvIFa1lBAaYrpw4IvxXsdEVwBv4+DIHDorKkRdrvZxmr23fIkRmH5xZ0Sp18r6r
    1l5MDFYbpZluDpWfuqYfypet6w+OW4VEhTxM0XCEK2AlJvWLINwbw/JSZKTyedCY0m64
    TN13inEEbt3Wc7UzwYjwRQCngL5WR5x7Y4e8/gTJjBN1wsIP83idRUj+zdxrzalcx5m+
    xD9g6xCEMQCBm2azQ+DEW3t2n8tS/W0jWlMPVGI1SF1hfoPm+MmBUTHQ3TGcDCzT4QeF
    0o9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708373727;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CEZCINTGBTCcsox1nU55T0ngzd4ltlNj1PSCmMr9nDs=;
    b=p64tVpe9axLZrPcLgtGqSGLgVPRKuXZ71mT9B+L9nxH/+q6XbeG+ylpf8/s8WBFxKE
    dJ4kXAEp5illLlOtZODg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDdAnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::90c]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01JKFR85s
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Feb 2024 21:15:27 +0100 (CET)
Message-ID: <2828dbd5-9bea-4b2e-9a4f-ebd0582c8f73@hartkopp.net>
Date: Mon, 19 Feb 2024 21:15:19 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 22/23] can: canxl: add virtual CAN network
 identifier support
To: Marc Kleine-Budde <mkl@pengutronix.de>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
 <20240213113437.1884372-23-mkl@pengutronix.de>
 <20240219083910.GR40273@kernel.org>
 <20240219-activist-smartly-87263f328a0c-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20240219-activist-smartly-87263f328a0c-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-02-19 10:41, Marc Kleine-Budde wrote:
> On 19.02.2024 08:39:10, Simon Horman wrote:
>> +Dan Carpenter

(..)

>> But I noticed the problem described below which
>> seems worth bringing to your attention.
> 
> Thanks Simon.
> 
>>
>> ...
>>
>>> @@ -786,6 +822,21 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>>>   		val = &ro->xl_frames;
>>>   		break;
>>>   
>>> +	case CAN_RAW_XL_VCID_OPTS:
>>> +		/* user space buffer to small for VCID opts? */
>>> +		if (len < sizeof(ro->raw_vcid_opts)) {
>>> +			/* return -ERANGE and needed space in optlen */
>>> +			err = -ERANGE;
>>> +			if (put_user(sizeof(ro->raw_vcid_opts), optlen))
>>> +				err = -EFAULT;
>>> +		} else {
>>> +			if (len > sizeof(ro->raw_vcid_opts))
>>> +				len = sizeof(ro->raw_vcid_opts);
>>> +			if (copy_to_user(optval, &ro->raw_vcid_opts, len))
>>> +				err = -EFAULT;
>>> +		}
>>> +		break;
>>> +
>>>   	case CAN_RAW_JOIN_FILTERS:
>>>   		if (len > sizeof(int))
>>>   			len = sizeof(int);
>>
>> At the end of the switch statement the following code is present:
>>
>>
>> 	if (put_user(len, optlen))
>> 		return -EFAULT;
>> 	if (copy_to_user(optval, val, len))
>> 		return -EFAULT;
>> 	return 0;
>>
>> And the call to copy_to_user() depends on val being set.
>>
>> It appears that for all other cases handled by the switch statement,
>> either val is set or the function returns. But neither is the
>> case for CAN_RAW_XL_VCID_OPTS which seems to mean that val may be used
>> uninitialised.
>>
>> Flagged by Smatch.
> 
> And "err" is not evaluated, too.
> 
> Oliver, please send a fix and squash in this chance to reduce the scope
> of "err" to the cases where it's actually used.

Hello Marc,

the problem was an incomplete code adoption from another getsockopt() 
function CAN_RAW_FILTER. No need to reduce the scope of err here as we 
only have one sockopt function at a time.

@Simon: Many thanks for catching this issue!!

Patch: 
https://lore.kernel.org/linux-can/20240219200021.12113-1-socketcan@hartkopp.net/

Best regards,
Oliver


> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index cb8e6f788af8..d4e27877c143 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -756,7 +756,6 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>           struct raw_sock *ro = raw_sk(sk);
>           int len;
>           void *val;
> -        int err = 0;
>   
>           if (level != SOL_CAN_RAW)
>                   return -EINVAL;
> @@ -766,7 +765,9 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>                   return -EINVAL;
>   
>           switch (optname) {
> -        case CAN_RAW_FILTER:
> +        case CAN_RAW_FILTER: {
> +                int err = 0;
> +
>                   lock_sock(sk);
>                   if (ro->count > 0) {
>                           int fsize = ro->count * sizeof(struct can_filter);
> @@ -791,7 +792,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>                   if (!err)
>                           err = put_user(len, optlen);
>                   return err;
> -
> +        }
>           case CAN_RAW_ERR_FILTER:
>                   if (len > sizeof(can_err_mask_t))
>                           len = sizeof(can_err_mask_t);
> @@ -822,7 +823,9 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>                   val = &ro->xl_frames;
>                   break;
>   
> -        case CAN_RAW_XL_VCID_OPTS:
> +        case CAN_RAW_XL_VCID_OPTS: {
> +                int err = 0;
> +
>                   /* user space buffer to small for VCID opts? */
>                   if (len < sizeof(ro->raw_vcid_opts)) {
>                           /* return -ERANGE and needed space in optlen */
> @@ -836,7 +839,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>                                   err = -EFAULT;
>                   }
>                   break;
> -
> +        }
>           case CAN_RAW_JOIN_FILTERS:
>                   if (len > sizeof(int))
>                           len = sizeof(int);
> 
> regards,
> Marc
> 

