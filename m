Return-Path: <linux-can+bounces-8394-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9KvnNo8SVmofywAAu9opvQ
	(envelope-from <linux-can+bounces-8394-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:42:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 430577537C3
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:42:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=b1LXczD+;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=8zj2MCf9;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8394-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8394-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15C30303FD93
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 10:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD636896D;
	Tue, 14 Jul 2026 10:42:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A317436A358
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:42:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025740; cv=pass; b=SijERDtegn4HOWotapk9LU8Bl2Yf19hhGNGANrSJaQ50ftBHHudPxtopK/CSsbAxYZBKHpUBZPBYDXz9YoA1JUTILnfW9ENfgAYEMjS1A2iiNrogur0ejFbns+fsD5onuhOPEMK63ALq7HJmY3UyOLRNrDokkzQRHh+c3VZG33E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025740; c=relaxed/simple;
	bh=N8SOvgZkBChhIonIF/peRZ11JlMEy8QAcmCDl8TOeUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJAAX1t0eqbWYW9EKmSj6yV9+cCqW1vSU4mn/jriD2i7zLVhCTIaN2ehTYfxKwRyA+r/YEiYy4WYQQ5WVVLKYMbSoqB2eY8pQinCOXKCPVCEgYgVRUZfKDw0M+v/hbVdLBBLMc2OSbk0NR6EZs2ZWO013td+zMcoaEAg8tAGO9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=b1LXczD+; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=8zj2MCf9; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal: i=1; a=rsa-sha256; t=1784025736; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RLa7ZeEqM/7oWCbMWS+1NpLA/0h/SNnQUxRvHwbkcLcd7FAjteL9r6IHaIAv7cFAPH
    C8fx2XH2VzMSAA1kyn1qkFIKsqsruCyelCjhriWxwukGeFOH4fzvZb6e6LZ36cONdV2b
    nDOp0/5iY2b+UOZ+UWt9sHf/mXs1+WgVMAKNpZ1+tlrroZA8lywiwtC97//VKGkK6czJ
    nptZMGBwbHbUIUvi/WsIzNA6cJybOEDXptqLmWWz0pYIt5ClGWe7lmwN4Qsb5Dfg5dpt
    zzihf/paKNNliM6q1mn1Otqv7e1rdecmEFG4tJrRLjDPErBRGVERiUG0d6J5s3Gcrcwa
    ODig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784025736;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mhJOruwc2a+41VXyHClvW3ZTzaJA0gbaUVN9cFiiWLI=;
    b=WRhk0z3UtZ7zeXHjYRDFhSwWSL0cBMVPzjhoDVqSLl2mSGWh/a+atPmPie0qkwaeoQ
    kuWQBf117Ew4TT7UKK8AD1BGVbMlbNRvlO4Qw/uQzJRFx+d1aUy1quywvtBvu3p6X/ym
    pI/Kh712WjGtbnL70H0YyPgfdk/JDCVm6odZu8B/C0LGUTn4SGJrmKqneZjczV+wULPy
    PJEkWCdaOFvVDYowsrIKFYb9NI4DPEhvO9BKgg94hjXivvpd93NSA+LmDDI4j/PMb3H3
    G5+hoS9uPnIlKlH9XrD6585TDIEFmG8AceH7uwHJ1jofs+Ut0tFRyoiXQuV1eOZ7H92g
    gvXg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784025736;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mhJOruwc2a+41VXyHClvW3ZTzaJA0gbaUVN9cFiiWLI=;
    b=b1LXczD+02xnh8+Wo3WPYTdRpZbMcBlj+IkghHTkejIcSGqeLChMzjqOstferfKha5
    qnKVM+OdatT/yVAk/GWq/Ra8XbvnWUWkTeVDTu+X4RoTzQu0/Gu8RuPzKlWnvI/Va9rE
    J2uZiDproHcmGuYYK5Hi/+ii1JVVkAMWXeval5JNf+rl0xHaruWR+A2EwyV17/3Bba+b
    UEUgPhX+HaAVPVbgHqcLIsfYylinoIRzLXgcfPCW/23+u38q3kVGLBgg7JKRRX6tckzS
    8xensYiwAYVIFi2Q08VmvsJxGmVT5w1G/16y3G9fHzLS+GjMxsN/iuL0/25723mxwkyZ
    mCRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784025736;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mhJOruwc2a+41VXyHClvW3ZTzaJA0gbaUVN9cFiiWLI=;
    b=8zj2MCf9WtU6/WIMA5mhTbnY3fIaQrGjmxapgdTl8L8ENcZrO9vOo2uIyUemE5rduT
    KyE6TJpkc0snVZwRgtBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.190]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26EAgGjA1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 12:42:16 +0200 (CEST)
Message-ID: <e1e073b6-b133-448e-bdfd-c9ea06d71f08@hartkopp.net>
Date: Tue, 14 Jul 2026 12:42:15 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/11] can: bcm: defer rx_op deallocation to workqueue
 to fix thrtimer UAF
To: sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-1-fd667c61099a@hartkopp.net>
 <20260714103950.538C31F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260714103950.538C31F000E9@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8394-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:from_mime,hartkopp.net:dkim,hartkopp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 430577537C3



On 14.07.26 12:39, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Module exit sequence destroys the socket slab cache before flushing the deferred workqueue, causing a kernel warning and slab cache leak.
> 

Fixed later in patch 5.

> Pre-existing issues:
> - [High] Missing RCU-safe list primitives for rx_ops and tx_ops list modifications and traversals, causing potential crashes during procfs reads.
> --
> 
> --- Patch [1]: [PATCH v13 01/11] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF ---
> commit 9beb61cd8491cca022797eead8556214843e4d99
> Author: Lee Jones <lee@kernel.org>
> 
> can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
> 
> This commit fixes a use-after-free by deferring the deallocation of
> bcm_op to a dedicated workqueue instead of using call_rcu(). It ensures
> that hrtimer cancellation and memory freeing occur in a sleepable context.
> It also takes a reference on the socket while the work is pending to
> prevent the socket from being freed prematurely.
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index a4bef2c48a559..bdf53241bd7b3 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> 
> [ ... ]
> 
>> @@ -1060,6 +1081,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>>   
>>   		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>>   		op->sk = sk;
>> +		sock_hold(sk);
>>   		op->ifindex = ifindex;
>>   
>>   		/* initialize uninitialized (kzalloc) structure */
> 
> [Severity: High]
> This is a pre-existing issue, but can traversing the RCU-protected tx_ops
> and rx_ops lists without RCU-safe primitives cause crashes during procfs
> reads?
> 
> Looking at bcm_tx_setup() and bcm_rx_setup(), list_add() is used instead
> of list_add_rcu(), which lacks the smp_store_release() memory barriers:
> 
> bcm_tx_setup() {
>      ...
>      /* add this bcm_op to the list of the tx_ops */
>      list_add(&op->list, &bo->tx_ops);
>      ...
> }
> 
> Concurrently, if another thread reads /proc/net/can-bcm, bcm_proc_show()
> traverses bo->tx_ops locklessly under rcu_read_lock() using the non-RCU
> list_for_each_entry():
> 
> bcm_proc_show() {
>      ...
>      list_for_each_entry(op, &bo->tx_ops, list) {
>      ...
> }
> 
> Can weakly ordered CPUs reorder the initialization of the bcm_op structure
> after its insertion, allowing lockless RCU readers to observe uninitialized
> memory and crash?
> 
> [ ... ]
> 
>> @@ -1869,6 +1898,8 @@ static void __exit bcm_module_exit(void)
>>   	can_proto_unregister(&bcm_can_proto);
>>   	unregister_netdevice_notifier(&canbcm_notifier);
>>   	unregister_pernet_subsys(&canbcm_pernet_ops);
>> +	rcu_barrier();
>> +	destroy_workqueue(bcm_wq);
>>   }
> 
> [Severity: High]
> Does this module exit sequence destroy the socket slab cache before flushing
> the deferred workqueue?
> 
> Looking at bcm_free_op_work(), the deferred work item drops the final socket
> reference:
> 
> bcm_free_op_work() {
>      ...
>      sock_put(op->sk);
>      kfree(op);
> }
> 
> If there are pending work items in bcm_wq during module unload,
> can_proto_unregister() will call kmem_cache_destroy() on the protocol's
> slab cache while sockets are still allocated.
> 
> Will this cause a kernel warning and a slab cache leak, since
> destroy_workqueue() runs after can_proto_unregister() and will attempt to
> free sockets into the destroyed slab?
> 


