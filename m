Return-Path: <linux-can+bounces-6036-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CBCD02269
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 11:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E47633118FDF
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 10:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A86F3A0EA5;
	Thu,  8 Jan 2026 10:27:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9AA3D5221
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868072; cv=none; b=Gk6KlYXz1ihMdX5EtjQeTvIOlWChqU1tGvcj5DK8K8VnxuzIGksBINZz2BgMVqr6Hr1HfBKATw0thTufSUCxrWdUClKcdFtIpeYsg5CFo3z20G3JdMPRGvBgm7N7C48PLqfpv51aN/xX2lA1nvGrqu5QVhB/9j8x6+duHzxOLJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868072; c=relaxed/simple;
	bh=pGg9zkdVQOf89+usv8Daa9DstO50p1qO1Ru3e94qQX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UH/vbvZ7gf23agez+dpFneE9uFfo2GUaLaLs8sNZjsHosOps64bCg/U1f3ywvSx/WSKq1kAIdbE/jiElfQuBX/JBxWkEf69eWCAsB+m9Qklt6RTFuHwAZOXMo/MyCxLo0F+zkfglynJfJ+9ye2leDK3rA3rL64cvQ6tW9VMwGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88a2b99d8c5so26320996d6.1
        for <linux-can@vger.kernel.org>; Thu, 08 Jan 2026 02:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868068; x=1768472868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6KYTwUPo18TQzTPppR+0uTL0qRsTCN2Iw6Xw2gz/T9k=;
        b=BcOqsmG6Fnn42uSEhxk5OmjiauWa3ffv0wDglAaXaOangDK13FErUk3SDyva54ezXj
         ugX20NAoAJcL1Z3ZGb0LP+/B7ZgZuZMYIn8+BSeJK5nbpwaZAoEc8cX1ME0dr4DS9hPX
         tkYqe47E2/87hMnnfpA+wve2+OV9yZMjRn6zwEwNIsKjEJTrZWkf2rgjAAi6ZusfFXws
         frEXrE8z799jDnPiv/U+DrLHCx3HKgAzw9+FlZw6E/nkwk97CSoQ146RBdnl85JvZnUS
         fKrNYuqFrLfYxQFsQI9nFt5AZGjdkDUy/tje6feqEMpaLmkTelDo3WTunnhINNn3g+7E
         WXgA==
X-Forwarded-Encrypted: i=1; AJvYcCVm9XGG2JmSfAFYxFVkkG+cILNcZL8//TrXesTMd17XGX+mRMN3kULIxj9ZI/O8XimfxXlvOIIgrXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpyQIJ0uyfCNT+D00opBDoqUiBjTfqJ6eko98G7YeobdqbYsef
	DLbRo4bA47tC1mQUtDNsZQbuZX8KS5vQz/YETVNWrYh7IfsaCuEMUaASI44k3oFo
X-Gm-Gg: AY/fxX7ACjTh8iiy59aRDvfQbTGkiRFAUO1oXVRCymNaqXKJRK86Vf9SfcLwME1Uld1
	RfONjtHNqBpOCCla8AxPi7fE9UDUjxQqClyRka0NT4iZS3EVydK1qGJqqBPMEKSaWlIVd3B/PJN
	kEU+AiFojAEzFn/+n/AiYlU39PKPMTbMAo0LioQ/jvnKxchoMKPP5/WDcHBioBSLVFZyZV8L0VB
	2A3TXGB05MqZJhaA0BuU2EoMcCGR9ZHkFQFR5OU0dl1lkuRrUs9jCRSZfVzpWAkkIMogdjuXn8b
	nfJ/T8RO3p6wI3EUL8uAElqTaTovpkUYeA+e2Son23v44Vsv6rnx2715t642u+tbGwq2nRqL0Dd
	4vctUa7micEkaBEV9meNN2PNG82ooFWPkKdJHpDIoBGDW6JG9okE9tAqp1x++4saolF8jfYkM9C
	y1B9sOC0LlFqjvbMGVnQuFr+oHko7Y4cxAOnKTsrFaQIIz4DqBrcr+
X-Google-Smtp-Source: AGHT+IFZXmgPEfZju4x1/w8jYyH7jlPhreEfbmy8o55R4FhFAG6aWWmT5VX4w5NrBkOLMm2c9KO9Mw==
X-Received: by 2002:a05:6214:2d42:b0:88f:e3cb:baa5 with SMTP id 6a1803df08f44-890842eda2emr88129006d6.65.1767868067754;
        Thu, 08 Jan 2026 02:27:47 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077284f23sm50170866d6.57.2026.01.08.02.27.47
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 02:27:47 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ffc5fa443dso1458331cf.2
        for <linux-can@vger.kernel.org>; Thu, 08 Jan 2026 02:27:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfzFU4QECQiIz+ZZcdPjCkDmGvtJ2ShvsLdIV8Jc1a1lP33NXOanTWQMVq4PRMsTlGRLaj09QaGlI=@vger.kernel.org
X-Received: by 2002:a67:e716:0:b0:5d7:de28:5618 with SMTP id
 ada2fe7eead31-5ecb1e6f437mr2335328137.5.1767867662424; Thu, 08 Jan 2026
 02:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251230115814.53536-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX5_TkFmgqv29Nddo4bZzEWQrL87kwqTdiLwfq+qMtsXg@mail.gmail.com> <CA+V-a8to1W2xbA7LpzLa5RSy02hyUFG0AeDR4iSsj7jt36VKVQ@mail.gmail.com>
In-Reply-To: <CA+V-a8to1W2xbA7LpzLa5RSy02hyUFG0AeDR4iSsj7jt36VKVQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 11:20:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUe6gkbgQj7cjeZ5w2Mn_HPDwiuh5yEp8nQEE-vQPLqQg@mail.gmail.com>
X-Gm-Features: AQt7F2q329GKSf7dgOJYdzgZ3DUM2vDua1zqaJTIpmI1KP2q0zp9hslKg4nKf7k
Message-ID: <CAMuHMdUe6gkbgQj7cjeZ5w2Mn_HPDwiuh5yEp8nQEE-vQPLqQg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] can: rcar_canfd: Add RZ/T2H support
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Thu, 8 Jan 2026 at 11:13, Lad, Prabhakar <prabhakar.csengg@gmail.com> wr=
ote:
> On Wed, Jan 7, 2026 at 4:37=E2=80=AFPM Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
> > On Tue, 30 Dec 2025 at 12:58, Prabhakar <prabhakar.csengg@gmail.com> wr=
ote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > The CAN-FD IP on the RZ/T2H SoC is similar to R-Car Gen4, but differs=
 in
> > > the AFLPN and CFTML bits and supports two channels with eight interru=
pts.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> >
> > Thanks for your patch!
> >
> > LGTM, so
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > However, compared to other SoCs, CFDCnNCFG.NSJW[6:0] has:
> >
> >     0x00: Setting prohibited
> >
> Sharp eye!

I knew what I had to look for ;-)

This one was indeed hard to compare with other SoCs, as the structure
is completely different. For e.g. RZ/V2H and RZ/G3E, I could just use
diffpdf, restricted to the pages I am interested in.

Still need to enhance diffpdf with shift up/down buttons, so I don't
have to adjust the page numbers manually when a few lines are suddenly
moved to a new page...

> > Perhaps this is a documentation issue, as the same limitation was
> > dropped in RZ/V2H Hardware User Manual Rev.1.30?
> > Linux also has no can_bittiming_const.sjw_min field.
> >
> I've notified the HW team to get it clarified.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

