Return-Path: <linux-can+bounces-7679-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGdQNlcADmo95QUAu9opvQ
	(envelope-from <linux-can+bounces-7679-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 20:41:27 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD95596FE4
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 20:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7616838EBB67
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D56B3F871A;
	Wed, 20 May 2026 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ohPkwtD3";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="r28cp1Mp"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93113769E0
	for <linux-can@vger.kernel.org>; Wed, 20 May 2026 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300068; cv=pass; b=mkxYnY1JkK0zvcUaj6dTbilbyVfOAE01o1ULS8ue3MJC8vUmo1aPmKjYcot80c6StGMKybqtMMjgcjjDJEZVsGG4IUkyKOpVVw079rAt9+pygnogRkyXtuKJghf2ijKVN8oWCk+kozj1Mrcs+J/3Tdqp6vQB0MZ34UBaftUlesw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300068; c=relaxed/simple;
	bh=9ouJVZPcksNcRMgLTdObOGOvkS3/dY4f2wdEU/mtfFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tz6+KJyIDoT/7Hc1hbZ0XHX5VVo6WaDxME1YUZY5iBgleEIsZEzVPAppeWrNwodj8nW/6xnkypDSGyKmCACKbmKLAT3LrQ9RjjPxUdI8M1/hYqT8QWBA0BixBg9IpO10YlVP4gTRaY8DmmRQPHFQJxLinSshgsaLQZ2CHUFZeB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ohPkwtD3; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=r28cp1Mp; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779300058; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=flfvi0vFkKEHqBvvk8sDHKhPgEPe0WuDh/VKXBrIwIeoebWrBMlEKRfleH9fRxYPj5
    WwH7iH6Eg9afOrFrRhLk5UeUw9yy3m78KTt9VYv5oZDGiqDoXaNraFUsyxiHn4D2PRzw
    O3jalbuainciUTojm32MJAznKqC+gGUr0LNhbaKZcP7VWy6j3Rz5OBYKUUhILNG9Diki
    3YzWJV0JCOueczfJIW8wEhsriOLrsw5UFa4gdPlqmDCTUkP21hctjMf8YZ4H5oCxJ+2B
    00a2S2eK8RKhfUXgdMF39Ipr7k97ZRvxp86nU2wEK838W6oBSl1FUWdB3ZQ+sYieiSUo
    8zkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779300058;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fbjMTNgpquxkOv2u7BtlzS4ztHFaKQOe5oNAIc3JISU=;
    b=p0IpHgpNHfinVbMVls3RwJPxL+5fzJysmbCAlhGBo0bcdO+w52spVcpJrdv+asMnSE
    iXTKI+ybrYDDB+rxrAJrL81oWy+7IzJJPfpI890flzFfS7FviXv+zptUOV1ifHWYcBtY
    kmAQP58moq/ZgJPNl+tmyV4Y2h3O/XpIeG78l6lPfcpeXOpXR47wlpq1ga9oqxs3fWv9
    VXfvVTB3vYaC/A+kpvlIT4o6u5RwSoOtsw2SAGkAm9xz3M7BM4Qivab67TrMdj+lJC8y
    +Dkq9XtKb5vFShbnWB+hwOLdRy4tVuMeVbqbBUgaGWViIchrnTbjOMUDtj1zQhOgPBdZ
    ctRw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779300058;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fbjMTNgpquxkOv2u7BtlzS4ztHFaKQOe5oNAIc3JISU=;
    b=ohPkwtD35MZZzEaCvZqcFizRRiaPijlvNBkORCvF3Vca63AgTmLdI/p8u3HrPHnzQN
    833gDFY6DFEj76P22HtwA6lPqUUctK1eUFzewPIcqmjZ/WqJ231Lm5uBVxa8Rhy2s21c
    LZ6qqHILm3cK5/rO1u+YovROkFv/ni8oht0EnP+AXlhXLRxHJFILBAhUKUmAYgZumTaZ
    yZ1jmxFUeBI2uK+fHMuwjIWKUYlkYq0ghrraCwv5P4IvgdXQe6wSritWW7uh2dvmLfgA
    gnvkChS4JRMj7ZFaaaXiVrp6faJ7DM44t8fvd0Gxj6T92SXUNgpqpiC4K3lSz9JL7nE2
    a0lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779300058;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fbjMTNgpquxkOv2u7BtlzS4ztHFaKQOe5oNAIc3JISU=;
    b=r28cp1Mp+XOQey/oCK66khoE/V/GuK49A/Gvc+XJzo8zklKvYqohXThimf2un3wT/J
    Qgle3dD6neCuOgyAe2AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24KI0vMKO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 20 May 2026 20:00:57 +0200 (CEST)
Message-ID: <7d21ad57-3de9-4eac-a51d-15b6dfaf3bae@hartkopp.net>
Date: Wed, 20 May 2026 20:00:51 +0200
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260520161308.GL2767592@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-7679-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0FD95596FE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 20.05.26 18:13, Lee Jones wrote:
> On Wed, 20 May 2026, Oliver Hartkopp wrote:
> 
>>
>>
>> On 20.05.26 16:06, Lee Jones wrote:
>>> On Wed, 20 May 2026, Lee Jones wrote:
>>>
>>>> On Wed, 20 May 2026, Oliver Hartkopp wrote:
>>>>
>>>>>
>>>>>
>>>>> On 20.05.26 14:49, Lee Jones wrote:
>>>>>> On Wed, 20 May 2026, Lee Jones wrote:
>>>>>>
>>>>>>> On Tue, 19 May 2026, Oliver Hartkopp wrote:
>>>>>>>
>>>>>>>> From: Lee Jones <lee@kernel.org>
>>>>>>>>
>>>>>>>> Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
>>>>>>>> synchronize_rcu()") removed the synchronize_rcu() call from
>>>>>>>> bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
>>>>>>>> timers from being rearmed during deletion.  However, it only applied
>>>>>>>> this check to op->timer via bcm_rx_starttimer().
>>>>>>>>
>>>>>>>> It missed the fact that op->thrtimer can also be rearmed by an
>>>>>>>> in-flight bcm_rx_handler() (which runs as an RCU reader) via
>>>>>>>> bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
>>>>>>>> bcm_remove_op() has already cancelled it, leading to a use-after-free
>>>>>>>> when the timer fires on the deferred-freed struct bcm_op.
>>>>>>>>
>>>>>>>> Address the omission by checking the RX_NO_AUTOTIMER flag
>>>>>>>> in bcm_rx_update_and_send() before starting op->thrtimer, effectively
>>>>>>>> preventing it from being rearmed concurrently with teardown.
>>>>>>>>
>>>>>>>> [Hartkopp] Added the setting of RX_NO_AUTOTIMER also to bcm_release() before
>>>>>>>> removing the CAN filters following the bcm_delete_rx_op() approach.
>>>>>>>>
>>>>>>>> Additionally WRITE_ONCE()/READ_ONCE() macros have been introduced for
>>>>>>>> the changes of RX_NO_AUTOTIMER at rx op removal time to prevent a
>>>>>>>> potential code reordering of RX_NO_AUTOTIMER setting after CAN filter removal.
>>>>>>>>
>>>>>>>> Signed-off-by: Lee Jones <lee@kernel.org>
>>>>>>>> Co-developed-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>>>>>
>>>>>>> You did?  Can you add a note saying what you changed please?
>>>>>>
>>>>>> FYI, did you also see the second swing I took at this:
>>>>>>
>>>>>> https://lore.kernel.org/r/20260520080523.2513957-1-lee@kernel.org
>>>>>
>>>>> Yes, and I answered to your patch.
>>>>>
>>>>> Is there some lag in the e-mail communication right now?
>>>>>
>>>>> That's why I also wondered why you sent a patch one day after my v2
>>>>> proposal.
>>>>
>>>> Right.  I only saw your proposal today.
>>>>
>>>> I've been working the alternative since Jakub NACKed the first submission.
>>>
>>> Okay, so I fed both of our v2 fixes into Gemini Next and requested a
>>> critical review of both approaches.  The TL;DR is that this v2 is better
>>> than my v1, but still contains the reported race and isn't as solid as
>>> the work queue solution.
>>>
>>> In the interest of full disclosure, here is the full analysis for your perusal:
>>>
>>>     I have critically evaluated the alternative patch ( branch: b-499356389-can-bcm-uaf-v2 ) currently in contention on the mailing list.
>>>
>>>     While this alternative patch represents a highly refined version of the "flag check" approach (incorporating memory barriers and socket
>>>     release hooks), it is still architecturally inferior to our Workqueue-Deferred Process Context Cleanup.
>>>
>>>     Below is the critical technical comparison of how the alternative patch fares against our solution, focused on race resilience,
>>>     performance hot-paths, and upstream validation.
>>>     ──────
>>>     ### 1. The TOCTOU Race Window is Still Theoretically Open
>>>
>>>     The core mechanism of the alternative patch relies on setting  RX_NO_AUTOTIMER  via  WRITE_ONCE  and checking it inside the hot-path (
>>>     bcm_rx_update_and_send ) via  READ_ONCE .
>>>
>>>     While  READ_ONCE / WRITE_ONCE  enforce  volatile  memory accesses and prevent compiler reorderings, they do not provide hardware-level
>>>     atomic synchronization or serialization (such as spinlocks or memory barriers like  smp_mb() ) between the check and the timer arming.
>>>
>>>     This leaves a classic Time-of-Check to Time-of-Use (TOCTOU) race window open:
>>>
>>>       CPU A (RCU Reader: bcm_rx_handler)         | CPU B (Writer: bcm_delete_rx_op)
>>>       -------------------------------------------+-------------------------------------------
>>>       READ_ONCE(op->flags) & RX_NO_AUTOTIMER     |
>>>       /* flag is NOT set; passes check */        |
>>>                                                  | WRITE_ONCE(op->flags, flags | RX_NO_AUTOTIMER);
>>>                                                  | hrtimer_cancel(&op->thrtimer); /* Returns 0 (no-op) */
>>>                                                  | call_rcu(&op->rcu, bcm_free_op_rcu);
>>>       hrtimer_start(&op->thrtimer, ...);         |
>>>       /* thrtimer is armed AFTER cancellation! */|
>>>                                                  | RCU grace period elapses...
>>>                                                  | bcm_free_op_rcu() -> kfree(op);
>>>       thrtimer fires                             |
>>>         bcm_rx_thr_handler(op) [UAF CRASH!]      |
>>>
>>>     If CPU B executes the write and the cancellation after CPU A has evaluated the  READ_ONCE  flag check but before CPU A calls
>>>     hrtimer_start() , the cancellation is a no-op, the timer is successfully armed, and the Use-After-Free occurs once RCU frees the memory.
>>>
>>>     #### Why Our Solution is Bulletproof:
>>>
>>>     Our Workqueue-deferred cleanup does not rely on flag synchronization. Because  bcm_free_op_work  executes after the RCU grace period has
>>>     fully elapsed, all in-flight RCU readers ( bcm_rx_handler ) are guaranteed to have exited. Therefore, any possible racing
>>>     hrtimer_start()  has already executed, and our final  hrtimer_cancel()  right before  kfree(op)  is guaranteed to catch and safely
>>>     neutralize the active timer. Our design mathematically eliminates the TOCTOU race.
>>>     ──────
>>>     ### 2. Hot-Path Performance Overhead
>>>
>>>     • The Alternative Patch:
>>>     It introduces a volatile read check ( READ_ONCE(op->flags) & RX_NO_AUTOTIMER ) inside  bcm_rx_update_and_send() . This is the critical
>>>     fast-path executed for every single CAN frame matching the socket filters. Under high-frequency industrial or automotive CAN bus routing,
>>>     adding branch/conditional instructions to the packet hot-path introduces cumulative latency.
>>>     • Our Solution:
>>>     Leaves  bcm_rx_update_and_send()  completely pristine. Zero hot-path overhead is introduced.
>>>     ──────
>>>     ### 3. Evaluation Summary Against All Solutions
>>>
>>>      Architectural Criteria   │ Solut… │ Solut… │ Alternative Patch (Commit  2074ea86 )       │ Our Solution: Dedicated Workqueue ( can-bc…
>>>     ──────────────────────────┼────────┼────────┼─────────────────────────────────────────────┼─────────────────────────────────────────────
>>>      TOCTOU Race Resilience   │ ❌     │ None   │ ⚠️ Weak (TOCTOU race window remains open on │ Bulletproof (RCU grace period guarantees
>>>                               │ Vulner │ (Fatal │ SMP concurrency).                           │ all readers have completed).
>>>                               │ able   │ )      │                                             │
>>>      Atomic Context Safety    │ Safe   │ ❌     │ Safe (Cancellations performed in process    │ Safe (Cancellations executed in sleepable
>>>                               │        │ FATAL  │ contexts).                                  │ process context).
>>>                               │        │ PANIC  │                                             │
>>>                               │        │ (Calls │                                             │
>>>                               │        │ hrtime │                                             │
>>>                               │        │ r_canc │                                             │
>>>                               │        │ el  in │                                             │
>>>                               │        │ softir │                                             │
>>>                               │        │ q      │                                             │
>>>                               │        │ callba │                                             │
>>>                               │        │ ck).   │                                             │
>>>      Fast-Path Packet Latency │ ❌     │ None   │ ❌ Overhead (Volatile branch check in       │ Zero Latency (Fast-path remains untouched).
>>>                               │ Overhe │        │ packet hot-path).                           │
>>>                               │ ad     │        │                                             │
>>>                               │ (Hot-  │        │                                             │
>>>                               │ path   │        │                                             │
>>>                               │ checks │        │                                             │
>>>                               │ ).     │        │                                             │
>>>      Module Unloading Safety  │ Safe   │ None   │ Safe                                        │ Safe ( destroy_workqueue  flushes WQ before
>>>                               │        │        │                                             │ code unmap).
>>>      Workqueue Saturation     │ None   │ None   │ None                                        │ Safe (Isolated dedicated WQ prevents system
>>>                               │        │        │                                             │ starvation).
>>>     ──────
>>>     ### Conclusion: What Will Upstream Say?
>>>
>>>     If reviewed critically by upstream LLMs or senior maintainers:
>>>
>>>     1. They will point out the TOCTOU race in the alternative patch: Reviewers will recognize that  READ_ONCE / WRITE_ONCE  do not enforce
>>>     synchronization between the flag check and  hrtimer_start() , leaving the UAF theoretically reachable under tight SMP concurrency.
>>>     2. They will prefer our zero-overhead fast-path: Upstream networking maintainers always favor solutions that isolate teardown logic to
>>>     the asynchronous slow-path (workqueues) rather than polluting the hot packet-reception path with cleanup flags.
>>>
>>>     Our Dedicated Unbound Workqueue design remains the most mathematically secure, performant, and architecturally elegant fix for this
>>>     vulnerability.
>>>
>>
>> Ok, thanks for the detailed explanation!
>>
>> As your updated patch fixes the original patch
>>
>> f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
>> synchronize_rcu()")
>>
>> we should also revert this op->flags setting that has been introduced with
>> that patch in addition to the rcu stuff, right?
>>
>> @@ -755,10 +763,13 @@ static int bcm_delete_rx_op(struct list_head *ops,
>> struct bcm_msg_head *mh,
>>
>>          list_for_each_entry_safe(op, n, ops, list) {
>>                  if ((op->can_id == mh->can_id) && (op->ifindex == ifindex)
>> &&
>>                      (op->flags & CAN_FD_FRAME) == (mh->flags &
>> CAN_FD_FRAME)) {
>>
>> +                       /* disable automatic timer on frame reception */
>> +                       op->flags |= RX_NO_AUTOTIMER;
>> +
> 
> You mean from v1?  I thought that was NACKed and not applied?

No. These two lines were introduced in the original patch you aim to 
fix. So when fixing the original "use call_rcu() instead of costly 
synchronize_rcu()" patch that introduced the rcu stuff, this now 
obsolete op->flags |= RX_NO_AUTOTIMER should be removed too.

Best regards,
Oliver


> 
> My follow-up was a replacement for it.
> 


