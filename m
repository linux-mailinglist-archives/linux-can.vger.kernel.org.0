Return-Path: <linux-can+bounces-8075-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2eASC87mTGosrwEAu9opvQ
	(envelope-from <linux-can+bounces-8075-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 13:45:18 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 403D871B130
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 13:45:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=Gkf0cJaI;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=2EcsMNbw;
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8075-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8075-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 769633022342
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A9F3F86E0;
	Tue,  7 Jul 2026 11:33:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0723C3E6383
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 11:33:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423989; cv=pass; b=l25xkJw+cThq/wjbHqkdUa0/3SfF09GSpk2xTt06A19Oc9sXCCocIhnp9Qknt4Boj9RCiqp59GaDYQBMRYBvJF+KLLrM5p56gXLo4wZzYzDXzgCHzdNR0YDEV+TyrfqmIE1T9hrvSn/Okw7M2dvni4coCcXsBybTdfHY4yfiFfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423989; c=relaxed/simple;
	bh=wS/J0Nbi93oH1TFz0RrqSQaENoKnBheUpQQSDF7bGCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrKbGx41QgQf/QQdkT8EaPBJW79r4D/Ioch7O7Q5kcjdu4cOf6MpyQeHMYbVBRMCDrg5Gf9+lxOlJ4paiSlDcTkwh7hM5QalPtgEEsMz42pxeuHkBalLrYjI5+Lr3lLrMCnb33d5NHvgp2U5FmJHB76FqotXhDv9EsiSE0O6eFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Gkf0cJaI; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=2EcsMNbw; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal: i=1; a=rsa-sha256; t=1783423978; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AuJ12quyEN/NA6s5bhh70B5AVP83sEu35yn76fnuTZeAWJIJa1qXM2dgLBm9S9apyY
    wWZJ5fVkDHMDpnGdqkvm9MCWAnPoHVy1h7i08j5o0QuW9HD3MnyqLw3lNEuZ89fGRnXD
    yGwGlwm0x6und7bbLkOyrqkmxnIkfl3YI+zOa/8l4rI3NvX83g9mZvdfI9zwdASw3kQq
    woRVPnN8o0+cF62r1AMxaIksvlRoWaX/dv1QIt8Mvb1zgTVNnXyWSYFjpnjWSwj5UkKD
    YVoDbpHMql/jr0VPTm5i/vUocaSLkCcyedkfXAloEhdjulTVd1L8nsFPNGYeO/usclTd
    qg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783423978;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=T4Vv+CHRYPL/lz5GPxGyVBrz8JFS2hOWlz0sl1GEEA0=;
    b=SVQgp7rS8OTNFwQQk3r3I3tH/wMaa19E+m259/0dVAxXDkGl2P1H2NtLkBzT4tWZn+
    /Lx/O2Y4D0wQA58Mc0dlD/IWVpQct0EadZ6HtwCHelfu5OYUrq502lQ6QXdRZL/HhIeb
    t5aHvdpsaqa0d9IYI0FFEmr5HTxAaz7O49PVveFMBAlL+1JsY/DEhrSQojWqB+JQczH0
    A50lyo47O/E5vJAeEzi4V1l4OQeUlQKf6V5/NHW9d4kI6otm9rssdrOai6eRiL1moKx8
    BxF1OXqmFDe6HHqZye01wdJAsa4WNuMa6yiWHPuAkV6OWn1IZorXymYFVbjDqQShiNHU
    yCMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783423978;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=T4Vv+CHRYPL/lz5GPxGyVBrz8JFS2hOWlz0sl1GEEA0=;
    b=Gkf0cJaI4yFVXb6ZVP+BLF5pafwkF/yRbmBE30x9YjSL4PGzm+fb3W7ttrGaZ/pVE9
    nKma7uDIH4TwR0VlIFH5Hj1ps5mRmbbHAgdyMM2La5dnuVBs/qMg1GiiJd8UhEia5s1c
    Ia/VIfR0j/jZbeHDVy7mn697TqCFk7nMc3/TgX/cKMGWO5Rt8nWAwGPJXBhwQVtPrTuH
    Ow0wotkZK9cJ/6r3AGjKv2zNQf1yx8nm574ouW3NGOSHC6Se4GesaLgH0W0jP0OzxAPj
    VkCv9LVe3QH+qHMHTDNvkimpOf70VqA081boOUPW0+AGxILXstb0W8Gp6WuPnVdQ66DS
    YJLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783423978;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=T4Vv+CHRYPL/lz5GPxGyVBrz8JFS2hOWlz0sl1GEEA0=;
    b=2EcsMNbw1yoQPdEf/Rf5qVhv7eknK80bcHdhjBpiL+QBPLHDH8nGkpXvRlheTIIr8W
    mMlT7yUHuX3ZyVKmUbBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.154]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb267BWwSp3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 7 Jul 2026 13:32:58 +0200 (CEST)
Message-ID: <916beff4-bd6f-45d6-a8d3-4801278596b8@hartkopp.net>
Date: Tue, 7 Jul 2026 13:32:58 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] can: bcm: add locking when updating filter and
 timer values
To: sashiko-reviews@lists.linux.dev
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net>
 <20260707-bcm_fixes-v3-3-84600ca6d889@hartkopp.net>
 <20260707103500.6898B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260707103500.6898B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8075-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:from_mime,hartkopp.net:email,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 403D871B130



On 07.07.26 12:35, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Concurrent timer updates lead to hrtimer_forward_now being called with a zero interval, triggering a WARN_ON.

Will be fixed in V4

> - [High] Missing locking in the TX path leads to data races and torn reads for CAN frames and timer values.

Fixed in patch 6:
https://lore.kernel.org/linux-can/20260707-bcm_fixes-v3-6-84600ca6d889@hartkopp.net/

> --
> 
> --- Patch [3]: [PATCH v3 3/7] can: bcm: add locking when updating filter and timer values ---
> commit 29dee20a547c38c99b2b856375f9e172e6a33181
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
>      can: bcm: add locking when updating filter and timer values
> 
>      KCSAN detected a simultaneous access to timer values that can be
>      overwritten in bcm_rx_setup() when updating timer and filter content
>      while bcm_rx_handler(), bcm_rx_timeout_handler() or bcm_rx_thr_handler()
>      run concurrently on incoming CAN traffic.
> 
>      Closes: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@google.com/
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index b612135b017d1..fd548c6eaa913 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -293,22 +294,26 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>>    * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interface
>>    *              of the given bcm tx op
>>    */
>> -static void bcm_can_tx(struct bcm_op *op)
>> +static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
>>   {
>>   	struct sk_buff *skb;
>>   	struct can_skb_ext *csx;
>>   	struct net_device *dev;
>> -	struct canfd_frame *cf;
>> +	struct canfd_frame cframe;
>>   	int err;
>>   
>>   	/* no target device? => exit */
>>   	if (!op->ifindex)
>>   		return;
>>   
>> -	/* read currframe under lock protection */
>> -	spin_lock_bh(&op->bcm_tx_lock);
>> -	cf = op->frames + op->cfsiz * op->currframe;
>> -	spin_unlock_bh(&op->bcm_tx_lock);
>> +	if (!cf) {
>> +		/* read currframe under lock protection */
>> +		spin_lock_bh(&op->bcm_tx_lock);
>> +		memcpy(&cframe, op->frames + op->cfsiz * op->currframe,
>> +		       op->cfsiz);
>> +		cf = &cframe;
>> +		spin_unlock_bh(&op->bcm_tx_lock);
>> +	}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does bcm_tx_lock actually
> prevent concurrent overwrites by bcm_tx_setup()?
> 
> The commit message claims to "take a lock-protected snapshot of the currframe
> in bcm_can_tx() to avoid partly overwrites by content updates in
> bcm_tx_setup()".
> 
> However, looking at bcm_tx_setup(), it appears to copy user data directly into
> op->frames without holding bcm_tx_lock:
> 
> net/can/bcm.c:bcm_tx_setup() {
>      ...
>      for (i = 0; i < msg_head->nframes; i++) {
>          cf = op->frames + op->cfsiz * i;
>          err = memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
>      ...
> }
> 
> If the writer never acquires the lock (since memcpy_from_msg() can sleep),
> doesn't this lock in bcm_can_tx() remain ineffective against races?
> 
> [ ... ]
> 
>> @@ -461,7 +466,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
>>   	struct bcm_msg_head msg_head;
>>   
>>   	if (op->kt_ival1 && (op->count > 0)) {
> 
> [Severity: High]
> This is a pre-existing issue, but is this lockless read of kt_ival1 vulnerable
> to torn reads on 32-bit systems?
> 
> bcm_tx_setup() appears to update kt_ival1 and kt_ival2 locklessly, and this
> handler reads them locklessly. Could this cause the timer to fire at
> unintended intervals if a 64-bit ktime_t is partially updated while being read?
> 
>> -		bcm_can_tx(op);
>> +		bcm_can_tx(op, NULL);
>>   		if (!op->count && (op->flags & TX_COUNTEVT)) {
> 
> [ ... ]
> 
>> @@ -686,15 +695,22 @@ static int bcm_rx_thr_flush(struct bcm_op *op)
>>   static enum hrtimer_restart bcm_rx_thr_handler(struct hrtimer *hrtimer)
>>   {
>>   	struct bcm_op *op = container_of(hrtimer, struct bcm_op, thrtimer);
>> +	enum hrtimer_restart ret;
>> +
>> +	spin_lock_bh(&op->bcm_rx_update_lock);
>>   
>>   	if (bcm_rx_thr_flush(op)) {
>>   		hrtimer_forward_now(hrtimer, op->kt_ival2);
> 
> [Severity: High]
> This is a pre-existing issue, but could hrtimer_forward_now() be called with a
> zero interval, triggering a WARN_ON_ONCE?
> 
> If a user updates an RX operation with msg_head->nframes == 0 and ival2 == 0,
> bcm_rx_setup() updates op->kt_ival2 = 0 but does not clear op->last_frames.
> It drops the lock before cancelling the timer:
> 
> net/can/bcm.c:bcm_rx_setup() {
>      ...
>      spin_lock_bh(&op->bcm_rx_update_lock);
>      op->ival2 = msg_head->ival2;
>      op->kt_ival2 = bcm_timeval_to_ktime(msg_head->ival2);
>      ...
>      spin_unlock_bh(&op->bcm_rx_update_lock);
> 
>      /* disable an active timer due to zero value? */
>      if (!op->kt_ival1)
>          hrtimer_cancel(&op->timer);
> 
>      hrtimer_cancel(&op->thrtimer);
>      ...
> }
> 
> Because hrtimer_cancel(&op->thrtimer) is called without the
> bcm_rx_update_lock held, could a concurrently expiring bcm_rx_thr_handler()
> acquire the lock, flush the still-throttled frame, and call
> hrtimer_forward_now(hrtimer, op->kt_ival2) with an interval of 0?
> 
>> -		return HRTIMER_RESTART;
>> +		ret = HRTIMER_RESTART;
>>   	} else {
>>   		/* rearm throttle handling */
>>   		op->kt_lastmsg = 0;
>> -		return HRTIMER_NORESTART;
>> +		ret = HRTIMER_NORESTART;
>>   	}
>> +
>> +	spin_unlock_bh(&op->bcm_rx_update_lock);
>> +
>> +	return ret;
>>   }
> 


