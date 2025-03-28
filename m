Return-Path: <linux-can+bounces-3271-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A478A7493B
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 12:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A729517D429
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 11:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5A51DFE04;
	Fri, 28 Mar 2025 11:32:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759D145B27;
	Fri, 28 Mar 2025 11:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743161539; cv=none; b=d74oNy1mCBzkWmfP2lQ7Jd1+aYulluYB/eV6xLx+4h9XQfJkMnO2fTJisCqJfAOjlM/5Ilet4W5v/KDVnuBBQmz3iK+1Ef1Yf8sx+q8AZJe2C2K/cxpCDrunVt85VsHLoSMEiiXTAA7cEbRe+mt4bhV/6rssRthvTgubWpURBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743161539; c=relaxed/simple;
	bh=Mlw4SetQvxHQK/jnVDJCyQBL6wct+TcoCJMiF4QffJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jn9HI0SyzEkh3+uLeLS7hlovkz6qbU6O1cOfrJ2CZ7S2VHGE1Z/0NMDJR8buFxn1czFx4J5/0K0r2OQ8Z+JMrmPAxUafPZv33qK6CQgZs3yi67eA331c5pxlbTX/XjDmNl26JRk+iq39L71lhWfv0n0PjpOhBWOtkHrJBgkBxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-523dc190f95so1038508e0c.1;
        Fri, 28 Mar 2025 04:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743161534; x=1743766334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijHoUEZyT+2IlX8UHxDCNKAX+1FUz2oJEoSvsAr2vfI=;
        b=qp/VCRh+TrWRFZRc2mjVnpfwA8Rb7erSdYe2zLeyYNLRP3OoK2XkpvgfLhWwdTsIuB
         Tnqw56kySo7m9DnlP1LW29Onr20h9bJ1+3AbXKaVcbPly9gpq0ZL087ptBp1TAYu2JnH
         F1avrx0vJMlMUJ6qg7kilWklszLEwFfA7lKfa85gQypD6gLKV/fqHT4sopCQinP1vpX5
         1ySIQR2VHH5lfhl/D6dudYiWX0PBP4tSxHWi+D11UvaGwnQzVcuHe9liPVAaUzPZ1cNV
         zcQj1ar90w+SLROL7NsHUFYS7IxLFI0gWs3VF2raJ9yBvajm6SOpfHR9I7JBSQhiR7a3
         Pl/A==
X-Forwarded-Encrypted: i=1; AJvYcCUZQz0YfZ2fSt7kNb+Jk5ph3rYMZJnD0sa9PifxWtnhfKVlMUGrqhy7B3nJGcUXSa2XEv0BRIIcLuU=@vger.kernel.org, AJvYcCWeD0/RXtHCCgsclNs76ZmTjm7/0wqDU/ZL/xhUqnh+342Nb/VBMD6eEcE0i/qHjNqyaj4HYstILkZMi3rjkktEMqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEMllxL0jDZqpshBeatWe9PmEqIyLK6fIINx+8TexOXvsvVlY2
	0Aids7TVcrbQUed9kIwkDDg8GF7mVI6C1SapdsOeqQWFTSLHexrCjBjhdt0/
X-Gm-Gg: ASbGncsq4NO5V3g1UwccMkFRWFp58O8/lDY+RrQZ2FtAn1NRc4deYuzcWRPgd8L23Yb
	y5DcH/oDFPRkgsOdCuZ8giiQoUXo5Fs0c2AAM8YrHok57iXaJa2OcLTMmFh6GuCo1drMVj5m1QL
	qN4HVe2oBbPnWROqZk7/A2rmki/xJH0S2hhl03Z5EvVEyNlxZ43q233q7N0PLvgvqOmbEuptEiZ
	eQkbO/96pB1+OwaOzWGo8X7ZD21XfT2SOZy+u6oo5qo9dQifENrX9vxykn4kTYm9UkjaENc+Qde
	I82SGGMUNuTimx1jZHqHiSynXQvdwn6pNhn7zEl5kwC6gGS40uNRu7Lph52sdZZ0OopCVu9MAD+
	mStrylZM=
X-Google-Smtp-Source: AGHT+IG8s6zIUqXao1gW2aTt3brCHOaWNIoi4uhLWz1tsMzoPmLHj6cEdyyELWm/hZ25GgbKFGUuCQ==
X-Received: by 2002:a05:6122:3289:b0:523:e175:4af1 with SMTP id 71dfb90a1353d-52600a32552mr6029668e0c.6.1743161534384;
        Fri, 28 Mar 2025 04:32:14 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-871a33890a3sm330076241.22.2025.03.28.04.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 04:32:14 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86dde90e7a3so972345241.1;
        Fri, 28 Mar 2025 04:32:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdj2OdggMlbqnL6NljrJpxFnFUII95OcsCDZCu49pe7rN1k+iJOC9KpeLzQL2qc00QMRR3JWofp/lsDSo0VPxg8UM=@vger.kernel.org, AJvYcCXbz4QSTAhwRhCY7LJVbyQn5P08MSmAw7hVEX7n6Is1okUOtEEdXT7eYKbpx9LgIOkjLfUK7/aWGDc=@vger.kernel.org
X-Received: by 2002:a05:6102:f12:b0:4c4:e409:5f9e with SMTP id
 ada2fe7eead31-4c586f0fdd1mr7328723137.2.1743161533687; Fri, 28 Mar 2025
 04:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-9-biju.das.jz@bp.renesas.com> <ee0f8bff-6dc4-4ddc-a2d2-89ed6fddcc8f@wanadoo.fr>
 <TY3PR01MB113467D894782F210DA15345E86A02@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <1c797eda-658e-4902-8257-5b24fce0274f@wanadoo.fr>
In-Reply-To: <1c797eda-658e-4902-8257-5b24fce0274f@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Mar 2025 12:32:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVRebZ7E+am=xHDLVm1G_9Fgtxr46XbJemtBF=D0vfyNQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jrz8IBMWkBVYyOzKWSQiQNIuZwjjhzoe3c7vdS0MCmkkpkTW9HtY_Tfpbc
Message-ID: <CAMuHMdVRebZ7E+am=xHDLVm1G_9Fgtxr46XbJemtBF=D0vfyNQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/18] can: rcar_canfd: Simplify RCANFD_GAFLCFG_SETRNC macro
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On Fri, 28 Mar 2025 at 12:21, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> On 28/03/2025 at 19:54, Biju Das wrote:
> >> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >> On 26/03/2025 at 21:19, Biju Das wrote:
> >>> The shift values in RCANFD_GAFLCFG_SETRNC are dictated by the field w=
idth:
> >>>   - R-Car Gen4 packs 2 values in a 32-bit word, using a field width
> >>>     of 16 bits,
> >>>   - R-Car Gen3 packs up to 4 values in a 32-bit word, using a field
> >>>     width of 8 bits.
> >>>
> >>> Add rnc_field_width variable to struct rcar_canfd_hw_info to handle
> >>> this difference and simplify the shift value in RCANFD_GAFLCFG_SETRNC
> >>> macro by using a formula (32 - (n % rnc_stride + 1) * rnc_field_width=
).
> >>>
> >>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> >>> --- a/drivers/net/can/rcar/rcar_canfd.c
> >>> +++ b/drivers/net/can/rcar/rcar_canfd.c
> >>> @@ -89,7 +89,7 @@
> >>>  /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */  #define
> >>> RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
> >>>     (((x) & ((gpriv)->info->num_supported_rules - 1)) << \
> >>> -    (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
> >>> +    (32 - (((n) % (gpriv)->info->rnc_stride + 1) *
> >>> +(gpriv)->info->rnc_field_width)))
> >>
> >> I can not follow how this is the same. Let's take the gen4 as an examp=
le. Before:
> >>
> >>   (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8))) =3D
> >>   16 - ((n & 1) * 16)
> >>
> >> So, I have:
> >>
> >>       n      shift value
> >>      ---------------------------------
> >>       0      16 - ((0 & 1) * 16) =3D 0
> >>       1      16 - ((1 & 1) * 16) =3D 16
> >>       2      16 - ((2 & 1) * 16) =3D 0
> >>       3      16 - ((3 & 1) * 16) =3D 16
> >>       4      16 - ((4 & 1) * 16) =3D 0
> >>
> >> After:
> >>
> >>   (32 - ((n % rnc_stride + 1)) * rnc_field_width) =3D
> >
> > 32 - (n % rnc_stride) + 1 =3D
> >>   32 - ((n % (2 + 1)) * 16) =3D
> >
> >
> >>   32 - ((n % 3) * 16)
> >  32 - ((n % 2) + 1)) * 16) =3D
> >
> >>
> >>       n      shift value
> >>      ---------------------------------
> >>       0      32 - ((0 % 3) * 16) =3D 32
> >>       1      32 - ((1 % 3) * 16) =3D 16
> >>       2      32 - ((2 % 3) * 16) =3D 0
> >>       3      32 - ((3 % 3) * 16) =3D 32
> >>       4      32 - ((4 % 3) * 16) =3D 16
> >>
> >> Is there something wrong in my calculation? What am I missing?
> >
> > 0     32 - ((0 % 2) + 1) * 16) =3D 16
> > 1     32 - ((1 % 2) + 1) * 16) =3D 0
>
> OK. Thanks. I didn't parse the parenthesis correctly. It's been a long
> week, sorry for the noise.
>
> >> More generally, it is really hard to review and understand what this m=
acro does.
> >
> > Macro is doing a simple calculation.
> >
> > (32 - (n % rnc_stride + 1) * rnc_field_width)
>
> This is before adding the tons of parenthesis. I did my review of best
> effort and got it wrong not because the calculation is complication but
> because of the noise introduced by those parenthesis (plus admittedly
> some fatigue from the long week=E2=80=A6)
>
> >> Can add one more patch:
> >>
> >>   can: rcar_canfd: turn RCANFD_GAFLCFG_SETRNC into a function
> >>
> >> and then apply your change?
> >>
> >> I do not see the reason why this needs to be a macro. If you make this=
 a function, at least, it will
> >> be easier to follow what is going on and the compiler optimizer will i=
nline it anyway so you should
> >> not get any penalty.
> >
> > I am leaving Marc, Geert to provide their feedback on this.
>
> The maintainers of the CAN drivers and Marc and myself. Of course, I do
> appreciate Geert feedback here. But for doing this maintenance as a
> volunteer, in exchange, I want you to make my review work (and the long
> term maintenance) easier.
>
> function-like macro are not welcome unless strictly needed and I am not
> keen on dropping this ask.

I agree the heavy use of macros can be improved.

E.g. handling the access to the RNC field is spread across
two macros:
  - RCANFD_GAFLCFG_SETRNC() handles ch % something,
  - RCANFD_GAFLCFG() handles ch / something.

A single function to write to the RNC field would make this more readable.
This is just an example, there are many more of these...

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

