Return-Path: <linux-can+bounces-8077-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9AIbAUjxTGqAsQEAu9opvQ
	(envelope-from <linux-can+bounces-8077-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 14:30:00 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4864371B5CF
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 14:29:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=kZ1pYNtA;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=FbmrGRnw;
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8077-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8077-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCAD6300F9C4
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 12:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD3530D407;
	Tue,  7 Jul 2026 12:26:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB13FF1AC
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 12:26:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427215; cv=pass; b=rvxIyoin38Nnj8kd1l9xlfY6UpX6tvaycVdvs0/mTFFztjNrSvI/OHC9L3RX9jXB/Qu9gtPtLhFKQ2baXcmcWCYZfr3BfQGX1lYzBxgFECFnBe8LuU9eXz8m2wYBXX2xxAvQkNuySG/8dK25NhqV8jXWWuZRf/qM/agplWyO9bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427215; c=relaxed/simple;
	bh=uW3L9D1LjITsjuGOS0+yoTYtaO4LQhiM71qcWZaD9WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIrfUPfEu/qUBiQwL6WjpTJKKL6pWQKpX5649VO8ThCejEpfZ0pKY+bfB9SEWU8Jb1wwFJeAzmQsJY5J0vYHX3GlrBBdK2fZa4i+kD11SZszPjZdFgFJJVcXlsHIlvh42M1QCnTcl9t90W2HzVGUeWRQpObin2Tg8scln+jCZoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kZ1pYNtA; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FbmrGRnw; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal: i=1; a=rsa-sha256; t=1783427029; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=P9lio/RFBCaeREOBdGVox4VATevIS8tzkLt/KUdY49nQgAqyDL2FyvohDxcTuBaJPW
    HZ+CNE8IOHdsYXfFCwGpTBISKBzr3POssWLvUUUZTI0qFAmtxkFL4yqpleJF7D6iZFzp
    Tnf2MfLxbR/frjdp9IpJiLyKO566v/5QCHp6Vmgcq3O8L5dJnQd26hWUycW50zlj5QTa
    FrpEnoSdCVjD7piIl5aACZKb+Dzd4Z9Ok5fMWLT+OLMLUUJ85DsUDl3WNckbtTxJn4iM
    I/Gjz0zDg8lWmiDHj6tq2U0mx/21J7ryIX8d3rW6qaPbkrLZtQKXOx9HVkEydmEFNv3+
    z/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783427029;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8b0tkocE/IM9WIjFd3EHZ5WIFmbn4qTdDJaLiGlXZ/M=;
    b=d/QFSlpmTMl+PZpJHp2yASkKtuSFSoKKr37pFVB+NIHPvn5t9FILxsjsVFhfDewBuO
    SSy0JYxNEjGGM4xSfXdntNYxGeFxqiLKM+MjB99wytVgoi17H9iEE5FZ1Af1nT1Gt26p
    HrsWQC672fg3wt2UZSOGOgVuI235YRgREISJKDEYY8M9ZtLbqVKZXMRIsos/ci41fKgp
    MIxsEdlPVW5nI82w+ZoN8ofCKIm45cbnBlBSPELJXV4vxWfPTW2FTE40PwBmczG3mZPw
    nrB/q3yDfxRAcmn6ZtyGA/bV5tjTWdNCRq4UmEQIjAPsVcTDqTqeLat/enmqc96gy2uU
    /35w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783427029;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8b0tkocE/IM9WIjFd3EHZ5WIFmbn4qTdDJaLiGlXZ/M=;
    b=kZ1pYNtAz+RH2LHg46WLkcx4wu9Xg6mclSyf8rhIbEB7QSVK/BjkimcEkHnKUKGpGE
    H8mLZ9hLIIvsqcU7ZqLq0gg59ths09r0b1ZGJUIRBYJ5xFsftUkuPOmjHVNmup/eb0GO
    F1z1br9IAVJYuh4LeUn7kKwV2NEkphqUByWt1QcvRT75wMCbAEhgkrPmCSsjkeA0CN23
    9GpksY+Iouo0isr86UqzGREa6fcfHnpvidZ3h79tb35mX1/X59ikvFicX9w6k2d7FGPM
    ZMQe+qfEndupcYdEYUlEz5oTWYAQi+TLqGJUgyRgpPOtdc9z9bXpLVSSVD2eIERu6WlE
    pPJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783427029;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8b0tkocE/IM9WIjFd3EHZ5WIFmbn4qTdDJaLiGlXZ/M=;
    b=FbmrGRnwCyObukvqwvtwFwQ+3LI4IrTnKmWX1A1CSKWi7bBMSHjngEBAac022nCuzC
    v5o7Zh9ISqZ+ZINbS/Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.154]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb267CNmTQU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 7 Jul 2026 14:23:48 +0200 (CEST)
Message-ID: <cf9d0adf-62c8-4bfa-8cfd-304d22c05e7d@hartkopp.net>
Date: Tue, 7 Jul 2026 14:23:48 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] can: bcm: fix CAN frame rx/tx statistics
To: sashiko-reviews@lists.linux.dev
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net>
 <20260707-bcm_fixes-v3-4-84600ca6d889@hartkopp.net>
 <20260707103714.9A6AB1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260707103714.9A6AB1F000E9@smtp.kernel.org>
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
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8077-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4864371B5CF



On 07.07.26 12:37, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] A Time-Of-Check to Time-Of-Use (TOCTOU) race during statistics reset can permanently break the invariant `frames_filtered <= frames_abs`.

Fixed in V4
> 
> Pre-existing issues:
> - [High] Missing RCU publish/subscribe barriers for lockless list operations, risking uninitialized memory reads in procfs.


Fixed in patch 5:
https://lore.kernel.org/linux-can/20260707-bcm_fixes-v3-5-84600ca6d889@hartkopp.net/

> --
> 
> --- Patch [4]: [PATCH v3 4/7] can: bcm: fix CAN frame rx/tx statistics ---
> commit faeade145d2ba64627aca2f6af5f2b0b8ad0d933
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: bcm: fix CAN frame rx/tx statistics
> 
> KCSAN detected a data race within the bcm_rx_handler() when two CAN frames
> have been simultaneously received and processed in a single rx op by two
> different CPUs. Use atomic operations with (signed) long data types to
> access the statistics in the hot path.
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index fd548c6eaa913..0378e31ea10ed 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> [ ... ]
>> @@ -280,7 +283,8 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>>   			seq_printf(m, "t2=%lld ",
>>   				   (long long)ktime_to_us(op->kt_ival2));
>>   
>> -		seq_printf(m, "# sent %ld\n", op->frames_abs);
>> +		seq_printf(m, "# sent %ld\n",
>> +			   atomic_long_read(&op->frames_abs));
>>   	}
> 
> [Severity: High]
> This is a pre-existing issue, but does this function safely traverse
> the lockless tx_ops list?
> 
> bcm_proc_show() traverses bo->tx_ops via list_for_each_entry() instead of
> list_for_each_entry_rcu(), which lacks the necessary subscribe barriers.
> 
> Additionally, neither bcm_tx_setup() nor bcm_rx_setup() use list_add_rcu()
> when inserting into these lists:
> 
> bcm_tx_setup()
>      list_add(&op->list, &bo->tx_ops);
> 
> bcm_rx_setup()
>      list_add(&op->list, &bo->rx_ops);
> 
> Could reading /proc/net/can/bcm/<inode> while another thread concurrently
> sets up a BCM message on the same socket result in traversing uninitialized
> memory due to missing RCU publish/subscribe barriers?
> 
>>   	seq_putc(m, '\n');
>>   
>> @@ -290,6 +294,15 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>>   }
>>   #endif /* CONFIG_PROC_FS */
>>   
>> +static void bcm_update_stats(struct bcm_op *op)
>> +{
>> +	/* prevent statistics overflow */
>> +	if (atomic_long_inc_return(&op->frames_abs) > LONG_MAX / 100) {
>> +		atomic_long_set(&op->frames_filtered, 0);
>> +		atomic_long_set(&op->frames_abs, 0);
>> +	}
>> +}
> 
> [Severity: Medium]
> Could this non-atomic reset allow other threads to interleave their
> increments and permanently break the statistic invariant?
> 
> If Thread A hits the LONG_MAX / 100 threshold and begins resetting the stats:
> 
> Thread A
> bcm_update_stats()
>      atomic_long_set(&op->frames_filtered, 0);
>      atomic_long_set(&op->frames_abs, 0);
> 
> And Thread B is concurrently processing bcm_rx_changed():
> 
> Thread B
> bcm_rx_changed()
>      if (atomic_long_read(&op->frames_abs))
>          atomic_long_inc(&op->frames_filtered);
> 
> If Thread B reads a non-zero frames_abs, then Thread A resets both to 0,
> and finally Thread B increments frames_filtered, wouldn't frames_filtered
> become 1 while frames_abs is 0?
> 
> This would leave frames_filtered greater than frames_abs, causing the procfs
> output to display negative reduction percentages.
> 
>> +
>>   /*
>>    * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interface
>>    *              of the given bcm tx op
> [ ... ]
> 


