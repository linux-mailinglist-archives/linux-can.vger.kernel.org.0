Return-Path: <linux-can+bounces-6035-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 227A5D0231A
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 11:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 032F33092449
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9733B961F;
	Thu,  8 Jan 2026 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdYgb6tY"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFD53B8D79
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867243; cv=none; b=RunK8uPuH2CEo77w4QTW+V3nC9LN5FvSfu+PG3GfXc9TIAebQ8vVqdrrydTTrDLSotpB0d3JIGxmAMP5KHc8bvW1gaUxEEZlN+E9QHwH0ue+/Afdop194zS9rkvyeQQd4I6K2uK//cy0lXhXvMvCEtVPOXBrtnDC7+dbbeq9A+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867243; c=relaxed/simple;
	bh=sXoW4mVTyRQzIbKcvvJZzwtyNNh7crECPosOAqfEHSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwKaQwjYlb/UKyXgZyq5xeEZ+VDpoQnn0ni3zZs836PNEYwMsScic+keGl3LbRoIeqIZvbpDJCk6s61Swh9S6/eNkJl/3eocRypGIYlW7WfjBPMQ8LixhOlN4YWkC3DcwfEJv0piowS7SpItlvGkv+01bz0fu+rpZynCBw3UoAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdYgb6tY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so1615872f8f.3
        for <linux-can@vger.kernel.org>; Thu, 08 Jan 2026 02:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767867237; x=1768472037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhDPeXMLOmbhNZMmayEqn2Xyh0RUQfbS2x0SaXmYylI=;
        b=hdYgb6tYe8y13ML2C51MbA7pxqTImRwxAl3Jv+1dG009POEsUfy6fjaCiMdC3wpJ7k
         ABHjdEhOMxn41RQEnNsblqclCJGl6wtqDf+/kfWGZpwFIBhZPGmjnsA/gnu/IWlLhmK4
         SBas7yMPZaGbv1y1Gn49VPQNckLLkVELo2jKXGOUIecdhoMsxjyElDAoUH+44PwjmbWa
         W4YMUGCa0wPaTX7PRB182RCQQ2RTf5kXmT0lXRDbeXNV8I5w9wY20Oqdi1SFeleUWW7Y
         vyHjhg2rmkVwt7gd/SPShNZpWF5WJBoho3VmpCw3isJRKMO6ucEPjDovdQWocGEUB7d3
         oR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767867237; x=1768472037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qhDPeXMLOmbhNZMmayEqn2Xyh0RUQfbS2x0SaXmYylI=;
        b=GToYwLNEhPkjnuZWPTp7uLpgHAYk6XNt4GHO6e4jyRkTWqM5G1UQs3hvSge72P9cZv
         4zqeCAimeG7lGf/PxwYUjc11wYVAuKX7l0HBnTRRgQ+aKlia/5gEJnwyS5pU4wEY0MTF
         HNjxglhpmUFvTPDzCLvQOXz6pJ6Wb9hvMfqv35zyt7+yHcIv4TtcxzlP7ycWbBmANaik
         +9+ANhVjGS7iaANqs/8AefTbaUHInOxuRwR815orW6IMMCop4ct1WZeJcb18HbfbevUr
         SXgiPk7ThG0hkVJFd0ESiiS8qeB8mhW76jv5iZqEcTHcliFsrW4/ALS5JwhsDcs4cWjb
         v2kw==
X-Forwarded-Encrypted: i=1; AJvYcCVMeIbtOl4mCBNxlK2eHAv0uyfWS2vUV2prcB6/R+4ibRT3NXRW8oWxZiEOGOSFzOmf/qL6xSlo924=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRW5Gy+xqDGb7ABb4cMG33iEp3jAApWJP6S4/XUvfSV1eZAGzm
	VEgRPoGCPkc4gxQFWwBk7YJQULnhD4qTUEWmH7niA7jMvmOPNRJUWQlI/kzYtvfsTX3bAtW+SLH
	g+1DJ/W57Pnf+nwg7hbBQMDPuzVp+4sI=
X-Gm-Gg: AY/fxX4BcclT7bQROGy0bzjN3RHVTK5ssXLkFlZkWDNNEPVCyaYuFIEkxHZt3Jv91kH
	rbOkKDam91f6+jrbJ6T1sZVzMMqTaTKeG3V5OMIoj3CCveLSYsbvUezj/ROGQf9/JNCH2G3gRZi
	rfyHDCteMWBSuzcoKqBtdwMJ3Pgz/BekXDiv3LTwdhuwygtNRhr/s7e4PtYVq2wIY5fd2StZTxb
	7/vRqbwDDGwR6ZcyBq06csAkm0o+wAc8eNGDZDA6JXZNleWvyadTz5Av/VSs7EHw/ZYUOPkA20B
	xaL6Ber5eD02KKI5mx4ejpV6syLM4GMxoJF8dZXrRd/AXcDgAhUuZCtq7w==
X-Google-Smtp-Source: AGHT+IFP0dUQJo6LOh2kBlHH57wWlfc/4287ppA81OjmXtNFTh6Sm1IDnpOcmlyPE+R331Nvt9CzRNqdOsB9pumwoec=
X-Received: by 2002:a05:6000:40dc:b0:432:5bf9:cf2e with SMTP id
 ffacd0b85a97d-432c377298amr7420571f8f.13.1767867236499; Thu, 08 Jan 2026
 02:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251230115814.53536-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdX5_TkFmgqv29Nddo4bZzEWQrL87kwqTdiLwfq+qMtsXg@mail.gmail.com>
In-Reply-To: <CAMuHMdX5_TkFmgqv29Nddo4bZzEWQrL87kwqTdiLwfq+qMtsXg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 8 Jan 2026 10:13:30 +0000
X-Gm-Features: AQt7F2pfXBaU0qS8scxlI8e3JZryt-q1cuaCgkd0suVDe9HGuILaVv9inKd0-_U
Message-ID: <CA+V-a8to1W2xbA7LpzLa5RSy02hyUFG0AeDR4iSsj7jt36VKVQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] can: rcar_canfd: Add RZ/T2H support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Wed, Jan 7, 2026 at 4:37=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 30 Dec 2025 at 12:58, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The CAN-FD IP on the RZ/T2H SoC is similar to R-Car Gen4, but differs i=
n
> > the AFLPN and CFTML bits and supports two channels with eight interrupt=
s.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> However, compared to other SoCs, CFDCnNCFG.NSJW[6:0] has:
>
>     0x00: Setting prohibited
>
Sharp eye!

> Perhaps this is a documentation issue, as the same limitation was
> dropped in RZ/V2H Hardware User Manual Rev.1.30?
> Linux also has no can_bittiming_const.sjw_min field.
>
I've notified the HW team to get it clarified.

Cheers,
Prabhakar

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

