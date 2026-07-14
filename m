Return-Path: <linux-can+bounces-8397-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xmmfKjsWVmrrywAAu9opvQ
	(envelope-from <linux-can+bounces-8397-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:58:03 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 252AC753A58
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:58:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=bePim84e;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=+tuvW+vr;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8397-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8397-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DF2D30F1904
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 10:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2735E371D1F;
	Tue, 14 Jul 2026 10:57:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30253365A0F
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:56:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026621; cv=pass; b=nwqCXqtYOlUsfvl58BQZvYyJD+i/o2MKuoQjE5R1Q78o/v5jq9CLA1sq0mBQ9Wn7nYfj/uPtVFyP3bIJXziyG5fNRNbtXPVAOv15t/++8KRXKVWkH84Py/yhBaeXwZDIMEwJ+F3iaRAEk3fVUmrHGBGsShKub0PbCIBppWBRBRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026621; c=relaxed/simple;
	bh=X0tTSfk9evMwNKDm7jrzp7MiGt9hR3mncd+M9vgGtW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BB5fgCzoklFMRrVw/9aGHxqKID3h0O5RUS9zvOBuGEr3ulRRahKvJPSj1qnxpK6y8dqjirnhjH2gi0tRr1RugNFv1aeridojkMF3PvFDiCP/0+2WSiSk3A4P+JkYzfl8sKuQv2z6QnfA1bLKowuD85JwFbuwn71L0c8BViGRxWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bePim84e; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+tuvW+vr; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal: i=1; a=rsa-sha256; t=1784026600; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cvIgV5Shv/HOBK4uxZt8g/pU0xWBJY19Itzi9qRA3yFc42rNQrSTGp+xZkAoccks8Q
    0Ixu6mYP7oWvtzNvAjYKKql2Xi0/ovD6Vjc7CEiriwwPnVAUnY4YxVy8A9X790hA11TH
    ui0LqjFh2j2doP1xfqsu1pTz+gRCTR1RYVLgKehf1r45DTNqzHBtCKQQC0vDqHqvy8uM
    r9LN1e5kcN0u5l377Lfu1mKm+DhSdFm01P2FySDKuiw6L5IruCa2qN8KlAcir33VUv2J
    QzB7iAuGvEsgPjyl0agnlxWui7phYo3Lmx2WxhP2+6nBL6borkLan+4w+0SGdqWoCmHc
    yJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784026600;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yZ1Prlqe9KeKO/0OELMwEZ+0wc80WVcN8M7572srkXg=;
    b=tEC6clk43dswWYpsc1+Nwly3r8gboZhAGyd3/xnKWWy/V//95r+/TCHclesOPyZr++
    P2zI24fZOsi3r3reB72iqvMg0RSw8S+oFLWqVYqOgPZqxB2hC+wfvdsaGBUjYDzDaCkT
    ++LfO+vKy+hpYFZW5Ux6r0ZB7tGQqu2Ay5jF0au4aDiPVTLZctGmEwCZpWgWLuyFJaWO
    /SCegc3l06Swa0Bl1KSe5PBhxyjF1WcNWf0FSVcGbDgl6rJFCveQwBagxZvHftxVAh61
    1EJtl+8QPVvcd4AXYbHtkIWT2qVizelpH910JruwHsE/5e+YtRPmb7KGmSiuA7o8pE0a
    H8Wg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784026600;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yZ1Prlqe9KeKO/0OELMwEZ+0wc80WVcN8M7572srkXg=;
    b=bePim84etATb6wAX5K18h2u/cbnCHOTaktmL2nKth6MuEsqMnJEPQBQwOG6MWxsnzb
    eD3PmifK/p8K448SUVvUVh7vO3GbZM/RrcTDfgipfVQoMrI3G3qX5pC2RB60HodLjl+w
    miIVBqQLmTcvH4wpjosgYAFdGnx5q3SyK3Sns3q1miI/nJxI8V5VbVwHXyTUjCpVl9GD
    KKZSifMRNKaH6guYqkETS3Fc9Bt/8q0GJhlDV9MyVFEsq7JN2H2HRneOig10wMe1/3ui
    NyUSxZ8lZtLNzw4hDo+sMT4cJjE+r3svGzzbz1fkwmv+zsD7srXnCLWp9ceM76HEt+rQ
    7iVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784026600;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yZ1Prlqe9KeKO/0OELMwEZ+0wc80WVcN8M7572srkXg=;
    b=+tuvW+vrPJ7MSVdsQr8jOodCtUuUsXcqpZ8jOR94zcApBiED0deHX3isq0NSSJLzVm
    PLLNSoTspZLNrErDqQAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.190]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26EAuejLv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 12:56:40 +0200 (CEST)
Message-ID: <da3f9cb9-6b60-4f95-91c3-6684555c09b9@hartkopp.net>
Date: Tue, 14 Jul 2026 12:56:39 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 06/11] can: bcm: extend bcm_tx_lock usage for data and
 timer updates
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-6-fd667c61099a@hartkopp.net>
 <20260714103422.2E3A71F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260714103422.2E3A71F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8397-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:from_mime,hartkopp.net:mid,hartkopp.net:email,hartkopp.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 252AC753A58



On 14.07.26 12:34, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Torn reads of ival1, ival2, and count lead to corrupted TX_EXPIRED API notifications.
> --
> 

Well yes :-/

V14 candidate

> --- Patch [6]: [PATCH v13 06/11] can: bcm: extend bcm_tx_lock usage for data and timer updates ---
> commit 69a20e6fcc24540387b82e9501090dfb55f155cf
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> can: bcm: extend bcm_tx_lock usage for data and timer updates
>      
> Stage new CAN frame content for an existing tx op into a kmalloc()'d
> buffer and validate it there, mirroring the approach already used in
> bcm_rx_setup(). Only copy the validated data into op->frames while
> holding op->bcm_tx_lock, so bcm_can_tx() and bcm_tx_timeout_handler()
> can no longer observe a partially updated or unvalidated frame.
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 940cd9df1cca3..18601d6fdf763 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> 
> [ ... ]
> 
>> @@ -486,8 +492,17 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
>>   {
>>   	struct bcm_op *op = container_of(hrtimer, struct bcm_op, timer);
>>   	struct bcm_msg_head msg_head;
>> +	bool tx_ival1, tx_ival2;
>>   
>> -	if (op->kt_ival1 && (op->count > 0)) {
>> +	/* snapshot kt_ival1/kt_ival2/count under lock to avoid torn
>> +	 * ktime_t reads racing with concurrent bcm_tx_setup() updates
>> +	 */
>> +	spin_lock_bh(&op->bcm_tx_lock);
>> +	tx_ival1 = op->kt_ival1 && (op->count > 0);
>> +	tx_ival2 = !!op->kt_ival2;
>> +	spin_unlock_bh(&op->bcm_tx_lock);
>> +
>> +	if (tx_ival1) {
>>   		bcm_can_tx(op, NULL);
>>   		if (!op->count && (op->flags & TX_COUNTEVT)) {
>>   
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but the lockless read of
> op->count here can see a newly written value after bcm_can_tx() drops the
> lock.
> 
> If bcm_tx_setup() runs concurrently via sendmsg() and mutates op->count,
> could this condition falsely fail and drop the TX_EXPIRED event?
> 
> Additionally, in the lines immediately following this (when setting up
> msg_head), op->ival1, op->ival2, and op->count are read locklessly:
> 
> 			msg_head.count   = op->count;
> 			msg_head.ival1   = op->ival1;
> 			msg_head.ival2   = op->ival2;
> 
> Since bcm_tx_setup() modifies these multi-word structures under
> op->bcm_tx_lock, does this lockless read risk tearing the tv_sec and
> tv_usec halves on 32-bit systems, sending corrupted timevals to userspace?
> 


