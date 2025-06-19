Return-Path: <linux-can+bounces-3866-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A9BADFC96
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 06:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C227E7A7F6F
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 04:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD3D23D287;
	Thu, 19 Jun 2025 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="E765Lm38"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-66.smtpout.orange.fr [193.252.22.66])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BA91DE885;
	Thu, 19 Jun 2025 04:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750308303; cv=none; b=BPBJvRmGM1dyWJ8CkU5QvLWliJowhQHOD44I6kFv+iBWTo8F2qkw8ibo6dzk6GPLwzPn1NZlQkFEIymFEjmsSR8mWVnKSfLed0my5H9xv5OflohQsRISmTHu/y4u41XVO+pKTwxDwbQfr2lVoVlxvWwTPqsS5Co+Z5Q5K22sNXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750308303; c=relaxed/simple;
	bh=kQkLHVJ2ZPsO0NuKc5/U1omWdLY4oKRUot7eHII1Bnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2IjBdgKhUbLKVMwbFen9bb63pYjs/gizqkcepP/YQ9BFNHPI6rvxlT1xybY18rIEUDfXTm2/SGkw+KlYF7nAA9J1nKm8abvuaDdQAVlcdn+xohY71Pnb3jYPUSikNaViJH+atpOrx8jpTm6qNjHaT/IYHjDTJYcqCP30yaAyCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=E765Lm38; arc=none smtp.client-ip=193.252.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f47.google.com ([209.85.208.47])
	by smtp.orange.fr with ESMTPA
	id S77turHmbl2oHS77tul2R6; Thu, 19 Jun 2025 06:43:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750308229;
	bh=t1M0mXHTq4mHVkAQJdaMdwf1zAB+PTCioJIkEZ5mdoQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=E765Lm38k3lip9mXN4zXVCDnzn0gQ8G/S1tBERXYxEWUE9N53HMi7krnsiUDb1r8F
	 CDRc+9de45tncj4JDdh+qCSBj0RuTKsRjPz4/Qsqtnq7QsPRWuhplWqyowIJ9bIoJZ
	 q12kajbtxE90fiyXuM1lTCTCc7y2zPGDRnbldcZ79HHiLvutUXgCRaMHMKIP2rIHWj
	 170GLdhNsQH26OCbKbPpSFGvQ0+XfZ/8CYkswd+X6wZLukcXa3vgFgg1DMB2Tdmz76
	 SRsjCb+3xRDMlsrgFBDKwWxOIwIrrHA+n4S31t/IvaHlYV9AQepEPzwL5hgbIGaEuf
	 cQmbGYZkOmY5g==
X-ME-Helo: mail-ed1-f47.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 19 Jun 2025 06:43:49 +0200
X-ME-IP: 209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607c5715ef2so507654a12.0;
        Wed, 18 Jun 2025 21:43:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUU4WR7CLHZ5lpPDZ/XoR+XlxFOr8IhfBzknTj9vL+nHbilGKbqYUWLvRvvc/PersL1Vf0p5vqq@vger.kernel.org, AJvYcCXxWYfdE3cCjhi/XxYBaoZJvvZqRXp7iDOc7HBXHOPFBMJl+x4jLcPMDCo8fZoVqP3AEsn/DyyQuJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHX9X8J6MhfkXhblhbT7xVmlJXNstsyiZohACm23jWLkKUJXvz
	bmq4NkvGZ8ydvKkG3JC7moFOPWQbcarP+LrEBOH2aY9roy7xMcJHyfkYbXr3pcZSsT1kkO8amcE
	oGPvQbwel6eMBSxFqK+iaPTeYffO5iPI=
X-Google-Smtp-Source: AGHT+IHbdXtPO5wCYpHV/m7pNfTmz1pMt3wKzDZ97MzOlxFvbI8hb5k63PjX7golAF3G/fOtcLbyPsWMwl0/LC4BwvY=
X-Received: by 2002:a17:907:94c7:b0:ad8:e477:970c with SMTP id
 a640c23a62f3a-adfad310901mr1745369966b.23.1750308229307; Wed, 18 Jun 2025
 21:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618092336.2175168-1-mkl@pengutronix.de> <20250618092336.2175168-7-mkl@pengutronix.de>
 <20250618183827.5bebca8f@kernel.org>
In-Reply-To: <20250618183827.5bebca8f@kernel.org>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 19 Jun 2025 13:43:37 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+azM63cyLc+A3JLwVCgopOcu=LSGfmBQAbKrkJzmFYGg@mail.gmail.com>
X-Gm-Features: Ac12FXwhdJ8r4NT9__gVZOqyz6ZnSA2M4s0IkYDW1z-AE8RjR56EvUXj5gk0XHY
Message-ID: <CAMZ6Rq+azM63cyLc+A3JLwVCgopOcu=LSGfmBQAbKrkJzmFYGg@mail.gmail.com>
Subject: Re: [PATCH net-next 06/10] can: rcar_canfd: Repurpose f_dcfg base for
 other registers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org, 
	davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Thu. 19 Jun. 2025 at 10:38, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 18 Jun 2025 11:20:00 +0200 Marc Kleine-Budde wrote:
> > +static inline unsigned int rcar_canfd_f_dcfg(struct rcar_canfd_global =
*gpriv,
> > +                                          unsigned int ch)
> > +{
> > +     return gpriv->info->regs->coffset + 0x00 + 0x20 * ch;
> > +}
> > +
> > +static inline unsigned int rcar_canfd_f_cfdcfg(struct rcar_canfd_globa=
l *gpriv,
> > +                                            unsigned int ch)
> > +{
> > +     return gpriv->info->regs->coffset + 0x04 + 0x20 * ch;
> > +}
> > +
> > +static inline unsigned int rcar_canfd_f_cfdctr(struct rcar_canfd_globa=
l *gpriv,
> > +                                            unsigned int ch)
> > +{
> > +     return gpriv->info->regs->coffset + 0x08 + 0x20 * ch;
> > +}
> > +
> > +static inline unsigned int rcar_canfd_f_cfdsts(struct rcar_canfd_globa=
l *gpriv,
> > +                                            unsigned int ch)
> > +{
> > +     return gpriv->info->regs->coffset + 0x0c + 0x20 * ch;
> > +}
> > +
> > +static inline unsigned int rcar_canfd_f_cfdcrc(struct rcar_canfd_globa=
l *gpriv,
> > +                                            unsigned int ch)
> > +{
> > +     return gpriv->info->regs->coffset + 0x10 + 0x20 * ch;
> > +}
>
> clang is no longer fooled by static inline, it identifies that 4 out of
> these functions are never called. I think one ends up getting used in
> patch 10 (just looking at warning counts), but the other 3 remain dead
> code. Geert, do you have a strong attachment to having all helpers
> defined or can we trim this, please?

I had a discussion with Geert on these functions here:

https://lore.kernel.org/linux-can/20250613-misty-amethyst-swine-7bd775-mkl@=
pengutronix.de/t/#mef5cb235313c5f0c4910d5571b052eb5e9ada92e

in which I made a suggestion to reword these. That suggestion would
actually resolve your concerns. Geert was OK with the suggestion but
we agreed to move on as-is and make those changes later on.

If temporarily having those static inline functions unused is not a
big blocker for you, can we just have this merged and wait for the
bigger refactor which is on Geert TODO=E2=80=99s list?


Yours sincerely,
Vincent Mailhol

