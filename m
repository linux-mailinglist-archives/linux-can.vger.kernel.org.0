Return-Path: <linux-can+bounces-7805-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lPBpEL0YKWpCQgMAu9opvQ
	(envelope-from <linux-can+bounces-7805-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 09:56:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D9666D4F
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 09:56:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=eeGv2eQv;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=s1UGm8pJ;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7805-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7805-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C89923221B3F
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEE0370D63;
	Wed, 10 Jun 2026 07:50:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84739385D85
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 07:50:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077858; cv=pass; b=KxB0i9CxTW0HStS00T0U9sQP2v5KddVJt6sR0agEKD4+R2AasJlQVwMQoZ5XlP1w446rZYJFMXIkziV8vKTLck8YJ43wfStsbOhAKetss3I/fthfKBhk9JhvzzWJvcqQvoF87gWuVvt9knjg1apERFZ/AGXw5ckLS38PIepITQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077858; c=relaxed/simple;
	bh=cXnNmyH7yb63g8v+SKaecPXaRZ4sGI+/sGEu3BRsXHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlSBdVPpyxxR4JROCzVg+tNJqhWcjToLGbmtqhCXinEvbmFTcxcFT+JwU5qN6ordlgUd7KL3K7PZThPHhmnv0kECUCzgcX19O4UlcUwC7hcpsIEEMbWnfBfTmokpLbxDDfhkGs3e4c89kfMHh8yFFrJSZBgspxPg7dDPO6SDgcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eeGv2eQv; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=s1UGm8pJ; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal: i=1; a=rsa-sha256; t=1781076414; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Gxy4dzlXyHjRPdyY6bE5TQH10ucWiNELXWMmzcPMuz/mYAhapeeTWFaklKO5doYZr7
    nWlZxVDcvvP932pW9qTuNdDoUQwQOSG/+57p1u5uuY9Uy/LANDNrZoFlMzmkYWlH0p1D
    cCixriDFrR1xfpOzAV2yele9HmHMyJSLk9GZEVzxFv5O4pXlacQXTrv+RGPXmDfGWJCg
    WeubxnYsS3j3jUvXN5gdSd/FNrbqVFs5WJuGfDJhDrKOj1MsgB0sfeMk3HnMcu+95kum
    mzxWiwYcepgL0BT4WSUlHu43bp1pFjQgWOtl2glCGMJaPWapHixlf8iAMkMC6YMaF+cJ
    2QNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781076414;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PUEVtF9ZdOvBdDkK5+Yu4heQXu8CDQpdN613lg05l3Q=;
    b=N9z6H27HIKOuQMxZaM1C1MAUi+DyxUjqFaEvr6vyVbwMWk+ZwxvE1BBp03pG/byyeq
    Pyazhue/JXLe/EaQtuXmd1k2EuAIgF8gucLLkhgXNQsgkUA3W9+iEWO3Eh/pCTXK7DJP
    Ntojoafu5R5ISWtB7WI6BG9cp1lhW03XGLfdFMUjs+M5EtDN4U84fbk55gWOYAvv7JId
    dnY5SMsDNkX+f0er6zmMRzqCGNv1XZhcoGIQejbVvJIzlmCveHAKdNlYTvM9tGAOAfzp
    2AlEgiqs+xmvZbwcx1KWvghdiGupHjydVVlEpwrnbm4BphOeIoHWGnZ+DOCf3URUHpRD
    BTDA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781076414;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PUEVtF9ZdOvBdDkK5+Yu4heQXu8CDQpdN613lg05l3Q=;
    b=eeGv2eQvYWPyOJ4vud4xzIvTECfLNJS3ecjkHZdTYe33KOcN47eAQXmtd3OFyVNYhl
    cJEijeVO5LYRXitMe4/xwQJRihFDAWOhvGS3oHORodxbe1Z6MutkzvGatsHaqkNGEY2S
    GnOwzXg0cE40DTi6+31JYjznFUGvIH0ick1UXSMYJaNYHtYBxzO/dUufY8UgN9Bh3f2K
    pCgEgpkIUMLhXK+MyfRE+uKwcZjbFWdWFRZEVPcZBlwCiYK5K7VLXvARXtBIWia9xsWD
    DJcwLZSB1m9SDuKjEiJ9SeEbkkOBNCDKFHE372RMfDRAhVIQ4l+OwVi9Ztb3aw/bTCyJ
    XmVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781076414;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PUEVtF9ZdOvBdDkK5+Yu4heQXu8CDQpdN613lg05l3Q=;
    b=s1UGm8pJ+bB3sULiY5syRwOpRs/yeZ6MKrgUHb89IriKVZYrM+uWYQzSF2Ezjyh9X8
    P+Zf80LEF2bMRGIhyUCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25A7QshHS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Jun 2026 09:26:54 +0200 (CEST)
Message-ID: <62c8fce9-2c38-4d01-b73a-00c063f2f99d@hartkopp.net>
Date: Wed, 10 Jun 2026 09:26:48 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] can: bcm: add locking when updating filter and
 timer values
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260522180758.51128-2-socketcan@hartkopp.net>
 <20260609185553.61D621F00893@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260609185553.61D621F00893@smtp.kernel.org>
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
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-7805-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,hartkopp.net:dkim,hartkopp.net:email,hartkopp.net:mid,hartkopp.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 996D9666D4F

The op->flags |= RX_NO_AUTOTIMER issue has been addressed by this patch 
which needs to be applied before evaluation:

[PATCH v3 1/1] can: bcm: defer rx_op deallocation to workqueue to fix 
thrtimer UAF

https://lore.kernel.org/linux-can/969151cc-5316-472b-970b-c29b8aadc1f9@hartkopp.net/T/#t



On 09.06.26 20:55, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Concurrent RX_DELETE and CAN frame reception can cause a timer to be armed after it was canceled, leading to a Use-After-Free.
> --
> 
> commit a1560c18e32869b3dc94d859252cf67b537b151d
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: bcm: add locking when updating filter and timer values
> 
> KCSAN detected a simultaneous access to timer values that can be
> overwritten in bcm_rx_setup when updating timer and filter content.
> 
> Fix the RX_SETUP update case by protecting the timer and filter updates
> with a spin_lock_bh().
> 
> Link: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@google.com/
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index a4bef2c48a559..dbdf5d4f4ed7b 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> 
> [ ... ]
> 
>> @@ -774,6 +788,8 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
>>   
>>   rx_starttimer:
>>   	bcm_rx_starttimer(op);
>> +
>> +	spin_unlock_bh(&op->bcm_rx_update_lock);
>>   }
> 
> [Severity: High]
> This is a pre-existing issue, but does this still leave a race condition
> with bcm_delete_rx_op()?
> 
> Even with bcm_rx_update_lock held here, bcm_delete_rx_op() modifies
> op->flags without taking bcm_rx_update_lock:
> 
> net/can/bcm.c:bcm_delete_rx_op() {
> 	...
> 	/* disable automatic timer on frame reception */
> 	op->flags |= RX_NO_AUTOTIMER;
> 	...
> 	bcm_remove_op(op);
> }
> 
> And bcm_remove_op() cancels the timers and queues the object for RCU freeing:
> 
> net/can/bcm.c:bcm_remove_op() {
> 	hrtimer_cancel(&op->timer);
> 	hrtimer_cancel(&op->thrtimer);
> 	call_rcu(&op->rcu, bcm_free_op_rcu);
> }
> 
> If bcm_rx_starttimer() reads the old op->flags value, can it be executed
> after bcm_remove_op() has already canceled the timers? This would result in
> the timer being re-armed on a soon-to-be-freed object, potentially leading
> to a use-after-free when the timer fires.
> 
> Should bcm_delete_rx_op() also take bcm_rx_update_lock when updating
> op->flags?
> 


