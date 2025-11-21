Return-Path: <linux-can+bounces-5553-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE9EC78252
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34D7E3633CC
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76D2332EBB;
	Fri, 21 Nov 2025 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QQz6QqBU";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+aTQuyI6"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50133F8C9
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716986; cv=pass; b=YVg+N+wmBuOWxDiFeg17Nacu6LV469megHS5whkuVP4obdLKGWAGqUzceK3FTu57Pq5DeP3Yg3t+U6ChKolZI3e9NZdenho0HgO+K2GvApS6ixHC2yVEARyByd+grj20amMWntSbaQwijWGOZLGEGZtTQ2xtGvkvB9QunKDYKh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716986; c=relaxed/simple;
	bh=qB5KHt+OI/yRa95U/E8HScVP/9Cm3AISZyWxo7CgQUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ww9l1I3k97l82kKBLkot1J4YMCEX465nq/WYEgjMEx98VKv+cQBOMrfJHJQTeRcEGUfktpp+wGjkvOPd1c4PDTw+oR3rbp46RstUVCOP+Ccl+CEUZQvXMOIZ3Mf3PHUMlLGxlQpFdtvzAcXSIYAEHuO3iChEWpLVTtUqbKuhAuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QQz6QqBU; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+aTQuyI6; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763716785; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QoYO2XT7Ass/YYOEUb/ERAJAT214EAQ/aNjw9sZ9V5dYKcj5JiVdP+Ou+uisBRAFu1
    1U1v+Is9jEFLjfGxqmzAW0VLnw27H0qWzfQ/wdYX7qTZq5F+R0UBKWncZL0wQ7JLHQ2o
    fxTrYQkJsZwsAcl4dz2r2DiDJKTaGCsv5fwgIWiAwl+3Xjhvn+GGx9/q6e/s59mdcvVg
    mcMycT+DcgprYl7PtQkC4VMsLJBfvd6cnHHQoUaiGywAJ04k0iNbn7mA9NNZTQ6FaP0s
    Y8my+lSKo443rZQt2yQ9uP4N7jl53uYcdIkNpXqPFqJTWLiXa11VPEGa7UaeVI7+sDQu
    l0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763716785;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ygQ/aleTv9uUFHfKKa/8z46x2MkZ9jH7oofzIMzRZ2w=;
    b=GoRvleDY+HYWG4ybJA6YiwgFmBlGDV/BC0K1lHg4Oxbm2+LhEutfabWkPT9ADJXJit
    IKj3itu0ZMobgpBESJoo/Og//hSRWzfLs3uNFRiSxGUnwQImfFdqdUC10NDTY/3/+I7q
    oXzGN8pTBRVFiYFvbckafXcnH9z3TWu6Z7vPKRuk4VYu13eL6JcjLP8J7glpnFgTrCR1
    Y/EkQP7Fl40xbU+fcgkm/n7JvXaFdDOKLZzMNFLvlz2baDKADxLNMLkxIOHCBSs5YdYT
    7kug1QH+btCcNAunslrlvpKSkRE/gwKRUw8tzpwVyAMfYjeOJsnKEUfzYUWflkSFIxHC
    l+qA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763716785;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ygQ/aleTv9uUFHfKKa/8z46x2MkZ9jH7oofzIMzRZ2w=;
    b=QQz6QqBUISYROgYXavhAf1zQX01/JnIM9Mq79ZkJlt5o7P31s+Yv7atMSOFNahDDsk
    iTxdmPzCe+Qm/cLXsOvWgQvY/ZocYDhwtjvLg548N1K+G0FFvnRTJUcAAa6eZGxY7+xo
    1zLjXgPf4yh/IK0Fn0yQe4FSuMM4N+1Dp9j+O5KA6YeuCxYLybESJa9TBIgAhb6AUrVX
    578JPGaguxFJiEcIrSHQIz1RbwkENNbOiZm6NrmjG7V+rA0IiW+ZJkNQl31rkZ4iCjBh
    bcDW5xaa1IqWwDhmbkBpuuhIR5kOeiEW8MWFVQkLDD3S0VOnn8z17B/b8MVCd83RQbov
    dUzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763716785;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ygQ/aleTv9uUFHfKKa/8z46x2MkZ9jH7oofzIMzRZ2w=;
    b=+aTQuyI62FKm99gxRI98idAI9+ETfs9d+QS8qsqysQxk3+YLulILXvmgg3rvO/sOzq
    2a2phH6SYG33W4KBpmAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL9JjAvN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 10:19:45 +0100 (CET)
Message-ID: <c16bbec8-f4ad-4eb6-9e0f-362c3e6261df@hartkopp.net>
Date: Fri, 21 Nov 2025 10:19:39 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v4 16/17] can: dev: can_get_ctrlmode_str: use capitalized
 ctrlmode strings
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
 Stephane Grosjean <stephane.grosjean@hms-networks.com>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
 <20251121083414.3642-17-socketcan@hartkopp.net>
 <20251121-meticulous-authentic-hippo-a88adc-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251121-meticulous-authentic-hippo-a88adc-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21.11.25 09:47, Marc Kleine-Budde wrote:
> On 21.11.2025 09:34:13, Oliver Hartkopp wrote:
>> Unify the ctrlmode related strings to the command line options of the
>> 'ip' tool from the iproute2 package. The capitalized strings are also
>> shown when the detailed interface configuration is printed by 'ip'.
>>
>> Suggested-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/dev/dev.c | 34 +++++++++++++++++-----------------
>>   1 file changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
>> index 1de5babcc4f3..32db9f69844d 100644
>> --- a/drivers/net/can/dev/dev.c
>> +++ b/drivers/net/can/dev/dev.c
>> @@ -90,43 +90,43 @@ EXPORT_SYMBOL_GPL(can_get_state_str);
>>
>>   const char *can_get_ctrlmode_str(u32 ctrlmode)
>>   {
>>   	switch (ctrlmode & ~(ctrlmode - 1)) {
>>   	case 0:
>> -		return "none";
>> +		return "(none)";
>>   	case CAN_CTRLMODE_LOOPBACK:
>> -		return "loopback";
>> +		return "LOOPBACK";
>>   	case CAN_CTRLMODE_LISTENONLY:
>> -		return "listen-only";
>> +		return "LISTEN-ONLY";
>>   	case CAN_CTRLMODE_3_SAMPLES:
>> -		return "triple-sampling";
>> +		return "TRIPLE-SAMPLING";
>>   	case CAN_CTRLMODE_ONE_SHOT:
>> -		return "one-shot";
>> +		return "ONE-SHOT";
>>   	case CAN_CTRLMODE_BERR_REPORTING:
>> -		return "berr-reporting";
>> +		return "BERR-REPORTING";
>>   	case CAN_CTRLMODE_FD:
>> -		return "fd";
>> +		return "FD";
>>   	case CAN_CTRLMODE_PRESUME_ACK:
>> -		return "presume-ack";
>> +		return "PRESUME-ACK";
>>   	case CAN_CTRLMODE_FD_NON_ISO:
>> -		return "fd-non-iso";
>> +		return "FD-NON-ISO";
>>   	case CAN_CTRLMODE_CC_LEN8_DLC:
>> -		return "cc-len8-dlc";
>> +		return "CC-LEN8-DLC";
>>   	case CAN_CTRLMODE_TDC_AUTO:
>> -		return "fd-tdc-auto";
>> +		return "TDC-AUTO";
>>   	case CAN_CTRLMODE_TDC_MANUAL:
>> -		return "fd-tdc-manual";
>> +		return "TDC-MANUAL";
>>   	case CAN_CTRLMODE_RESTRICTED:
>> -		return "restricted-operation";
>> +		return "RESTRICTED";
>>   	case CAN_CTRLMODE_XL:
>> -		return "xl";
>> +		return "XL";
>>   	case CAN_CTRLMODE_XL_TDC_AUTO:
>> -		return "xl-tdc-auto";
>> +		return "XL-TDC-AUTO";
>>   	case CAN_CTRLMODE_XL_TDC_MANUAL:
>> -		return "xl-tdc-manual";
>> +		return "XL-TDC-MANUAL";
>>   	case CAN_CTRLMODE_XL_TMS:
>> -		return "xl-tms";
>> +		return "TMS";
> 
> Here the prefix "XL-" is dropped. Was that intentional?

Yes. The patches for iproute2-next and for the kernel are inconsistent.

The command line (and its help text) uses:

[ tms { on | off } ]

The ctrlmode is named:

CAN_CTRLMODE_XL_TMS

And the output of 'ip -det -link show can0' currently prints:

can <XL,XL-TMS> state STOPPED restart-ms 0

Which needs to be changed to <XL,TMS> IMO.

I think 'tms' is better in the command line than xl-tms as it is clear 
that tms only works with XL-only and if you try it otherwise you get an 
error.

 >>   	case CAN_CTRLMODE_3_SAMPLES:
 >> -		return "triple-sampling";
 >> +		return "TRIPLE-SAMPLING";

There's not always a 1:1 name mapping.

IMO CAN_CTRLMODE_XL_TMS together with "TMS" looks fine for the internal 
and external representation.

> We should move this patch to the front, so that new members could be
> added in uppercase from the beginning.

This is a useless effort IMO.

When we decided to unify the capitalization as a clean-up four weeks 
later (what we did) than the patch sequence would look like this in the 
tree.

Best regards,
Oliver

> 
> Marc
> 
>>   	default:
>>   		return "<unknown>";
>>   	}
>>   }
>>   EXPORT_SYMBOL_GPL(can_get_ctrlmode_str);
>> --
>> 2.47.3
>>
>>
>>
> 


