Return-Path: <linux-can+bounces-5588-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA09C7BB48
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 22:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27353A7232
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 21:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC8B225762;
	Fri, 21 Nov 2025 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="POLL7nVH";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bBOwFbb3"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713F270557
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763758897; cv=pass; b=XauQ+WPPyl50nYTpufI7GDerQ/P/zCVCPAXhymvkgWV/OdjR6ITqVnF2+QErlmT9RUd4eSmjGQrwCS/gmaZypn6T3z+MdS3pAl87ZxRHBTmzigjzWF3AFvuL9hZVHmdURG9+nDJn1IBKtLDRFrrkcDQ3zmHnXFVWHEaSbdk2F2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763758897; c=relaxed/simple;
	bh=/sM1zca2AuP8vHG96Y/+p0QYx6Icz1BRnB26WecfLRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b20S2+tA4Viagv3gvsVetN7OdDnjz8XncOCT8kmMRUsqysqgU4tL6bmoecrPkmmQ3XZ0S74aSQiVUQGBkb8wLjL09Z2Bdg7WvbPTRIAxjJ6Ouqj+lA/eowz5+YV/QMwHrjJDt1RDdljLuSZVKz1D+WDVtnStPfJYKhHtR305KiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=POLL7nVH; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bBOwFbb3; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763758876; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QCNl5x1hRZ6QIqubInL4Lf5pHIXPUUtQBXAh+cSEy1T05X4ACPsNTl1dkbjfkDiXHd
    DRH4Q4QhNh0d6cHlR7A/XGzJT42pk6U8F7G5K2e4zNzRySkICUIOk/GEoQArbJwUUr89
    qYsrc596lKUS3H6kwdNp8CFp7eQ8EOUM5//Uduir2Qj96/MJhc2Do73OXEYCdKpT46Mf
    ICCm3FYUUf8ERTQzlpcDd2Av/e8RWh8ZI9OUzk2xHWK/x9g9UcXSiiPXirHcf0TSbEm1
    xfwLrAmBbGNMAUjSmWehdee7H8nfykh7THqET4Qv/1e57V0PN21sbrDay9tTFBlUKAZQ
    r6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763758876;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RAqeWupCh5xEBaZHkrejleLProm7Jf3JHGP5TYO+4A8=;
    b=PBuKXbi0Io+DTBwKekB072ACC+JHC0eQ2b6LSIZtPZFappH/XgKLhqiszFHA3JqCiS
    WngKUIX4XOPsfO6KZF3eLG+KptVDoOAkk3XxecYfLyLq52x1BluKmnzn9BOGlpl1tvK8
    pd7A4H8zs9s/3CEvwt7j1G5Mdfb5Q/AYyuSQHKixzMtJZOSCaIIJe1P3RXR/DSbAD6Ic
    8DtumLtQ7f61aHWCUWajjdcSwG1ZBqpT+VTtWu9HHHIiWVK3jIeCeSgw1/l3W4/AeUl1
    1cY4BX66mg7ZAG+bs12ocZ5xpQfW+fJZLNoP+mPwbOx44RKLuRpzhJG1lpAsK6p1a7eK
    6gzQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763758876;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RAqeWupCh5xEBaZHkrejleLProm7Jf3JHGP5TYO+4A8=;
    b=POLL7nVHYxYNqJnX+VSbRY0UxxG2w0aRm5ZRZObZgBxNuAqrWPC9VXHlq00n0Kxt/6
    LfUv2KIaxBz7uFtEF/RVwBE5VGItniTF25zFE7VZFxN/e/sUdDVYCl4kJHeOHHd190SA
    b6cMliVrCq0CHqU26mmP5hDVIsRJunqMeawDsgwSYOXk+Belemu9sQNlNA821wji0rlS
    aNFSV+IlkL7gb0a/u6JhLZ3m8SRuz8Nb5IDyBSbZxbYHz4muinxEaUP9xWVtsCgx+TIS
    jf3xjn4tXdf1LC9SWnvZ3z0siFENYtYgLMZnMumYowkBfWw/F233SVHRHxadnsmdfGF0
    x17A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763758876;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RAqeWupCh5xEBaZHkrejleLProm7Jf3JHGP5TYO+4A8=;
    b=bBOwFbb3v5ixS1G1f9lX243blZihszjSWAAYktOUxH5v8QGh8L/zH36LcIsx8KfmX9
    CtRBWgShD0an45meA7CQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALL1GEsP
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 22:01:16 +0100 (CET)
Message-ID: <6320e689-a9ce-4b65-afcd-ac4ec66b29bf@hartkopp.net>
Date: Fri, 21 Nov 2025 22:01:10 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v5 17/17] can: dev: print bitrate error with two decimal
 digits
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
References: <20251121193513.2097-1-socketcan@hartkopp.net>
 <20251121193513.2097-18-socketcan@hartkopp.net>
 <20251121-judicious-dalmatian-from-hyperborea-085fe4-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251121-judicious-dalmatian-from-hyperborea-085fe4-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21.11.25 20:57, Marc Kleine-Budde wrote:
> On 21.11.2025 20:35:13, Oliver Hartkopp wrote:
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
>> index 0b11c4e98172..71c5ba338f8f 100644
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
> 
>> +		/* print at least 0.01% when the error is smaller */
>                                          ^^^^
>                                          if

I changed it locally for v6.

I will wait for other feedback until ~11:00 tomorrow.

Best regards,
Oliver


>> +		bitrate_error = max(bitrate_error, 1U);
> 
> regards
> Marc
> 


