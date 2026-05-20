Return-Path: <linux-can+bounces-7669-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HZfKNKuDWrW1QUAu9opvQ
	(envelope-from <linux-can+bounces-7669-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 14:53:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 234B058E454
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 14:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E2013061190
	for <lists+linux-can@lfdr.de>; Wed, 20 May 2026 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612823DDDB6;
	Wed, 20 May 2026 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSeRS6C/"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AFB39BFFA
	for <linux-can@vger.kernel.org>; Wed, 20 May 2026 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281283; cv=none; b=DBG8W+5X21XiV3fzAc7uAHZGgNiL+PNGUOAG6W3Jt5Yhs3kw2vYX0BqbkQxyniqT5g0F9iTq89VQDvkDxsD22OfSF3sNp2PDmy921o0yXwn7v9Q5pLEr7Rs30h9W1Oi7aKuBtRzxCroxQyrhl9WrDy2FTwINyAezAYie8djB4Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281283; c=relaxed/simple;
	bh=RJc8ad6Nyb9wcs03KGEb/LfH3EsM0tmZVhykHin9KgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McgWnJZx+2eenV2QboxlaRw0z+geb8bwyyOTIJjYJWKruvqeA9in4JfXUjAWapk8o0nP65TCrU8XTU/d2tT63XUR9oTfGy1DxSjO9eCBFLcOq4AAEk4KOiAGBQsSO1Vl14ORaL4WG+IgxK/zR5muDnHZkwQwAYWfaYbX/lDd4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSeRS6C/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7381F000E9;
	Wed, 20 May 2026 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779281281;
	bh=tJ5rH8cO8X15r/le2dikiPNnxYv/H3NwSXWiUF3GoLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VSeRS6C/6+Qg/a1tW3FxcyBNQve08V1B0J6FAMhiTPKDTUC9QgtzNBWDeFfc3k1Rj
	 pDc4y1WLBFtkt190hEk40foXFwpEJ3dAwd8KMwLN1LTgsZg2kYjTp0f7VNX7tC4cPj
	 sVqBXToQGEZvdxpNXYU5J9EH+2tkkS/Pf6qHFD9oY85+l5xdAWJgqHqkUvcbo0bivT
	 Dk5BxBbwOvJy1rdEXtwD4hrxB5KYJ/QxsUTmaO+PGCmOde6e8aPD0gVojb8sXiSvU/
	 SYkQypqkmLFVDiDXx6QZcCuo74YG5DDdeYoznK6VRmYhV7k6NYr8yFyGSa8dsy3F5o
	 bgep3kSYx9rsQ==
Date: Wed, 20 May 2026 13:47:58 +0100
From: Lee Jones <lee@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
Message-ID: <20260520124758.GA305027@google.com>
References: <20260519113806.85456-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519113806.85456-1-socketcan@hartkopp.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7669-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,hartkopp.net:email]
X-Rspamd-Queue-Id: 234B058E454
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026, Oliver Hartkopp wrote:

> From: Lee Jones <lee@kernel.org>
> 
> Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> synchronize_rcu()") removed the synchronize_rcu() call from
> bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> timers from being rearmed during deletion.  However, it only applied
> this check to op->timer via bcm_rx_starttimer().
> 
> It missed the fact that op->thrtimer can also be rearmed by an
> in-flight bcm_rx_handler() (which runs as an RCU reader) via
> bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
> bcm_remove_op() has already cancelled it, leading to a use-after-free
> when the timer fires on the deferred-freed struct bcm_op.
> 
> Address the omission by checking the RX_NO_AUTOTIMER flag
> in bcm_rx_update_and_send() before starting op->thrtimer, effectively
> preventing it from being rearmed concurrently with teardown.
> 
> [Hartkopp] Added the setting of RX_NO_AUTOTIMER also to bcm_release() before
> removing the CAN filters following the bcm_delete_rx_op() approach.
> 
> Additionally WRITE_ONCE()/READ_ONCE() macros have been introduced for
> the changes of RX_NO_AUTOTIMER at rx op removal time to prevent a
> potential code reordering of RX_NO_AUTOTIMER setting after CAN filter removal.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> Co-developed-by: Oliver Hartkopp <socketcan@hartkopp.net>

You did?  Can you add a note saying what you changed please?

> Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  net/can/bcm.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a55..abf7bd2c2e6f 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -537,10 +537,16 @@ static void bcm_rx_update_and_send(struct bcm_op *op,
>  
>  	/* with active throttling timer we are just done here */
>  	if (hrtimer_active(&op->thrtimer))
>  		return;
>  
> +	/* bcm_remove_op() may have cancelled thrtimer concurrently with this
> +	 * RCU-protected handler; do not rearm it. Mirrors bcm_rx_starttimer().
> +	 */
> +	if (READ_ONCE(op->flags) & RX_NO_AUTOTIMER)
> +		return;
> +
>  	/* first reception with enabled throttling mode */
>  	if (!op->kt_lastmsg)
>  		goto rx_changed_settime;
>  
>  	/* got a second frame inside a potential throttle period? */
> @@ -603,11 +609,11 @@ static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
>  /*
>   * bcm_rx_starttimer - enable timeout monitoring for CAN frame reception
>   */
>  static void bcm_rx_starttimer(struct bcm_op *op)
>  {
> -	if (op->flags & RX_NO_AUTOTIMER)
> +	if (READ_ONCE(op->flags) & RX_NO_AUTOTIMER)
>  		return;
>  
>  	if (op->kt_ival1)
>  		hrtimer_start(&op->timer, op->kt_ival1, HRTIMER_MODE_REL_SOFT);
>  }
> @@ -838,11 +844,11 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
>  	list_for_each_entry_safe(op, n, ops, list) {
>  		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
>  		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
>  
>  			/* disable automatic timer on frame reception */
> -			op->flags |= RX_NO_AUTOTIMER;
> +			WRITE_ONCE(op->flags, op->flags | RX_NO_AUTOTIMER);
>  
>  			/*
>  			 * Don't care if we're bound or not (due to netdev
>  			 * problems) can_rx_unregister() is always a save
>  			 * thing to do here.
> @@ -1618,10 +1624,14 @@ static int bcm_release(struct socket *sock)
>  
>  	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
>  		bcm_remove_op(op);
>  
>  	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
> +
> +		/* disable automatic timer on frame reception */
> +		WRITE_ONCE(op->flags, op->flags | RX_NO_AUTOTIMER);
> +
>  		/*
>  		 * Don't care if we're bound or not (due to netdev problems)
>  		 * can_rx_unregister() is always a save thing to do here.
>  		 */
>  		if (op->ifindex) {
> -- 
> 2.53.0
> 

-- 
Lee Jones

