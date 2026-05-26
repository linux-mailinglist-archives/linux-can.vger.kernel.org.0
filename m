Return-Path: <linux-can+bounces-7707-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBhHEcTEFWoAagcAu9opvQ
	(envelope-from <linux-can+bounces-7707-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 18:05:24 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA3D5D9482
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 18:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D7203000518
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 15:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD0390C85;
	Tue, 26 May 2026 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFHyjCob"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5CE368D69;
	Tue, 26 May 2026 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811080; cv=none; b=gtDftM6CxEAL/lZ3MiYd2g+6oWlz4UtB5dSNQONGYRJkA4SjxYuX2lLOUr2ypwiaJsKRXUQ/51A+ZACmMBrTPlPeq8GnaBrLg9lxQU5jOIFxznj52TgtgFqjaHcalDG4NIoRMDyWQ6bleT7yVqHz3th1yL1152hmoKI+y4Dnw7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811080; c=relaxed/simple;
	bh=Ele+E0tQkfHRAao8H64HR6F68ewe7ulRXtIQ8P4KHYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTTi91qdBxBSXzCpxnVERoEZ30TQbXbOj19GmZF8YECVJ9WnzpR/MEwEdR6btN1MxSnBvlA8qGQ/Sh5A2rJytZinzOosalwLDvo4oraAgvrBbptNgF14baL/4VrSWNPk7GnqQs669shD6bF5/5vgLPyYzOzi1FhC3E1av3oyKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFHyjCob; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463DD1F000E9;
	Tue, 26 May 2026 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811079;
	bh=79tFNywJ1ujWM1ngLzbyRJb8vvTvJrlWsQKys4QTyM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FFHyjCob9W5eGLAeyPyOqWuc32kLdbwtTPW1L/MzM3/PVGFryHJVEVMVKiLONgfh/
	 eK8by759I2vHyBl63O8aDKG2+3Ot5BqcGF9ytC2kTz07KLzKbDhLPy281kN3JSJ5C2
	 MRwiHl2VSqc7vfsbI4RO4pZNRI9heBH/c8EUa2nhE02rfuwnV4VU4vuX+HNBwZ7iOv
	 XT579DOPnVr9hqWv/hIWH4m3JTVUoUrrWWLX94dhehUOahlbM0W3liEORGW2Jv2eqR
	 pBl2vq4n0MuMQ6GYZrQPe6wJYo0I4HKS+pHwVYvfFrxraDs9H0Ien5xphd0rIsIdAY
	 pSut3Kzm45Z2w==
Message-ID: <6ea756bf-d776-4eff-b0ca-eeaa6737e035@kernel.org>
Date: Tue, 26 May 2026 17:57:55 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] can: Add Loongson CAN-FD controller support
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen
 <chenhuacai@loongson.cn>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Bingxiong Li <libingxiong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
 linux-can@vger.kernel.org, jeffbai@aosc.io
References: <cover.1777273055.git.zhoubinbin@loongson.cn>
 <d7b19f6c1e634ffe4454809e73fb03058e7a1a9d.1777273055.git.zhoubinbin@loongson.cn>
 <709ef711-4af1-413e-9662-08892b18fca5@kernel.org>
 <CAMpQs4K5Q_vC=wnGp3gf=F5RU8t61PLh4dLEmcLMMbM4mR+Wnw@mail.gmail.com>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <CAMpQs4K5Q_vC=wnGp3gf=F5RU8t61PLh4dLEmcLMMbM4mR+Wnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7707-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DDA3D5D9482
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/05/2026 at 05:24, Binbin Zhou wrote:
> Hi Vincent:
> 
> On Thu, May 7, 2026 at 1:50 AM Vincent Mailhol <mailhol@kernel.org> wrote:

(...)

>> Use the CAN TDC framework to get the SSP value (c.f. struct can_tdc,
>> struct can_tdc_const and can_fd_tdc_is_enabled())
> 
> Last question:
> 
> In the general framework, the calculation condition for tdco is
> (dbt->brp == 1 || dbt->brp == 2), which does not seem to correspond to
> the current condition (dbt->bitrate > 1000000).

Where does the current condition comes from? Is it some empirical test?

FYI, the

  (dbt->brp == 1 || dbt->brp == 2)

check comes from ISO 11898.

> Although for CANFD, rates below 1 Mbit/s would negate the primary
> advantages of FD, from a controller hardware design perspective, I
> would still prefer to retain the condition (dbt->bitrate > 1000000).
> 
> Do you have any other suggestions?

Using TDC on low bitrates is indeed unstable and can lead to bus errors.
But the condition which you suggest

  (dbt->bitrate > 1000000)

is indirectly linked with the brp values. That's why the brp check is
sufficient (and more precise than the empirical 1 Mbit/s threshold value).

Are you able to trigger any bus errors when using TDC with a brp value
of 1 or 2 and a bitrate below 1 Mbit/sec? If no, there is no reason to
add this extra check and we can continue to rely on the framework test.


Yours sincerely,
Vincent Mailhol


