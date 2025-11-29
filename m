Return-Path: <linux-can+bounces-5789-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5112FC948D0
	for <lists+linux-can@lfdr.de>; Sun, 30 Nov 2025 00:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95043A6AC9
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 23:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1992571DA;
	Sat, 29 Nov 2025 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGuviMCy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5AF14F125;
	Sat, 29 Nov 2025 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764458188; cv=none; b=m90KQ9fukMCpQjeFYzUEYEllIOyJA822Z5wQlL3e+zvY+wSZ7S9241zBmV0Jae8qiZM0HwigbEDUNm+PMN64BjQOausNOzgnUBpJjcWQXbJ/hPKRp/wercbd8UbD1r0cfXuj2X5iXDVZ28ANQ/Vszd3HJ/7t2TLtalqy0reZ68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764458188; c=relaxed/simple;
	bh=9+g47q9s6n6faQ1m7dAxX/6NbjuMMEwRM6LxqMIxQNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDWVtEeFXzDFZiXwrHqusKuKTO2hjK2mRAkonBV9F3XgiR/nTKCE3tTVMvJgYrP5ursH5jAN7gHgV8PjsUEvo+eaWveXL3HVCeaPB5daHDrYpxC3Q8ZpXFw7KvNv0SVUFj32YOi/+KLLf1AUdejgvFlzfcurqNXs4ZEMCMW3tJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGuviMCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C46C4CEF7;
	Sat, 29 Nov 2025 23:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764458188;
	bh=9+g47q9s6n6faQ1m7dAxX/6NbjuMMEwRM6LxqMIxQNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YGuviMCyfM+OzXC3+YeNyQFl6KTImjg4BeR3VoZHei/Fkk3zLwsMoaxkQ6k751mWw
	 fQUldJ0G5LUD2++2GtFE5bR6gcIxXT+MtoUwglLziosunrro1VxSsfNdG6X4sjtvlK
	 J1Jp4TZiPtWo05jKJI//DRIEeKSVgjevXIttyL/gD6PPTeN1yaPo5jDU9tDR5w4WD5
	 do0o6aIT6jPdTXhF4Bf6KrZWI/gsdNFjIA2r0/2WlHixcaP8FeZ2NpJ09sN7uTA9dm
	 eRfNbm40C/9g0ceSHtr/0J6HlBXUj0f5cFuyOuHoRWq0MSEl1WWk9kmBjfdpU+sn0u
	 p+Suvx9SpQN4g==
Message-ID: <72c06703-6dce-4734-985b-b390a4b106ad@kernel.org>
Date: Sun, 30 Nov 2025 00:16:23 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] iplink_can: add CAN XL's "tms" option
To: Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
 <20251129-canxl-netlink-v1-6-96f2c0c54011@kernel.org>
 <d2e94a1f-b2f3-473a-babe-76fd0fed0ab9@hartkopp.net>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <d2e94a1f-b2f3-473a-babe-76fd0fed0ab9@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oliver,

On 29/11/2025 at 18:21, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 29.11.25 16:29, Vincent Mailhol wrote:
>> This is the iproute2 counterpart of Linux kernel's commit 233134af2086
>> ("can: netlink: add CAN_CTRLMODE_XL_TMS flag").
>>
>> The Transceiver Mode Switching (TMS) indicates whether the CAN XL
>> controller shall use the PWM or NRZ encoding during the data phase.
>>
>> The term "transceiver mode switching" is used in both ISO 11898-1 and CiA
>> 612-2 (although only the latter one uses the abbreviation TMS). We adopt
>> the same naming convention here for consistency.
>>
>> Add the "tms" option to iplink_can which controls the CAN_CTRLMODE_XL_TMS
>> flag of the CAN netlink interface.
>>
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>> ---
>>   ip/iplink_can.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/ip/iplink_can.c b/ip/iplink_can.c
>> index 24f59aad..3e7925e8 100644
>> --- a/ip/iplink_can.c
>> +++ b/ip/iplink_can.c
>> @@ -49,6 +49,7 @@ static void print_usage(FILE *f)
>>           "\t[ restricted { on | off } ]\n"
>>           "\t[ xl { on | off } ]\n"
>>           "\t[ xtdc-mode { auto | manual | off } ]\n"
>> +        "\t[ tms { on | off } ]\n"
>>           "\n"
>>           "\t[ restart-ms TIME-MS ]\n"
>>           "\t[ restart ]\n"
>> @@ -127,6 +128,7 @@ static void print_ctrlmode(enum output_type t, __u32
>> flags, const char *key)
>>       print_flag(t, &flags, CAN_CTRLMODE_XL, "XL");
>>       print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_AUTO, "XL-TDC-AUTO");
>>       print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_MANUAL, "XL-TDC-MANUAL");
>> +    print_flag(t, &flags, CAN_CTRLMODE_XL_TMS, "XL-TMS");
> 
> print_flag(t, &flags, CAN_CTRLMODE_XL_TMS, "TMS");
> 
> That fits to the command line option and the messages inside the kernel now.

OK. This will be addressed in v2 (including the updates on Patch #7 description).


Yours sincerely,
Vincent Mailhol


