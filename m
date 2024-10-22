Return-Path: <linux-can+bounces-1722-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23629AB4A2
	for <lists+linux-can@lfdr.de>; Tue, 22 Oct 2024 19:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544F21F24307
	for <lists+linux-can@lfdr.de>; Tue, 22 Oct 2024 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A474F126C00;
	Tue, 22 Oct 2024 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z+kxPzZt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y+uNF1uq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z+kxPzZt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y+uNF1uq"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B70256D
	for <linux-can@vger.kernel.org>; Tue, 22 Oct 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616675; cv=none; b=mTkx4CE8odFHOnXmrwJNP/Fz8ulmkhfq99PGBivaDK2wxu2Rsw/VipCyfT99lKt1Ao5h7+YdZfek5DA6MVqJOl61PgQkWJwrFbzpHMgLn7UNHvHF50bQ+UBAUepmwkkIkzdB2/1UO+I+q/z4WjKRKtNyLTCx44+uov5Rf9cJ+8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616675; c=relaxed/simple;
	bh=r2XREKT+QpzQjFzj3SXcVoc/noYfmpD7U7YTsPyS9Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7PFWWKU/gEXQ80gttrbrcp2ekvzJGowIW3mw74KZzPjRtAI8KFTwCDhyhTH2bTRzaEIk59Bo0K3AxInP8pyC7PtnXwOTMPQ6blU2z3rawcvFM3qcGOc1b0lYAJzW3roJt/+b6bYN6/cqu5/pFnrDTTqzratxTm4nnK4NpcvXic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z+kxPzZt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y+uNF1uq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z+kxPzZt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y+uNF1uq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF92321BC9;
	Tue, 22 Oct 2024 17:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729616671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKPWS5bxXQ1GSGz2Pfsojg/GgbT1a57DyNiKl1UZ3a8=;
	b=z+kxPzZt2nJb8f46aExmoCE0Yu0qOLhgFAdC5kTTlWFddTdeVZ/CINviSdpk/2pG+L6B5E
	RsfbEgAcPRcmbl2VNSo2aqqEk2WFyY3DLH6KwdMMgyZU0WFDFRHxN7o55pXGDEDP+9K71w
	T540kXvEHm4RyWC/M0Lek+VZubANaTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729616671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKPWS5bxXQ1GSGz2Pfsojg/GgbT1a57DyNiKl1UZ3a8=;
	b=Y+uNF1uqHuribYp2vzNYVKC+swOhGAagaythub5bm0g1prl0nsL+r4tPmvGeXHvEw8eC8M
	fV36zgp73fAAx3Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z+kxPzZt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Y+uNF1uq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729616671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKPWS5bxXQ1GSGz2Pfsojg/GgbT1a57DyNiKl1UZ3a8=;
	b=z+kxPzZt2nJb8f46aExmoCE0Yu0qOLhgFAdC5kTTlWFddTdeVZ/CINviSdpk/2pG+L6B5E
	RsfbEgAcPRcmbl2VNSo2aqqEk2WFyY3DLH6KwdMMgyZU0WFDFRHxN7o55pXGDEDP+9K71w
	T540kXvEHm4RyWC/M0Lek+VZubANaTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729616671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKPWS5bxXQ1GSGz2Pfsojg/GgbT1a57DyNiKl1UZ3a8=;
	b=Y+uNF1uqHuribYp2vzNYVKC+swOhGAagaythub5bm0g1prl0nsL+r4tPmvGeXHvEw8eC8M
	fV36zgp73fAAx3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FC9A13894;
	Tue, 22 Oct 2024 17:04:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b5xRFR/bF2eIIgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 22 Oct 2024 17:04:31 +0000
Date: Tue, 22 Oct 2024 19:04:30 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Marc Kleine-Budde
 <mkl@pengutronix.de>, Miguel Ojeda <ojeda@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] can: rockchip_canfd: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20241022190430.46c9b311@endymion.delvare>
In-Reply-To: <CAMZ6RqJxb-52eSPqvaESjA-Wd_Jd-=gFO1HWbzxWe3gx7GWDmA@mail.gmail.com>
References: <20241022130439.70d016e9@endymion.delvare>
	<CAMZ6RqJxb-52eSPqvaESjA-Wd_Jd-=gFO1HWbzxWe3gx7GWDmA@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AF92321BC9
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[wanadoo.fr];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi Vincent,

On Tue, 22 Oct 2024 22:22:05 +0900, Vincent MAILHOL wrote:
> On Tue. 22 Oct. 2024 at 20:06, Jean Delvare <jdelvare@suse.de> wrote:
> > Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), OF
> > can be enabled on all architectures. Therefore depending on
> > COMPILE_TEST as an alternative is no longer needed.  
> 
> I understand the motivation behind this patch, but for me, as a
> maintainer, it becomes more work when I want to do a compile test.
> Before I would have needed to only select COMPILE_TEST but now, I
> would need to remember to also select OF for that driver to appear in
> the menuconfig.

Not sure what your typical process looks like, but if you need to
test-build drivers on a regular basis, why don't you have
CONFIG_COMPILE_TEST always enabled? Switching back and forth must be a
hassle.

About CONFIG_OF, well you probably want it enabled regardless. For one
thing, there are at least 940 drivers in the kernel tree which depend on
OF, so you are already missing a lot of test build coverage if you have
it disabled.

For another, if test-building a driver which would normally depend on
OF, but with OF disabled (as you do for rockchip_canfd at the moment,
as I understand it), then you may not be building the full driver. Part
of the code could be stripped out at build time because the compiler
notices that it is unreachable. Apparently this isn't the case of the
rockchip_canfd driver though.

> Well, I am not strongly against this simplification, but, wouldn't it
> be good to make COMPILE_TEST automatically select OF then? Looking at
> the description of COMPILE_TEST, I read:
> 
>  If you are a developer and want to build everything available, say Y here.

As a side note, I don't think this is a proper description of how to
use this option. If you "want to build everything available" then what
you want to do is "make allmodconfig", not manually enabling all
drivers in "make menuconfig". The purpose of manually selecting
COMPILE_TEST would presumably be to test-build a specific driver or set
of drivers.

> So having COMPILE_TEST automatically select OF looks sane to me as it
> goes in the direction of "building everything". If this makes sense, I
> can send a patch for this. Thoughts?

My initial reaction was that this would be an artificial dependency,
which seems wrong.

However, considering that the purpose of COMPILE_TEST is essentially to
let the user build drivers from other architectures, and that enabling
OF on an architecture which doesn't have it enabled by default
essentially lets you select a whole lot of drivers from other
architectures... I must admit that both options indeed share a
purpose.

But I still have a concern. Some drivers can be built with or without
OF (they support both OF and non-OF devices). If someone wants to
test-build such a driver on a different architecture (and therefore
must enable COMPILE_TEST) and wants to ensure that it builds fine with
and without OF, then if COMPILE_TEST selects OF as you suggested, they
would no longer be able to test the CONFIG_OF=n case.

So I'm afraid we can't actually do that.

-- 
Jean Delvare
SUSE L3 Support

