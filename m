Return-Path: <linux-can+bounces-7665-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CTBONWQDWpyzgUAu9opvQ
	(envelope-from <linux-can+bounces-7665-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 12:45:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDC658BE87
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 12:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 813E1300E254
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 10:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B9A371898;
	Wed, 20 May 2026 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="clrzMXsr";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QJpi01rV"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C772EFD95;
	Wed, 20 May 2026 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273937; cv=pass; b=VPqPUxUSHlSBCBA/aeD3deBFO5/1U2nlDi1xX0pQXuB9X1HJ4j6K5sWUfYsUNOWizcPy4mFCRO0gcSiRtv1nAnhk5qJM/w0o5dKzE9hfd+Pm7tZfvwrRji5c+Unkb7HxiImJRGgo6f1cmtLnqRwJ43f93Dp/reHpx5QWDSbCvzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273937; c=relaxed/simple;
	bh=oPwPKMwlQbd2PvFGmv3QbhjcdHtCUQWRTxMo9hYRGFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfwv43S96q3xEG6HWFtEUT5bENJ+IViR9uyrDmZt+FZanitk86PVFWI9YTjQerSUtaOpIVFf9dMnduQn20yAR+xTSnTLAam7JVm/mDXb6HA2wz82wr1zq9OeFSfccp4+qEb9Zsy20dRkCiy4F1vV7mUNcRGpxHzeDm0L/bQEb3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=clrzMXsr; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QJpi01rV; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779273927; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JKq8oWwSBs7mxu0MCmmANJ+gh8ZykUSGpn8bZxc7h+NfeTbm+K2BVMnwCiwDbUpOkt
    ZeSTN522rb9r3ouhT+tRnNPGppXwC5XbKNk1p0vQl9SIayd75/4HG8m+9O1Ab8/CYRQx
    vL7vbmU3kGQB7pjFWXQC0IIlGIIwqgZLRcF3H6yrtYId/Z4QVNKbbUkhfWmwqnrCYHdi
    1GaJW68mLGzLBUG/IKay9xmqwVOTZtBW+dD+KIRzRye0MZMmm57kB4B8R43/lgNyhatH
    rj4GPKYKoOOSbxCfLOVJ0kWmnK0ZFMsgSu4FoUDC2o4+4sa8Y43kBqe607w+WE68/wuH
    pUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779273927;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RRJ1EN9ucnIbuMKXXHAQnuoatE/qctP3UIG4crlVEnM=;
    b=YwbtN7T9WleEbLr1wotInLg9nnmaIHXQXuwuaM0OdWlHng+clG6VhGyBr1CC0QrBIS
    yNDUJe/C7FBV+Gq7RgkjKFQ1px1fhJGT8WDnJ8c727XW7GV/E1QxCOxpmNhNmuPFGZfa
    cKHbE173OxWMnN4H7LOQpBnSKyrO4JBFWXHLMj9/u277SmFmolxr35P6GsN4bd4AQLTZ
    bC8id8lFCJCLz7EqM10bmpA5cCZeM9VltGJTa9AnsVuNkO8wEHhjd99SuWLebd7iurdJ
    sGaytIR/NpU7s/3ElbjaUBcknNsoG7ZJ/Of89OyYyK7dpTagrREqr1c69z5IyC0aP91g
    eyeQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779273927;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RRJ1EN9ucnIbuMKXXHAQnuoatE/qctP3UIG4crlVEnM=;
    b=clrzMXsrj7moGE6pjBpTVpp9sm/SMzUMi4I59irn4L0GrbpOYQXblMf+mWUcLOUuJD
    /9DJHkm3cvA98uDTzXLly73lI+nHL5fCEekmJv+TT6vYSUB64cc6rP1Gx2LzrOuh8lvf
    g8BhZaBeU+s7Sy+BMLwnXKrivciNoOfD8hba55DKMqnfzkcZgKHrsYqbW81qRCzQgk+D
    ariU7vUtRp0BKomF87eFykLEy9nhH8z+E0cXCoar4LijzzQGTlRJ7tGoCK0xVpLZXQc1
    VaWNy9i8oLBgScdxZilkliq69qWACIDpB9goKkJbvtufRWIuClFLu8s+W0f2J9lZ2tvq
    hoLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779273927;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=RRJ1EN9ucnIbuMKXXHAQnuoatE/qctP3UIG4crlVEnM=;
    b=QJpi01rVMuoLRGKFO0AA4R4fubCtjt8Bt1mDI6WQpa8TAoo0iFwPEfrJhfB+2xh98W
    i8rQmp4Fsv1+PnLxaRDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24KAjRKk7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 20 May 2026 12:45:27 +0200 (CEST)
Message-ID: <e17d9fd4-33cf-4602-8928-c347d19127f6@hartkopp.net>
Date: Wed, 20 May 2026 12:45:20 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] can: bcm: defer rx_op deallocation to workqueue to
 fix thrtimer UAF
To: Lee Jones <lee@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kuba@kernel.org
References: <20260520080523.2513957-1-lee@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260520080523.2513957-1-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7665-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,claude.ai:url]
X-Rspamd-Queue-Id: 4BDC658BE87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Lee,

did you check my changes to your original patch?

https://lore.kernel.org/linux-can/20260519113806.85456-1-socketcan@hartkopp.net/T/#u

I double checked the code with claude.ai (Sonnet 4.6) and it should fix 
the issue without a workqueue.

Best regards,
Oliver

On 20.05.26 10:05, Lee Jones wrote:
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
> ---
> Not v2 per-say - this is replaces the following with a different approach:
> 
> can: bcm: prevent thrtimer UAF in rx path by checking RX_NO_AUTOTIMER
> - https://lore.kernel.org/r/20260422102239.948594-1-lee@kernel.org
> - https://lore.kernel.org/r/20260508151237.7d0a9105@kernel.org
> 
>   net/can/bcm.c | 28 +++++++++++++++++++++++++---
>   1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a55..fa42c0f89f4e 100644
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
> @@ -1869,6 +1890,7 @@ static void __exit bcm_module_exit(void)
>   	can_proto_unregister(&bcm_can_proto);
>   	unregister_netdevice_notifier(&canbcm_notifier);
>   	unregister_pernet_subsys(&canbcm_pernet_ops);
> +	destroy_workqueue(bcm_wq);
>   }
>   
>   module_init(bcm_module_init);


