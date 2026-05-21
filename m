Return-Path: <linux-can+bounces-7685-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGogFQUXD2qVFQYAu9opvQ
	(envelope-from <linux-can+bounces-7685-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 21 May 2026 16:30:29 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10065A74A1
	for <lists+linux-can@lfdr.de>; Thu, 21 May 2026 16:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E6BA308B45B
	for <lists+linux-can@lfdr.de>; Thu, 21 May 2026 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5072877F7;
	Thu, 21 May 2026 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBK4QUkJ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A533EE1EC
	for <linux-can@vger.kernel.org>; Thu, 21 May 2026 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371506; cv=none; b=CC+NtG3NfHhZjW/9068ODIQFArN+zdmXwCHtvA/ydAqz4Zf+uUe00H3W165YCZfgM5BScOP/YHZrbxzFPxtkui2ylFYXYWSu14/qqqf+fjpf+7ZTToNJKO2t+RBLWoS2dXWLTsLs91HNMBWHuGypnlel/9mFm41+hDP05H4BesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371506; c=relaxed/simple;
	bh=e+zQbqbn72RTjh45TYt93oJP9Ae0G+tWS8MU2EqL0EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzhno8vwXETIT0t1ZXq9eSHDOYLJMj5C1lrPMerQiOgJ9rMId8OkrBa7J+On2iYGtMLLSqgVd3w2OsdHn33GDh6z9jr3D0CYbf0wdYYZl2h17KDU6ZHgDKmBVzbvw+HY9kZbJNPhhNOcPcNePFvONFAe+Z8IezNUCsvhchwrHcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBK4QUkJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30801F00A3C;
	Thu, 21 May 2026 13:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779371504;
	bh=WiMWWsHN3R0CEHmTcySk+d3VauGRlZMcrMM7zFF26tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NBK4QUkJAXYtNIlkIA7UyWFTBUcafNmxK0UQjR3SQdVzx+nBnzVYh+TMkp28/DEBr
	 9fTXPkfRPlZzs6RbmoUBAfdBcTkMS2PjGilY0rADFhkFZIy+CRcZ8FAF2gZYW2HKZd
	 sEO1s0IgfNqHKx2YfPupvPxSBUEG80gxEY598yKsIxQxxEzYCV74I9Ey4VOQ+5sMvv
	 58ZDPzp3xbpWfWuM3xSowYev98rAzey73Db56mN8XFfDgimoiQ20q9VvTPsvDdwvRo
	 WZH7GvPt48xfTdxx9CWKPaO0yRJz1SfbFOavcDuSPMBiT/1hHt3rYLwVsJzkhVXDUI
	 jNyhumKCgJZZw==
Date: Thu, 21 May 2026 14:51:41 +0100
From: Lee Jones <lee@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
Message-ID: <20260521135141.GC3591266@google.com>
References: <20260520124758.GA305027@google.com>
 <20260520124907.GB305027@google.com>
 <442a92c9-5810-4fcd-ab05-5b0acd0f345c@hartkopp.net>
 <20260520134032.GA2767592@google.com>
 <20260520140657.GC2767592@google.com>
 <24a20c37-5cac-4a38-a8f1-ed98b38f7e1d@hartkopp.net>
 <20260520161308.GL2767592@google.com>
 <7d21ad57-3de9-4eac-a51d-15b6dfaf3bae@hartkopp.net>
 <20260521110708.GC2921053@google.com>
 <80f98c44-e9f3-45e2-989f-32f1a7c2c38b@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80f98c44-e9f3-45e2-989f-32f1a7c2c38b@hartkopp.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7685-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E10065A74A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026, Oliver Hartkopp wrote:

> 
> 
> On 21.05.26 13:07, Lee Jones wrote:
> > On Wed, 20 May 2026, Oliver Hartkopp wrote:
> > > > > Ok, thanks for the detailed explanation!
> > > > > 
> > > > > As your updated patch fixes the original patch
> > > > > 
> > > > > f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> > > > > synchronize_rcu()")
> > > > > 
> > > > > we should also revert this op->flags setting that has been introduced with
> > > > > that patch in addition to the rcu stuff, right?
> > > > > 
> > > > > @@ -755,10 +763,13 @@ static int bcm_delete_rx_op(struct list_head *ops,
> > > > > struct bcm_msg_head *mh,
> > > > > 
> > > > >           list_for_each_entry_safe(op, n, ops, list) {
> > > > >                   if ((op->can_id == mh->can_id) && (op->ifindex == ifindex)
> > > > > &&
> > > > >                       (op->flags & CAN_FD_FRAME) == (mh->flags &
> > > > > CAN_FD_FRAME)) {
> > > > > 
> > > > > +                       /* disable automatic timer on frame reception */
> > > > > +                       op->flags |= RX_NO_AUTOTIMER;
> > > > > +
> > > > 
> > > > You mean from v1?  I thought that was NACKed and not applied?
> > > 
> > > No. These two lines were introduced in the original patch you aim to fix. So
> > > when fixing the original "use call_rcu() instead of costly
> > > synchronize_rcu()" patch that introduced the rcu stuff, this now obsolete
> > > op->flags |= RX_NO_AUTOTIMER should be removed too.
> > 
> > Is that not orthogonal to the fix?
> > 
> > If it is, would you be kind enough to submit a fix (and get your own
> > creds up ;-D).  This is usually something that I'd gleefully pick up,
> > but I'm absolutely inundated with vulnerability reports right now.
> > 
> 
> Yes, of course I can clean this up later. But not for getting extra creds
> :-)
> 
> Btw. have you seen the AI remark on your patch that asks about an additional
> rcu_barrier() in bcm_module_exit() ?
> 
> https://netdev-ai.bots.linux.dev/ai-review.html?id=9e8842e7-59a2-4ec5-9f65-1df7973c6170
> 
> says this:
> 
> > @@ -1870,6 +1891,7 @@ static void __exit bcm_module_exit(void)
> >  	can_proto_unregister(&bcm_can_proto);
> >  	unregister_netdevice_notifier(&canbcm_notifier);
> >  	unregister_pernet_subsys(&canbcm_pernet_ops);
> > +	destroy_workqueue(bcm_wq);
> >  }
> 
> Does bcm_module_exit need an rcu_barrier() call before destroy_workqueue?
> Consider this sequence:
> 
> A socket is being closed while the module is unloading:
> 
>   bcm_release()
>     bcm_remove_op()
>       call_rcu(&op->rcu, bcm_free_op_rcu)  // RCU callback scheduled
> 
>   Module refcount reaches zero, rmmod proceeds
> 
>   bcm_module_exit()
>     can_proto_unregister(&bcm_can_proto)
>     unregister_netdevice_notifier(&canbcm_notifier)
>     unregister_pernet_subsys(&canbcm_pernet_ops)
>     destroy_workqueue(bcm_wq)             // bcm_wq destroyed
> 
>   RCU grace period elapses
> 
>   bcm_free_op_rcu()                       // callback fires
>     INIT_WORK(&op->work, bcm_free_op_work)
>     queue_work(bcm_wq, &op->work)         // UAF: bcm_wq already freed
> 
> The RCU callback queues work to bcm_wq, but if the callback hasn't fired
> yet when bcm_module_exit runs, it will try to queue_work to a destroyed
> workqueue. Before this patch, bcm_free_op_rcu called kfree directly without
> using module-global resources, so this wasn't an issue.
> 
> Should bcm_module_exit call rcu_barrier() before destroy_workqueue to
> ensure all pending RCU callbacks complete first?

I hadn't seen it (do you get notifications?  If so, how do I enable
those?), but it is legitimate.  I shall send out a v2 early next week.

-- 
Lee Jones

