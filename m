Return-Path: <linux-can+bounces-5459-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9DFC63040
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 10:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB9A934AB09
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965F2320CC2;
	Mon, 17 Nov 2025 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Pdspk5eu";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JqmczHvh"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A532142A
	for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763369961; cv=pass; b=c0GqN9SOTrtG635UDBJFnnLLXi4MjHmAcXO8AaoayLOeMZJ9WxlzLWLrIZnzmbeUdmfaIzNNAYrBOu+G/Yt74d5PRMwLFS3/IZstAcb4ZyGiV6DPKsXI47sToaecSEUvJEOw57NkOEqJs1pGOToR+hRtTS4U1QCKAAm3IiY+xsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763369961; c=relaxed/simple;
	bh=fXW+vclstD1l7UP9iYGdnMg/pdtMj1W006kFJofwjB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cn5pCeKu8wVU4X2bfIbkwSL3OWKVQasNF0ynNEcEO/QR/EbL0ojDasZBJ5+H1+PdrDU9oaEi4j5cXbTz7WNq4tF7xGZgMp0KOyvqYL9cIs/SxD7ld4PP4C58/GUDkNa0xbmPFMIM9FZ+ucBsxnPmL7lFtfW7hUljsrAQAZxjWRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Pdspk5eu; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JqmczHvh; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763369951; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Uyrlp37Op+SNbo7YOKooYwAO1sJn0XbMTUQnn9/HVUg4T9XbyG3KZRY8De/V1lJFHp
    yVYXgkNDDBwNo+TmkRCwns3y4PVa0fiuR33bJ2U/A/cs69Gq3BI8Ysq1/O8CJhAArAWZ
    zSktyMFMOodxvmIQIWO+D3GpthiWb4gKfK+BGQk8cDM9aBrCr4nl+6xlDEiQSE+EMKEN
    kip9nsZOJ76iGzwe1XGZ4YLJy+9ghJVHD0lVXrG7UFNFiOU5MBboJ/fHrM4TEeBbkOHn
    ohf64lSolD5vuEFyPRsOXiblfHpuFKh8qg+XylJ1i7z0GqcO+vilUpRYSwtH5fuWApaq
    qkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763369951;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=HDa+kzPPIZA60W33RwLy7T1y4EuPU+xE8yHENIi41Q4=;
    b=egvHnEdBLvDwCHLRkUWtKDIPnNPO7Uib81fRQaY9Pg3ua3AHKjGVGF+TUdKSD24X18
    XxMUPemwyyFE/BvMxf6wCI8tSJzdCp3ZZm0jI4ipV3JcF4Plyk0Ifb2CEvihXtcp+U6E
    KXlycOmH9NHKZnym9+Ic+tKRKHBysQVVTOhixbY3hS2GF+5aUmpOK89cJwRvbZ5wBgp0
    f2zLL/iU8rmHrTIQs9JakPFfRJznIunz1jHg10ICcy7h+dsNeWt+wXOOil7xyeC0YaG6
    sRJEm8cwLqIQ5UOIEJTsVS5pU27H4dBHJH53VBNS0QrMfQu+Liq5QWXt7yI3ZCdW55Rq
    5bWg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763369951;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=HDa+kzPPIZA60W33RwLy7T1y4EuPU+xE8yHENIi41Q4=;
    b=Pdspk5eu6jY2H0si2ZBVwROIW7DNoJ/vEC9o+yxWAI9OlzTnbIj5Au2k0atu+SfJSd
    uAunsIVb0Ov7dVPVMOLkTHFGcYMljmbzNwPDTalkIiqoGOClptq4a3QO/kKqx4SvyAFZ
    Htv2gklH8eUT8EqobwyddQzv7lPri3H7gk19LV+TQbVZsRxvKqZdQeFDYTH+sshdXf29
    biKUxNECiuKw9u6pqoN9m+be6GlQ90vzDjEQY6XIHqgSz+R04kCi0lZF5V5p+/Bh2g9F
    qlrhotQC5LttM7oMjqGudr22qgUfAt6INGE0bjUp5x1pSK5vPuMJVRaXj1L216OW0Udw
    //rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763369951;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=HDa+kzPPIZA60W33RwLy7T1y4EuPU+xE8yHENIi41Q4=;
    b=JqmczHvhJkGhhBCA+lx84N4Kx01qIsri/llfDmcqvI+lmseBWiGae7pSaNYQU4hDhu
    1Ym2PgcCtJ380WFZS6BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AH8xBjhC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Nov 2025 09:59:11 +0100 (CET)
Message-ID: <78c98b06-366a-4d4b-b943-1dbac9c72525@hartkopp.net>
Date: Mon, 17 Nov 2025 09:59:10 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v2 13/15] can: calc_bittiming: add
 can_calc_sample_point_pwm()
To: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
References: <20251115163740.7875-1-socketcan@hartkopp.net>
 <20251115163740.7875-14-socketcan@hartkopp.net>
 <69fb9682-82ab-4a3b-a79e-74fa24da23be@hartkopp.net>
 <a6a2ecfa-3caa-4a4d-90e6-16e031e68f73@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <a6a2ecfa-3caa-4a4d-90e6-16e031e68f73@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 16.11.25 23:18, Vincent Mailhol wrote:

>>
>> In the case of xbitrate 12300000 the feedback is
>> Warning: bitrate error: 0.0%.
>>
>> The calculated bitrate is:
>> xbitrate 12307692 xsample-point 0.538
>>
>> 12307692/12300000 = 1.00062536585
>>
>> So it is 0.06%
>>
>> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 13300000 xl
>> on tms on
>> Warning: bitrate error: 0.2%.
> 
> Random unrelated comment: I figured out that if you have both a
> NL_SET_ERR_MSG_FMT() Warning and a NL_SET_ERR_MSG() Error message (note the _FMT
> suffix only on the warning side), the warning may take precedence over the
> Error. Because netlink can only carry one message, it would be better to only
> report the error when both error and warning occurs. Note that this is not an
> issue in our tree. I wanted to look at it in more details once the CAN XL is
> merged (although I do not expect the fix to be complex).
> 
>> The calculated bitrate is:
>> xbitrate 13333333 xsample-point 0.583
>>
>> 13333333/13300000 = 1.0025062406
>>
>> So it is 0.25%
>>
>> Would it make sense to add another digit and probably additionally some round-up
>> to omit a 0.0% warning?
> 
> I drafted this:
> 
> ------------8<------------
> can: calc_bittiming: add one decimal place in bitrate error messages
> ---
>   drivers/net/can/dev/calc_bittiming.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/dev/calc_bittiming.c
> b/drivers/net/can/dev/calc_bittiming.c
> index 9c8154859513..45d1dc286197 100644
> --- a/drivers/net/can/dev/calc_bittiming.c
> +++ b/drivers/net/can/dev/calc_bittiming.c
> @@ -152,19 +152,19 @@ int can_calc_bittiming(const struct net_device *dev,
> struct can_bittiming *bt,
>   	}
> 
>   	if (best_bitrate_error) {
> -		/* Error in one-tenth of a percent */
> -		v64 = (u64)best_bitrate_error * 1000;
> +		/* Error in one-hundredth of a percent */
> +		v64 = (u64)best_bitrate_error * 10000;
>   		do_div(v64, bt->bitrate);
>   		bitrate_error = (u32)v64;
>   		if (bitrate_error > CAN_CALC_MAX_ERROR) {
>   			NL_SET_ERR_MSG_FMT(extack,
>   					   "bitrate error: %u.%u%% too high",
> -					   bitrate_error / 10, bitrate_error % 10);
> +					   bitrate_error / 100, bitrate_error % 100);
>   			return -EINVAL;
>   		}
>   		NL_SET_ERR_MSG_FMT(extack,
>   				   "bitrate error: %u.%u%%",
> -				   bitrate_error / 10, bitrate_error % 10);
> +				   bitrate_error / 100, bitrate_error % 100);
>   	}
> 
>   	/* real sample point */
> ------------8<------------
> 
> No time to test at the moment (maybe I will be able to test in a couple days),
> but does it look good to you?

Yes. I will test it.

I was thinking of this for a round-up so that we never get a 0.00%:

NL_SET_ERR_MSG_FMT(extack,
	"bitrate error: %u.%02u%%", // always 2 digits
	bitrate_error / 100,
	((bitrate_error / 100) || (bitrate_error % 100))?(bitrate_error % 100):1);

Best regards,
Oliver

> 
> Also, this isn't the only place in which we are getting out of significant
> digit. This was already a couple months ago, but when I started calculating the
> PWM symbols, I figured out that on very high bitrates, can_bittiming->tq will
> lack some significant digits because of the decimal truncation. Using this in
> CAN XL can become problematic. That's another TODO…
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 


