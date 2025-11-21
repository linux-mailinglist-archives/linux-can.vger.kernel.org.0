Return-Path: <linux-can+bounces-5552-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F28C7824F
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E55B73626D6
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FBD23E325;
	Fri, 21 Nov 2025 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="q8lO1+P9";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="MKKJNAz4"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A02824A3
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716948; cv=pass; b=Wm1Ai6m36Xi1egZzfvX1HxJ4PLgibsRKcKm2VBfguUQF486A2zs2TRk+DXBFmopbWml0LTZezBC/m17Bc2Ss9pipmhZ0+azQEURsSI+cf6k2J+4pM8mImM2kWlz+W/M3/GYqFP13C4k9xyQQNATC8QnsrZFpEXs/lQWR9ddt2fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716948; c=relaxed/simple;
	bh=WQlpKuKUkxo4tsYj0z89XB9ktqSP+SGw0ZDg1bQ4F3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSZ44m5n8Xf1a1uPL1hw64TsQsou79lAEX/z4pED8qpYM8KeKE0ssQYqfAIVBwPrhZFphTTPT/rMUsHjAyXmI/1SvWAzrSn0IxkyI3k3Is7rhfpC/EqbuzkCbAKdXUXyLVhYt5TWdU8THGyIKtTfXSp8qmN63vN39aIHJMiSQcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=q8lO1+P9; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=MKKJNAz4; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763716939; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dwmpv1edlyx1M1b/nU/6+BDx1jz2+C5ERMv0uGXLesZJYJpMK6pHff2jjVkmYjBsVS
    QWQRNL/Vh0OWY/YgYlnEmeHuBgPkreFrD3wLz2/WPTLC1o9I3dObzH9hedojx78pOhZR
    75/y6Sq7cFef56wd6+Po4kB1IoTn49EabZwsp2BGDYMSkpBLbDkeQVICI2UjPzSwEMQu
    5DICuBaSCA9eA7N7JyxUfd4VYUpRbQvDdc3P1H3bnnZfgWBm16f2z6ebZIxh+74CIPit
    ERe/Ctwi4hDznHM+D1VsGGzxWxOe+MzAAxXmgKiURP12Td6bTJlA4j9MlSdPV+/vdKkG
    r6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763716939;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UFUbUTIisF231Y8WLfHyPmF2I5FN96rzzYB3wcurjzc=;
    b=pBsEm8tRq6h1yXL7zfmSwQ6MOU8UyK9i5IGIEmqL6SEm+TiKQLF3RlWGtUedru88UV
    Fcmfn6ojTdZRJM9VKWuhVC6VacMgOwyM8p40fLXTONEpzP83WM5lv4n+/eOLLr/eWATP
    LHDpPF8/ZOTSxK07IToTlv9VUoSuZfPlmuvFS8lViFE/z/noXmbCFIiwODJAZ/+NeO9u
    eDgQwvzDyNEkrMxb1ZocKaYZp1hT+gDw2Lr3mb4AnhJTmFd6rQR/pUIDFuX8e7/I9YGm
    j3J6QBMzniz8wuAHlLJ9CEIgfATJnAedeNdsJVue/DRXy4mj3t7q9ZG8KuRuIUTU6Hay
    cvCA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763716939;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UFUbUTIisF231Y8WLfHyPmF2I5FN96rzzYB3wcurjzc=;
    b=q8lO1+P9y2s4oyI0wbqFnuy2mLUmZbws7bVrmS00HFUAMq/EGZGPhtsXGFjCL+THXO
    7uwjzEnvzP/SQ3vKBXAIFlWnDWJl6Vfouw5rpO9OCyPZwJ007WE2XFV7drsRSUcKd54C
    R9C07B3R2QkyFnT/AeyVa8VPW0NckXEQBxFnICYy/c1QQfhxmcDzhaQe59IdwOCY2TcE
    Hm3LBkd/ww8AZf6gIIAMVlsA0AGMkJOUMn/YqfzVT/iUGtFNAaF6gZJvs198OGmRQA2R
    imG3WLLFco9vMtljJ5J6wjzlYpZ10AxfBN3qYe64VCF/660bc7ksouT7kOO2Hqg223NV
    z64w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763716939;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UFUbUTIisF231Y8WLfHyPmF2I5FN96rzzYB3wcurjzc=;
    b=MKKJNAz4MAQaWXtVCtBfXk+1E6kNBkD6xZRyGmdGVjWCrejxZxZpyhlb8FU7eXZ9OX
    upmXKEXfVHr23fbN0TAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL9MJAw9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 10:22:19 +0100 (CET)
Message-ID: <5aaf105b-f3be-4b98-a251-c5632448ec8f@hartkopp.net>
Date: Fri, 21 Nov 2025 10:22:19 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v4 17/17] can: dev: print bitrate error with two decimal
 digits
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
 <20251121083414.3642-18-socketcan@hartkopp.net>
 <20251121-khaki-termite-of-glee-053933-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251121-khaki-termite-of-glee-053933-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21.11.25 10:13, Marc Kleine-Budde wrote:
> On 21.11.2025 09:34:14, Oliver Hartkopp wrote:
>> Increase the resolution when printing the bitrate error and round-up the
>> value to 0.01% in the case the resolution would still provide values
>> which would lead to 0.00%.
>>
>> Suggested-by: Vincent Mailhol <mailhol@kernel.org>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/dev/calc_bittiming.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
>> index 0b11c4e98172..103128773a7d 100644
>> --- a/drivers/net/can/dev/calc_bittiming.c
>> +++ b/drivers/net/can/dev/calc_bittiming.c
>> @@ -150,23 +150,26 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
>>   		if (bitrate_error == 0 && sample_point_error == 0)
>>   			break;
>>   	}
>>
>>   	if (best_bitrate_error) {
>> -		/* Error in one-tenth of a percent */
>> -		v64 = (u64)best_bitrate_error * 1000;
>> +		/* Error in one-hundredth of a percent */
>> +		v64 = (u64)best_bitrate_error * 10000;
>>   		do_div(v64, bt->bitrate);
>>   		bitrate_error = (u32)v64;
>>   		if (bitrate_error > CAN_CALC_MAX_ERROR) {
>>   			NL_SET_ERR_MSG_FMT(extack,
>> -					   "bitrate error: %u.%u%% too high",
>> -					   bitrate_error / 10, bitrate_error % 10);
>> +					   "bitrate error: %u.%02u%% too high",
>> +					   bitrate_error / 100,
>> +					   bitrate_error % 100);
>>   			return -EINVAL;
>>   		}
> 
> We already know we have a bitrate error, so we can set it to at least 1:
> 
>          bitrate_error = max(bitrate_error, 1U);
> 
> Please add a comment describe the reasoning.

Excellent idea!

Will do.

Best regards,
Oliver

> 
>>   		NL_SET_ERR_MSG_FMT(extack,
>> -				   "bitrate error: %u.%u%%",
>> -				   bitrate_error / 10, bitrate_error % 10);
>> +				   "bitrate error: %u.%02u%%",
>> +				   bitrate_error / 100,
>> +				   ((bitrate_error / 100) || (bitrate_error % 100))?
>> +				   (bitrate_error % 100):1);
> 
> So we can avoid this.
> 
> Marc
> 


