Return-Path: <linux-can+bounces-5456-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A62AC61E63
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 23:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B24E3353903
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 22:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D8823AE66;
	Sun, 16 Nov 2025 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvP57C7X"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23921322F
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763331538; cv=none; b=QwiBPUSO7CLb+ljYz0OOLDTSHooj5o2GPRQqYuSf9+c/i+wbs8MMnpwS5qLw4lrCDb1G2+gN8PLifBrm7UDNc20VdmPCBBa8zPlWMHYZRG8w7cQaAzd7qpAUaa+urt9gIQ1e1R10RVXoAd7+SaIS/ag6pE3ApmifktUgfO33PsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763331538; c=relaxed/simple;
	bh=hwXVITgsQd0SkdVRfG2s57EorEUdFOlJElsoLvet5c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qzw6h4EJg2vsCOcpx0XHcnpPLk6jWLl/vCK8g7rozOaXhKOpxvGXbz9Xyvs9+9chqJxTw8jGg7mW9AhDzGmR/o9sZPvkwiD3F2IV3UXnokq7p627fvxfkpttDT2e+0ONMqXMc5/D7iLxsUf3QFQhJBl8Ndy21AKbvIVNv5NN7E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvP57C7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F87BC4CEF1;
	Sun, 16 Nov 2025 22:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763331538;
	bh=hwXVITgsQd0SkdVRfG2s57EorEUdFOlJElsoLvet5c8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=JvP57C7X2XqClkM4otbXPVm1gl+HRnDX8LU6egiUFWTb8vm4RzlDBJb6axMpI2bYC
	 t5CeQSLTQIftyp4VfHKn4Wi6XPj/er9AAyCe7xIpedi6fQLpbxdZc+wUotSeJC0nuq
	 l79H2h9O1y4sRZI6+3dFwMjdDx7GFLVnQRNUd/6giQKsfxuKlHY8g4AinRfaNQ0CAM
	 mrnPLluc30FFQJ32uB70uM37qqzox/M/l4vYY0sl1J5mve5quzuTLMQpyTFJMW+UXZ
	 rgS/AOw/QmgGjUYMZmqxzPKYz9enLaXig86D6A/xhNCX8MPxdKgdFLHhVkitH4ClQs
	 dCeiLyuWn9C6A==
Message-ID: <a6a2ecfa-3caa-4a4d-90e6-16e031e68f73@kernel.org>
Date: Sun, 16 Nov 2025 23:18:55 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v2 13/15] can: calc_bittiming: add
 can_calc_sample_point_pwm()
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20251115163740.7875-1-socketcan@hartkopp.net>
 <20251115163740.7875-14-socketcan@hartkopp.net>
 <69fb9682-82ab-4a3b-a79e-74fa24da23be@hartkopp.net>
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
In-Reply-To: <69fb9682-82ab-4a3b-a79e-74fa24da23be@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/11/2025 at 21:05, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 15.11.25 17:37, Oliver Hartkopp wrote:
>> From: Vincent Mailhol <mailhol@kernel.org>
>>
>> The optimum sample point value depends on the bit symmetry. The more
>> asymmetric the bit is, the more the sample point would be located
>> towards the end of the bit. On the contrary, if the transceiver only
>> has a small asymmetry, the optimal sample point would be slightly
>> after the centre of the bit.
>>
>> For NRZ encoding (used by Classical CAN, CAN FD and CAN XL with TMS
>> off), the optimum sample points values are above 70% as implemented in
>> can_calc_sample_point_nrz().
>>
>> When TMS is on, CAN XL optimum sample points are near to 50% or
>> 60% [1]. Add can_calc_sample_point_pwm() which returns a sample point
>> which is suitable for PWM encoding. We crafted the formula to make it
>> return the same values as below table (source: table 3 of [1]).
>>
>>         Bit rate (Mbits/s)    Sample point
>>         -------------------------------------
>>           2.0             51.3%
>>           5.0             53.1%
>>           8.0             55.0%
>>          10.0             56.3%
>>          12.3             53.8%
>>          13.3             58.3%
>>          14.5             54.5%
>>          16.0             60.0%
>>          17.7             55.6%
>>          20.0             62.5%
> 
> I tested all these examples.
> 
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 4000000 xl
> on tms on
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 2000000 xl
> on tms on
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 5000000 xl
> on tms on
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 8000000 xl
> on tms on
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 10000000 xl
> on tms on
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 12300000 xl
> on tms on
> Warning: bitrate error: 0.0%.
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 13300000 xl
> on tms on
> Warning: bitrate error: 0.2%.
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 14500000 xl
> on tms on
> Warning: bitrate error: 0.3%.
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 16000000 xl
> on tms on
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 17700000 xl
> on tms on
> Warning: bitrate error: 0.4%.
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 20000000 xl
> on tms on
> root@de1soc1:~#
> 
> In the case of xbitrate 12300000 the feedback is
> Warning: bitrate error: 0.0%.
> 
> The calculated bitrate is:
> xbitrate 12307692 xsample-point 0.538
> 
> 12307692/12300000 = 1.00062536585
> 
> So it is 0.06%
> 
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 13300000 xl
> on tms on
> Warning: bitrate error: 0.2%.

Random unrelated comment: I figured out that if you have both a
NL_SET_ERR_MSG_FMT() Warning and a NL_SET_ERR_MSG() Error message (note the _FMT
suffix only on the warning side), the warning may take precedence over the
Error. Because netlink can only carry one message, it would be better to only
report the error when both error and warning occurs. Note that this is not an
issue in our tree. I wanted to look at it in more details once the CAN XL is
merged (although I do not expect the fix to be complex).

> The calculated bitrate is:
> xbitrate 13333333 xsample-point 0.583
> 
> 13333333/13300000 = 1.0025062406
> 
> So it is 0.25%
> 
> Would it make sense to add another digit and probably additionally some round-up
> to omit a 0.0% warning?

I drafted this:

------------8<------------
can: calc_bittiming: add one decimal place in bitrate error messages
---
 drivers/net/can/dev/calc_bittiming.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c
b/drivers/net/can/dev/calc_bittiming.c
index 9c8154859513..45d1dc286197 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -152,19 +152,19 @@ int can_calc_bittiming(const struct net_device *dev,
struct can_bittiming *bt,
 	}

 	if (best_bitrate_error) {
-		/* Error in one-tenth of a percent */
-		v64 = (u64)best_bitrate_error * 1000;
+		/* Error in one-hundredth of a percent */
+		v64 = (u64)best_bitrate_error * 10000;
 		do_div(v64, bt->bitrate);
 		bitrate_error = (u32)v64;
 		if (bitrate_error > CAN_CALC_MAX_ERROR) {
 			NL_SET_ERR_MSG_FMT(extack,
 					   "bitrate error: %u.%u%% too high",
-					   bitrate_error / 10, bitrate_error % 10);
+					   bitrate_error / 100, bitrate_error % 100);
 			return -EINVAL;
 		}
 		NL_SET_ERR_MSG_FMT(extack,
 				   "bitrate error: %u.%u%%",
-				   bitrate_error / 10, bitrate_error % 10);
+				   bitrate_error / 100, bitrate_error % 100);
 	}

 	/* real sample point */
------------8<------------

No time to test at the moment (maybe I will be able to test in a couple days),
but does it look good to you?

Also, this isn't the only place in which we are getting out of significant
digit. This was already a couple months ago, but when I started calculating the
PWM symbols, I figured out that on very high bitrates, can_bittiming->tq will
lack some significant digits because of the decimal truncation. Using this in
CAN XL can become problematic. That's another TODO…


Yours sincerely,
Vincent Mailhol


