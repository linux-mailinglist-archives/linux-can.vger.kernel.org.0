Return-Path: <linux-can+bounces-7837-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XMTpEdFfLmoGugQAu9opvQ
	(envelope-from <linux-can+bounces-7837-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 14 Jun 2026 10:01:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B3968097B
	for <lists+linux-can@lfdr.de>; Sun, 14 Jun 2026 10:01:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=Xoq685eB;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=XhbyKnZd;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7837-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7837-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F36BC3007CA4
	for <lists+linux-can@lfdr.de>; Sun, 14 Jun 2026 08:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803C7222597;
	Sun, 14 Jun 2026 08:01:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C31F78E6
	for <linux-can@vger.kernel.org>; Sun, 14 Jun 2026 08:01:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781424077; cv=pass; b=o4poIrSsPVuvRe7q3WhR/pxe+sYkrDkoaOUE6Os8PlndbqyHKzpnNzi8r7jK8gJySnPfbDi6M/8VKoNCiXZxxFQCD2rXsZ2jQx8JMEUBIkVOYaZmPCM20wQcQb/GR0xhq0V2wIQvsY9QvKsFU5S91wV2zgnZP2Iwpoarnvg7DFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781424077; c=relaxed/simple;
	bh=YcdRRJZzYQ1rL7GdnsfP1sR2nC1UfZDSOq1nIXaH2TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um1ez0Khs0HA19/ptE8SEzr7oMFMAkfwzMkKUFZCqIg9RaTQW1/xUj1cJNzXUlLmMUPR67jui+L7VgSGt03gXOhiR/jqb8Gc+UjYWSnBQ0cSJnko2KPlH4WcTn2MXR240aU6WN5FBoM0a87McSe+lPJTtSRsw2ZPeF6bTEpmBkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Xoq685eB; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XhbyKnZd; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal: i=1; a=rsa-sha256; t=1781423348; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=twTTZHubC/A25FywYYF/D4wLxShBiJZLFpZliLzZUrZIGncaH2gz+B72g/q8JYfajn
    lpwRxItSuV45Rp850UaUuPLb1PFQyBuzowGwRMefuv20xQ9hAamnvONUW1x9TYa34ovr
    J+CAiFWoCO3ar1Kxesmd/q9gGZ5zRoyFZ7fxZ2ckHBzFMPoDnsNz+rpVaDmBwGmIF7ko
    v/RBD+/PO0zGeDHJ7SaXBIYKBMVzKQ8KW8QZ8lCv/A5F5OzLG41+b8/268yN5P8bZxQ4
    iL01HWmkrpGP88Bst8yZKkjZ07CpLGYzwKzcvdz1THg0orwy2PBxR9VBNqatXRrcvVmR
    efzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781423348;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KVpksOCflGtFYviiLOwk026RHZjBofHh/GjLqgl7GSQ=;
    b=S7mIM6n/wwLchNdsC/miIkrqagoCSml5x/0VjeShTKmc2hMXVlj5idHLqikEJ/ZHs9
    07ntMWajWAmE/oaplxZaKNBtnIklPnTNBhatSiUIwZPgKZoIcGhsj+/QRNEKLB8Yon6k
    an5jyutjYe7eolEaNHM+S54N35KqBNd/epDnLoDmHo89J19klHyuX4EiDdjKlxto4e2v
    jAxJoNOdyXjTnoanyglOmdtAtALrTokgmHjFb5YmKjt7EhvXYemo5KkKbcYisX1K5He0
    1pgAen3qHdS1BVZ9VoRJOYaftqVbagNhJOO27Hz8R8joqRFT9bZGk3xT8gRoW3eTd5CT
    JyDw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781423348;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KVpksOCflGtFYviiLOwk026RHZjBofHh/GjLqgl7GSQ=;
    b=Xoq685eBiUfVZlIEWxj76AU5cFYkPLtqVhHLh241fADag551aqsYWg6dDPYH45Q67R
    838THui5hgn125Yp3dfK1i/NQo+RNgnj914BScNeNijvBpzyXgA27x5nGp7RnFVmowr/
    lnCfRJYFB0zW92Mk8fcKOG88lZJtlqNam7knE8CaTgkM+Y1pFyHIr6mdBtp0//MLE7FT
    Ny/F6xgIE4jkCfTD2sC1nLjvdqEqmsV6A5uC4pSuqloBJBLpds3w5UABtEHyFFK5U26x
    Czb/YKadcce+Cb/JQgsRKT1J86HiPmDYavGi9TzYv9GOlLqWcQHaLmuVwYpnPJogcHMd
    melQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781423348;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KVpksOCflGtFYviiLOwk026RHZjBofHh/GjLqgl7GSQ=;
    b=XhbyKnZdlSWRp8/DWl2NNUG2PpvxHAxxw09/Y6U/1kJd3J+XEQpQ/46rk9kuN9g2fr
    FifAYAJrm5DnzreA8aCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTRoMrpo2Pns16vgVmpkX3b1C/r5gOyYFIGxzfNnVzarVKfZ8Zcg="
Received: from [IPV6:2003:d5:572f:6400:c1e8:d7fa:9644:b0f3]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25E7n7LVP
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 14 Jun 2026 09:49:07 +0200 (CEST)
Message-ID: <a585092a-8fd6-4519-ad0a-1102b2773487@hartkopp.net>
Date: Sun, 14 Jun 2026 09:49:01 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] can: bcm: defer rx_op deallocation to workqueue to
 fix thrtimer UAF
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Lee Jones <lee@kernel.org>,
 Ji'an <eilaimemedsnaimel@gmail.com>
References: <20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net>
 <20260612-bcm_fixes-v1-1-ca2fa07ee70f@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260612-bcm_fixes-v1-1-ca2fa07ee70f@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7837-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:lee@kernel.org,m:eilaimemedsnaimel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hartkopp.net:dkim,hartkopp.net:email,hartkopp.net:mid,hartkopp.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82B3968097B

Document successful testing for the patch.

On 12.06.26 13:05, Oliver Hartkopp wrote:
> From: Lee Jones <lee@kernel.org>
> 
> Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> synchronize_rcu()") replaced synchronize_rcu() in bcm_delete_rx_op()
> with call_rcu() and introduced the RX_NO_AUTOTIMER flag.
> 
> However, this flag check was omitted for thrtimer in the packet rx
> fast-path. During BCM RX operation teardown, a concurrent RCU reader
> (bcm_rx_handler) can race and re-arm thrtimer via
> bcm_rx_update_and_send() after call_rcu() has been scheduled.  Once
> the RCU grace period elapses, bcm_op is freed.  The subsequently
> firing thrtimer then dereferences the deallocated op, causing a UAF.
> 
> Adding flag checks to the rx fast-path (bcm_rx_update_and_send) does not
> fully close the TOCTOU race and introduces latency for every CAN frame.
> Conversely, calling hrtimer_cancel() directly inside the RCU callback
> (softirq context) is fatal as hrtimer_cancel() can sleep, triggering
> a "scheduling while atomic" panic.
> 
> Resolve this by deferring the timer cancellation and memory free to a
> dedicated unbound workqueue (bcm_wq).  The RCU callback now queues a
> work item to bcm_wq, which safely cancels both timers and deallocates
> memory in sleepable process context.  A dedicated workqueue is used to
> prevent system-wide WQ saturation and is cleanly flushed/destroyed
> on module unload to avoid rmmod page faults.
> 
> Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
> Signed-off-by: Lee Jones <lee@kernel.org>

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Tested-by: Ji'an <eilaimemedsnaimel@gmail.com>

> ---
>   net/can/bcm.c | 29 ++++++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a55..c49b09f3229f 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -56,10 +56,11 @@
>   #include <linux/can.h>
>   #include <linux/can/core.h>
>   #include <linux/can/skb.h>
>   #include <linux/can/bcm.h>
>   #include <linux/slab.h>
> +#include <linux/workqueue.h>
>   #include <linux/spinlock.h>
>   #include <net/can.h>
>   #include <net/sock.h>
>   #include <net/net_namespace.h>
>   
> @@ -90,10 +91,12 @@ MODULE_LICENSE("Dual BSD/GPL");
>   MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
>   MODULE_ALIAS("can-proto-2");
>   
>   #define BCM_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_ifindex)
>   
> +static struct workqueue_struct *bcm_wq;
> +
>   /*
>    * easy access to the first 64 bit of can(fd)_frame payload. cp->data is
>    * 64 bit aligned so the offset has to be multiples of 8 which is ensured
>    * by the only callers in bcm_rx_cmp_to_index() bcm_rx_handler().
>    */
> @@ -103,10 +106,11 @@ static inline u64 get_u64(const struct canfd_frame *cp, int offset)
>   }
>   
>   struct bcm_op {
>   	struct list_head list;
>   	struct rcu_head rcu;
> +	struct work_struct work;
>   	int ifindex;
>   	canid_t can_id;
>   	u32 flags;
>   	unsigned long frames_abs, frames_filtered;
>   	struct bcm_timeval ival1, ival2;
> @@ -791,23 +795,34 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
>   	}
>   
>   	return NULL;
>   }
>   
> -static void bcm_free_op_rcu(struct rcu_head *rcu_head)
> +static void bcm_free_op_work(struct work_struct *work)
>   {
> -	struct bcm_op *op = container_of(rcu_head, struct bcm_op, rcu);
> +	struct bcm_op *op = container_of(work, struct bcm_op, work);
> +
> +	hrtimer_cancel(&op->timer);
> +	hrtimer_cancel(&op->thrtimer);
>   
>   	if ((op->frames) && (op->frames != &op->sframe))
>   		kfree(op->frames);
>   
>   	if ((op->last_frames) && (op->last_frames != &op->last_sframe))
>   		kfree(op->last_frames);
>   
>   	kfree(op);
>   }
>   
> +static void bcm_free_op_rcu(struct rcu_head *rcu_head)
> +{
> +	struct bcm_op *op = container_of(rcu_head, struct bcm_op, rcu);
> +
> +	INIT_WORK(&op->work, bcm_free_op_work);
> +	queue_work(bcm_wq, &op->work);
> +}
> +
>   static void bcm_remove_op(struct bcm_op *op)
>   {
>   	hrtimer_cancel(&op->timer);
>   	hrtimer_cancel(&op->thrtimer);
>   
> @@ -1837,15 +1852,19 @@ static struct notifier_block canbcm_notifier = {
>   
>   static int __init bcm_module_init(void)
>   {
>   	int err;
>   
> +	bcm_wq = alloc_workqueue("can-bcm-wq", WQ_UNBOUND, 0);
> +	if (!bcm_wq)
> +		return -ENOMEM;
> +
>   	pr_info("can: broadcast manager protocol\n");
>   
>   	err = register_pernet_subsys(&canbcm_pernet_ops);
>   	if (err)
> -		return err;
> +		goto register_pernet_failed;
>   
>   	err = register_netdevice_notifier(&canbcm_notifier);
>   	if (err)
>   		goto register_notifier_failed;
>   
> @@ -1859,17 +1878,21 @@ static int __init bcm_module_init(void)
>   
>   register_proto_failed:
>   	unregister_netdevice_notifier(&canbcm_notifier);
>   register_notifier_failed:
>   	unregister_pernet_subsys(&canbcm_pernet_ops);
> +register_pernet_failed:
> +	destroy_workqueue(bcm_wq);
>   	return err;
>   }
>   
>   static void __exit bcm_module_exit(void)
>   {
>   	can_proto_unregister(&bcm_can_proto);
>   	unregister_netdevice_notifier(&canbcm_notifier);
>   	unregister_pernet_subsys(&canbcm_pernet_ops);
> +	rcu_barrier();
> +	destroy_workqueue(bcm_wq);
>   }
>   
>   module_init(bcm_module_init);
>   module_exit(bcm_module_exit);
> 


