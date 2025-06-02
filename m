Return-Path: <linux-can+bounces-3758-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4004CACAFA0
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 15:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873261BA29AA
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B00221F1E;
	Mon,  2 Jun 2025 13:50:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94714221735;
	Mon,  2 Jun 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872205; cv=none; b=MPyedlwlCDoz3Fy7KvJKBoHx5daaqGE2UhKsjsOGii5Sy+p6TPOHmBoG+KzaCqzenKA24Bn5rb6nZWK3/GOGqvsyuqL+PKNTf3iiWG9axqfVahitnPmZGlXuutkQ1lFefnDicdt3THQbA6Bc6tD7gSSXS+V4NnxuSAMs6JMGmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872205; c=relaxed/simple;
	bh=2hVOScTOPxgGU3obpF+xyUzi1olck3dURBYJmqncss0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWnH84TQ9WXQ6BvMsh1nvCGNRwXnsjMRSu24MfsIHHJxqZAjmPSF6zKeDhP/aZE08pI0Pz7L6y/1lCI3qIyaFfMaw1oa5LYlJIbbLzZuTKKnvKZ5XDchyqNiSSnD2XFgtB3ZM9zLqqaYq8QQx8L/7fS5mr9FcuaZ23d0iRb6VSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e2b5ffb932so1581760137.0;
        Mon, 02 Jun 2025 06:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748872201; x=1749477001;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZ/JEYlQnYQFetWNFfMCevOjGsPnTIRqYp0+Ouq9MHw=;
        b=vIdsSCShm78fcdOpLm5gYC0EW+er4oL3puW0sUBwF1a2Jv3cTrRe6Ho1ta/xPIETHd
         RG7F+rla35Smoe1ghOknI9tO6+nxtpVhkX2WGJb8GMHfzlT3vTwpYvrP53WrYycClNdM
         61jM5M8vv9Ld13mO1TdsKhYxfjqaE+55KFNTNIZ97gkPMny9TvsC0Nygm3RWm7tfBtx+
         iPCGUrlWyLC1kpp+xTt3G302mLIecfaJrxcM5Fc4HMw+Fbudfkdh29hwUO8LaKutUrfI
         VY4CVSOk99hjsg/agYD1Ao2qs2xs2ySdCTd5s9O+iIK9qGXw8/j9wUwPfEsYteWevyuD
         6m4w==
X-Forwarded-Encrypted: i=1; AJvYcCUFN0bMdBVmm74DvcqOSWkt0wV1itqHQ4mYheJdY54rh7T5/hR15v4z449fwWt8AcEJVKoQ9YEqSOE=@vger.kernel.org, AJvYcCVCgcBK8SxhRr5ifB8dqEAdLTsSnlDVWVU9QgTbi8tzbL5a4OJNnN4FgEj737pzsY1DkMVEV0ykQx9Yi7+YnBL9lxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkOtQyKKiRThEfP8tauOy5030NTEyv3tMTNFOoXW47B6/kVMXV
	PWSEJiqwv6H1q0VsYkR+Lwvxpjnuj3WhjhRBwk/N2kG1P3x4PuzQr5JlnJkokQC0
X-Gm-Gg: ASbGncsXr0fXorbpI29Ba0wbZ1mYzkZ/31tqD96A/3A+Gv3v5zaqyShpeouLw+QQOOB
	ItJFf0pHPXq9gOjPOWuBJFxgE4SKnH8sodGjpKu70XlJkX3y9Eeo8olwg19Bvzi562v0VS3ZYLH
	qwiZ9LxPQeNyWtUefl2urDuXcU4v9DtZg5dKDVP6wlPHKyYyiapydIPZp3EBURM8TsHu0YBpK38
	oafeuokqGz/EUFnpPlCmRqplV+FFNE0Ks5rWJWo7WlkGa/2xuDUW2DyN1nrSRr3xzBV4EGSOB/W
	xNt6QdTN/NQszS7H28oDqwMM6emcvfdE9Ts9VJ6EFdj2rJmceTQDtGmq2URcTMo0QJW7gzhI/UH
	P6opqSrpYs6vwKg==
X-Google-Smtp-Source: AGHT+IHJuESa8wwy6jjRRrY3Qlsx/N7sIFxDsqQ+Xsy88+cmINR6+Yfn06Wi9cEdEKDE8gt5SkIh9w==
X-Received: by 2002:a05:6102:6ca:b0:4e4:5ed0:19bb with SMTP id ada2fe7eead31-4e6e41dc00fmr11538433137.22.1748872200650;
        Mon, 02 Jun 2025 06:50:00 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e6444294a6sm7218550137.3.2025.06.02.06.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 06:49:59 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e58e0175ceso1146642137.2;
        Mon, 02 Jun 2025 06:49:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVUmlEHbIgzY/zWve726/0fTC5UF43CxTQ7UFK6TzmCi6xYFVwchs9Vd6Nqj7XFkuWXtWuxDnYMRs8=@vger.kernel.org, AJvYcCWhN4R2H4LRSjqqLBXxgrTKb3ozEblxSTJ/iXCzjFb40iCXsvlNrNvXcgQXDxPfkr3nAR8WS4bBbS5cCao3PQUM518=@vger.kernel.org
X-Received: by 2002:a05:6102:6ca:b0:4e4:5ed0:19bb with SMTP id
 ada2fe7eead31-4e6e41dc00fmr11538329137.22.1748872199380; Mon, 02 Jun 2025
 06:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748863848.git.geert+renesas@glider.be> <f9c114fcf8cc8eaae150a3ce95dd3224cf247f6b.1748863848.git.geert+renesas@glider.be>
 <94755286-47fb-461e-9850-e14830f2536e@wanadoo.fr>
In-Reply-To: <94755286-47fb-461e-9850-e14830f2536e@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Jun 2025 15:49:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXaqDNE6dcSdDO+TersETtu8wrAhH_0DA1v3ngpPkneZA@mail.gmail.com>
X-Gm-Features: AX0GCFtzEWq0DfXDnzKdlHJGAFBQhGa2AY4lps2DWwki31pKDr6T2k2Wc2R1H9Y
Message-ID: <CAMuHMdXaqDNE6dcSdDO+TersETtu8wrAhH_0DA1v3ngpPkneZA@mail.gmail.com>
Subject: Re: [PATCH 6/9] can: rcar_canfd: Repurpose f_dcfg base for other registers
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Mon, 2 Jun 2025 at 15:16, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> On 02/06/2025 at 20:54, Geert Uytterhoeven wrote:
> > Reuse the existing Channel Data Bitrate Configuration Register offset
> > member in the register configuration as the base offset for all related
> > channel-specific registers.
> > Rename the member and update the (incorrect) comment to reflect this.
> >
> > This fixes the addresses of all other (currently unused)
> > channel-specific registers on R-Car Gen4 and RZ/G3E, and allows us to
> > replace RCANFD_GEN4_FDCFG() by the more generic RCANFD_F_CFDCFG().
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/net/can/rcar/rcar_canfd.c | 22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> > index 0cad3c198e58e494..7a9a88fa5fb1a521 100644
> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > @@ -425,18 +425,16 @@
> >  #define RCANFD_C_RPGACC(r)           (0x1900 + (0x04 * (r)))
> >
> >  /* R-Car Gen4 Classical and CAN FD mode specific register map */
> > -#define RCANFD_GEN4_FDCFG(m)         (0x1404 + (0x20 * (m)))
> > -
> >  #define RCANFD_GEN4_GAFL_OFFSET              (0x1800)
> >
> >  /* CAN FD mode specific register map */
> >
> >  /* RSCFDnCFDCmXXX -> RCANFD_F_XXX(m) */
> > -#define RCANFD_F_DCFG(gpriv, m)              ((gpriv)->info->regs->f_dcfg + (0x20 * (m)))
> > -#define RCANFD_F_CFDCFG(m)           (0x0504 + (0x20 * (m)))
> > -#define RCANFD_F_CFDCTR(m)           (0x0508 + (0x20 * (m)))
> > -#define RCANFD_F_CFDSTS(m)           (0x050c + (0x20 * (m)))
> > -#define RCANFD_F_CFDCRC(m)           (0x0510 + (0x20 * (m)))
> > +#define RCANFD_F_DCFG(gpriv, m)              ((gpriv)->info->regs->coffset + 0x00 + (0x20 * (m)))
> > +#define RCANFD_F_CFDCFG(gpriv, m)    ((gpriv)->info->regs->coffset + 0x04 + (0x20 * (m)))
> > +#define RCANFD_F_CFDCTR(gpriv, m)    ((gpriv)->info->regs->coffset + 0x08 + (0x20 * (m)))
> > +#define RCANFD_F_CFDSTS(gpriv, m)    ((gpriv)->info->regs->coffset + 0x0c + (0x20 * (m)))
> > +#define RCANFD_F_CFDCRC(gpriv, m)    ((gpriv)->info->regs->coffset + 0x10 + (0x20 * (m)))
>
> I really start to dislike all those function like macros in the rcar_canfd
> driver. The only benefits of a function like macro is either to have type
> polymorphism or to generate integer constant expression or to work with context
> specific info (e.g. __func__ or __LINE__).

I agree much can be improved in the way this driver accesses registers.
Unfortunately a large part of it is due to the horrendous naming of the
registers in the documentation, and the two different register layouts.

> Can you just change these five function like macros to static functions?

I assume you want something like was done commit 6b9f8b53a1f3ad8e
("can: rcar_canfd: Add rcar_canfd_setrnc()")?

These five macro just calculate the offsets for specific registers
and for the specified channel indices.  Their return values are to
be passed to one of the five accessors that take register offsets
(rcar_canfd_{read,write,set_bit,cleat_bit, update}()).  Hence
converting the macros to accessor functions means there will be more
than five functions...

> And from now on, each time there is a need to modify one of the rcar_canfd, I
> would like this to become an opportunity to little by little clean up that macro
> madness.

That's exactly what Biju and I are doing, slowly ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

