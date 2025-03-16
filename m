Return-Path: <linux-can+bounces-3103-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A349A634E6
	for <lists+linux-can@lfdr.de>; Sun, 16 Mar 2025 10:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D833216EC63
	for <lists+linux-can@lfdr.de>; Sun, 16 Mar 2025 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B319D884;
	Sun, 16 Mar 2025 09:53:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28FC39ACC;
	Sun, 16 Mar 2025 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742118824; cv=none; b=dFUnHjBJYHCWAzE3ndCSzDSEYNfrtcGKpY9UMuzSdhym2Tt/k03P66fXuMlqoR+j/+ufUR4UXPNRhAsCFfG2dy8JquCR1l4Ky3NsVx/cQZOnY7nCLfg0uyx8OlcNojvDjwH6s/6hhjqw0oBw2dUqhG6a1hkBCph3VpmlaV09VyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742118824; c=relaxed/simple;
	bh=Kef1UUdzBllH8WnWjHd/Om3oTcS2OCU/mtMQvItVNYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3UaoyFhaLh053Xzbmc3ybPDhAeVGej1dOa1ZtQdkzRoL1LgYm3fbI7FOKVo8CYa1LDmszkc0aIzzjh9Wz78pc26GYAIvRIZcMFNFC2AGsiJjSEFh6hvPpiFZUHBM9c6TtIX/FJiqP0TOrdsv7VC3+FK/VnKTitR8vJSPDxzk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d5e42c924so3621590241.3;
        Sun, 16 Mar 2025 02:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742118819; x=1742723619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxE4dtYZ0okg/d0c3PnqSAxiemoMdLNFmXJm6g4nPh0=;
        b=fmuLCh4hA0+Z4oFeDi7wLX52JxYLwAX1hGC+NZX22qTmM+vYG30O7ccBwJTTWJnIpN
         flkse4j/VG4JM6AGLHX21rv57u05Yyr+DdpvpEXWUEylYEiB+Hu0I3pg56SYPJdpQRB9
         vZHXmJVrgLTLlrOhHmXT2jrFYyr9OlyD7WYDC0YK2PVwe9Mh5eD6iBcOBTbzqrBUs5Rf
         38cZ90yt2Bq1EIu6X2DvtWeboEw2lNTsYW2MKoigdfKxlsEbFIalhblgeNL5g/D+woSO
         b5rRgv/DTRoqmqxlYoyXCA5tZd5LRhSxkq/45gFgzdj2desR4V2VIEfLck6bAtpPrMV5
         2ufQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0g/ugUMxsQvLE0xY32Pd+IEznxfEnBZgo8b0YluwfjEN/nl/0hkwB/x3i8x9p+o0qFsVIwRofXZo=@vger.kernel.org, AJvYcCXys9r1rZ9l9vEFGRzyWI7yvJzUaFdco3HkyEtn5pS66l3q9hsqj56e5C0ZgkpK8i+pyyrdXPz45rfn3CMiBstaydQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjYnvmCPPPYwbZasMLaDX9soOw1YI6fn7+9lqNMtKpti50H6t
	M6HhPI0trkT0Nap9Tih6Y7lA4rSlS50VerRob4Wrf6e/k3ntpIu7YNLO6usu
X-Gm-Gg: ASbGncvad9yn68pwJkwSxLph0fKeF8FX0M7DOa9ur+mom/e+aFnH3F7nYxc+fx2zvQA
	NPop66Ha+1UT7XOoLFHtKBAjvfeozhqNUw6b/P4BCJDfawfYXd5F0sLKtRLGRLNVTlxBh289wp3
	D88/LgE9v+hsy2DkkIapzO+a75Xnlev8QxcYoyFfBGKcoRHn8orIdyLj5hMfr6q2bdLb3EAERMx
	aM8lAApU0OvZG/nbslKyJoVxfAJhgihQzkaTpVUeU5LK7sdwXy1OOJx4UNWcBy9pmTLeWG7uGmr
	2gmCvTa/v1DZtTT1xz9XYCY4etC7ZobS+d/YsZziNq4/AaLXIUeTXOic/zyRXoUYVZKoaO8m+Lh
	GEvWj9WG/s74=
X-Google-Smtp-Source: AGHT+IGfO0aZKygTdrt7eTaAs012c4GeuxdQstpXzsA1dtXOggCyyEoPoatSKfkxm1x19P/q+Dpa9A==
X-Received: by 2002:a05:6102:50a4:b0:4c1:8ebb:400e with SMTP id ada2fe7eead31-4c383139a10mr5798029137.8.1742118818995;
        Sun, 16 Mar 2025 02:53:38 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d90d911b0sm1308013241.8.2025.03.16.02.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 02:53:38 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso3695535e0c.1;
        Sun, 16 Mar 2025 02:53:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTm4l/YwCjmngMAz0U10a+yk0u0TYydQ760pvfnww40Gd388nYBJAOBSvYToDtUjlSaZLMKSC6J9jNtWYApPK0N2U=@vger.kernel.org, AJvYcCWosqCyca4E5PIJezPutpfnVRQBwasMrqR8UlDr+gQu2DvDRPrSsc3xEysIUbv9ZfWmmWDNa4VYVhg=@vger.kernel.org
X-Received: by 2002:a05:6122:2222:b0:520:4996:7cf2 with SMTP id
 71dfb90a1353d-52449a0ad67mr4921763e0c.10.1742118818026; Sun, 16 Mar 2025
 02:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
 <20250306124256.93033-9-biju.das.jz@bp.renesas.com> <CAMuHMdWk5vXSMSz15NBM+dxYRNyov2jFUAOKDrCANLVzJ5-AtA@mail.gmail.com>
 <TY3PR01MB113462D2249AB5B239E8213E286DD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113462D2249AB5B239E8213E286DD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 16 Mar 2025 10:53:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWB0N6a_0yfr-e+M1CTmvDy473x+RSvbi++b+oSHWgp3Q@mail.gmail.com>
X-Gm-Features: AQ5f1JqpvvyYjEJ2UlFr9fCPxd-y5kjpc-KbRwOuQ7rEpJC529PM1WivVv4OW1s
Message-ID: <CAMuHMdWB0N6a_0yfr-e+M1CTmvDy473x+RSvbi++b+oSHWgp3Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] can: rcar_canfd: Add shift table to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Sat, 15 Mar 2025 at 18:31, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Thu, 6 Mar 2025 at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > R-Car Gen3 and Gen4 has some differences in the shift bits. Add a
> > > shift table to handle these differences. After this drop the unused
> > > functions reg_gen4() and is_gen4().
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > A suggestion for improvement below.
> >
> > > --- a/drivers/net/can/rcar/rcar_canfd.c
> > > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > > @@ -90,11 +90,13 @@
> > >  /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */  #define
> > > RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
> > >         (((x) & (gpriv)->info->mask_table[RCANFD_RNC_MASK]) << \
> > > -        (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
> > > +        ((gpriv)->info->shift_table[RCANFD_FIRST_RNC_SH] - ((n) & 1) * \
> > > +         (gpriv)->info->shift_table[RCANFD_SECOND_RNC_SH]))
> >
> > Both shifts are dictated by the field width:
> >   - R-Car Gen4 packs 2 values in a 32-bit word, using a field width
> >     of 16 bits,
> >   - R-Car Gen3 packs up to 4 values in a 32-bit word, using a field
> >     width of 8 bits.
> > The odd split in two shifts is due to the MSB-first numbering of the fields.  Hence I think it would
> > be better to use a field width parameter, and derive the proper shift value from that (like you have
> > already done for ICU ;-)
> >
> > Note that the formula will have to be reworked anyway to support the third channel on R-Car V3H_2, as
> > "n & "1 will no longer fly here...
>
> Agreed. Will introduce rnc_field_width variable in struct rcar_canfd_hw_info and
> Simplify the calculation using the formula (32 - (n + 1) * rnc_field_width).
> Which will work for third channel on R-Car V3H_2 as well.

Note that you still need to mask n, as n can be up to 7 (on R-Car V4H),
while the register holds only 2 or 4 values.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

