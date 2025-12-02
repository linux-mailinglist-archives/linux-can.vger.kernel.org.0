Return-Path: <linux-can+bounces-5808-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F22C9D368
	for <lists+linux-can@lfdr.de>; Tue, 02 Dec 2025 23:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4D354E3CC4
	for <lists+linux-can@lfdr.de>; Tue,  2 Dec 2025 22:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305EC2F7AB1;
	Tue,  2 Dec 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i22wqEQW"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009FA280330;
	Tue,  2 Dec 2025 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714648; cv=none; b=Bd2rElwqDGQovRD6RPQYi+CegjItT0Alo+5Uew2xKvbuHNRaaHoR1luu5+uMPZ3eGeosdpkpmAuv6LEKz0sSkZeEX2cP+XsW7BcGXTsrrdB8i7cM016SRdDwzVoFpckqV8pHlpWSalgsbTDJSmMyxYica6M3q6Wdv0zYWr+B6n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714648; c=relaxed/simple;
	bh=R0VK8aPrj64/tkCwd23+5g2mL/Tww0AKUYcg/GPMiEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqTtbobMNTdJ6K6HQ6volMAHZnFuTR0EcNYTY4dKP6W5+f/HtRwTQWgVoG+Bp/i7zASnJ4nEjJFW0N2JHOOesL2kDyaCVpGzknkLiCYlcXBozz7uc1ICjjiT2a1F8PXsAbrtZrrXkkTI6zaCUXjnU3qDR8/tDG6eJrkVEdpdewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i22wqEQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF2AC4CEF1;
	Tue,  2 Dec 2025 22:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764714646;
	bh=R0VK8aPrj64/tkCwd23+5g2mL/Tww0AKUYcg/GPMiEk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i22wqEQW6MoMp51k3D57gcGWRlW8ACTNCTd7HbyzjAy7OCUQF2SyKnUXRHoWqJZnZ
	 Gh3liP6FnmeYt9+QBJ9Iy2amAxeByEVRSTF22L/FAY1zQlMjXLrEG+Kjxk2lIUT1b6
	 XRICCrAbYnOUeqx+dt3PX6EQu1zwjXUvIQYCzlQTHci+FDQ5FqMR1JvfHdoiDuQ31T
	 1EFHNFNUpSyYyK1z8FYeAy4FHMgYBiJ0CwK/eKAPtZ+JANGK0WKdrZrpBF5u2Dy2l+
	 Du5ljA6kGpe5iR57NjS0J0RjwFbE6W402AKzne0B2H0L6PSZfIqghFIL5zKNG1P0ZS
	 kVlqgRykgsZsg==
Message-ID: <8acb6a32-bc4a-4f9f-adb2-f8b20dd0d5c9@kernel.org>
Date: Tue, 2 Dec 2025 23:30:41 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 5/7] iplink_can: add initial CAN XL
 interface
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>,
 Rakuram Eswaran <rakuram.e96@gmail.com>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
References: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org>
 <20251201-canxl-netlink-v2-5-dadfac811872@kernel.org>
 <20251201163810.3246dc49@phoenix.local>
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
In-Reply-To: <20251201163810.3246dc49@phoenix.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2025 at 01:38, Stephen Hemminger wrote:
> On Mon, 01 Dec 2025 23:55:13 +0100
> Vincent Mailhol <mailhol@kernel.org> wrote:
> 
>>  
>> -static void can_print_tdc_opt(struct rtattr *tdc_attr)
>> +static void can_print_tdc_opt(struct rtattr *tdc_attr, bool is_xl)
>>  {
>>  	struct rtattr *tb[IFLA_CAN_TDC_MAX + 1];
>>  
>>  	parse_rtattr_nested(tb, IFLA_CAN_TDC_MAX, tdc_attr);
>>  	if (tb[IFLA_CAN_TDC_TDCV] || tb[IFLA_CAN_TDC_TDCO] ||
>>  	    tb[IFLA_CAN_TDC_TDCF]) {
>> -		open_json_object("tdc");
>> +		const char *tdc = is_xl ? "xtdc" : "tdc";
>> +
>> +		open_json_object(tdc);
>>  		can_print_nl_indent();
>>  		if (tb[IFLA_CAN_TDC_TDCV]) {
>> +			const char *tdcv_fmt = is_xl ? " xtdcv %u" : " tdcv %u";
> 
> Having a format string as variable can break (future) format checking and some compiler flags.

Ack. I now see that this would raise some -Wformat-nonliteral warnings. I was
not aware of that flag before reading your comment. This will be addressed in v3.


Yours sincerely,
Vincent Mailhol


