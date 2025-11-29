Return-Path: <linux-can+bounces-5788-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1698FC948C4
	for <lists+linux-can@lfdr.de>; Sun, 30 Nov 2025 00:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F132345E39
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 23:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F29C247DE1;
	Sat, 29 Nov 2025 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfLv7VME"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F4236D51E;
	Sat, 29 Nov 2025 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764458039; cv=none; b=EYRlXWnG0RCoCUHdDkptG4dbmpQBVer2lWtg3izVlqJqPfGgkohU0WgstWlLSQrX6Nh5QjZl6diVvdGIutgfVQ9LRHNnJsE2mjozQS8fP+A0QgsAOkI49VCbKyZewDB6WOP6if/uJG/b2uuqRwvRtOXZUw+M0ZVdOpoH5iZlejo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764458039; c=relaxed/simple;
	bh=m0Obm5gIwV7F7Qt1kS9OIm8ga5wdZIb7eYbpMlTuqSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcYKKvGcoxb1KxdSf648nXcMI1uZbLOtrBK53HbQe9jSeXiyk3bqL4GMF1fR6WR9qVE2KddmWLOLN3+/5MFwcfGvCL+If4JmsRhr/thqZbjKERM48rYWxObwX0T6lZwzg6BpdAPwmYJkA8LHI4+qI403mDlmW45VUobDHsTCEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfLv7VME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5532C4CEF7;
	Sat, 29 Nov 2025 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764458038;
	bh=m0Obm5gIwV7F7Qt1kS9OIm8ga5wdZIb7eYbpMlTuqSg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CfLv7VMEyziaZ5zu+XRGN3AnoTOGtUNVwTp4McnwG2D4ydPb1tdSRm76VuvRFdEvJ
	 KDmn9AJt3y/JIRzYTEH9aYt0H5kJrK1Rb2Up+ht+YbpUQMjFqgvPPQuWgZ/zJwXEpO
	 SwUfvdQxFgxqFa6U6RF3sdAjtdX42RxNBotSckDEv4SIvZQqtOs0xI9RyVrC1jgo4Q
	 bBC2/Yu1x8+ls2xe6wYOHxGhZuCKWLXaa6KIhqeHLE2DaCkreQhLFMnQSwRPg7c4Dc
	 bG9G5rw10lvfKm8a+2Ivuh0q3/CNovuPiv3dc1Rj+GjqDvqxoB7O7Xvl3PNqL+wt/g
	 iBC9HNekiSVIg==
Message-ID: <fc2c8f97-b481-4c77-99ba-5d3df7c74644@kernel.org>
Date: Sun, 30 Nov 2025 00:13:53 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] iplink_can: add initial CAN XL support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
 <20251129-canxl-netlink-v1-5-96f2c0c54011@kernel.org>
 <20251129090403.5185f2ee@phoenix.local>
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
In-Reply-To: <20251129090403.5185f2ee@phoenix.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2025 at 18:04, Stephen Hemminger wrote:
> On Sat, 29 Nov 2025 16:29:10 +0100
> Vincent Mailhol <mailhol@kernel.org> wrote:
> 
>> +		} else if (matches(*argv, "xl") == 0) {
>> +			NEXT_ARG();
>> +			set_ctrlmode("xl", *argv, &cm, CAN_CTRLMODE_XL);
>> +		} else if (matches(*argv, "xbitrate") == 0) {
>> +			NEXT_ARG();
>> +			if (get_u32(&xl_dbt.bitrate, *argv, 0))
>> +				invarg("invalid \"xbitrate\" value", *argv);
>> +		} else if (matches(*argv, "xsample-point") == 0) {
>> +			float sp;
>> +
>> +			NEXT_ARG();
>> +			if (get_float(&sp, *argv))
>> +				invarg("invalid \"xsample-point\" value", *argv);
>> +			xl_dbt.sample_point = (__u32)(sp * 1000);
>> +		} else if (matches(*argv, "xtq") == 0) {
>> +			NEXT_ARG();
>> +			if (get_u32(&xl_dbt.tq, *argv, 0))
>> +				invarg("invalid \"xtq\" value", *argv);
>> +		} else if (matches(*argv, "xprop-seg") == 0) {
>> +			NEXT_ARG();
>> +			if (get_u32(&xl_dbt.prop_seg, *argv, 0))
>> +				invarg("invalid \"xprop-seg\" value", *argv);
>> +		} else if (matches(*argv, "xphase-seg1") == 0) {
>> +			NEXT_ARG();
>> +			if (get_u32(&xl_dbt.phase_seg1, *argv, 0))
>> +				invarg("invalid \"xphase-seg1\" value", *argv);
>> +		} else if (matches(*argv, "xphase-seg2") == 0) {
>> +			NEXT_ARG();
>> +			if (get_u32(&xl_dbt.phase_seg2, *argv, 0))
>> +				invarg("invalid \"xphase-seg2\" value", *argv);
>> +		} else if (matches(*argv, "xsjw") == 0) {
>> +			NEXT_ARG();
>> +			if (get_u32(&xl_dbt.sjw, *argv, 0))
>> +				invarg("invalid \"xsjw\" value", *argv);
>> +		} else if (matches(*argv, "xtdcv") == 0) {
>> +			NEXT_ARG();
>> +			if (get_u32(&xl.tdcv, *argv, 0))
>> +				invarg("invalid \"xtdcv\" value", *argv);
>> +		} else if (matches(*argv, "xtdco") == 0) {
>> +			NEXT_ARG();
>> +			if (get_u32(&xl.tdco, *argv, 0))
>> +				invarg("invalid \"xtdco\" value", *argv);
>> +		} else if (matches(*argv, "xtdcf") == 0) {
>> +			NEXT_ARG();
>> +			if (get_u32(&xl.tdcf, *argv, 0))
>> +				invarg("invalid \"xtdcf\" value", *argv);
>>  		} else if (matches(*argv, "loopback") == 0) {
>>  			NEXT_ARG();
> 
> not accepting any new code with matches()

Ack. I will do a s/matches/strcmp/g in the next version.

For the old code, I assume that we should keep it as-is, otherwise that would be
a breaking change.


Yours sincerely,
Vincent Mailhol


