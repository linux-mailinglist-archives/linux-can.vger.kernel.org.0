Return-Path: <linux-can+bounces-5458-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC11C62F21
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 09:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB1534E8215
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 08:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772912EA15C;
	Mon, 17 Nov 2025 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="PIkcDPjz";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Zz5nn+f8"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEAA30C631
	for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763369012; cv=pass; b=BthfErULU8TqAsxpEUDfVrnADvlq4so1W7RgxeRyi3V83hzGTGyt2LuHc4bTnIBUwL9w1nxODcdQYjr062wZJELfHE+v62j6y53kWDBOfQOWxjCfvVxXfeHC3hwxssX8zqogvYpmPldqiqTw8F9Ql4XvdOZu8F2wvWEAlbv17ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763369012; c=relaxed/simple;
	bh=cRuOWQUKIP4GD3HQEpvm3zvbjS7zO7UduKSUSXtbrxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLeWfaI4OOqIB8nDYoZgr4cTTzcPNtx/ouk6j2Jw5jeQKbckSiA7drLQw5HAuujR16BopNiVEGXFFadRqgU/HSXZyC4RXJ61gEvAHUmsQXH15UZ+LjMPBR1SjZ091DR71CblF2nHBddF7cfArpyb9dR05oCtx+AAVs67Rh300aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=PIkcDPjz; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Zz5nn+f8; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763368821; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dMV96i4FH3uys1yQpWyA8+Idcxkq0jK9cXlIo2Ug9isAL4PcFFd5mfnKoVe+JykRUT
    SYdy2WOlfYgTdohmg4RGuu1NxGWazVE5Yvj67YJjIK0iL1H8wOQjmpA46xmlAPkUs8jb
    XeVMo+z3fWkFl4MVKJHfVQMx0MydZDI0XjPJdyadJwIirjxRSiAvZCYU2CPpFiWZRnXe
    6VgvNCu5mvezo3RJct0q7IjQxBfWnRrkGwm4XIqWzFUqV1/Yt4PAxIzHyHzDdaLsxPFX
    Ul81mbuAU5ad2XM96pDHRDr91U7aFEb9uc7y1/knUL73Ght7ctQAxo0ie9aUfJJs9O5W
    +C1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763368821;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=jTwVZbKkkjiP6AKGIkVNj7Ue7bEM9V36Qxf7qwyM+t0=;
    b=JVn2qxz+yuaGJKOBJnS8HCnXCal5TCth5IpDerjLxAxDgfMb9LxD9c1rE5wTnN26OC
    jl7txJ8bjO5biSi8weeCXkoNi85HZux719UUXALDJMwqBp6MiUCwx9YtmDlUj6o3UC3g
    LYOXnVD+D62c6ud8h4bDAv5uX73VBgEyh5X9g5YElEoIwpOqUPh2mNjUgIAeOamYwvSX
    Zlh0qijuxcyRgZdy52zxdToO+JFJH+dyiTgUo+jpcpDlse8hLH8X/Ay6GrVugde61LXf
    Jl8ev2FbtXjQFSKwQfNCPZcdkgkY7KoEdsa2UKc1OP6q43umh2yHoLbxQMNF8c7OrTQq
    jfkQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763368821;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=jTwVZbKkkjiP6AKGIkVNj7Ue7bEM9V36Qxf7qwyM+t0=;
    b=PIkcDPjzJwraIG0WMtdKKN7Rdj8ubxpgPm8RhbEedldh41dlg8+AAoB9hmQdLLRCxu
    y279ElMk09kBm9UnnxaJsv8nNhqwE8Z1tMB7YUZhTTPdi2NbA7jQH5DJG+qm/QyOG6lA
    Y5k9ZWXrOu+GLclw9vM+kkoS1rLZxNybI6uChb0CigidgrSCGBEvBt5AVIIFQXknf18Z
    ogsnlrRWp6UyXTQOIlxjuoi4orDx4Gkv7x+UcIQ59lznouxXfR7SBVIyz0wtwpR8wDdW
    RlGJ8Orl/6Z4KhEaPgIZl1qwNvp0QPD7jl5qiBSGPwKdTK5NL525SkQwuOeWKXambkvc
    +RYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763368821;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=jTwVZbKkkjiP6AKGIkVNj7Ue7bEM9V36Qxf7qwyM+t0=;
    b=Zz5nn+f8FJFNqglOs8WAhqwq6ym/BcF7HzVAn3VWXlYnUfLKxS97Tm1Fl2OaRKfwtz
    vWazGvAgjOeED09+57DA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AH8eLjaI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Nov 2025 09:40:21 +0100 (CET)
Message-ID: <cf86b798-c8d5-42fb-a03a-1235720c7ee9@hartkopp.net>
Date: Mon, 17 Nov 2025 09:40:15 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v2 05/15] can: netlink: add CAN_CTRLMODE_XL_TMS flag
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20251115163740.7875-1-socketcan@hartkopp.net>
 <20251115163740.7875-6-socketcan@hartkopp.net>
 <c77caed0-5d88-4b2c-b371-3e2870324b4d@hartkopp.net>
 <8788fd27-8998-4dbc-98e9-1bd9557d15e9@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <8788fd27-8998-4dbc-98e9-1bd9557d15e9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 16.11.25 22:54, Vincent Mailhol wrote:

>>> +            if (tms_conflicts) {
>>> +                NL_SET_ERR_MSG_FMT(extack,
>>> +                           "TMS and %s are mutually exclusive",
>>> +                           can_get_ctrlmode_str(tms_conflicts));
>>
>> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 dbitrate 2000000 fd
>> on xbitrate 4000000 xl on tms on
>> Error: TMS and fd are mutually exclusive.
>>
>> The error messages should look consistent in terms of capitalization.
>>
>> Maybe can_get_ctrlmode_str() should deliver capitalized strings as we see it in
>> the 'ip' tool output:
> 
> In a full English sentence, I tend to see ALL CAPITALIZED WORDS as kind of
> aggressive. 

Really? Kind of aggressive?

This is not a poetry contest here.
We are talking about error messages and warnings from the ip tool, that 
already shows the specified defines in capital letters:

	can <FD,TDC-AUTO,XL,XL-TDC-AUTO>

Take a look at:

"TMS and fd are mutually exclusive."

fd = file descriptor? It gets lost in the text.

or

"Listen-only and restricted modes are mutually exclusive"

Where do you find the defines you know from 'ip -det link show can0' ?

"LISTEN-MODE and RESTRICTED modes are mutually exclusive"

(..)

> This is typically the kind of thing where I prefer the lower case. The above
> seems as if the error message is shouting at me.

Maybe the problem is on your side then. For me it looks fine. I'm robust 
against error messages shouting at me to clearly show the defined key words.

> Well, if you still prefer upper case after my explanation, I will change.

It is not about my personal opinion. Not finding the known defines in 
the text gets an usability score of -10000.

Best regards,
Oliver



