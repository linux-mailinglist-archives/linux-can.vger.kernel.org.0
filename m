Return-Path: <linux-can+bounces-8041-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4KHcI1bKTGpJpwEAu9opvQ
	(envelope-from <linux-can+bounces-8041-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 11:43:50 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F35719EBC
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 11:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=LbnCvPIz;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=ANiw+yYe;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8041-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8041-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CACAB3021EB6
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750323AE185;
	Tue,  7 Jul 2026 09:37:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AFD3A0EB8
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 09:37:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417061; cv=none; b=ePoK4bJ1bff+fnvydnmZOBkAMDDBNsokBIR2Jkb48kziMM4AeC1iZ7um6191n87xvEL8+a066e2fXYCoIIv1pGaRR+0qCv/cqQkr/iZzTmt53bamdFj3TB70nr+algn18TmgulWP59QEQ6CX34mMUWSjZ5yqdHyslk3McpBwLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417061; c=relaxed/simple;
	bh=i4gbiS27P6MD/HkHGyel6TnxVEq2sL0vStcGbbl56II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkrJI6Iy9M+zJYZYs0bVc0+gkbEvlB+lLruhVqXjV8ZDj4Iy1jW/8aLHLxeO8Eqg+qVOOiyobYMLaHRjEJxEMQEG1wt37zs0+wzA3gdCF5xcSzJBtSovnGQhdn5Uxrh3rjmoQz71Nb6YyWgUxoVvIGuXozauPWXsfYJTRDa6/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LbnCvPIz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ANiw+yYe; arc=none smtp.client-ip=193.142.43.55
Date: Tue, 7 Jul 2026 11:37:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783417057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GmmNoUeEgt3B62U5jcjFe/ceBGguxPGkq26EFGBVKXI=;
	b=LbnCvPIzgb2iSS2ly6sVurMDKPDRwwNd8W2M7gsan9IbfVe2nrYBRLBIS4kM84Ox6g7Akn
	znnyRx2QZ7SSmpxOc+qheX/0Bo/m3894aPxoB9azaYnLWCywwKb0KCOk0QnORbTuOxXYyi
	HXDxMfeMgwF9rs+TyW4KA96SbGllSpLA0gsBmCifgxN1pUrLfDCiCikfTsixw2JdSjBHlr
	G5c1Pm4Q9fuKH5mx1beyre8wnv1u0O6mZQQxSeSz26exanvOFSokaStj6ZV19zycKcRRfB
	9Pd6ZQx8Gx+eV088Kp4L1lPnLUPVP1w0/U/TGXDlkv3HoYQp12Lm/Wy+gs43JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783417057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GmmNoUeEgt3B62U5jcjFe/ceBGguxPGkq26EFGBVKXI=;
	b=ANiw+yYelHs0ndmGh6SHMGfMkZkqjWcqGZ89Y6IIvLJDgLCWBp9UgWgBvYNsXkrlvRQXaz
	QkKf/zP3k1Y+5ACg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH net-next] net: Convert %pK back to %p
Message-ID: <20260707093736.88o1Y93D@linutronix.de>
References: <20260706073824.xixrLxoD@linutronix.de>
 <20260707074654.325F01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707074654.325F01F00A3A@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:mkl@pengutronix.de,m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8041-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linutronix.de:from_mime,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08F35719EBC

On 2026-07-07 07:46:53 [+0000], sashiko-bot@kernel.org wrote:
> > @@ -2806,7 +2806,7 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
> >  				      READ_ONCE(tp->copied_seq), 0);
> >  
> >  	seq_printf(f, "%4d: %08X:%04X %08X:%04X %02X %08X:%08X %02X:%08lX "
> > -			"%08X %5u %8d %llu %d %pK %lu %lu %u %u %d",
> > +			"%08X %5u %8d %llu %d %p %lu %lu %u %u %d",
> 
> [Severity: Critical]
> Does replacing %pK with %p in get_tcp4_sock() break the userspace tracing
> ABI and bypass the kernel.kptr_restrict sysctl?
> 
> Under kptr_restrict=1 (the default on most distributions), %pK returns the
> raw kernel pointer to users with the syslog capability. By reverting to %p,
> a hashed pointer is unconditionally returned instead. 

Debian and Arch have kptr_restrict=0 by default as far as I can tell. A
hashed pointer is still useful for tracing it is just not the actual
address which can be used in reading the content from memory.

> While the commit message notes that hash_pointers can be disabled at boot,
> does this break the runtime configurability provided by the
> kernel.kptr_restrict sysctl? 

It is not documented which pointers are controlled by which knob. So
this unites this.

> Will existing tracing tools that correlate /proc sockets with kernel memory
> receive hashes and fail instead of raw pointers?

It still can correlate pointers.

> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index f7a9d55eee8a1..6a8174977c87a 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> 
> [ ... ]
> 
> > @@ -3554,7 +3554,7 @@ static int unix_seq_show(struct seq_file *seq, void *v)
> >  		struct unix_sock *u = unix_sk(s);
> >  		unix_state_lock(s);
> >  
> > -		seq_printf(seq, "%pK: %08X %08X %08X %04X %02X %5llu",
> > +		seq_printf(seq, "%p: %08X %08X %08X %04X %02X %5llu",
> 
> [Severity: Critical]
> Does this also expose unix socket structures directly as hashed pointers in
> unix_seq_show(), bypassing sysctl restrictions?

hashed pointers do not reveal actual pointers.

> Similar to the tcp change above, will tracing tools no longer be able to
> resolve these pointers when kptr_restrict=1 is set?

I don't think tracing tool need to resolve pointers. They just care if
they are the same.

> [ ... ]
> 
> [Severity: Medium]
> Does this commit leave the networking subsystem in an inconsistent state by
> missing net/bluetooth/af_bluetooth.c?
> 
> Looking at bt_seq_show() in net/bluetooth/af_bluetooth.c, it still uses %pK:
> 
>     seq_printf(f, "%pK %-6d %-6u %-6u %-6u %-6llu %-6llu",
> 
> Is this the only remaining use of %pK in the net/ subsystem that was missed
> by the refactoring? This appears to leave bluetooth procfs files respecting
> kptr_restrict while the other protocols do not.

This is staged for the BT tree.

Sebastian

