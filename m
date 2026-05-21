Return-Path: <linux-can+bounces-7682-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACLDJGXnDmqPDAYAu9opvQ
	(envelope-from <linux-can+bounces-7682-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 21 May 2026 13:07:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2605F5A3BE2
	for <lists+linux-can@lfdr.de>; Thu, 21 May 2026 13:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8213300336F
	for <lists+linux-can@lfdr.de>; Thu, 21 May 2026 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AC03A380E;
	Thu, 21 May 2026 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O64i4mcS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AE3845D5
	for <linux-can@vger.kernel.org>; Thu, 21 May 2026 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361633; cv=none; b=SEiAHyJUfkU1cq9DlDZiN4+d6SCke6C6jmBFc3TEwb86tV4NvkUKI6AWE+ny4bqTvArzLNwMgS67fv/SIHcro6S4rpy7yikH+FEpTDsIHnFqFfEEmBFx2CTPX0zmoApNZ65c8/Vb+LNKIPjFwjY/mRqGPh38tb5lND25rUlj+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361633; c=relaxed/simple;
	bh=MF3O1FNZdwkYMAe2JfzNS+yyvnQiVhjNu16tJA6dYY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW0ape1M1H3sHsMVYeqQqkWOiVHiVKhMJBX6uCx/Hn1VnMrAgtym74orbg6TFu2ZRHPuiLJc/G7jHpH2oy5IJ7wVCFX4TtIlLUATeIN2axqH57KtT+G+E41/aNt8KFx7YaA0MQeqpTc2C2UAJE89hCleYZnEVmflrNjNXxfgBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O64i4mcS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934BF1F000E9;
	Thu, 21 May 2026 11:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779361632;
	bh=cLsLoxqIO6kFH6mnh5hy+OaJIqMt/DMFdJ+d6L+LbyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O64i4mcSvssyaogKGNmmLElVW5LYnqMLOOK8dN6WZ+eLN+jbyiEGFsuF5TlCRY3vO
	 KiYSHTg+5OzT34etSjAcT/GosSlNpyTq1/QHKa8FQvEuKKXdob6sHLyUtB2EKDL88O
	 lSl8Qr5NXeGG1IWqko7w31fISD903P58vI4eSyXVPx3loJDy7efsRQlQB3J4bFr5SM
	 HvShSuXeQefJrDFgCNoQaNHkEAjuoMFKlct40ofgZlnYOxHurHvgbbTA/2MegXeiMe
	 mr4zLI2TNtuI/BmfSn1mNWAe/3csaZ8yhDXYXDIgoFV6GliUm1fRmyG8LoTdSGY7vY
	 a6nTbVLRFe7cQ==
Date: Thu, 21 May 2026 12:07:08 +0100
From: Lee Jones <lee@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
Message-ID: <20260521110708.GC2921053@google.com>
References: <20260519113806.85456-1-socketcan@hartkopp.net>
 <20260520124758.GA305027@google.com>
 <20260520124907.GB305027@google.com>
 <442a92c9-5810-4fcd-ab05-5b0acd0f345c@hartkopp.net>
 <20260520134032.GA2767592@google.com>
 <20260520140657.GC2767592@google.com>
 <24a20c37-5cac-4a38-a8f1-ed98b38f7e1d@hartkopp.net>
 <20260520161308.GL2767592@google.com>
 <7d21ad57-3de9-4eac-a51d-15b6dfaf3bae@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d21ad57-3de9-4eac-a51d-15b6dfaf3bae@hartkopp.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7682-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2605F5A3BE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026, Oliver Hartkopp wrote:
> > > Ok, thanks for the detailed explanation!
> > > 
> > > As your updated patch fixes the original patch
> > > 
> > > f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> > > synchronize_rcu()")
> > > 
> > > we should also revert this op->flags setting that has been introduced with
> > > that patch in addition to the rcu stuff, right?
> > > 
> > > @@ -755,10 +763,13 @@ static int bcm_delete_rx_op(struct list_head *ops,
> > > struct bcm_msg_head *mh,
> > > 
> > >          list_for_each_entry_safe(op, n, ops, list) {
> > >                  if ((op->can_id == mh->can_id) && (op->ifindex == ifindex)
> > > &&
> > >                      (op->flags & CAN_FD_FRAME) == (mh->flags &
> > > CAN_FD_FRAME)) {
> > > 
> > > +                       /* disable automatic timer on frame reception */
> > > +                       op->flags |= RX_NO_AUTOTIMER;
> > > +
> > 
> > You mean from v1?  I thought that was NACKed and not applied?
> 
> No. These two lines were introduced in the original patch you aim to fix. So
> when fixing the original "use call_rcu() instead of costly
> synchronize_rcu()" patch that introduced the rcu stuff, this now obsolete
> op->flags |= RX_NO_AUTOTIMER should be removed too.

Is that not orthogonal to the fix?

If it is, would you be kind enough to submit a fix (and get your own
creds up ;-D).  This is usually something that I'd gleefully pick up,
but I'm absolutely inundated with vulnerability reports right now.

-- 
Lee Jones

