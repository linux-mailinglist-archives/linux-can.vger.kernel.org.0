Return-Path: <linux-can+bounces-7683-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C21D1HvDmqmDQYAu9opvQ
	(envelope-from <linux-can+bounces-7683-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 21 May 2026 13:41:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9734D5A4262
	for <lists+linux-can@lfdr.de>; Thu, 21 May 2026 13:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 235CC3050473
	for <lists+linux-can@lfdr.de>; Thu, 21 May 2026 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633303C378D;
	Thu, 21 May 2026 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="rQmQBJkk";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="/3F/OpoQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913F73148D2
	for <linux-can@vger.kernel.org>; Thu, 21 May 2026 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363353; cv=pass; b=CHcOShDufpVxP4ctsRC4GHG+DdwHYO4FEPGQ24BbAky97wkXlW1h3NJx74gSE1YjEH79cLecttuxe+4nfCc3jbvrLdl1qd2jUEDSMqgX1vNuiu7jsbC6mliUd8PZn2WLbGtQoC6XzRkxvy8rrqABwFMbfmSOVAuBTNPwE1me3i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363353; c=relaxed/simple;
	bh=AbsUZpz5wSghlRnWKwWyPQ3Z50cFVDMqpMKN5JOrkI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5r5bPhNhpcx1gnzpI7iL+heSnfs16H7UqhQlN/DxZXiP3Wcb8T0ABJvR6c3GqPFUue1/6rQBm9RxAkssTLfyUCtaRyoKsXz3Ybrhfra77Emhq0palyphLPwejovrblAJNqiUyJ2JAglKA/S7xxaaEAWLZlzSsxk8OQvl2BGVoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=rQmQBJkk; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=/3F/OpoQ; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779363343; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RINn/0l6CC/ZdOV27Ctm+v1gjVUfPUY+jMRfOHR9S7OkqP7l6rd4eu6KV8GkKd+ilp
    M1Sh/dNIMC1uPsxsbI3RyMTdhNJrMF7QFfAzhBywRfWhdLC2S7TAyvohJUAiwxTi6gqF
    yWRMjIpvSM69RxbZh+Ty2ARxvaoq0q+wfsrDXtK9qC4rLK0ozq5YbZOwXHFT9WmpODmh
    kcBdv0PJe/LFoeStXn9DwubqX0AASjTCWHh7Dt+ZILQtqCo8DAWVr2jyJ06Kgj4DtZcq
    rlgCV3VEUS0zOhtKK8Rr0Pk5HgSPQRwlz4ynPnLEV1056GGAmA9ZRqRTPj9q6JUogYm9
    sBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779363343;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7r4rfL9aGfmcPmvbqXec1d92q1K4//ZGgfbJhc8QTNQ=;
    b=rBkxKokZY44GYwpF0bfx/6L8vnfHP9MhziXq8EOi8cl9FV2IHLJGPmlscs/SqGiF4G
    0wIzsSvsiaNToRfO/QML1UK/a0Uh+v3sBSSoDLpaYezockYkg+RY1eIKnVTZpuV6rTt9
    a/YUCYqAS0o5N46mqEDkVLeEoKtgR1VziW9tz6zKM2zle6AaNgN00rlLG9YmSECx+vSt
    ZnJWKsplhJSEV9t6Ttbt6k+j3s2TTYXkhkL54XBc9vlHScLYCj6IvHXdMBlocPlW1UWD
    6vWlzz+sbow3DnoOYj6dYrbUvhm2r2/Dar5LzT4nrRQACx2lt3R51VNwU0u+Ocs8VU/6
    vkTA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779363343;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7r4rfL9aGfmcPmvbqXec1d92q1K4//ZGgfbJhc8QTNQ=;
    b=rQmQBJkkdTnNlS2SiLPjgWImGzm/ut5JRN103G5rIhqM08DrCAEl8MitnPhxjUJm7D
    UUU58DabAkrQXx2viROoxtkMrcwLGnE5eEwNzznxna0NKCejolr1towhnvS4OYflafbK
    uKUvFCFomb1M5LonMPEfCPsthXWZHdHHp7mC9fhFln+PtFCRGsuxIZQc6Fdum+y1LAvP
    gXasmnl5cD3bUt5MCFk7b0BRQ2oqRTF2S2L9UM9mI3mm8Rx/nswfiZ31luXdhiH6VfKp
    YiaILMQTdCSfcYPmRLbREvSL9IxgSaPAoAuh02+enY1auIMRmmCLCwKAeXsi/4UxmKwQ
    GsXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779363343;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7r4rfL9aGfmcPmvbqXec1d92q1K4//ZGgfbJhc8QTNQ=;
    b=/3F/OpoQKS16VI2REr6jrjt4iib1BL7eaHA+6JHYILncNtj6FV3PZEZqE9mcWVrF/f
    Ym1N51WNk3trOisOEACg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24LBZgOuT
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 21 May 2026 13:35:42 +0200 (CEST)
Message-ID: <80f98c44-e9f3-45e2-989f-32f1a7c2c38b@hartkopp.net>
Date: Thu, 21 May 2026 13:35:38 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
To: Lee Jones <lee@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20260519113806.85456-1-socketcan@hartkopp.net>
 <20260520124758.GA305027@google.com> <20260520124907.GB305027@google.com>
 <442a92c9-5810-4fcd-ab05-5b0acd0f345c@hartkopp.net>
 <20260520134032.GA2767592@google.com> <20260520140657.GC2767592@google.com>
 <24a20c37-5cac-4a38-a8f1-ed98b38f7e1d@hartkopp.net>
 <20260520161308.GL2767592@google.com>
 <7d21ad57-3de9-4eac-a51d-15b6dfaf3bae@hartkopp.net>
 <20260521110708.GC2921053@google.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260521110708.GC2921053@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7683-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: 9734D5A4262
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 21.05.26 13:07, Lee Jones wrote:
> On Wed, 20 May 2026, Oliver Hartkopp wrote:
>>>> Ok, thanks for the detailed explanation!
>>>>
>>>> As your updated patch fixes the original patch
>>>>
>>>> f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
>>>> synchronize_rcu()")
>>>>
>>>> we should also revert this op->flags setting that has been introduced with
>>>> that patch in addition to the rcu stuff, right?
>>>>
>>>> @@ -755,10 +763,13 @@ static int bcm_delete_rx_op(struct list_head *ops,
>>>> struct bcm_msg_head *mh,
>>>>
>>>>           list_for_each_entry_safe(op, n, ops, list) {
>>>>                   if ((op->can_id == mh->can_id) && (op->ifindex == ifindex)
>>>> &&
>>>>                       (op->flags & CAN_FD_FRAME) == (mh->flags &
>>>> CAN_FD_FRAME)) {
>>>>
>>>> +                       /* disable automatic timer on frame reception */
>>>> +                       op->flags |= RX_NO_AUTOTIMER;
>>>> +
>>>
>>> You mean from v1?  I thought that was NACKed and not applied?
>>
>> No. These two lines were introduced in the original patch you aim to fix. So
>> when fixing the original "use call_rcu() instead of costly
>> synchronize_rcu()" patch that introduced the rcu stuff, this now obsolete
>> op->flags |= RX_NO_AUTOTIMER should be removed too.
> 
> Is that not orthogonal to the fix?
> 
> If it is, would you be kind enough to submit a fix (and get your own
> creds up ;-D).  This is usually something that I'd gleefully pick up,
> but I'm absolutely inundated with vulnerability reports right now.
> 

Yes, of course I can clean this up later. But not for getting extra 
creds :-)

Btw. have you seen the AI remark on your patch that asks about an 
additional rcu_barrier() in bcm_module_exit() ?

https://netdev-ai.bots.linux.dev/ai-review.html?id=9e8842e7-59a2-4ec5-9f65-1df7973c6170

says this:

 > @@ -1870,6 +1891,7 @@ static void __exit bcm_module_exit(void)
 >  	can_proto_unregister(&bcm_can_proto);
 >  	unregister_netdevice_notifier(&canbcm_notifier);
 >  	unregister_pernet_subsys(&canbcm_pernet_ops);
 > +	destroy_workqueue(bcm_wq);
 >  }

Does bcm_module_exit need an rcu_barrier() call before destroy_workqueue?
Consider this sequence:

A socket is being closed while the module is unloading:

   bcm_release()
     bcm_remove_op()
       call_rcu(&op->rcu, bcm_free_op_rcu)  // RCU callback scheduled

   Module refcount reaches zero, rmmod proceeds

   bcm_module_exit()
     can_proto_unregister(&bcm_can_proto)
     unregister_netdevice_notifier(&canbcm_notifier)
     unregister_pernet_subsys(&canbcm_pernet_ops)
     destroy_workqueue(bcm_wq)             // bcm_wq destroyed

   RCU grace period elapses

   bcm_free_op_rcu()                       // callback fires
     INIT_WORK(&op->work, bcm_free_op_work)
     queue_work(bcm_wq, &op->work)         // UAF: bcm_wq already freed

The RCU callback queues work to bcm_wq, but if the callback hasn't fired
yet when bcm_module_exit runs, it will try to queue_work to a destroyed
workqueue. Before this patch, bcm_free_op_rcu called kfree directly without
using module-global resources, so this wasn't an issue.

Should bcm_module_exit call rcu_barrier() before destroy_workqueue to
ensure all pending RCU callbacks complete first?

Many thanks,
Oliver


