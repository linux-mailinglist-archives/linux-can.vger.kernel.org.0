Return-Path: <linux-can+bounces-6015-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83148CFB2C8
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 22:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D3063080F6D
	for <lists+linux-can@lfdr.de>; Tue,  6 Jan 2026 21:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25E2D77FF;
	Tue,  6 Jan 2026 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kw3oeS3m"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C286F2BEFF8
	for <linux-can@vger.kernel.org>; Tue,  6 Jan 2026 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767736440; cv=none; b=qycR5hr5MH6+67rw7cgfOnGiV37h/fpp9k1YXK3HSkPYHM1AC3b+AMsQapHcX7gkqKi173SSm0Vy9h0AuG7E2GtTxSA7KVy5tqRM+sfuD/9A7Ngp5RFJGiuJcMOHe087kAp4GNXSH/clDg7qPCeexQqPGT7ym1m1kSBNpsXSgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767736440; c=relaxed/simple;
	bh=d4rGAO0U0TxZ9w2H/WEEN6FL/LfJ8AB9BuS6CwpoOYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvQaXfx3KgRdQOtRl3tdup0V6b4oq1709ONUGJOHTFJpYXrf/IbNkOXUMYcUycv0Q69ZA70hbc690vryP+liN0TwfVJDA1c/30hR3v+EX987otPtyMveFWxFw0tAVGGNd2VAVf2N+D/m6pfSFQh8ofXtOnbd4+MxkkIR3L1J7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kw3oeS3m; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so11579465e9.3
        for <linux-can@vger.kernel.org>; Tue, 06 Jan 2026 13:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767736437; x=1768341237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xyVxIYmy3wtOuQL/m2GM7dhtWyBgchh4pfGSSU0ZDI=;
        b=kw3oeS3mJqcazWm7SyAXLOOvJaSZ3tX0DZDrKzDrPeZsSXXhtoC5Td/mvBfj775JN9
         l0hAXbXF5LALQAbzCrdtR+fRQDOmUBQ6ovqIZssc3n7/Bb26ojdyNi6l6nH4w9eBIDje
         bhGmpIkBq5SjRhEcw/F+BLo836kMXY4gz8VPrdCtpzJX2OahmtZ54QBnhRw51jlCDmKv
         Nw84Del/xHzoY69uLPp4FDAG9yU3CoX4MMkh2Z2CYi1fIfKx+Ls3E7BMPPBKw56yyxqP
         lU7nVW9g26FcDNUQNhNyyzHi537jS1+ajxaaNj1IIk9NBSWZdJ99nvs+iEX8PKB2l0wd
         OYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767736437; x=1768341237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6xyVxIYmy3wtOuQL/m2GM7dhtWyBgchh4pfGSSU0ZDI=;
        b=TtH1Sx6fUq8G2Ks5Jng+qTzcecKD95XXQoWrrHj9iF6UKaCihImUGIPYTnpl6o5NYQ
         CZwCK02aJ+5Xnp4EfWCSA+jfoKUWlAqLgRcYC5oqBu2yljR1oDopaUR80ahGlve8qGYS
         NKJRQguYwrxNjyn27EJGb8dQu4JwYKNmdtyVjxAM/HbJ8ezSvIz+rltWUyPmDoEOwAaa
         6WzSOIj0u1+a/G5LHXOZKxKhALXBgNXPV9zwR0ECn2OIeIbpsuDgfB+sJplZtWQ9cfPe
         rFJ/WjGQW23CQQvbjX3j0AS8DgfpEWzJ6IwFTgXCCgrkschLv0xKkm8mqCFIc/wYfwmY
         ou6g==
X-Forwarded-Encrypted: i=1; AJvYcCWbtRW54T29U38TwH0ZdsPsnQfOeVobIXgCJDpjfImjTQDEmZ9B7gHA1GCWDTA1Gqw+oxSyhustR9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ycWrroeH/LVjx/GPHs4puXB8j9s9xP1W9jd31glovFlIcD2o
	Crk8vW2jA7bNKmNAi0MZWfNk9+RsYC5GBzaSTzTcEjlsRtO/7dT34MMTRXGzdN4Q7R8E2bPEVXa
	SfiUw0jfhT73XAKwQQSE/49Za+Nk2SGI=
X-Gm-Gg: AY/fxX4+/1uiYdvvHFL6g2W3a56NGOfNY3X5GlOsMK1fhSuAb4Dh+R6fLXovztCaJQL
	6k6GieBP7RcrgGY60tvciTC8XQuNekWQVbOYsqw5HeYPemVqOMFckMUR6YGfjPjfvAS89fd+JK8
	fSl1ejo517YoscQg/tC9ods5MVVCYNp9E/DSpos0omB7XjMXk7pcSF9naUgde98ophcf+8yLYE9
	vv/5WS/BCEO/EHxAzGphNgybOUBiLoePV+JHDUvMPPBBFREwomYMHHtkH7QMCLB0GXa1Uh4UBBw
	+gOubDU+K6zmeBO+FkcwEDABWGYVucnqYrW2VvzlubYZiHOB69ZRPZep3ABYm8jInipl3YPhtIX
	6LANoqNNzEiLK
X-Google-Smtp-Source: AGHT+IHJYyf174/QsrKA4yj9izst/o67M12RhUcvLu8ST8wy8rthqncq05WjMVIhUNkdstK9csgrrZnrP63a4Kf6rMM=
X-Received: by 2002:a05:600c:c491:b0:471:1774:3003 with SMTP id
 5b1f17b1804b1-47d84b5b5d4mr3073085e9.29.1767736436903; Tue, 06 Jan 2026
 13:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251230115814.53536-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260102-quirky-hornet-of-downpour-ddda69@quoll> <CA+V-a8sY0QneUWQ4A0XCKUGPL8VYkU5NQE2h_cOK=06JG_1c2g@mail.gmail.com>
 <20260106173936.GA2345468-robh@kernel.org>
In-Reply-To: <20260106173936.GA2345468-robh@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 6 Jan 2026 21:53:30 +0000
X-Gm-Features: AQt7F2p1qSg94FMvdzlxCyc7AxN9JH-ov8zGg9NHMiITr64SSrfzG_NiapklzBU
Message-ID: <CA+V-a8tOTrjzTvko7hg14pBmHMbxg7r2jWc-EkQFPtHbwXnaUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: can: renesas,rcar-canfd: Specify reset-names
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob.

On Tue, Jan 6, 2026 at 5:39=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jan 06, 2026 at 05:17:17PM +0000, Lad, Prabhakar wrote:
> > Hi Krzysztof,
> >
> > Thank you for the review.
> >
> > On Fri, Jan 2, 2026 at 11:16=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> > >
> > > On Tue, Dec 30, 2025 at 11:58:11AM +0000, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Specify the expected reset-names for the Renesas CAN-FD controller =
on
> > > > RZ/G2L and RZ/G3E SoCs.
> > >
> > > You should explain here from where you got the actual names.
> > >
> > > Otherwise you got following review:
> > >
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > > > ---
> > > > v1->v2:
> > > > - Moved reset-names to top-level properties.
> > > > ---
> > > >  .../bindings/net/can/renesas,rcar-canfd.yaml  | 33 +++++++++++----=
----
> > > >  1 file changed, 19 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar=
-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.=
yaml
> > > > index e129bdceef84..9bfd4f44e4d4 100644
> > > > --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.=
yaml
> > > > +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.=
yaml
> > > > @@ -122,6 +122,11 @@ properties:
> > > >
> > > >    resets: true
> > > >
> > > > +  reset-names:
> > > > +    items:
> > > > +      - const: rstp_n
> > > > +      - const: rstc_n
> > >
> > > rst seems redundant. _n as well. Are these names from datasheet? How =
are
> > > they called in this device (not the soc) datasheet exactly? Because i=
t
> > > feels you use pin or SoC names which is not useful.
> > >
> > rstp_n/rstc_n are coming from the SoC HW manual and is already used by
> > the driver (since commit 76e9353a80e9 "can: rcar_canfd: Add support
> > for RZ/G2L family"). The reset-names existed previously but were
> > dropped as of commit 466c8ef7b66b "dt-bindings: can:
> > renesas,rcar-canfd: Simplify the conditional schema". Let me know if
> > you want me to rename them but the driver will have to maintain the
> > backward compatibility or do you want me to drop this patch.
>
> The names are fine. The above is useful information that should be in
> the commit msg. Please help us if we've already reviewed something.
>
Sure, I'll add the above info in the commit message and re-spin the series.

Cheers,
Prabhakar

