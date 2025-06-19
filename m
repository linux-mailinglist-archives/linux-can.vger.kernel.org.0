Return-Path: <linux-can+bounces-3873-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108E0AE0897
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 16:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF223ADCA2
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C184921883E;
	Thu, 19 Jun 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXdVQp7x"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E1F1C3C04;
	Thu, 19 Jun 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342934; cv=none; b=i/SIrTEn7VnptT5q5mHlINgkv4siF7G7/EuudZLhxyH5w6oTBPPUyzr5wk9RQV6okIc1bQaXs2ajcDAMnaLrA3I39TSfbLnsLeBed65E43Klqbo9yTUW2K/jtLauiCaWtScqt4VmwgTdGZSzNNxIkppCseEkljbFIw2CzgucRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342934; c=relaxed/simple;
	bh=UUJ2Oo7w36PsdYpLovHSd8OEWg3RiaNcBSmrNY/hHH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fv/F+TG3YiWYTrpOOoUFid1IZ4aEzGMv69DRGzl/vqTcY+zGqK7nohZssDMyLYqSNE2VJW42QgYiTSOYkBJ3XjpGrgc45fqf12ayBxF2ZP8Exqy/oGalCH/d2/HsszVSaXFaUv3gnP64cFcMjjYtFrtQhF9Pnd1NQkjp3+EFSho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXdVQp7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9865C4CEEA;
	Thu, 19 Jun 2025 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750342934;
	bh=UUJ2Oo7w36PsdYpLovHSd8OEWg3RiaNcBSmrNY/hHH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JXdVQp7x/Xr3a71TZxt5MTs3bihXSgo5imc0jEqDayqa3z7P1c0N3uRPldIkequpx
	 7/t2cfjEUKWwxREv69jwySZUUrhHvoZ1Cr8tcyBpAUThfp/KShsUXOOQHD4fwsxjzj
	 rMacuQWvFwU8st5sL04dgtkt4WAJ3cgaOLfieFgNBprow9tnMK8GLZS2zB/vt3Phj6
	 PQg6ntsDdn5JssAid08L7aG7rRIjzlU/u6wOCr/A9sZmhHbcmp+oaTNVfq5TnvTVyU
	 K76XmQPTeDZEobLFQ4Q1y/iSvqRVoBVQPcVbaQmWgW//m5kkWYkGNNfbdMuqGZk46W
	 MutITUgY5hF+Q==
Date: Thu, 19 Jun 2025 07:22:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Marc Kleine-Budde
 <mkl@pengutronix.de>, netdev@vger.kernel.org, davem@davemloft.net,
 linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 06/10] can: rcar_canfd: Repurpose f_dcfg base
 for other registers
Message-ID: <20250619072213.3d84c100@kernel.org>
In-Reply-To: <CAMuHMdU=7YUZgcwK_annDigTgE9YqQ=sxjtF9ttAGzPV-7wR6A@mail.gmail.com>
References: <20250618092336.2175168-1-mkl@pengutronix.de>
	<20250618092336.2175168-7-mkl@pengutronix.de>
	<20250618183827.5bebca8f@kernel.org>
	<CAMZ6Rq+azM63cyLc+A3JLwVCgopOcu=LSGfmBQAbKrkJzmFYGg@mail.gmail.com>
	<CAMuHMdU=7YUZgcwK_annDigTgE9YqQ=sxjtF9ttAGzPV-7wR6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 12:16:00 +0200 Geert Uytterhoeven wrote:
> On Thu, 19 Jun 2025 at 06:43, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> > On Thu. 19 Jun. 2025 at 10:38, Jakub Kicinski <kuba@kernel.org> wrote:  
> > > On Wed, 18 Jun 2025 11:20:00 +0200 Marc Kleine-Budde wrote:  
> > > > +static inline unsigned int rcar_canfd_f_cfdcrc(struct rcar_canfd_global *gpriv,
> > > > +                                            unsigned int ch)
> > > > +{
> > > > +     return gpriv->info->regs->coffset + 0x10 + 0x20 * ch;
> > > > +}  
> > >
> > > clang is no longer fooled by static inline, it identifies that 4 out of  
> 
> Oh well, that explains why someone pointed to a CI log showing more
> unused functions in a different driver.  I hope it only does that
> for unused functions in .c files, not in header files?

Yes, AFAIU it's clever enough to distinguish what came in from 
the headers.

> > > these functions are never called. I think one ends up getting used in
> > > patch 10 (just looking at warning counts), but the other 3 remain dead
> > > code. Geert, do you have a strong attachment to having all helpers
> > > defined or can we trim this, please?  
> 
> I would like to keep them (or at least the information), as it serves
> as register documentation, just like the macros they replaced....

Okay, we'll pull, but we really should try to keep the tree free of W=1
warnings. The CI can deal with existing warnings but they will annoy
humans doing development. Maybe there is a way to disable the warning
selectively for rcar if you find it unhelpful? And then we'll see if
some well meaning code janitor sends a patch to delete them anyway ;)

