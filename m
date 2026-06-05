Return-Path: <linux-can+bounces-7759-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vJeDEUmkImqBbQEAu9opvQ
	(envelope-from <linux-can+bounces-7759-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 05 Jun 2026 12:26:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C156474E1
	for <lists+linux-can@lfdr.de>; Fri, 05 Jun 2026 12:26:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WuYKJMtt;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7759-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7759-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DA4E30FEA9B
	for <lists+linux-can@lfdr.de>; Fri,  5 Jun 2026 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6E13F44E4;
	Fri,  5 Jun 2026 10:11:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095D3F0ABF;
	Fri,  5 Jun 2026 10:11:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654306; cv=none; b=ftH+PBZH+oCkfoqpL11a4X7/NsuNZaz5+fvWm+r4jeoNSqPe4AhoVo3lmGc96hSfzheCsUf21G9Lv4XoLIBPEoKqx8TY4AoTsxAon7fJWEx6OVhSuP0X+6AfvqnnX8VcwfmtT3x+Afscvieq2U8g6hmELWzymRl8iR6RLs0bMAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654306; c=relaxed/simple;
	bh=+oSOPs6reVleJdmau1UD0l1OFs/hLRZSYZdSyznmc6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaiOkuJb4l/bBue38yupSKL8stIkyA6tDJeCCko5OqiNapIAX7JU7irdc0ZMpV1swmIoJnV7wACYyooZC4mmSztqyS+FS5gAQPN4ZOMyEIlBSIEBiWyqIqd8EKVxATJjKfb6IQVgtE/Qa7IaWa5K8cQ9gPxxy0xwCtg4uDsPOVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuYKJMtt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426A51F00893;
	Fri,  5 Jun 2026 10:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780654305;
	bh=aqkBQe41bV9bTC2QJ3RlElkystE3ub8D5XKqw3M77sk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WuYKJMttjplblCLncClf1gu5wappddlpic3N33kpJlzlKaJD0BWqHv4LaPNAbJ8Ax
	 LnQ0etd4FoLgpvQtaGElW5MiDG911N5/nkDtfGf6IvWjIQUhhYYhn0nuRmsENOZmgA
	 v2Am40yyBj/skYr8EkKUdvH7pXOsWdFMU2/VkwOzQ8Dx+3Hb24sgqYkTVIUPI3CWcH
	 kfkmmkjL42nFi7FBbmgjCHYSoF8R6Kg0Qt+aVUP3GlRv4kkb9x6G2QrMW+DeEtVeo5
	 JoRKmzE2m4QXwfZSFCjVVs/6s1LBcR9dSJmgVLM+qtJRA+bELS8T/9GlZJgknuSOdY
	 vfQF1ZO4iS75A==
Message-ID: <2e9662a3-1047-41b2-a269-8fcd3e30f8f9@kernel.org>
Date: Fri, 5 Jun 2026 12:11:41 +0200
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
 linux-can@vger.kernel.org, jeffbai@aosc.io, gongyifu@loongson.cn
References: <cover.1777273055.git.zhoubinbin@loongson.cn>
 <d7b19f6c1e634ffe4454809e73fb03058e7a1a9d.1777273055.git.zhoubinbin@loongson.cn>
 <709ef711-4af1-413e-9662-08892b18fca5@kernel.org>
 <CAMpQs4K5Q_vC=wnGp3gf=F5RU8t61PLh4dLEmcLMMbM4mR+Wnw@mail.gmail.com>
 <6ea756bf-d776-4eff-b0ca-eeaa6737e035@kernel.org>
 <CAMpQs4KfLP9z6TVx+xGzuW7KEXMRAC0Y59hMBUmq57x6U33t7Q@mail.gmail.com>
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
In-Reply-To: <CAMpQs4KfLP9z6TVx+xGzuW7KEXMRAC0Y59hMBUmq57x6U33t7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7759-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhoubb.aaron@gmail.com,m:zhoubinbin@loongson.cn,m:chenhuacai@loongson.cn,m:mkl@pengutronix.de,m:libingxiong@loongson.cn,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:loongarch@lists.linux.dev,m:linux-can@vger.kernel.org,m:jeffbai@aosc.io,m:gongyifu@loongson.cn,m:zhoubbaaron@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91C156474E1

On 04/06/2026 at 07:52, Binbin Zhou wrote:
> Hi Vincent:
> 
> Sorry for the late reply.
> 
> On Tue, May 26, 2026 at 11:58 PM Vincent Mailhol <mailhol@kernel.org> wrote:
>>
>> On 21/05/2026 at 05:24, Binbin Zhou wrote:
>>> Hi Vincent:
>>>
>>> On Thu, May 7, 2026 at 1:50 AM Vincent Mailhol <mailhol@kernel.org> wrote:
>>
>> (...)
>>
>>>> Use the CAN TDC framework to get the SSP value (c.f. struct can_tdc,
>>>> struct can_tdc_const and can_fd_tdc_is_enabled())
>>>
>>> Last question:
>>>
>>> In the general framework, the calculation condition for tdco is
>>> (dbt->brp == 1 || dbt->brp == 2), which does not seem to correspond to
>>> the current condition (dbt->bitrate > 1000000).
>>
>> Where does the current condition comes from? Is it some empirical test?

You did not answer this question. Where does this idea come from? Is it
an individual initiative from one of your hardware engineers or does it
come from any literature or research paper?

>> FYI, the
>>
>>   (dbt->brp == 1 || dbt->brp == 2)
>>
>> check comes from ISO 11898.

My feeling is that you were not aware of the BRP <= 2 criteria. That
criteria comes from ISO 11898-1. Was your hardware team aware of this
BRP <= 2 ISO criteria? If yes, what made them decide to not use it?

>>> Although for CANFD, rates below 1 Mbit/s would negate the primary
>>> advantages of FD, from a controller hardware design perspective, I
>>> would still prefer to retain the condition (dbt->bitrate > 1000000).
>>>
>>> Do you have any other suggestions?
>>
>> Using TDC on low bitrates is indeed unstable and can lead to bus errors.
>> But the condition which you suggest
>>
>>   (dbt->bitrate > 1000000)
>>
>> is indirectly linked with the brp values. That's why the brp check is
>> sufficient (and more precise than the empirical 1 Mbit/s threshold value).
>>
>> Are you able to trigger any bus errors when using TDC with a brp value
>> of 1 or 2 and a bitrate below 1 Mbit/sec? If no, there is no reason to
>> add this extra check and we can continue to rely on the framework test.

You also didn't answer this second question:

  Are you able to trigger any bus errors when using TDC with a brp value
  of 1 or 2 and a bitrate below 1 Mbit/sec?

> After offline discussions with our hardware engineers, we have decided
> to retain the existing decision criteria.
> 
> The threshold is set to `1 Mbit/s` primarily based on the CAN 2.0
> physical layer protocol, which supports a maximum rate of 1 Mbit/s;
> this decision also takes into account that at low baud rates, the bit
> duration is sufficiently long, so there is generally no need to enable
> the second sampling point. Conversely, if the CAN controller’s time
> quanta clock frequency is very high, causing the BRP to consistently
> exceed 2 while traversing parameters, TDC may not be enabled.
>> Additionally, there is a low probability of bus errors occurring
during testing.

Can you prove that the 1Mbit/sec threshold gives a *lower* probability
of bus errors occurring compared to the BRP <= 2 rule?

The point is that to be accepted, it is insufficient for your new
criteria to just match the current criteria. It has to *improve* the
current situation. Otherwise, more code for same performance means that
we just bloated the kernel with a useless check.

> So, in your opinion, should we keep it as is?

An important aspect for the kernel maintainability is to centralize code
as much as possible. If you can prove that your 1Mbit/sec threshold is
*better* than the current rule, then this check must go in the framework
(e.g. modify can_fd_tdc_is_enabled()) so that all the drivers can
benefit from it. If not, it has no reason to exist.

As much as possible, we should avoid driver individual initiatives, so
keeping this condition in your driver is a hard no for me (one exception
for local workaround would only be if your device has a defect which
need some unique logic for fixing).

So, either convince me through some tangible proof that your criteria
improves the ISO criteria (e.g. empirical test showing bus error
reduction when adding your rule) or drop the idea.


Yours sincerely,
Vincent Mailhol


