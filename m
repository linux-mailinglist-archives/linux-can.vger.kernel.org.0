Return-Path: <linux-can+bounces-6576-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFSmLFU3k2mV2gEAu9opvQ
	(envelope-from <linux-can+bounces-6576-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 16:27:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A481458CE
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 16:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0082300407F
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 15:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8AE328B49;
	Mon, 16 Feb 2026 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="3I3ct1mS"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B8C3164C2;
	Mon, 16 Feb 2026 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255535; cv=none; b=syI6h/6BOV8LB6E265Q8DahJFXr3pjQNPTCc00/EH73b/RqmIlMjvclCzHZMGQGphj8ljwEHwAkjopQeeOKuhwuCwWMaf0ddyNGIRQuhW2EFLqh8xXgMdvjcILSnZHyaUm82dICj2fk1MD9UKY1r93cURSUe9PeWeyW/f0mOm9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255535; c=relaxed/simple;
	bh=K3lRTqVkgTbsUZEdt0AotXacxdi5Nb+Ix685DjTsOz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X96MBk9WCXgvTsD2MB8t2KtocbGROaLSVBuv+5gF1vsNSzKTSZ/1UY+S/4w4oLAe4Lyhh+BC9a/abXjP/rFcSTPipcBkQvONXaCROWoFjxKu2bFwS6IQJs6e80ooT54szqGNmFI9GJNZUh9HgkXgM+g8fKw9AW1CKzRf5NUkzc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=3I3ct1mS; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+NuGee1f3YReNLAkZ92SuV7HlsXpngRlfWnVEVSkgmQ=; b=3I3ct1mSQotzkI0CFg0yUeDyPU
	uszNV5kuZ5BoqCMC6ea1ywRQ9F8zCXOL/daxPnD8zkNgUHA+mmizXUBINHJxHNlw7hMr4s0IHioh9
	5rlaft8K+ZH5XDqp0Yd3XdFnTcTPA0XAPgtXdL/jwazhLlNkinKzlgXymtdDixCgO7CocgnDF5suu
	iCBCt9pqxSEP8lbjwY7jbss/nmXL51hQ0fv4jm+WRPHHO549392zOcsxYzRk4jTZQeTcsDoqFc90M
	+tiUVHW2jQH47ycjEgqCjs3dAESLSss5wECck4GJNgxvFwo7SB0sPhR8g79fm5Jur8p5mkQOASMuj
	68a4dnlQ==;
Date: Mon, 16 Feb 2026 16:24:06 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Josua Mayer <josua@solid-run.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik
 <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, Andi Shyti
 <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Yazan Shhady
 <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, Mikhail
 Anikin <mikhail.anikin@solid-run.com>, "linux-can@vger.kernel.org"
 <linux-can@vger.kernel.org>, "linux-phy@lists.infradead.org"
 <linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org"
 <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Message-ID: <20260216162406.0121dd91@kemnade.info>
In-Reply-To: <20260216092914.kmvl7aep7dantcsd@skbuf>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
	<20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com>
	<20260212164823.mbeycqwzsy2dfq6e@skbuf>
	<CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
	<f9ede0d3-6a37-449c-b62b-a5c761ece097@solid-run.com>
	<20260216092914.kmvl7aep7dantcsd@skbuf>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kemnade.info,none];
	R_DKIM_ALLOW(-0.20)[kemnade.info:s=20220719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6576-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kemnade.info:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreas@kemnade.info,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[solid-run.com,linux-m68k.org,pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,vger.kernel.org,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kemnade.info:mid,kemnade.info:dkim,infradead.org:email]
X-Rspamd-Queue-Id: E2A481458CE
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 11:29:14 +0200
Vladimir Oltean <olteanv@gmail.com> wrote:

> Hi Josua,
> 
> On Mon, Feb 16, 2026 at 08:19:27AM +0000, Josua Mayer wrote:
> > >> In the future, when you have a series with cross-tree dependencies,
> > >> please try to think of it as individual mini-series for each tree's
> > >> 'next' branch, and specify clearly that you need stable tags (to be
> > >> pulled into other trees).  
> > 
> > I don't really understand how I could split my series up to avoid this 
> > issue.
> > 
> > Due to the fact that one (and now two) drivers implemented local
> > mux helpers, to undo that an atomic change must be made tree-wide.
> > 
> > Meanwhile it must be avoided that while the mux core helpers are being
> > tested / reviewed, that any tree adds another driver-local mux helper
> > like appears to have happened here.
> > 
> > Note that my patch-set did go to linux-phy@lists.infradead.org list, too.
> > 
> > The second challenge for this series was that mux framework is being
> > enabled only by drivers Kconfig "select" - and not possible by menuconfig.
> > This is e.g. responsible for being unable to test =m build with arm64
> > defconfig - and lead to it only being detected through kernel robot
> > x86_64 allmodconfig.  
> 
> To avoid this, a combination of developer due diligence + maintainer due
> diligence is probably required.
> 
> From linux-phy perspective, there will be some automated build testing
> (which did not exist at the time of your submission). This would have
> caught the 'hidden' devm_mux_state_get_optional() call present only in
> linux-phy/next, when testing patch 2/7.
> 
> But, to work, the build automation needs to be able to apply the entire
> patch set on linux-phy/next. So expect some pushback if it doesn't
> (hence the recommendation to send a mini-series to linux-phy first, and
> request a stable tag).
> 
I do not think that is at all the duty of the patch submitter. I think as
long as every dependencies and side effects are documented, it is IMHO up to the
maintainers to decide how it can be merged best. They know best whether there
is any danger of conflicts in their working tree because that is an area 
where people are working on. Especially this patchset is around for months.

 In MFD where it is
more common practice to have cross-subsystem patchsets, once acks from
everyone are there, MFD Maintainer creates an immutable branch with a tag.
The maintainers of the affected subsystems pull it in. 

Regards,
Andreas

