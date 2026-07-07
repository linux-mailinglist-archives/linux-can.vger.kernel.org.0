Return-Path: <linux-can+bounces-8076-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rF96MQ/xTGpzsQEAu9opvQ
	(envelope-from <linux-can+bounces-8076-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 14:29:03 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B883671B5B0
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 14:29:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=cnP6MREG;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b="/hnyQDwS";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8076-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8076-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06BE03013C70
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 12:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721993FE362;
	Tue,  7 Jul 2026 12:26:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D55D30D407
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 12:26:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427206; cv=pass; b=I3M6uJrZafiy9UCRUdTqOEKg8JEiPNXxyyQLWcYUFCYSVBaSwrRWy3y1N1GTdttB+FyCtE5Wrks8XMIDjd8S9VHRAZkjPWnWfwbxYbD4uq+b2a7C8f2J+OUGHzFz0BNG2bsUXUr+EVFaOWqvUe/nOF0qiSwffGL+pfWQHqdRRUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427206; c=relaxed/simple;
	bh=gliTLLYedljJc4FRxomtiKotRi00Uow2q3LJI+cD26o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/n3h0WWa1Cuuz/ux4ryyjQihBxHMug1Fh55ssLSG1KDnIBFP2RULfQwL2gj6HMizq1CSYyclTjh5HH4GL+VdM0aISX5otoRIVi0x+MZ6dlbL+gT5jiEW6cxQaOSPQDFDRhcCQT0zp9RrwRJg+GVVrIRMWG9h4TIkwhBG9qqzns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=cnP6MREG; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=/hnyQDwS; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal: i=1; a=rsa-sha256; t=1783427193; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=X3V1xgyB3A1Dwi/l2d3jXbl8vowm5pFFPZqu7rXlCC6JzxIrUDKhDXE6HRnnrt+kfc
    hDj2QgIfPq0haO9xCskijMsqXMhvGm5ih7YcWduUfK4FfwmpJLe8HJYBqGLKT2jS6dJV
    e8xnGeH6fZvUaI754lQap/HoDWy+QuyIGwVB1Rv9Y/teNAwO6XAj2DwvHWiABLyg91ez
    OcKj+y2CEuXX6VD75xKriE67Ep4y70qwDEk53UHopOAGQJ9TbQxfDcRuEhud/bz4ei8s
    rJ35E/TkzDC7r1yML/n5eFK3UbDPeE2H7WaX69LOadwbMvWx+WvNiGuYvB8yVdvKnTcq
    Oi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783427193;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FNMWDUzgZmiq1suTeYc9IjjM5TKoT5Okj/bgFPcVwKQ=;
    b=Rq+QPBYy2xnMJ7zKQcVmq+Q+B33q5T8f+mAqZltgEJKwBKPlxzCe9kK8hWRpJFuPtx
    CTzfyaU5thFRwKAEgjk7oJ61fU9QI1+54OmNYdF8a+gkYFRSmyEF3KtkkpBdhksGKVdq
    /qV63MuHzMxQeUYKO/T2wri/psy+vMVy5STOdhjg3V2bOIrSy3x/mE/qV2FjH/WgQAnl
    bbJsdJJuuWq/L4JVdjd/AtIdAETaqH8lMakUbdHmDVykc3gcClY0uzMLxKebziMP9sOk
    FAkxa+msbHCjKc97R11Oui3Xo9TUDeMn+Pyi3Y4/2zYbiB63HEFoQp3h+jxKvwzt9L25
    iZ6g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783427193;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FNMWDUzgZmiq1suTeYc9IjjM5TKoT5Okj/bgFPcVwKQ=;
    b=cnP6MREGkIjTrf9U9fEWsJYCfFU5tvDKAZrmihoNySZucVmGPQKL8ieW7At44C+DUO
    oWg961JrjUcN583frIqVQlVXT7h8i7BwEyJdx+M1T9+thwNOpHXrXPSN25DvULI4ghvJ
    TVQcElJUBrrIrefj2uc9lR3Fg1gFQNjgIXPzKOW+QYb+Sh8sCVH7V5iYWs1XGbPykhNt
    oXLZlXG64eXeQPblOiFApgWUYFxgv7odFYH/Ck+nUGCz3EQFai1IoxvFJgHYn4YhPgNV
    6I2M5TJIaHGxnPu7YkzTBrMvgTrPvviFU/XtLUrpqQmm7/FMO19fczqRVc4KlH/5qEdK
    ZTMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783427193;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FNMWDUzgZmiq1suTeYc9IjjM5TKoT5Okj/bgFPcVwKQ=;
    b=/hnyQDwS7p84q56Xfjg19aXPipdsSU6+6f7GlpwhGomLjUPj9QVfYZ0oimOjsHSV4Z
    Bd40BX2W2vr/MNbeJnCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.154]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb267CQXTRQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 7 Jul 2026 14:26:33 +0200 (CEST)
Message-ID: <465316b7-4019-42a8-8704-e36954615f10@hartkopp.net>
Date: Tue, 7 Jul 2026 14:26:32 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] can: bcm: add missing rcu list annotations and
 operations
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
References: <20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net>
 <20260707-bcm_fixes-v3-5-84600ca6d889@hartkopp.net>
 <20260707104250.BEE571F00AC4@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260707104250.BEE571F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8076-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B883671B5B0



On 07.07.26 12:42, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Lockless reads of 64-bit ktime_t values and TOCTOU races on op->count in bcm_tx_timeout_handler
> --


Fixed in patch 6:
https://lore.kernel.org/linux-can/20260707-bcm_fixes-v3-6-84600ca6d889@hartkopp.net/


> 
> --- Patch [5]: [PATCH v3 5/7] can: bcm: add missing rcu list annotations and operations ---
> commit 8310d786e9cc8e49f889c95c47438e852dd137cc
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: bcm: add missing rcu list annotations and operations
> 
> This commit moves list_add_rcu() calls to the end of the setup code to cover
> initial settings and fixes the missing list_del_rcu() before bcm_remove_op()
> in bcm_release().
> 
> Link: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.kernel.org/
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 0378e31ea10ed..f21d48d99aab6 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> [ ... ]
>> @@ -1159,6 +1159,10 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>>   		op->flags |= TX_ANNOUNCE;
>>   	}
>>   
>> +	/* add this bcm_op to the list of the tx_ops? */
>> +	if (add_op_to_list)
>> +		list_add_rcu(&op->list, &bo->tx_ops);
>> +
> 
> [Severity: High]
> This is a pre-existing issue, but I have a question about concurrent access
> to the timer and count values in bcm_tx_timeout_handler().
> 
> When a userspace application continuously updates a BCM TX op via TX_SETUP,
> bcm_tx_setup() updates the op's timer and count values.
> 
> Concurrently, if the timer fires, bcm_tx_timeout_handler() reads them
> locklessly in softirq context:
> 
> net/can/bcm.c:bcm_tx_timeout_handler() {
>      ...
>      if (op->kt_ival1 && (op->count > 0)) {
>          bcm_can_tx(op, NULL);
>          if (!op->count && (op->flags & TX_COUNTEVT)) {
>      ...
> }
> 
> Can this lead to torn reads on 64-bit ktime_t variables (kt_ival1, kt_ival2)
> on 32-bit platforms, resulting in a bogus timeout value that breaks cyclic
> CAN frame transmission?
> 
> Additionally, could a TOCTOU race on op->count cause the handler to
> incorrectly miss sending a TX_EXPIRED notification to userspace?
> 
> It appears a similar issue for RX_SETUP was previously addressed by adding
> locking in commit "can: bcm: add locking when updating filter and timer
> values", but the TX_SETUP side might still be exposed.
> 
>>   	if (op->flags & TX_ANNOUNCE)
>>   		bcm_can_tx(op, NULL);
> 


