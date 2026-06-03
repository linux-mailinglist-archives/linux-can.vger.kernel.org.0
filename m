Return-Path: <linux-can+bounces-7753-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qCJTK1ogIGr5wAAAu9opvQ
	(envelope-from <linux-can+bounces-7753-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 14:38:50 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F03F63793A
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 14:38:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=Wr551Xgc;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=BrcXK5uV;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7753-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7753-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B9BC300AB21
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 12:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811F63822BF;
	Wed,  3 Jun 2026 12:36:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF547CC7A;
	Wed,  3 Jun 2026 12:36:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490201; cv=pass; b=YU2jX6znZUkI8gT3Z/nDu4UcW7KWsWcTOnXKgZ57ZN8c0KxAKO+rwApo3v61XwKo5OdeuRyVgOvhHxW4jG/m0hnj+jCmBstjhozSEoxgh4TpHqJy5O3NTYpdnfScEdqEF2YvmsvQCWlcUMd8yMxOCgFSNB+1oe82pKUBUCRwIoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490201; c=relaxed/simple;
	bh=yzSJxZ27OoKBewu+N0RwZovcKiLih5dWKFQC9c95cPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iH0554eHj3wZp6ZvSxX8jk7Y8fT0inbdLR7+3zT2nzMZhz7tiZ2F9G+W/XAO6bb7RzWqd1hU+JWRgLGBbPYxcWj2z6TQp4E0RRomxIoAR98mVeDPjdz071aCK5arbhP+YvO8xODIcXEd55szTh37/HMx1Ld8z5dHXP4MARWg2ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Wr551Xgc; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BrcXK5uV; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal: i=1; a=rsa-sha256; t=1780490010; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bSBIerlLSDXas9rcuak/7ABmy1zA6bNKhOngg5mdTE5EClvVgGwGbVDJcAKur6LtD2
    vJ49efNMnUByL5RYpFDA7DmmcCizpiIXrRdQpKIqxXUCCBXMKuyrsO3YLMWK7dWgynmI
    OBBv5Fo/jK2ZNyi9EpWJiKYF/PAz1bGLgTXQyxCCamlITUWaW7lxdVPggLei4KDehW4H
    xgKPyYlcz3XehJDk5mGuPyFZtr5ELNozN4YlmY/X+lMu3CNgZVrT1ts9sMunQFISz/rB
    MdBd+twitTdRG8uWg3cRlvOlseNCJg8Meu2Ck1/0rplSLuhtu/RVJ9dxAgThhkJJm0QH
    vvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1780490010;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=MRR3vg3P+8W6czG0SUHCd51oWSq7rgT5XFiCcSCj1JQ=;
    b=LkEOv1a93bl9Hjr4k7gpK7/V5+mu0U2ivBuBg3cNiUVwe8UWjkBmaOoU0mbqAzIpXR
    N0H40+Gm8a/NG0jTakUUr8qyHU7kMH+F3j6TtU0ZEpeRNoCFZ7QXnHh7Puy5FmIgA2cF
    hDK8umqUfhoczNxGvTbUmCm/kYZwytgnSaqdLhdYOGY4rPHVNNKLZtoHwkJnO2SCD1kd
    TSDPo19yHMDn1BJt8k7FKefcYtYm6B8u9G7/YkRuK6wcPq/eTQ3EXQrzoiBMbQ3i8mRu
    bWBmxNRav4K4Dpfl7w58Pm4xTwejunt+vF7XlSYla8ZYIjRsUU7BmT0DQXL7GtTJAwMZ
    q/Lg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1780490010;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=MRR3vg3P+8W6czG0SUHCd51oWSq7rgT5XFiCcSCj1JQ=;
    b=Wr551XgcuunSsOICcpP6BsYtYd4SLCr1d+ZSVBcdw/yQmyZLAqLecvGbgV6LPB9h0i
    M2lJamEuLbSfYNR1R92wwcTsvsji1Ere0oH7VjmsRHxijib3uI4QYu132EBs2LHPj/4x
    DtZaHdDJufHxO3pegzjDaMqp+O+n16FBIOVzdqo0seR/rdgUSyCRRyPqILpYCD7Htlr2
    B4Ej4rFcAVRfZQGggGngDLhvXqMCRhnf0tH/f/Q2JowGL0DoyLEa3FhJJh6lU/vO0L1n
    MDCkPthDOHXPjsvSM/eHbSU33me8ILrV9gZu5k5vM+FwrjoyswvEGpz5IJG5io+wMnK/
    1GrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1780490010;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=MRR3vg3P+8W6czG0SUHCd51oWSq7rgT5XFiCcSCj1JQ=;
    b=BrcXK5uVVJiwFj/z6Jn9rjWWyrqcMG0SldjMcGmEstavvUVWYRrvoC76L/5khC9QXb
    4Yh8ieO46n0G8bNnHZCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.90.236]
    by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
    with ESMTPSA id Kba96d253CXUWD4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 3 Jun 2026 14:33:30 +0200 (CEST)
Message-ID: <969151cc-5316-472b-970b-c29b8aadc1f9@hartkopp.net>
Date: Wed, 3 Jun 2026 14:33:24 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] can: bcm: defer rx_op deallocation to workqueue to
 fix thrtimer UAF
To: Lee Jones <lee@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260526165257.3705239-1-lee@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260526165257.3705239-1-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7753-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lee@kernel.org,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:dkim,hartkopp.net:from_mime,hartkopp.net:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F03F63793A



On 26.05.26 18:52, Lee Jones wrote:
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

I was not able to trigger the problem with an unpatched kernel for two 
days now - and this patch does not seem to make it worse.

Btw. @Marc: Do you plan to send some updates for the net tree for rc7?

If so, the two KCSAN fixes

https://lore.kernel.org/linux-can/20260522180758.51128-1-socketcan@hartkopp.net/T/#t

should be considered too.

Best regards,
Oliver


> ---
> v1 => v2: New patch using workqueues
> v2 => v3: Add memory barrier
> 
>   net/can/bcm.c | 29 ++++++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a55..c49b09f3229f 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -58,6 +58,7 @@
>   #include <linux/can/skb.h>
>   #include <linux/can/bcm.h>
>   #include <linux/slab.h>
> +#include <linux/workqueue.h>
>   #include <linux/spinlock.h>
>   #include <net/can.h>
>   #include <net/sock.h>
> @@ -92,6 +93,8 @@ MODULE_ALIAS("can-proto-2");
>   
>   #define BCM_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_ifindex)
>   
> +static struct workqueue_struct *bcm_wq;
> +
>   /*
>    * easy access to the first 64 bit of can(fd)_frame payload. cp->data is
>    * 64 bit aligned so the offset has to be multiples of 8 which is ensured
> @@ -105,6 +108,7 @@ static inline u64 get_u64(const struct canfd_frame *cp, int offset)
>   struct bcm_op {
>   	struct list_head list;
>   	struct rcu_head rcu;
> +	struct work_struct work;
>   	int ifindex;
>   	canid_t can_id;
>   	u32 flags;
> @@ -793,9 +797,12 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
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
> @@ -806,6 +813,14 @@ static void bcm_free_op_rcu(struct rcu_head *rcu_head)
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
> @@ -1839,11 +1854,15 @@ static int __init bcm_module_init(void)
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
> @@ -1861,6 +1880,8 @@ static int __init bcm_module_init(void)
>   	unregister_netdevice_notifier(&canbcm_notifier);
>   register_notifier_failed:
>   	unregister_pernet_subsys(&canbcm_pernet_ops);
> +register_pernet_failed:
> +	destroy_workqueue(bcm_wq);
>   	return err;
>   }
>   
> @@ -1869,6 +1890,8 @@ static void __exit bcm_module_exit(void)
>   	can_proto_unregister(&bcm_can_proto);
>   	unregister_netdevice_notifier(&canbcm_notifier);
>   	unregister_pernet_subsys(&canbcm_pernet_ops);
> +	rcu_barrier();
> +	destroy_workqueue(bcm_wq);
>   }
>   
>   module_init(bcm_module_init);


