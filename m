Return-Path: <linux-can+bounces-5403-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 529DCC603AB
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 12:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3383834E1F9
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 11:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B50288525;
	Sat, 15 Nov 2025 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkPoMX/R"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F727B348;
	Sat, 15 Nov 2025 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763205275; cv=none; b=PsWFVZFrYfYT4RCMyQUhbSN/KG30TG84s2b6mfpkCc72yIykDM3yjPWNw9+AyRNMEtBruAGPJzk/PoOOgHROnk14Rb2SGFq1FItyelGxM8JVyw0Kj3OOSC0zkuuyKVH+5xaRT3TMo1F/SF+rWEctYtr9C+qJXvz5W3+kW2e5G/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763205275; c=relaxed/simple;
	bh=NiKgCMHTdBZQbL9B7gsQiME9gAZkT81CYqHfisEgMI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2vvjIG11VPEfMDgh3IDN/fpRPtf4/sZQygwIsewMa6UWnST06526QvtlAeWvrw6KapPFH+UKVKAEkzS8/G4+ZMQIrgRR6qepWeMYSnQJxuIapYKAb3ZmEzQG+CI/9Ud00JAIwdQU3TewZsjR+SWFIzIumCyEwkTZMrBLMNcD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkPoMX/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43674C116D0;
	Sat, 15 Nov 2025 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763205275;
	bh=NiKgCMHTdBZQbL9B7gsQiME9gAZkT81CYqHfisEgMI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gkPoMX/RHxtaKozQEpNbehMGFNb1AzUBL8XopsXQ510eSXANhYT3atMT7K/LjGGWi
	 gdJSCAIjt0MUDcdzxicHWbhcuaKCp8sKfOFQA0ysSBnCx3xwp/R+E0x9gOyhYgaUfv
	 RS+rH52+tC8GsnSZSui1QM3DnNaQlBSWb7aMAE6joia1Djoj69zpaZp9NpTI5nrkGI
	 v3BjANPzh8fGR4Y854Uh1fWeJv8IRWGSkZHvFzyhC5pea/dhA/Gdx4bsc6fj2aY40Z
	 sbYk7P+YiuCAnC9xf/C1VBMgP7UWXu7c2YfZB+XcAjwXa5Z1o2h1IWd6Qv8Wd+SaNY
	 UZYPmiFTP7CWA==
Message-ID: <a84c66ff-c5ad-418e-afb6-31f114eda17c@kernel.org>
Date: Sat, 15 Nov 2025 12:14:31 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] can: calc_bittiming: get rid of the incorrect
 "nominal" word
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
 <20251102-pwm_sample_point-v1-1-3bbea180f59e@kernel.org>
 <20251112-remarkable-puzzling-fox-3b3202-mkl@pengutronix.de>
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
In-Reply-To: <20251112-remarkable-puzzling-fox-3b3202-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/2025 at 10:08, Marc Kleine-Budde wrote:
> On 02.11.2025 23:01:22, Vincent Mailhol wrote:
>> The functions can_update_sample_point() and can_calc_bittiming() are
>> generic and meant to be used for both the nominal and the data
>> bittiming calculation.
> 
> ""There are 2 hard problems in computer science: cache invalidation,
>   naming things, and off-by-1 errors.""

:D

> Here it's naming things. Back in the days, in commit 7da29f97d6c8 ("can:
> dev: can-calc-bit-timing(): better sample point calculation"), I wanted
> to distinguish between the sample point the user requested and the
> current sample point.
> 
> I was thinking about the signal that goes into a control loops, but at
> university the lecture was in German, so I picked the wrong term. I
> think "set point" or "reference value" are better terms.

OK. Thanks for the clarification, now it makes more sense.

>> However, those functions use terminologies such as "bitrate nominal"
>> or "sample point nominal". This is a leftover from when only Classical
>> CAN was supported and now became incorrect.
>>
>> Remove or replace any occurrences of the word "nominal" with something
>> more accurate.
> 
> What about replacing "nominal" with "reference"

Ack. I will also fully rewrite the patch description. The new title will become:

  can: calc_bittiming: get rid of the confusing "nominal" wording

>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>> ---
>>  drivers/net/can/dev/calc_bittiming.c | 30 ++++++++++++++----------------
>>  1 file changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
>> index 268ec6fa7c49..222117596704 100644
>> --- a/drivers/net/can/dev/calc_bittiming.c
>> +++ b/drivers/net/can/dev/calc_bittiming.c
>> @@ -24,7 +24,7 @@
>>   */
>>  static int
>>  can_update_sample_point(const struct can_bittiming_const *btc,
>> -			const unsigned int sample_point_nominal, const unsigned int tseg,
>> +			unsigned int sp_origin, unsigned int tseg,
> 
> Please don't remove the "const".
I always considered it silly to tag a scalar parameter as const. Because C
passes the function argument by value, it is pretty meaningless. But I guess
this change is out of scope. I will restore this in the next version.

>>  			unsigned int *tseg1_ptr, unsigned int *tseg2_ptr,
>>  			unsigned int *sample_point_error_ptr)
>>  {
>> @@ -35,8 +35,7 @@ can_update_sample_point(const struct can_bittiming_const *btc,
>>
>>  	for (i = 0; i <= 1; i++) {
>>  		tseg2 = tseg + CAN_SYNC_SEG -
>> -			(sample_point_nominal * (tseg + CAN_SYNC_SEG)) /
>> -			1000 - i;
>> +			(sp_origin * (tseg + CAN_SYNC_SEG)) / 1000 - i;
>>  		tseg2 = clamp(tseg2, btc->tseg2_min, btc->tseg2_max);
>>  		tseg1 = tseg - tseg2;
>>  		if (tseg1 > btc->tseg1_max) {
>> @@ -46,9 +45,9 @@ can_update_sample_point(const struct can_bittiming_const *btc,
>>
>>  		sample_point = 1000 * (tseg + CAN_SYNC_SEG - tseg2) /
>>  			(tseg + CAN_SYNC_SEG);
>> -		sample_point_error = abs(sample_point_nominal - sample_point);
>> +		sample_point_error = abs(sp_origin - sample_point);
>>
>> -		if (sample_point <= sample_point_nominal &&
>> +		if (sample_point <= sp_origin &&
>>  		    sample_point_error < best_sample_point_error) {
>>  			best_sample_point = sample_point;
>>  			best_sample_point_error = sample_point_error;
>> @@ -68,11 +67,11 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
>>  {
>>  	struct can_priv *priv = netdev_priv(dev);
>>  	unsigned int bitrate;			/* current bitrate */
>> -	unsigned int bitrate_error;		/* difference between current and nominal value */
>> +	unsigned int bitrate_error;		/* difference between current and calculated value */
> 
> What about: "difference between reference and calculated value"

Ack. Applied to next version.


Yours sincerely,
Vincent Mailhol


