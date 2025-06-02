Return-Path: <linux-can+bounces-3760-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75FDACB1A0
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 16:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287711701E4
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9A5222596;
	Mon,  2 Jun 2025 14:09:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BAF1CBA18;
	Mon,  2 Jun 2025 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873349; cv=none; b=Ix378Yk5h2Iz+5/++o7x/a5I+I3nzevlfW7SNEVQyt+WwNLtz5lssgKYhe8hxZfEV6MWvVQAakMkFYyVrfV2zPK7N0q8ojqVotx5Qc50BAxpmTM4Yu6yQz4cW92e6ittRT0mpdxyHtYsPe4czF/ei9bdbjURlR8liBVb6SwXDZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873349; c=relaxed/simple;
	bh=eWPn/GXK1V1urjmQznCKFca54VEZET0QGQk/1oeZzu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUwfl3FWBxV455lkL16ocgOBEb6wlAw492ZE+hpsZ3KCy9U8vBt1pryOEkHd3emkgdISEtdFPxQrQVfCxa/YoGx16eN7vXuwNv+1vgAw5Ecq1CBUqklNJq/6O9dXF3NhRSbEpJH71Jp93fxUo1DBy7fsi0etNt+HP9bRPeZFbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d20f799fe9so20705185a.2;
        Mon, 02 Jun 2025 07:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748873346; x=1749478146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZckFchCt8fem7MiUN5yn/CzNdLoI8oFfi5SYwrHm5Js=;
        b=WGm0fgHYTIMRjYhvqTWRAY4yTIcR7gtnaWpPUUXQTXnqau5X3ZGJ02yNoYaRpb79cA
         mwdjbu7qmMr1cyhZSDQ6spBR1tY8NSHy4DiH7BIFa8Y+zuU5MMl8dJbskg5oZVgn32oA
         x2BLPG+lTSa8YqnmyXeQ3XMBhCtGkdrZ4u/X2gjDMDA9q7LbbptMb4CgZjeyXa1OzRsq
         gddx1NpzFKResUN2AbJr5J6/RAcmi8skIdsC9tUXQC/m4uulek7KKMN/T99NzZQojhrd
         g2osdlXWa7QNpnzkuOgncTeVJYwYUBPaI89JarBRBet3t5hEZleFqvXKYdMWUlwPbXq5
         p+ew==
X-Forwarded-Encrypted: i=1; AJvYcCVB7NhXz1+DgIysTQeKaK8LQdQNkycK1iln+1QAI9F4kkrc8G/IRf69cuHVEygGRf+Gw884XxK2rJrJdei3O4VEPPc=@vger.kernel.org, AJvYcCVRROyOm1jN1RRALF78CIXYwCWYVRvJmnPA30nPuWF9ahoKPsF+jLuEUb/1yuNW86cesT9bZSYbULQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJoj2ge1iCkezuXBehvzZZFlGI/zI78ADmtfZDoO7FvoBNt3C7
	R/i0wH/FZfdaB+ce+sJbbcO3RY48RKMRWZIpXWwsTNBwsnJsuZNhU2cN5W+2BbHo
X-Gm-Gg: ASbGnctZYDGxV9uD0odSt9kZTOYsfIlXYyRCM1GxfpdZzo+pztZRZ9bTKpj1hFUPlKY
	5nTbSVYDJDrDjk1dkAfEV7DdX/Y4ZwNknp77AwFquneZCHfc6NJmfAsWdiAA88fQUQtQ59z08vX
	s3sQJ/tsj9nm9tF2XfgRy9ZIqsjlMQipps0vMikmsBnNnQR7otdOfc5wfKmW3s5hQ4ulSc1Gu9j
	rTMwkC4saNt/118uoOQPp+1RJeVguUyQHKkBsq9Ge7WMRsdg0JbZM/bjJhLUTfITNBvNdHG/8Or
	7WXB6GuQhnLYgfGrwDTZbnivw8tBRTW2Cv2jHGDOzzaJeee/M/DPfNo+V5XshQSiuuEJpyhu2Qe
	ipeN1s4zZbRzFF2yUaA==
X-Google-Smtp-Source: AGHT+IEu9cQIcTNuDt5xLbgt1w3cC0oMU3crOQIbsvRbMpzoBmKueJxqsLZsJqg3A4IJbmg5OwF1xA==
X-Received: by 2002:a05:620a:4091:b0:7c5:3b3b:c9da with SMTP id af79cd13be357-7d0a201dde3mr2200756185a.40.1748873346341;
        Mon, 02 Jun 2025 07:09:06 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0f8df7sm629245785a.36.2025.06.02.07.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 07:09:03 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a58f79d6e9so11028271cf.2;
        Mon, 02 Jun 2025 07:09:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/sIHLbouUhaYlTVblJwbXXZO6P1q+jDPs+pwL988D/byA/0RQsogtFkH9eDcH08wToLDYTQ4SRU0taElgzTBqXXM=@vger.kernel.org, AJvYcCXoZM1ugaaLRv2cORSHHGInDF10sxq1wvZKgoDX+ozfV96xFJ2YfFCpmeQhZM6EJCIjZJFV+LCURgw=@vger.kernel.org
X-Received: by 2002:a05:622a:2296:b0:494:abde:2aa3 with SMTP id
 d75a77b69052e-4a440031326mr225706541cf.18.1748873340918; Mon, 02 Jun 2025
 07:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748863848.git.geert+renesas@glider.be> <c830bd8b65d5f96c8831a2967c5b4c0eeb30e0af.1748863848.git.geert+renesas@glider.be>
 <7df51717-ffd1-43c1-8c5a-ab181439f580@wanadoo.fr>
In-Reply-To: <7df51717-ffd1-43c1-8c5a-ab181439f580@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Jun 2025 16:08:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU0PNpsfNfDUAW09d5DTuuwJ_FnEFYk6a3KAC7sPRmkeg@mail.gmail.com>
X-Gm-Features: AX0GCFsk9kmPqe5Ydhvnh63ga3M6t05LtlvSNVcCeJCk4js2ChGmcCMfiQJDL04
Message-ID: <CAMuHMdU0PNpsfNfDUAW09d5DTuuwJ_FnEFYk6a3KAC7sPRmkeg@mail.gmail.com>
Subject: Re: [PATCH 9/9] can: rcar_canfd: Add support for Transceiver Delay Compensation
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Mon, 2 Jun 2025 at 15:41, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> On 02/06/2025 at 20:54, Geert Uytterhoeven wrote:
> > The Renesas CAN-FD hardware block supports configuring Transceiver Delay
> > Compensation, and reading back the Transceiver Delay Compensation
> > Result, which is needed to support high transfer rates like 8 Mbps.
> > The Secondary Sample Point is either the measured delay plus the
> > configured offset, or just the configured offset.
> >
> > Fix the existing RCANFD_FDCFG_TDCO() macro for the intended use case
> > (writing instead of reading the field).  Add register definition bits
> > for the Channel n CAN-FD Status Register.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > @@ -191,9 +191,19 @@
> >  /* RSCFDnCFDCmFDCFG */
> >  #define RCANFD_GEN4_FDCFG_CLOE               BIT(30)
> >  #define RCANFD_GEN4_FDCFG_FDOE               BIT(28)
> > +#define RCANFD_FDCFG_TDCO            GENMASK(23, 16)
> >  #define RCANFD_FDCFG_TDCE            BIT(9)
> >  #define RCANFD_FDCFG_TDCOC           BIT(8)
> > -#define RCANFD_FDCFG_TDCO(x)         (((x) & 0x7f) >> 16)
> > +
> > +/* RSCFDnCFDCmFDSTS */
> > +#define RCANFD_FDSTS_SOC             GENMASK(31, 24)
> > +#define RCANFD_FDSTS_EOC             GENMASK(23, 16)
> > +#define RCANFD_GEN4_FDSTS_PNSTS              GENMASK(13, 12)
> > +#define RCANFD_FDSTS_SOCO            BIT(9)
> > +#define RCANFD_FDSTS_EOCO            BIT(8)
> > +#define RCANFD_FDSTS_TDCR(gpriv, x)  ((x) & ((gpriv)->info->tdc_const->tdcv_max - 1))
> > +#define RCANFD_FDSTS_TDCVF(gpriv) \
> > +     ((gpriv)->info->tdc_const->tdcv_max > 128 ? BIT(15) : BIT(7))
>
> See my previous comment: no more function like macro please.

OK, "int rcar_canfd_get_fdsts_tdcr(gpriv, sts)".

RCANFD_FDSTS_TDCVF() is unused, so I'll drop it.

> > @@ -634,6 +645,25 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
> >       .brp_inc = 1,
> >  };
> >
> > +/* CAN FD Transmission Delay Compensation constants */
> > +static const struct can_tdc_const rcar_canfd_gen3_tdc_const = {
> > +     .tdcv_min = 1,
>
> Interesting. This is the first time I see a driver with the tdcv_min and the
> tdco_min different than 0. At one point in time, I wanted those to be implicit
> values. Guess it was finally a good idea to include those minimums to the framework.

Really? As most other timing values need subtracting 1 when programming
the hardware, I would expect it to be rather common.

> > @@ -1477,6 +1514,22 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
> >       rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
> >       netdev_dbg(ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
> >                  brp, sjw, tseg1, tseg2);
> > +
> > +     /* Transceiver Delay Compensation */
> > +     if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO) {
> > +             /* TDC enabled, measured + offset */
> > +             tdcmode = RCANFD_FDCFG_TDCE;
> > +             tdco = tdc->tdco - 1;
> > +             netdev_dbg(ndev, "tdc: auto %u\n", tdco);
>
> Same as previously. Are those debugs really useful? You can get the value
> through the netlink interface (OK, you still have to do the minus one by hand,
> but don't tell me that's the reason).

No, I just mimicked the existing debug prints, which we already agreed
upon to remove.

> > +     } else if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
> > +             /* TDC enabled, offset only */
> > +             tdcmode = RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
> > +             tdco = min(tdc->tdcv + tdc->tdco, tdc_const->tdco_max) - 1;
>
> That's an edge case I did not think of and that is thus not handled by the
> framework. This min() is a bit hacky, but I do not see a better workaround.
> Also, I guess that this edge case will rarely occur.

can_calc_tdco() also does a silent min(..., tdc_const->tdco_max).

>
> > +             netdev_dbg(ndev, "tdc: manual %u\n", tdco);
> > +     }
> > +
> > +     rcar_canfd_update_bit(gpriv->base, RCANFD_F_CFDCFG(gpriv, ch), mask,
> > +                           tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
> >  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

