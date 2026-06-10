Return-Path: <linux-can+bounces-7810-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i77gAw0yKWreSAMAu9opvQ
	(envelope-from <linux-can+bounces-7810-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 11:44:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6009B667F4D
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 11:44:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b="b/jq4KOy";
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=dc7lYnXn;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7810-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7810-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F89C3258F7E
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141D73E0233;
	Wed, 10 Jun 2026 09:38:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380512F6918
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 09:38:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084297; cv=pass; b=jvbIOv0V6Xu0lP//3WYPByiQMsax9dMcyA8/OGVNirLdCDrl5pJb18BW4MVP70gI8EeXw6hn0M6iV1ZF0Oyx1mJ7Yj72G1xQqJFzONPSpmRCtHGXiKPGZNCfK8MXACtClVeqKcGKDGJ1j6E6/doyy5NwLm3NnvWwuxKLzkx1Xco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084297; c=relaxed/simple;
	bh=8Yj9BL+VGOezf97W3O1Kt6gfGUYs5mN7Fe5e4AaDoGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXCvJievBAKgSGQXErrcenNb30xN9QM5fi8rwWNiqy1emBkTtHV7/64wQrfUA3eOuWTx2wOHhCJsEpqx0MF/M/exb1KaH95pJV4escnMQjlcXf9swtf5LsSbLb2fiBkjaLVUyJiVGdb6YhWMfIpyDO0HOGdrDtV4oDSROx+DJr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=b/jq4KOy; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dc7lYnXn; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal: i=1; a=rsa-sha256; t=1781084292; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G6BoehJk8ZhZgnD8zsjm+JycyPdp9m729uE1M5gWS6SOmdHP+fQ6g2Bc8LmceYXFiA
    2/8kquoFkwqcGtJl8GBUuoTxX8HrfIrw/24OOldY6s7gtlyMqsu16a3obcmS74F6ogOB
    fPeWl4yI0e6C47oZgvY6cKsAq4xAwnoh4nvT3c87dUFf1ot8WvUUMb4piIg0mtWh8k8v
    6Zbwvo+7DYXoO2KtTH9uO15U0yWwpMMpwo78xHl54WhCc4NcpOOQFHCdFs3Mu4yArT7t
    2fBBNkt0ZYFVrM1xEbqP5hQI/AaO4HfwUWLWuMGikTy7I3CCu/YEjtqMspftp9QJTQuq
    XNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781084292;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eCSZZTqg0i2WylJCJaAbIzJktfm2LqzwOrcOBnvL8Qo=;
    b=X/tmyx0f7DyidxPDV1wsQveu2pnEOq+gjLDOSNfIU+ONxeddOqiyN74/70vh8k+Y8U
    nxfrnYsj43kLd1O5h+Rw2HSCWx9q/TJ607ZGvMw17CvAjgskwKLg3B1x03TXmZSSHZT/
    bXGxOgUV+K7j3gpQc++jAppmr6qpoeFGNDztJWms2kxwqzFY75yoyTPjtev/STWugnAB
    yaIIhVJhaqsM6lVbU93ZSxta4qrzR6zl/SkdRAm+mmRcQRntbh+bLcNzovJsFqJMIPNA
    u+czwtZqMQ9dgnayvvqljVVQWo7YvKqH1TrzPN1M5EUo8r0FOX3WJdtRWW8NU/nDqIlE
    HLAQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781084292;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eCSZZTqg0i2WylJCJaAbIzJktfm2LqzwOrcOBnvL8Qo=;
    b=b/jq4KOy1SkJ/zJDWhSz2Avxd/E0T1PR7qvJ6hUtwO/6yTjvNnca3emEq/iNPsZtFw
    d52bA21V5+JbzIqs/sODnK4ojvnEsfSqjQ/vpLNJf3IIxYgOBF81RLefx1eQw8FFbOFf
    MhWOML/RjV/J+eGN4MnXcuKkm0k2TiXS8P12r//uvVhbbdiLB50Mbbizq4A5MaUuxqFq
    dO5kPSaivTeZUvsPic0NAgw7t0mmrtzBhw7I5sU3FpoM/QvFLM+j5V99IKQ1IpANTnH1
    BsOpAw/Wz3SPaL16s5avBl4P6lxX9X0cApeHRH1oyFm6FQwp0biUv3d0jTdFEH1h2U3D
    WpRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781084292;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eCSZZTqg0i2WylJCJaAbIzJktfm2LqzwOrcOBnvL8Qo=;
    b=dc7lYnXnHD5e+lAIqDVUSx3LM8Sf82N+NLk6vtZ1JCCbfXiwImSNkyE+OI2/VNxQtt
    9iZRGjT/4T84rlcmAMDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25A9cBi5m
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Jun 2026 11:38:11 +0200 (CEST)
Message-ID: <3ac08afc-a1a5-419a-a221-5e719fb08cf7@hartkopp.net>
Date: Wed, 10 Jun 2026 11:38:11 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] can: bcm: use atomic access in receive statistics
To: sashiko-reviews@lists.linux.dev
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260522180758.51128-3-socketcan@hartkopp.net>
 <20260609184528.405221F0089B@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260609184528.405221F0089B@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-7810-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6009B667F4D



On 09.06.26 20:45, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Converting `frames_filtered` to `atomic_long_t` introduces a signed integer overflow on 32-bit systems during procfs statistics calculation, producing bogus corrupted percentages.
> 
> Pre-existing issues:
> - [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition in `bcm_proc_show()` can cause a division by zero and kernel panic due to multiple lockless reads of `op->frames_abs`.
> --
> 

Correct!

This patch is now superseded by:

[PATCH] can: bcm: fix CAN frame rx/tx statistics

https://lore.kernel.org/linux-can/20260610093422.39847-1-socketcan@hartkopp.net/

which addresses the found issues.

Many thanks,
Oliver

> commit 6749d4fcb2595ae8bc232f3dd041a194ebd9a9f4
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: bcm: use atomic access in receive statistics
> 
> This commit modifies the CAN broadcast manager (bcm) protocol to use atomic
> operations for rx statistics. This prevents a data race detected by KCSAN when
> multiple CAN frames are processed simultaneously by different CPUs.
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index dbdf5d4f4ed7b..8a2cb766603dc 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -228,7 +229,7 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>>   		unsigned long reduction;
>>   
>>   		/* print only active entries & prevent division by zero */
>> -		if (!op->frames_abs)
>> +		if (!atomic_long_read(&op->frames_abs))
>>   			continue;
>>   
>>   		seq_printf(m, "rx_op: %03X %-5s ", op->can_id,
> 
> [ ... ]
> 
>> @@ -250,9 +251,12 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>>   				   (long long)ktime_to_us(op->kt_ival2));
>>   
>>   		seq_printf(m, "# recv %ld (%ld) => reduction: ",
>> -			   op->frames_filtered, op->frames_abs);
>> +			   atomic_long_read(&op->frames_filtered),
>> +			   atomic_long_read(&op->frames_abs));
>>   
>> -		reduction = 100 - (op->frames_filtered * 100) / op->frames_abs;
>> +		reduction = 100 -
>> +			(atomic_long_read(&op->frames_filtered) * 100) /
>> +			atomic_long_read(&op->frames_abs);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does reading op->frames_abs
> multiple times introduce a Time-of-Check to Time-of-Use race here?
> 
> bcm_proc_show() in net/can/bcm.c first ensures op->frames_abs is not zero.
> However, concurrently, bcm_rx_changed() can hit the overflow threshold and
> reset it:
> 
> net/can/bcm.c:bcm_rx_changed() {
>      ...
> 	if (atomic_long_read(&op->frames_filtered) > ULONG_MAX / 100) {
> 		atomic_long_set(&op->frames_filtered, 0);
> 		atomic_long_set(&op->frames_abs, 0);
> 	}
>      ...
> }
> 
> If this reset occurs precisely between the initial non-zero check and the
> division above, could the denominator evaluate to 0 and cause a divide-by-zero
> kernel panic?
> 
> Would it be safer to read the atomic values exactly once into local variables
> at the beginning of the iteration?
> 
> [Severity: Medium]
> Does changing the statistics variables to atomic_long_t introduce a signed
> integer overflow on 32-bit systems?
> 
> atomic_long_read() returns a signed long. The expression
> atomic_long_read(&op->frames_filtered) * 100 in bcm_proc_show() now evaluates
> using signed 32-bit integer arithmetic on 32-bit systems.
> 
> While the overflow prevention in bcm_rx_changed() caps frames_filtered at
> ULONG_MAX / 100, multiplying by 100 when frames_filtered exceeds LONG_MAX / 100
> will overflow the maximum positive value for a signed 32-bit integer.
> 
> Dividing this negative intermediate result by frames_abs yields a negative
> number, which corrupts the final reduction percentage.
> 
> Should the reads be cast to unsigned long before the calculation?
> 


