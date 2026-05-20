Return-Path: <linux-can+bounces-7670-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHrSBXGvDWrW1QUAu9opvQ
	(envelope-from <linux-can+bounces-7670-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 14:56:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9188858E512
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 14:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C27BE301C89E
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 12:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103D63DCD8B;
	Wed, 20 May 2026 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1gSkwMc"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64EB3E025E
	for <linux-can@vger.kernel.org>; Wed, 20 May 2026 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281352; cv=none; b=Pm9pxg03AnR3zvfELQ2U3BeD96Dyn1xgpvLAws9axNTssioAK3XzezzCZ6yt4n0i2CQ0/cPHvZk+XTeHt7UtwR8RnDhyL7BWWVkvxn2/vfksFuLVMHI5RlsweXcXiqXvf9PEfUaP54OO/l/Q8C3AtOUf3KCnz15zjPiiNLT7mgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281352; c=relaxed/simple;
	bh=+yNKjLv3YC2IUb38ckq7Gq9S1KNywdZucjSp0gqvahg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJUdtXhlncobDZcaAG7/CQ5XFMSbQjT6Vvi+yW3FWkihL0btamgopk4EUlKLVGx4NepacdnTSc+vtw85qEUPPW+Win8yGtbI8Ow7AmkVBDeft9ejqcG88aZ4LIV5ouZxjWJF7oRN3wgeMWKCHQwnp8Iz3IeBgIdlaZCZOmNejwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1gSkwMc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF071F000E9;
	Wed, 20 May 2026 12:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779281350;
	bh=m4JvABC5jVNeEj8HP33j4c7B+8gmZ7ylZYCtjlUhEaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j1gSkwMcGJjswGgTYqyDxn5VtTJ8mriKdbiLrJteCB1K/awxfIx/xrEFIgIZ3gLtx
	 lEnODbnTDpOtLs5HqHnRNNolcQ36QWOZv2rGzcAZWdcFijt+v0uON7isQPZliSu15i
	 2SKZm1b1mfsYTkZsO0KKv3PQgZobHhGfzPx7n0doFiN/m5pFcPvFlkgzGNOt7fITEr
	 Ld3DIy6Wvn3L9WOJSAzs6ZgxqpD+ICTqdELfaJYUt5AP31j5o2AGDhY/lKT4+ptE/7
	 57FYBtpqVUKymUcP59wamtJkelQpaHUdIjTNzUmIkAVUzukvFiAGfMa6bmZucJcLQ5
	 VvjMal1MtgIHA==
Date: Wed, 20 May 2026 13:49:07 +0100
From: Lee Jones <lee@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
Message-ID: <20260520124907.GB305027@google.com>
References: <20260519113806.85456-1-socketcan@hartkopp.net>
 <20260520124758.GA305027@google.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520124758.GA305027@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7670-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9188858E512
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026, Lee Jones wrote:

> On Tue, 19 May 2026, Oliver Hartkopp wrote:
> 
> > From: Lee Jones <lee@kernel.org>
> > 
> > Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> > synchronize_rcu()") removed the synchronize_rcu() call from
> > bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> > timers from being rearmed during deletion.  However, it only applied
> > this check to op->timer via bcm_rx_starttimer().
> > 
> > It missed the fact that op->thrtimer can also be rearmed by an
> > in-flight bcm_rx_handler() (which runs as an RCU reader) via
> > bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
> > bcm_remove_op() has already cancelled it, leading to a use-after-free
> > when the timer fires on the deferred-freed struct bcm_op.
> > 
> > Address the omission by checking the RX_NO_AUTOTIMER flag
> > in bcm_rx_update_and_send() before starting op->thrtimer, effectively
> > preventing it from being rearmed concurrently with teardown.
> > 
> > [Hartkopp] Added the setting of RX_NO_AUTOTIMER also to bcm_release() before
> > removing the CAN filters following the bcm_delete_rx_op() approach.
> > 
> > Additionally WRITE_ONCE()/READ_ONCE() macros have been introduced for
> > the changes of RX_NO_AUTOTIMER at rx op removal time to prevent a
> > potential code reordering of RX_NO_AUTOTIMER setting after CAN filter removal.
> > 
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > Co-developed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> You did?  Can you add a note saying what you changed please?

FYI, did you also see the second swing I took at this:

https://lore.kernel.org/r/20260520080523.2513957-1-lee@kernel.org

> > Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
> > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > ---
> >  net/can/bcm.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/can/bcm.c b/net/can/bcm.c
> > index a4bef2c48a55..abf7bd2c2e6f 100644
> > --- a/net/can/bcm.c
> > +++ b/net/can/bcm.c
> > @@ -537,10 +537,16 @@ static void bcm_rx_update_and_send(struct bcm_op *op,
> >  
> >  	/* with active throttling timer we are just done here */
> >  	if (hrtimer_active(&op->thrtimer))
> >  		return;
> >  
> > +	/* bcm_remove_op() may have cancelled thrtimer concurrently with this
> > +	 * RCU-protected handler; do not rearm it. Mirrors bcm_rx_starttimer().
> > +	 */
> > +	if (READ_ONCE(op->flags) & RX_NO_AUTOTIMER)
> > +		return;
> > +
> >  	/* first reception with enabled throttling mode */
> >  	if (!op->kt_lastmsg)
> >  		goto rx_changed_settime;
> >  
> >  	/* got a second frame inside a potential throttle period? */
> > @@ -603,11 +609,11 @@ static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
> >  /*
> >   * bcm_rx_starttimer - enable timeout monitoring for CAN frame reception
> >   */
> >  static void bcm_rx_starttimer(struct bcm_op *op)
> >  {
> > -	if (op->flags & RX_NO_AUTOTIMER)
> > +	if (READ_ONCE(op->flags) & RX_NO_AUTOTIMER)
> >  		return;
> >  
> >  	if (op->kt_ival1)
> >  		hrtimer_start(&op->timer, op->kt_ival1, HRTIMER_MODE_REL_SOFT);
> >  }
> > @@ -838,11 +844,11 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
> >  	list_for_each_entry_safe(op, n, ops, list) {
> >  		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
> >  		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
> >  
> >  			/* disable automatic timer on frame reception */
> > -			op->flags |= RX_NO_AUTOTIMER;
> > +			WRITE_ONCE(op->flags, op->flags | RX_NO_AUTOTIMER);
> >  
> >  			/*
> >  			 * Don't care if we're bound or not (due to netdev
> >  			 * problems) can_rx_unregister() is always a save
> >  			 * thing to do here.
> > @@ -1618,10 +1624,14 @@ static int bcm_release(struct socket *sock)
> >  
> >  	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
> >  		bcm_remove_op(op);
> >  
> >  	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
> > +
> > +		/* disable automatic timer on frame reception */
> > +		WRITE_ONCE(op->flags, op->flags | RX_NO_AUTOTIMER);
> > +
> >  		/*
> >  		 * Don't care if we're bound or not (due to netdev problems)
> >  		 * can_rx_unregister() is always a save thing to do here.
> >  		 */
> >  		if (op->ifindex) {
> > -- 
> > 2.53.0
> > 
> 
> -- 
> Lee Jones

-- 
Lee Jones

