Return-Path: <linux-can+bounces-7678-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJT0IR/rDWrM4gUAu9opvQ
	(envelope-from <linux-can+bounces-7678-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 19:10:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 135FE59309E
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B666F313674D
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF4B352027;
	Wed, 20 May 2026 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXvzXIyj"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9BB672
	for <linux-can@vger.kernel.org>; Wed, 20 May 2026 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293593; cv=none; b=phii3y5O5zpEKA39eckHIj4OC5dfsnP14RKEMF2YBnxc9IQPdLgMQoBPgvK6zrka4liaePE7jR12gUREnuM1pRmPZyJKhbjUkNPK5HHc81tYjnn7fi0tlrt5mzRFYw9kP/lM/GHCYF5nuXiMVg23RS3KMQPR6evyxaoYrCPsvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293593; c=relaxed/simple;
	bh=Cym9PMPqKRHiYBhPeKIARQM6LU22Xd2RXWQ5tPO6Av4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GObW9PQjHgO1g1TbPbZm2HdlN6GEyQfxRO5iAlRl3tFKjr3UNZ5Mr1JFYBiU4K4HoPYBCslaRB65A9arzQFkeTufgHDumCCe73oCz7TrTqbW0zeKxYCS4KxWekQNwhkhzTrwNBJl/esUXOr3db6svChYVNlbITZ4jNhUPfCGgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXvzXIyj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65061F000E9;
	Wed, 20 May 2026 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779293591;
	bh=J6VDHfnTnHrtFU0bktwfS5hMARPKsedf9w9Y3u0HFzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YXvzXIyjwFqwZsspADxrfoIdxQhQk75AnTH3WSq0cBq2KV7MilVxhwzwGpBhfBTDb
	 RvmVHDQji1vMKj5HJAzX58BFzptbhx7I20+od9rvbs7xkyqctfw2aUsQTuEccvHwrL
	 /NUnw1CpOJ+8AzKLjmBnEGy8v79TgrBW4WaY3h2gA8umE8+BBM8IDepC//hVI4jnec
	 sxlZu3w3yypzMfpfehQJp+DcndNC3K7giCGT0sRy/sFEmK8JpR3SUC1nVKTzmuOiAa
	 o5ZH2851a4OhRlDpYsaYWv3hmxBn0ypJBKheuzr1LBKyP5SYSZCv14MJFhXV0Jf99u
	 QmA23fvkHixiw==
Date: Wed, 20 May 2026 17:13:08 +0100
From: Lee Jones <lee@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
Message-ID: <20260520161308.GL2767592@google.com>
References: <20260519113806.85456-1-socketcan@hartkopp.net>
 <20260520124758.GA305027@google.com>
 <20260520124907.GB305027@google.com>
 <442a92c9-5810-4fcd-ab05-5b0acd0f345c@hartkopp.net>
 <20260520134032.GA2767592@google.com>
 <20260520140657.GC2767592@google.com>
 <24a20c37-5cac-4a38-a8f1-ed98b38f7e1d@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24a20c37-5cac-4a38-a8f1-ed98b38f7e1d@hartkopp.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7678-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hartkopp.net:email]
X-Rspamd-Queue-Id: 135FE59309E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026, Oliver Hartkopp wrote:

> 
> 
> On 20.05.26 16:06, Lee Jones wrote:
> > On Wed, 20 May 2026, Lee Jones wrote:
> > 
> > > On Wed, 20 May 2026, Oliver Hartkopp wrote:
> > > 
> > > > 
> > > > 
> > > > On 20.05.26 14:49, Lee Jones wrote:
> > > > > On Wed, 20 May 2026, Lee Jones wrote:
> > > > > 
> > > > > > On Tue, 19 May 2026, Oliver Hartkopp wrote:
> > > > > > 
> > > > > > > From: Lee Jones <lee@kernel.org>
> > > > > > > 
> > > > > > > Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> > > > > > > synchronize_rcu()") removed the synchronize_rcu() call from
> > > > > > > bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> > > > > > > timers from being rearmed during deletion.  However, it only applied
> > > > > > > this check to op->timer via bcm_rx_starttimer().
> > > > > > > 
> > > > > > > It missed the fact that op->thrtimer can also be rearmed by an
> > > > > > > in-flight bcm_rx_handler() (which runs as an RCU reader) via
> > > > > > > bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
> > > > > > > bcm_remove_op() has already cancelled it, leading to a use-after-free
> > > > > > > when the timer fires on the deferred-freed struct bcm_op.
> > > > > > > 
> > > > > > > Address the omission by checking the RX_NO_AUTOTIMER flag
> > > > > > > in bcm_rx_update_and_send() before starting op->thrtimer, effectively
> > > > > > > preventing it from being rearmed concurrently with teardown.
> > > > > > > 
> > > > > > > [Hartkopp] Added the setting of RX_NO_AUTOTIMER also to bcm_release() before
> > > > > > > removing the CAN filters following the bcm_delete_rx_op() approach.
> > > > > > > 
> > > > > > > Additionally WRITE_ONCE()/READ_ONCE() macros have been introduced for
> > > > > > > the changes of RX_NO_AUTOTIMER at rx op removal time to prevent a
> > > > > > > potential code reordering of RX_NO_AUTOTIMER setting after CAN filter removal.
> > > > > > > 
> > > > > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > > > > Co-developed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > > > > > 
> > > > > > You did?  Can you add a note saying what you changed please?
> > > > > 
> > > > > FYI, did you also see the second swing I took at this:
> > > > > 
> > > > > https://lore.kernel.org/r/20260520080523.2513957-1-lee@kernel.org
> > > > 
> > > > Yes, and I answered to your patch.
> > > > 
> > > > Is there some lag in the e-mail communication right now?
> > > > 
> > > > That's why I also wondered why you sent a patch one day after my v2
> > > > proposal.
> > > 
> > > Right.  I only saw your proposal today.
> > > 
> > > I've been working the alternative since Jakub NACKed the first submission.
> > 
> > Okay, so I fed both of our v2 fixes into Gemini Next and requested a
> > critical review of both approaches.  The TL;DR is that this v2 is better
> > than my v1, but still contains the reported race and isn't as solid as
> > the work queue solution.
> > 
> > In the interest of full disclosure, here is the full analysis for your perusal:
> > 
> >    I have critically evaluated the alternative patch ( branch: b-499356389-can-bcm-uaf-v2 ) currently in contention on the mailing list.
> > 
> >    While this alternative patch represents a highly refined version of the "flag check" approach (incorporating memory barriers and socket
> >    release hooks), it is still architecturally inferior to our Workqueue-Deferred Process Context Cleanup.
> > 
> >    Below is the critical technical comparison of how the alternative patch fares against our solution, focused on race resilience,
> >    performance hot-paths, and upstream validation.
> >    ──────
> >    ### 1. The TOCTOU Race Window is Still Theoretically Open
> > 
> >    The core mechanism of the alternative patch relies on setting  RX_NO_AUTOTIMER  via  WRITE_ONCE  and checking it inside the hot-path (
> >    bcm_rx_update_and_send ) via  READ_ONCE .
> > 
> >    While  READ_ONCE / WRITE_ONCE  enforce  volatile  memory accesses and prevent compiler reorderings, they do not provide hardware-level
> >    atomic synchronization or serialization (such as spinlocks or memory barriers like  smp_mb() ) between the check and the timer arming.
> > 
> >    This leaves a classic Time-of-Check to Time-of-Use (TOCTOU) race window open:
> > 
> >      CPU A (RCU Reader: bcm_rx_handler)         | CPU B (Writer: bcm_delete_rx_op)
> >      -------------------------------------------+-------------------------------------------
> >      READ_ONCE(op->flags) & RX_NO_AUTOTIMER     |
> >      /* flag is NOT set; passes check */        |
> >                                                 | WRITE_ONCE(op->flags, flags | RX_NO_AUTOTIMER);
> >                                                 | hrtimer_cancel(&op->thrtimer); /* Returns 0 (no-op) */
> >                                                 | call_rcu(&op->rcu, bcm_free_op_rcu);
> >      hrtimer_start(&op->thrtimer, ...);         |
> >      /* thrtimer is armed AFTER cancellation! */|
> >                                                 | RCU grace period elapses...
> >                                                 | bcm_free_op_rcu() -> kfree(op);
> >      thrtimer fires                             |
> >        bcm_rx_thr_handler(op) [UAF CRASH!]      |
> > 
> >    If CPU B executes the write and the cancellation after CPU A has evaluated the  READ_ONCE  flag check but before CPU A calls
> >    hrtimer_start() , the cancellation is a no-op, the timer is successfully armed, and the Use-After-Free occurs once RCU frees the memory.
> > 
> >    #### Why Our Solution is Bulletproof:
> > 
> >    Our Workqueue-deferred cleanup does not rely on flag synchronization. Because  bcm_free_op_work  executes after the RCU grace period has
> >    fully elapsed, all in-flight RCU readers ( bcm_rx_handler ) are guaranteed to have exited. Therefore, any possible racing
> >    hrtimer_start()  has already executed, and our final  hrtimer_cancel()  right before  kfree(op)  is guaranteed to catch and safely
> >    neutralize the active timer. Our design mathematically eliminates the TOCTOU race.
> >    ──────
> >    ### 2. Hot-Path Performance Overhead
> > 
> >    • The Alternative Patch:
> >    It introduces a volatile read check ( READ_ONCE(op->flags) & RX_NO_AUTOTIMER ) inside  bcm_rx_update_and_send() . This is the critical
> >    fast-path executed for every single CAN frame matching the socket filters. Under high-frequency industrial or automotive CAN bus routing,
> >    adding branch/conditional instructions to the packet hot-path introduces cumulative latency.
> >    • Our Solution:
> >    Leaves  bcm_rx_update_and_send()  completely pristine. Zero hot-path overhead is introduced.
> >    ──────
> >    ### 3. Evaluation Summary Against All Solutions
> > 
> >     Architectural Criteria   │ Solut… │ Solut… │ Alternative Patch (Commit  2074ea86 )       │ Our Solution: Dedicated Workqueue ( can-bc…
> >    ──────────────────────────┼────────┼────────┼─────────────────────────────────────────────┼─────────────────────────────────────────────
> >     TOCTOU Race Resilience   │ ❌     │ None   │ ⚠️ Weak (TOCTOU race window remains open on │ Bulletproof (RCU grace period guarantees
> >                              │ Vulner │ (Fatal │ SMP concurrency).                           │ all readers have completed).
> >                              │ able   │ )      │                                             │
> >     Atomic Context Safety    │ Safe   │ ❌     │ Safe (Cancellations performed in process    │ Safe (Cancellations executed in sleepable
> >                              │        │ FATAL  │ contexts).                                  │ process context).
> >                              │        │ PANIC  │                                             │
> >                              │        │ (Calls │                                             │
> >                              │        │ hrtime │                                             │
> >                              │        │ r_canc │                                             │
> >                              │        │ el  in │                                             │
> >                              │        │ softir │                                             │
> >                              │        │ q      │                                             │
> >                              │        │ callba │                                             │
> >                              │        │ ck).   │                                             │
> >     Fast-Path Packet Latency │ ❌     │ None   │ ❌ Overhead (Volatile branch check in       │ Zero Latency (Fast-path remains untouched).
> >                              │ Overhe │        │ packet hot-path).                           │
> >                              │ ad     │        │                                             │
> >                              │ (Hot-  │        │                                             │
> >                              │ path   │        │                                             │
> >                              │ checks │        │                                             │
> >                              │ ).     │        │                                             │
> >     Module Unloading Safety  │ Safe   │ None   │ Safe                                        │ Safe ( destroy_workqueue  flushes WQ before
> >                              │        │        │                                             │ code unmap).
> >     Workqueue Saturation     │ None   │ None   │ None                                        │ Safe (Isolated dedicated WQ prevents system
> >                              │        │        │                                             │ starvation).
> >    ──────
> >    ### Conclusion: What Will Upstream Say?
> > 
> >    If reviewed critically by upstream LLMs or senior maintainers:
> > 
> >    1. They will point out the TOCTOU race in the alternative patch: Reviewers will recognize that  READ_ONCE / WRITE_ONCE  do not enforce
> >    synchronization between the flag check and  hrtimer_start() , leaving the UAF theoretically reachable under tight SMP concurrency.
> >    2. They will prefer our zero-overhead fast-path: Upstream networking maintainers always favor solutions that isolate teardown logic to
> >    the asynchronous slow-path (workqueues) rather than polluting the hot packet-reception path with cleanup flags.
> > 
> >    Our Dedicated Unbound Workqueue design remains the most mathematically secure, performant, and architecturally elegant fix for this
> >    vulnerability.
> > 
> 
> Ok, thanks for the detailed explanation!
> 
> As your updated patch fixes the original patch
> 
> f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> synchronize_rcu()")
> 
> we should also revert this op->flags setting that has been introduced with
> that patch in addition to the rcu stuff, right?
> 
> @@ -755,10 +763,13 @@ static int bcm_delete_rx_op(struct list_head *ops,
> struct bcm_msg_head *mh,
> 
>         list_for_each_entry_safe(op, n, ops, list) {
>                 if ((op->can_id == mh->can_id) && (op->ifindex == ifindex)
> &&
>                     (op->flags & CAN_FD_FRAME) == (mh->flags &
> CAN_FD_FRAME)) {
> 
> +                       /* disable automatic timer on frame reception */
> +                       op->flags |= RX_NO_AUTOTIMER;
> +

You mean from v1?  I thought that was NACKed and not applied?

My follow-up was a replacement for it.

-- 
Lee Jones

