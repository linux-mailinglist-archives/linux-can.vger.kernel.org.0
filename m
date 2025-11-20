Return-Path: <linux-can+bounces-5508-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6A7C73B3C
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 12:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id BF3102AB94
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 11:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E62D331A44;
	Thu, 20 Nov 2025 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nHnpA4Nr";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="SO8KsC7K"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E138032B9BD
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637715; cv=pass; b=PLqEUhPqnoYEmxZkQsFFHZRhdqyT1ioBek7Nno4YSz7cfbJBwGBWYPwW9l7YX1uGn6AgtG1rKGH4Hif41l9g+JBNKAXme4X5xct6hHnah6+yMKO+D0jhOIclgEJoss/SQLrhs+idh5Xs/7wAC+rs/EDqvyESykGkxLPEki4+mfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637715; c=relaxed/simple;
	bh=ZPvsNgfLQRpaDRsxrz/4JC4FzLEc1urcdk7c/ksOHtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CV84/L2IH+ZXCn0EqKIdIhyKbpXbR7VMxGTZk1MS0E5ybyg4a6y/p1kbNBWuXhUsdZcd6ai72WzSE2pDcjMKPtqGo0/+Vhe+sPhUinhQbbLTigmzI7R9Tg8TNcxel5cO+8VmHadRGK+dZ38JCueD29Jm8OF3fZ42BC15veIuphM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nHnpA4Nr; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=SO8KsC7K; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763637694; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r0hJa0VLa5hADcsOIYgIiB+kINm3JuswhdEmJPxMkCq5I5ga428bvLu+3wGciuXk9P
    sFwxSrr0ObWUcfuAFqwqiKEz2anvmNUXPb8AbVAxQ4tONhBuqSB+BHJp13QB2k8+ejwI
    5KrxaCvTKX0lQ/kF8v0Cd9r/PgmYXWxFZaNr94L19nw7hQE35Y3LxjTjlSzvg+QnPZkS
    I+5Hn6BeVvh0qCp+j2DR0DuUW9jFcpqPYrgJ6Pt+1FtPcYVGHa9Dl+i12nx1qEFOzOEE
    zHlY0LvNTFhwum9OcErb6waZ759i0VlzS9td479mCj/U9fKNZ66UDHJJar2aXQYoGaOL
    slUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763637694;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BK9baou2gHF94FcUWE80A1b4N/oI2mjffMSo234NJ/M=;
    b=YAwlXDZgog/lI6FMOP8o+dyAct2JD8OSOpdUBPIoYwvAATKfHB+utP30iCsGIZAW+Y
    VFP7gKKmUEiULxjUfx6Mf5R60iP38GrS2K6CBQuwKnD1YBosXRUh0gTiyOMObdGnVWZF
    KZZMyD9Dq63AI7BtNSbPezgCWLDLqsNfv83USM/kgUUf33mAOAGXr874GJjMZY1vB8Z3
    9msra1EvzBeFP4kWvEFzT31CPlvZ1IFC9OiuVOffZd9jhukP2PwffUrT2GKx1XZHxsi1
    78IJXrNRfkXHe17r7qTYd+ukaTWkYuhencdY0KJpOk3v5SFnmj9N2F5qfzuGb/cxMedB
    MkZQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763637694;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BK9baou2gHF94FcUWE80A1b4N/oI2mjffMSo234NJ/M=;
    b=nHnpA4Nry0nW15KGap1ETRxKFzJcMOVRViP0lYYRsm0P0q1jWMhddE5AYkv17n35fA
    elTBF+P4e1U1/O2HV1N/4kJM0AXtPmbLblRWCzJdwqbFa8tyGCd/rx7f5faDd4hwuot7
    UIvhtsymkmhp0e7Evnd6y5Ius+h9RW6CCq9QrHcFmIznNYi/7rUHfXtnuPfVsGMbCsEZ
    e/k1aGnFHdpbGisAXQJqJC04Fn0eJtQMmDFeL58OkcbiwluxQgpLxcNF7odhBVrbYj++
    cLXRKVVBKt6R+l4/MQrrh8kWoJKtl/mQcLqfCuKaYBivGrMV5DPa2Q3H5AbWdPD/jB9f
    XX7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763637694;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BK9baou2gHF94FcUWE80A1b4N/oI2mjffMSo234NJ/M=;
    b=SO8KsC7KOiwz+l3WmzGWyIiSBXUbrVWIveuFP7j6Yy9tWP4SNji8LAg5WS07q0OA7c
    E+ZtPh24pljgOM9r2vAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKBLY6Xg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 12:21:34 +0100 (CET)
Message-ID: <8dd16828-97cc-4562-b460-a9c76fca716c@hartkopp.net>
Date: Thu, 20 Nov 2025 12:21:29 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mainlining of [canxl v2 00/15] CAN XL support for review (full
 series)
To: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
References: <473832673.673623427.1763634854731.JavaMail.root@zimbra65-e11.priv.proxad.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <473832673.673623427.1763634854731.JavaMail.root@zimbra65-e11.priv.proxad.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stéphane,

On 20.11.25 11:34, Stéphane Grosjean wrote:

> Only small nitpicks from my side:
> 
>> - make RESTRICTED a normal ctrlmode_supported option
>> - make TMS a normal ctrlmode_supported option
> 
> If I understand “normal” (for RESTRICTED) as an option that is not solely linked to CANXL, I no longer understand it for TMS. Could you explain please?

Right. The RESTRICTED mode is not linked to CAN XL but is intended to be 
mandatory for XL nodes. See Vincent's commit message:

https://lore.kernel.org/linux-can/20251115163740.7875-4-socketcan@hartkopp.net/T/#u

OTOH the TMS option only works in the CANXL-only mode.

My change to the original TMS patch from Vincent

https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/linux.git/commit/?h=b4/canxl-netlink&id=c931f5efd2ec0e6cdabc968d67f8a758519e736e

is, that I removed that TMS always has to be set on the ip command line.
You needed to specify either "tms on" or "tms off" when "xl on" is set.

Now TMS has the default behavior again. Like any other ctrlmode flag it 
is default "off" and can be set with "tms on".

> The BOSCH communication refers to “pure-CANXL” mode rather than “CANXL-only” mode as used here. Is this an intentional choice on your part?

I have no strong opinions about the naming here. But "pure" sounds like 
pure water to me ;-D

>> Open discussions / review results:
>> - not removing "const" in can_update_sample_point()
> 
> This topic has nothing to do with CANXL, and I have already expressed my opinion on it: “const” has its place in the parameter declaration of a function in C.

Right. But this was a discussion when Vincent removed the "const" 
statement where Marc and you wanted to change that back.

https://lore.kernel.org/linux-can/20251117-transparent-exotic-myna-bd77c9-mkl@pengutronix.de/T/#u

>> - have the ctrlmode names in ip feedback messages capitalized
> 
> The use of capital letters here is simply a matter of adopting the formalism generally used in C for constant symbols. Which itself is inspired by the formalism generally used for acronyms. I don't see anything else to add here. IMHO.

Agreed! Thx!

> And finally, as little as my opinion on the various patches in the v2 series may be of use, I didn't see anything terrible. I did have some doubts about:
> 
> [canxl v2 08/15] can: bittiming: add PWM validation
> 
> +        if (pwm->pwmo >= pwm->pwms + pwm->pwml) {
> 
> but it turns out that >= is actually more sensible than >

??

Would you suggest

if (pwm->pwmo > pwm->pwms + pwm->pwml)

instead of

if (pwm->pwmo >= pwm->pwms + pwm->pwml)

which would also fit the error message?

"PWMO: %u tqmin can not be greater than PWMS + PWML: %u tqmin",

Best regards,
Oliver



