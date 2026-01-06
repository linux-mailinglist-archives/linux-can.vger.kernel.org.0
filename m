Return-Path: <linux-can+bounces-6008-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D00CF99C0
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 18:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62E0830276BC
	for <lists+linux-can@lfdr.de>; Tue,  6 Jan 2026 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5132877E8;
	Tue,  6 Jan 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiMocbuo"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B8433A717
	for <linux-can@vger.kernel.org>; Tue,  6 Jan 2026 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719866; cv=none; b=ZrRWYyf1E1c770oqfYZu4fOJjpoeimUSwwqSNFC+r8sQbvmHAIsvFAFekrrOPquX/rYUXyIEMBe17emr14E/ucrvI4Uqj5w+K7j92PlSIrfJdlQmXlfWST64NVLgs5y9xzRmj7HSbKjPOtfoTU09HklREgaiFtrN+PU7+KBUIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719866; c=relaxed/simple;
	bh=+i4yQ/J32R+PT8plwqXy9nxZsppdLI6MyqOJOxsX0UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3F/f+SXIMmHh5FyRv1otm8gW5sw2vo/7us4BQb7+Q/6V8xtCXD76EolPaYMG2ltsUeeccUwNsPHcFl/2ktkYsmpYnY2sexhmqhdj2lkuwWZ2nX63Ij6SAuDRcALFe61xk9830xNbIDZ5LeFRPY0xGfxN2yq3vkyKBAsJpGJomk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiMocbuo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so880845f8f.2
        for <linux-can@vger.kernel.org>; Tue, 06 Jan 2026 09:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767719863; x=1768324663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omNJI0np8/A37o5k8AFHebpXKnjsjMZumbvdbisQAi0=;
        b=hiMocbuouq20a4E84kkzcpFy0wTyvjxkb19fqNq8MeOt0YbWw8Q0kVDMst9zcNlhc5
         DSXmXs1jxCyxMGdojaqqNr96jmonOFPiBRV/8oXllmH6MTbdRnQZXOcol8Hsp6IwmMFj
         MDFxHZCVakbJof1/o8Z45cKHCFzRCAp7tqS0ZETyLsbsef32GQ8+M6nRR0V+CuNphKD7
         D5KrlwJx9S2es9QnZgLQl2YPIUS8PukX6U7D5+CLkgcsrbzSnXTXSGrH2VGKSnkcec1u
         zNI47TMwOnGIKFkqXZjZYe3BK2cXq+ihYKfME1Kw3surlyM1kaGNpjSspwP9zEUeXRs+
         wC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767719863; x=1768324663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=omNJI0np8/A37o5k8AFHebpXKnjsjMZumbvdbisQAi0=;
        b=m4zKow9JLTe1dnuIzxurBKLiP7k4GGGrVzVobhuB3lga/1KiFkpfGrfWuAAWIWgupQ
         EvEG3fO54L+Yy2OkKT7ylXO4Z5lBYbX0WuOjz2Zoaod/9UaZDrx+t1js0x2dmsGOr0zD
         2F5FGeFBx4FESw3AQeeuZ6ga7kkNw/LkfHMYJ/5i1JJaij1lhUYOXxYHdjOccD6cJ/Ok
         SVSRbreFOSJRF4YH+xcCtkMYhidceclHcryKTE6u3GH8JQBOxT6heEejRZ2oVk6E4jWU
         Wq2O7b9WbWSk/V0i0nwkbKSqtWuF4NkBM6KDooyNYOXIl2aIwcT/3MuB3+hOlQY7J98r
         g2gg==
X-Forwarded-Encrypted: i=1; AJvYcCXst2GVOQS3iVHX8FMKBgbPypx0cGRLo9SwWgHJePSx3T/F8uH4xj5Dap3Jb+MnXih0onTyybN9CuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9lX9eKvkZAmq2pQUOZ8xNKW4FL6zldnhDc/W6lq4WumEEL4WB
	nXqUEG1BHMA/2TQ/JMcql2WlWZmDmR1SW5gm15xdbIvhNsE6e+2CnbyUx2yO1YAL1xbnDttaNEu
	Fi7p4BhDl/UiTTaHMUWrKfeNiUeB0blY=
X-Gm-Gg: AY/fxX5H6rR5xIxY8vbUwWAaQW4cZbtK+IYbX+yxad/gTKyCkJyI1I8ilp8A5yIDQKs
	f2ZmBnA351/spKchWFlO6NGEHyS11ABixcgG9c6Ra0Io6eCZUaIE06teENj4OwrLxqAbA7biUpu
	30LRI2fkoI8weNmnpcjshy/evYGrnKpqvwXCC7YiWfhpWLllxQeBdGZbulsutJw0lAziC4aOzhl
	Q9Fz7BAzaaQwkYjgvytqTagyTSO44aklhBRAny+2/mBKd2xCDqPkBPzj6BHQqbPUPWUMNuqN4ZW
	CCqcYfGCPhKiqO08YGRhaeRb2E97qY99ZldNR4LEt1wP2M2Vc0H7SapG6Kc1gfxESX4SmycGFme
	xYI3jeTHZceKI
X-Google-Smtp-Source: AGHT+IGQllKLGXZw9XFWVTR0oSm/60fESFM2NQBn5PGd7ftNxtYras13avla7VpSZwBYhVejhwO84IWLhs7cyffC9Hk=
X-Received: by 2002:a05:6000:604:b0:430:fc5a:40ac with SMTP id
 ffacd0b85a97d-432bca566d2mr5730225f8f.54.1767719863134; Tue, 06 Jan 2026
 09:17:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251230115814.53536-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260102-quirky-hornet-of-downpour-ddda69@quoll>
In-Reply-To: <20260102-quirky-hornet-of-downpour-ddda69@quoll>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 6 Jan 2026 17:17:17 +0000
X-Gm-Features: AQt7F2q6b-vi36w4beMQgm0yTXwRcoRzoZCOAWuXYi8o96TqepqD1zW847R3kRw
Message-ID: <CA+V-a8sY0QneUWQ4A0XCKUGPL8VYkU5NQE2h_cOK=06JG_1c2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: can: renesas,rcar-canfd: Specify reset-names
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

On Fri, Jan 2, 2026 at 11:16=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Dec 30, 2025 at 11:58:11AM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Specify the expected reset-names for the Renesas CAN-FD controller on
> > RZ/G2L and RZ/G3E SoCs.
>
> You should explain here from where you got the actual names.
>
> Otherwise you got following review:
>
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> > - Moved reset-names to top-level properties.
> > ---
> >  .../bindings/net/can/renesas,rcar-canfd.yaml  | 33 +++++++++++--------
> >  1 file changed, 19 insertions(+), 14 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-can=
fd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > index e129bdceef84..9bfd4f44e4d4 100644
> > --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > @@ -122,6 +122,11 @@ properties:
> >
> >    resets: true
> >
> > +  reset-names:
> > +    items:
> > +      - const: rstp_n
> > +      - const: rstc_n
>
> rst seems redundant. _n as well. Are these names from datasheet? How are
> they called in this device (not the soc) datasheet exactly? Because it
> feels you use pin or SoC names which is not useful.
>
rstp_n/rstc_n are coming from the SoC HW manual and is already used by
the driver (since commit 76e9353a80e9 "can: rcar_canfd: Add support
for RZ/G2L family"). The reset-names existed previously but were
dropped as of commit 466c8ef7b66b "dt-bindings: can:
renesas,rcar-canfd: Simplify the conditional schema". Let me know if
you want me to rename them but the driver will have to maintain the
backward compatibility or do you want me to drop this patch.

Cheers,
Prabhakar

