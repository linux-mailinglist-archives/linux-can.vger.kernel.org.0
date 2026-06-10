Return-Path: <linux-can+bounces-7803-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 87C9J4kSKWrIPwMAu9opvQ
	(envelope-from <linux-can+bounces-7803-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 09:30:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 967E1666A50
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 09:30:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=N6miYyio;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=WrdfveS+;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7803-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-7803-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AB2C3006209
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C1038E8BE;
	Wed, 10 Jun 2026 07:30:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6438AC6E
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 07:30:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076605; cv=pass; b=TS2XldE2C9mVN8Fp9VVElTzdOF2p4e5I8zl72Ca0HEhpyuMQK0+1eppDJ1chZivDtFD3ieWIEnUDOEPWX9ugUMlnSw6Pq7d8kzmDqkem5sBRoczPx4ei2VnPfAsi9hsBUJ28KVc4/xs5cujSsR/ThbQfdaTbvwRyTo2oWaN+pSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076605; c=relaxed/simple;
	bh=mlCSh0uFdoni/BKpAm4b0aat1vCgx3b0XfXpsdBArvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTztJp48xjGHMTl3YVd1IH65hYkassaZVOij58HKCD4vzq2TGG5QLY/FGAgJuC0xU6XLv6stWfCybEdZ8PQ42caH7uP2N7+xK4peZ/WyAJ3QITFDEj04/VjnHRVI75K42FSPIB8atNwyV065Kugw2CKsIB+VtW1sfj4y8Fbn7kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=N6miYyio; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WrdfveS+; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal: i=1; a=rsa-sha256; t=1781076553; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=s/2x8XRSdocn6ckz+y4BgNTY+1Gl4sTfwnuNfU3A6PekTsVkJcGRhFqzmCOfWlFOpR
    xfQOrIWXK6O7cN6PoYwsPN+kZTAd0ggR7S68z/HDKUUWrx79eru4OR5IEVqvEafBZepE
    B1jWD8E4awGXCyggIbwhNHB/yknSkLW4OIJ37I0njmoEtDD7UgaO/etxaQgrMzgD9Im9
    JGpOFK5cedLFys24uF7VgNTVgEP5kKMVnhkkutn3yRtSaIB/IA3OsqdjmqLwkzzIOJJ1
    Dv7Y/Das/91qE7nCNKBoRW1Zq5oDXARvWi+j+lCe2yde7H1QLmsA0SDWdQWGfQx4gdbI
    hoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781076553;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5XTe0Fwpf5wEssSLn6p7izES+JmQBOHzjrazoZhl8rQ=;
    b=JZmLJNfrCFmf9qPXeXGtA1EKTaEEuh6uIEO694wD68qmYxlLpAmxRCwBtfYAEeOdob
    5FO++PwqfygRnLNNEkEDQzlzA0s2QgalAluqxuPj11wyMSDzBOZqbZxUmwgy0VKUUcUP
    bcYs02/GFv/W5NDpPs02Fr9wbFZPbQIgyFoF141afiCm0b5Tp+8wG35ADonb5D0BLoCg
    nuN1uPaY+1JZSBp57iSC6OIQSqhqqfOaUmtVjjU25SwRMIlCir/0maBWMnUAPdDJqbNv
    ykpxu1lVay4kE54hFoa1nFwlwMvATYh7RU167uPp0dCg5tzTA6YouBkSOs7bjsPpigTH
    EYDA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781076553;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5XTe0Fwpf5wEssSLn6p7izES+JmQBOHzjrazoZhl8rQ=;
    b=N6miYyiop3J6t0FW1CJG3S0rZxohZbIT8vCXf2S0no/lDppOp9FW1S/LdlHtpg+EqT
    TtS3czcc29LWIhSw9/f/RNpuodMjp3g+zTa/+QRO0T+uIIgI6JVjZCCQgsyvCp+hueyM
    MbQLovEMXK2bm1nXv00SNU2zN1I+hpwrTXPxdP3e0Qp5AEZq8MNfICijutL/6mD/sIol
    J/c0lsyEFs3pSfHqIbnLpxmHFfOFX8Qc/5jLKn23QQRHLU3QxZjd76afLSOKXqzcDbmE
    hw+lDAg8yxlzV0Jbln80kpxTDBgDJN4ZA5bxUEK3/kIrtGNBS746tx6HxfjyoJrYHTB3
    uqPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781076553;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5XTe0Fwpf5wEssSLn6p7izES+JmQBOHzjrazoZhl8rQ=;
    b=WrdfveS+qpr3ijxyu0J2PrMDk7z0u58sqlkdL3BeH6jo8QTqMS+ezMtUkNchOtPvDc
    +k555nvR1/L99sSKU+DQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25A7TDhI1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Jun 2026 09:29:13 +0200 (CEST)
Message-ID: <6e6b52f2-b5ce-43d3-a340-295a179ba817@hartkopp.net>
Date: Wed, 10 Jun 2026 09:29:13 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can] can: bcm: add synchronize_rcu() in bcm_delete_rx_op()
 to fix UAF
To: sashiko-reviews@lists.linux.dev, Zhenghang Xiao <kipreyyy@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
References: <20260526102349.94074-1-kipreyyy@gmail.com>
 <20260609185258.4F3E41F00898@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260609185258.4F3E41F00898@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:kipreyyy@gmail.com,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7803-lists,linux-can=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[lists.linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,hartkopp.net:dkim,hartkopp.net:mid,hartkopp.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 967E1666A50

The patch already has been rejected in favor of:

[PATCH v3 1/1] can: bcm: defer rx_op deallocation to workqueue to fix 
thrtimer UAF

https://lore.kernel.org/linux-can/20260526165257.3705239-1-lee@kernel.org/

On 09.06.26 20:52, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Skipping `bcm_rx_unreg()` when `dev_get_by_index()` returns NULL leaves the CAN receiver registered in the core, leading to a memory leak and Use-After-Free.
> - [High] Incorrect list primitives used for RCU-traversed lists (`rx_ops` and `tx_ops`), leading to list corruption and crashes.
> - [High] Concurrent modification of an existing RX operation in `bcm_rx_setup()` races with `bcm_rx_handler()`, allowing readers to see partially-written data.
> --
> 
> commit 27083d45b99681b318907aa96e90787a12c08a58
> Author: Zhenghang Xiao <kipreyyy@gmail.com>
> 
> can: bcm: add synchronize_rcu() in bcm_delete_rx_op() to fix UAF
> 
> This commit adds synchronize_rcu() in bcm_delete_rx_op() before
> bcm_remove_op() to ensure all in-flight handlers complete before timers
> are cancelled. This prevents a use-after-free where a timer could be
> re-armed by a concurrent bcm_rx_handler after being cancelled.
> 
> Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index a4bef2c48a559..ae083f59a9ef5 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -870,6 +870,7 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
>>   						  bcm_rx_handler, op);
>>   
>>   			list_del_rcu(&op->list);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at the code just
> above this addition in bcm_delete_rx_op():
> 
>      dev = dev_get_by_index(sock_net(op->sk), op->ifindex);
>      if (dev) {
>              bcm_rx_unreg(dev, op);
>              dev_put(dev);
>      }
> 
> During device unregistration, unlist_netdevice() makes dev_get_by_index()
> return NULL before the NETDEV_UNREGISTER notifier is dispatched.
> 
> If user space concurrently closes the socket in bcm_release() or deletes
> the RX filter in bcm_delete_rx_op(), these functions check
> dev_get_by_index(), see NULL, and bypass calling bcm_rx_unreg().
> 
> Does this leave the CAN receiver registered in the core, leaking the
> struct receiver and causing a use-after-free when queued frames process
> the already freed op pointer?
> 
>> +			synchronize_rcu();
>>   			bcm_remove_op(op);
>>   			return 1; /* done */
>>   		}
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential problem with the
> list primitives used for rx_ops and tx_ops in net/can/bcm.c.
> 
> In bcm_rx_setup() and bcm_tx_setup(), the code uses list_add():
> 
>      list_add(&op->list, &bo->tx_ops);
> 
> However, in bcm_proc_show(), the tx_ops list is traversed locklessly:
> 
>      list_for_each_entry(op, &bo->tx_ops, list) {
> 
> Because list_add() lacks the smp_store_release() memory barriers of
> list_add_rcu(), and the traversal doesn't use list_for_each_entry_rcu(),
> could this result in readers seeing partially initialized list pointers
> and dereferencing a NULL pointer on weakly ordered architectures?
> 
> [Severity: High]
> This is another pre-existing issue, but there appears to be a race
> condition between bcm_rx_setup() and bcm_rx_handler() in net/can/bcm.c.
> 
> When bcm_rx_setup() updates an existing RX operation under lock_sock(sk),
> it modifies the frames locklessly:
> 
>      err = memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);
>      if (err < 0)
>              return err;
>      memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
>      op->nframes = msg_head->nframes;
> 
> Meanwhile, bcm_rx_handler() accesses these fields in softirq context:
> 
>      for (i = 1; i < op->nframes; i++) {
>              if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) ==
>                  (get_u64(op->frames, 0) &
>                   get_u64(op->frames + op->cfsiz * i, 0))) {
> 
> Since memcpy_from_msg() can sleep on page faults, could bcm_rx_handler()
> read torn or partially overwritten CAN filters, leading to incorrect
> message delivery or spurious timer scheduling?
> 


