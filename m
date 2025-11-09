Return-Path: <linux-can+bounces-5321-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A44C44022
	for <lists+linux-can@lfdr.de>; Sun, 09 Nov 2025 15:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BD91889FC3
	for <lists+linux-can@lfdr.de>; Sun,  9 Nov 2025 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B476D2FDC47;
	Sun,  9 Nov 2025 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F//e05Al"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880302D63E5;
	Sun,  9 Nov 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762698510; cv=none; b=tvwr1//TEw8ahQCFjX0vMDy6uMZIUIk8juhl3GHPdnmXCpUgKR0UFZ3krU6Dy/Ia+vKTfEKIPlKc2pqlaCl/DcpB8So+hBRY71Kqlh+26kBZDp6tRYhVWkFr2wqex7gLVGNKbjeGTd1EOl+Hw6GGqjAsgRFrwdvPcbbuFMnjwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762698510; c=relaxed/simple;
	bh=blda30pWTHPL6Mg2lKLrTrLxbbshsM6s4eiSWZIoAwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uo5nDTd5a2IcRiSAPM+DW3KQRjrtEMHXgjnSSljInBwOy4ZTUCpseQH/4jcYSXCtTlkUcRgmhL1WtwrQ2/K7wcteq9DwVm7Hgc2sIH1BElnDz9yLDaMLu9cY/X4flxDHpawCt9H1v2ec24GnIfOSWrSYBSJ/oQSfF6IkKhrN5v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F//e05Al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50452C19422;
	Sun,  9 Nov 2025 14:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762698509;
	bh=blda30pWTHPL6Mg2lKLrTrLxbbshsM6s4eiSWZIoAwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F//e05AlYc4iANu9XU2x9NA7G6pqLwPbWx1JDfhO1ruta6fKVAmgMhkyoMj878+PY
	 WQjfytWeUUQTqE79TvN4i2xX4CsFnIHMBDJchzDE1A9q4M42XrNoVEUbstf96eyvH6
	 2wzbDWy0knjIS1StShSL/B2bKVJm5fkji+xEZLhoREK5Fqy6u4Z00KCf6lngEgLouq
	 KKKqoXfWTidVunU8VtaqqV2jKDKSm5HnNB/pclMEtZXqB3l/Y7UcHfQZXwsKATYLk2
	 fEMWUP9wcoriQ8SKbSYeNVSz1JH0v5HzJLXCvWAVDDbjqRTbagNRnPa56WYbA1HZvB
	 UVFXAHGgoTfFA==
Message-ID: <77daaf44-e75f-4adf-9d87-d2833a255748@kernel.org>
Date: Sun, 9 Nov 2025 15:28:23 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] can: netlink: add CAN_CTRLMODE_XL_TMS flag
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
 <20251021-canxl-netlink-v2-5-8b8f58257ab6@kernel.org>
 <a50a77c8-85ef-4ac8-b649-33b880ec4b17@hartkopp.net>
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
In-Reply-To: <a50a77c8-85ef-4ac8-b649-33b880ec4b17@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Oliver,

On 06/11/2025 at 09:42, Oliver Hartkopp wrote:
> Hello Vincent,
> 
> On 21.10.25 17:47, Vincent Mailhol wrote:
>> The Transceiver Mode Switching (TMS) indicates whether the CAN XL
>> controller shall use the PWM or NRZ encoding during the data phase.
>>
>> The term "transceiver mode switching" is used in both ISO 11898-1 and
>> CiA 612-2 (although only the latter one uses the abbreviation TMS). We
>> adopt the same naming convention here for consistency.
>>
>> Add the CAN_CTRLMODE_XL_TMS flag to the list of the CAN control modes.
>>
>> In the netlink interface, each boolean option is in reality a tristate
>> in disguise: on, off or omitted. For the moment, TMS is implemented as
>> below:
>>
>>    - CAN_CTRLMODE_XL_TMS is set to false: TMS is disabled.
>>    - CAN_CTRLMODE_XL_TMS is set to true: TMS is enabled.
>>    - CAN_CTRLMODE_XL_TMS is omitted: return -EOPNOTSUPP.
> 
> I would propose to follow the usual pattern:
> 
> - TMS off (default)
> - TMS on (when selected on the command line)

OK. "TMS omitted" will be interpreted as "TMS off" in v2.

>> For most of the other control modes, omitting a flag default to the
>> option turned off. It could also be possible to provide a default
>> behaviour if the TMS flag is omitted (i.e. either default to TMS off
>> or on). However, it is not clear for the moment which default
>> behaviour is preferable. If the usage shows a clear trend (for example
>> if the vast majority of the users want TMS on by default), it is still
>> possible to revisit that choice in the future. Whereas once a default
>> option is provided, we can not change it back without breaking the
>> interface.
>>
>> As a corollary, for the moment, the users will be forced to specify
>> the TMS in the ip tool when using CAN XL.
>>
>> Add can_validate_xl_flags() to check the coherency of the TMS flag.
>> That function will be reused in upcoming changes to validate the other
>> CAN XL flags.
>>
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>> ---
>> Question:
>>
>> Is it still possible to send Classical CAN frames when TMS is on? If
>> not, we need to also add this filter in can_dev_dropped_skb():
> 
> No.
> 
> I've now learned there are two "CANXL-only" modes:
> 
> 1. TMS on -> no CC/FD traffic
> 2. TMS off and ERR_SIG off -> no CC/FD traffic, because CC/FD require ERR_SIG on
> for a compliant transmission

I see. I was under the assumption that CC and FD could be used with error
signalling off in mixed mode. Thanks!

> And there is a "mixed-mode" with CC/FD/XL with TMS off ('ERR_SIG on' is default
> anyway).
> 
> This "mixed-mode" requires all bitrates for CC/FD/XL to be set and all these CAN
> protocols can be sent.

Why? Will your device reject the configuration if you omit the FD bitrate? I did
not see anything in this direction in the ISO standard.

Did you have any source for this? Maybe the CiA provided some clarification
which I am not aware of?


Yours sincerely,
Vincent Mailhol


