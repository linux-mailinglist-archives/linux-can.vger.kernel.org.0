Return-Path: <linux-can+bounces-6010-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11817CF9FD0
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 19:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2536330B0C76
	for <lists+linux-can@lfdr.de>; Tue,  6 Jan 2026 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE25333B6F5;
	Tue,  6 Jan 2026 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA1WiDHb"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1C1338F45
	for <linux-can@vger.kernel.org>; Tue,  6 Jan 2026 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720408; cv=none; b=opOxz58WpqlWkz3otLamc5ii7s4SXPl8n+3GIg6qEnqgsONmcEJLSh/8s1YQDc442yCUtom8+5vNV5oghVLrNVmD92ZVFZnTKoDH0bLN0GDDbbAF8BnwMWlPNiVbWO5FFH0wmKIVMoayBG/Fl157QnLHrHk5jAkGSgtkXNPxtlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720408; c=relaxed/simple;
	bh=jIERsNeLWsCMRsQUhVUyTdjFaVz1btYgxR4tH7uHWbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5bv1bpWBibU1a/TqjLrptRsIzP2YgdqnO2aOohY2lEZvOsJx2rCaFuKPfrgj8mCMkXOcLHbB25K0KaXd48E6jjPa7IY8q2tK8VWni5D7xx0zvGV9p7mkjbfZR6xRdu8CLIWpaKZLh8WnE+io8FaOMUS/9y07CEAAEjZCD1zxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HA1WiDHb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so10910075e9.0
        for <linux-can@vger.kernel.org>; Tue, 06 Jan 2026 09:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767720405; x=1768325205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pMHpVSuzSyUl3NaYsDNZbwWy9/z4ne3LRaPNYd9gtY=;
        b=HA1WiDHblkzmbBh+R3ra8Vi0u3Y+Hl7+/3c0w1xec3HDYnK/dh35FFm9ns9faoksmB
         pvhLb2DEYD1yfJThms691VLJAN+tmwllhkkRuGFxQad44rO3kd3WiNB0YcGP8HAkLout
         gBBp+ZiSCSLoDz61BiUbwdWnbu7ur6269vecvNBUNuLZuLrqVbgQsSehVunl0xeVNkAA
         0yzRf2tBrZPtRM1I31NrkWZXnWpnDFVAO1cBLwcD5jEokR1E8g2xaGNkFWhhuPh4/ozJ
         sO/XI/uWOduQx0C4LB/LS5ODbLaIIipekDBdIcRCn1SIwgyg3l2ED8mIoYeLbqJf02nG
         HoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767720405; x=1768325205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2pMHpVSuzSyUl3NaYsDNZbwWy9/z4ne3LRaPNYd9gtY=;
        b=UNsKHORFA/f8Z7GPo0xxPvmyQ1ohrNKkQsRYft2TArrifo5Ve/v68Kf7FgKVk2YSc2
         nuUKo7z4e10WK6tgIxHKWZ9GfRB9Icr8btfPvQEOcaJmzHrP58vAyQb6C0bfXb634Rb2
         YyDzC+viSgbIVQiBf95WaPF5quk/G2bO4JLbjOHUleKkTwKP+okN3U+KUr9vYe7tqcOc
         O/otMJBZW6gPWI4pJX/jTlqCXn6B+cOGOogDMoGh/YnlYIyfhWZUw5kQ9nbdbgks0Yeh
         TtO2nCqezoC7Co8KZGh5/ZTIMARvrxlH+arvbCLLjyWxq9k6KpVey+DA6GvTuWvv+qvg
         B06Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpc4GfgYYZFjNV+PEOoK/NZ8wifDrBvb+nNsIBeurOKLGsW3CxsS4VyFkrrjuKoqrZD/CB4y4fJrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Ta1esGBiz0ZRokGpV2BzRpf7XIWLOEajI0JiMDRVHxIDzpJY
	WFZ0YeV/Sta+0MuY0MIMbaucJsW+Aqf7Kg//m7xAqW7ILhPnT2CE2jRYh6r5qNmFSZek645+ur1
	vS/SQPO7uLLxpc43th+dR9A1F5dCDsmA=
X-Gm-Gg: AY/fxX7PeODaBw1KlcHe5JwqHG9cinhPPG2S58xFT4FX3+8XOla+N2uJ7Jy39C5GC4J
	gqXxi5VQEvG5EKpzhbkOP54hGSoTjGdCKnA9CpMupdC46JFAMAJI5VPtiuDlmmwPohfpiGSe4V1
	vvNpveLUwpv9U8Y3wquN89noLWd/6Vbf5L2XV8N60RdZFsgtuiMke7bH0dfumgRHhGUxnO5xIxa
	jMColDmkEF0eOD0JwVR/mFvVKy7woDtXflOWqA9pbCxRHqQ1wAg6tb3+1UsxAwupihhH2j0Jh45
	G/pBBE3GQN7m2fyhvkweUilxAc4aT0eZ1QDKx3BjWuFU6bOaVJ8RmyIUU3xVg5NgFNrSGcmsH6M
	vwuAsFQwMYhqkfk1jtfkEc50=
X-Google-Smtp-Source: AGHT+IE8gvKCbSJq1z8Cd0vdaqEHelQJRB7VUwu1Y6OV1SxZq84Rtw9xQvuGr69PPYzoTYxNGWtVKyAC81y0wEosCQQ=
X-Received: by 2002:a05:600c:154c:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-47d7f098beamr41642405e9.22.1767720405159; Tue, 06 Jan 2026
 09:26:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251230115814.53536-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260102-petite-gentle-wasp-81bbb8@quoll>
In-Reply-To: <20260102-petite-gentle-wasp-81bbb8@quoll>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 6 Jan 2026 17:26:19 +0000
X-Gm-Features: AQt7F2oLYuXOHzsB0MroBEn6dGAE93yUvo9CAwzUHg627WTSLy-aKKnPg1k6phQ
Message-ID: <CA+V-a8sryz1f_woi_r8jx_4x7TczrWPyjZoo+P9p=tG8KyK8YA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/T2H and RZ/N2H SoCs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thank you for the review.

On Fri, Jan 2, 2026 at 11:20=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Dec 30, 2025 at 11:58:13AM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Document the CAN-FD controller used on the RZ/T2H and RZ/N2H SoCs. The
> > CAN-FD IP is largely compatible with the R-Car Gen4 block, but differs
> > in that AFLPN and CFTML are different, there is no reset line for the I=
P,
> > and it only supports two channels.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> > - No changes made.
> > ---
> >  .../bindings/net/can/renesas,rcar-canfd.yaml  | 26 ++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-can=
fd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > index fb709cfd26d7..4a83e9e34d67 100644
> > --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > @@ -50,6 +50,12 @@ properties:
> >                - renesas,r9a09g057-canfd     # RZ/V2H(P)
> >            - const: renesas,r9a09g047-canfd
> >
> > +      - const: renesas,r9a09g077-canfd      # RZ/T2H
>
>
> That's part of other enum with single compatibles.
>
There is no enum with single compatibles as of in next [0], there is
only one compatible `renesas,r9a09g047-canfd`. I can club this with
RZ/T2H one.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml?h=3Dnex=
t-20260106

> > +
> > +      - items:
> > +          - const: renesas,r9a09g087-canfd  # RZ/N2H
> > +          - const: renesas,r9a09g077-canfd
> > +
> >    reg:
> >      maxItems: 1
> >
> > @@ -179,7 +185,6 @@ required:
> >    - clocks
> >    - clock-names
> >    - power-domains
> > -  - resets
> >    - assigned-clocks
> >    - assigned-clock-rates
> >    - channel0
> > @@ -243,11 +248,30 @@ allOf:
> >            minItems: 2
> >            maxItems: 2
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: renesas,r9a09g077-canfd
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 8
> > +
> > +        interrupt-names:
> > +          maxItems: 8
> > +
> > +        resets: false
> > +    else:
> > +      required:
> > +        - resets
>
> Why is this de-synced with reset-names? Properties are supposed to
> behave the same way, not once requiring resets other time requiring
> reset-names.
>
There are SoCs that have a single reset and others that require two
resets. For SoCs that require two resets, the reset-names property is
marked as required, while for SoCs with a single reset it is not.
Apart from the RZ/T2H SoC, all SoCs have either one or two resets.
This difference is why the properties became de-synced. Let me know if
this can be handled differently.

Cheers,
Prabhakar

