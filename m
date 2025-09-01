Return-Path: <linux-can+bounces-4411-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39662B3E553
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D38440A28
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938E335BAF;
	Mon,  1 Sep 2025 13:38:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566633437E;
	Mon,  1 Sep 2025 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733888; cv=none; b=kH8aG1DtehBrAujJPTP/W5DvuGycH8KKqIOjRMhONH5fncJevyuWzAD8F1HSOhEbmUeEDO3fo1thXxOLxIY4mwgshE+ZzWI+JxFpvP6eTFWDZlCaAIhlzZGt8X2OQa15w7JJN/IqLI6AKyQpSDC+Qkwe+z/eR18j7VRlD+dGyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733888; c=relaxed/simple;
	bh=dGnaVd/vCtxVDGI37N7sstZKzflVMS/aBlC/pClGFUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=az+fluy6J2v+ZLL8uqTa07uPSk99SlIuaTwlTUfq1DJhLnd5165Ii30gK+Nstziq00mKxjDEzt4+FCQTsosUBNTygIv9NHAgIxHwLsWlZWXAmkft377uWmkdCOOZhgOxlXUaENPu0zEEs2GdvxvzpV0E2gT+Fn6JxcKg6e6F1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-523264ecab8so1469328137.2;
        Mon, 01 Sep 2025 06:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733883; x=1757338683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVSKG61eHXtgpE4qwB4RiosQwwYKbxYizn9dn5EmgCQ=;
        b=A3ndalGpgKD95rFRs4Hqvpaz+p5TjUvT2edsGEVhAz7uf7M/MVZ+9QAlElAD9mBJmG
         xo5ihDC5Rz810A/TOKQt49CuqlZor8/u9WEySrYIV4Aa2JMEAz/9AfOMYo6+6jXRg6fY
         OcUFz5IOpe+djToCJq8EsJtZkvGkIFq1oiH1mdgeOByCrg7DpJ5Q7+8HVJHdPkCWeWna
         txOHPaD1K4oaUEdJm5UIRJn+mzXV+krqeBscP28sY96fiLicLBM7Ne8SmwvUCo6HJl12
         cqYnX3CYyFchthztJX/WJPivaV6N5JYxlCma6i1NBVAKLsDXCg+C6QWBIhcw4LqEMpIE
         10nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEuoe+SXQub7pIaiYb0dq97NoUMVV+JEY2MeDtQ/WrADIWp+DintR00v/+sxvTD/H4yJMG+aOHTrM=@vger.kernel.org, AJvYcCWo7ua9SGkDb8LGNZGf88zz/0rLCmnHngV3I8F0EMb8a81PWpEEpl9Mvm9z1C8pMfG0neeU92BnnqEbpeszXDHmnBY=@vger.kernel.org, AJvYcCXjazIiJCvA7ZVOBvqCAJOfHeciWL6eUgvF12nXnvWtPG9fwSif0OaCxU+vVRXezBIsasNGXa/RkfHhPd7c@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RYjiN3DbhZp7yacoNf79NLIH271Msu6hxwS8kBnIFQVoUBL/
	YAXFyn4Eg6XCyIiQbeWi2kIbXCzpsm4WrcJQXagh57pn404Or/IYqzzHIdGorvZ4
X-Gm-Gg: ASbGnctPgkwbIvV9zCw8r2jPTQUtwRs+51EMhjGEZ+ZUf2Om1bbdTGpU4h06cpTw2in
	OsfGzrZn+QOLVF6YqFKfYXEApKnpvpvg4oS9rq0ReFcxeFrUbGugihg9YTKK9mwh5i02Jrcwc8Z
	dfekj0TMXyYXhs5BQCI22FGdNXuqPEdl+IabGt5Bqv13CqU68UPR8H8Gx28YZCqfRFwK55X6tsR
	Lvc/XFT4Pf+GXstgsMiOmTI3peqJC3dF0hhq7u41ZxkmC7DpyLE1r8isP61foABdajJCA2LpTn9
	KXwm/YROtlTu9oQ5TlqSpZ/1INRhKK3i9cZ1qsazqiIqy/MOrv5eExXUQS/EiHbj2NFxHha7Qu4
	23Ee/PIQrLMHZ+w0sfIvCWcIwqFBJEiJzCd/eFEDPCSSnC7DNBcQOQQKPeYOP
X-Google-Smtp-Source: AGHT+IF7WBAAwNPGAo06eyYNEEfdl3c+Wh0YSG++CRmJbZjoCKN9VYQLhSxrZXEjVJziHu1qld2JrA==
X-Received: by 2002:a05:6102:1607:b0:524:bee7:aeb7 with SMTP id ada2fe7eead31-52b19335fc0mr1922468137.3.1756733883340;
        Mon, 01 Sep 2025 06:38:03 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8943b7c369asm3701630241.2.2025.09.01.06.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:38:02 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-529858dc690so953345137.0;
        Mon, 01 Sep 2025 06:38:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5eE0Ir88WFmtKcjFUUBxeWi3OVT567yLpyiqV4GSSa0LeqmMSlJy6Q7qt6oAc74mCF0vl2tORlIKEOxZNgBgEOLM=@vger.kernel.org, AJvYcCXCMsLvaC1QE0jbBfkhBqHltjAmz1x2dU1s0G40CjkGeJOXqFI7zsBYTPpK8iIRFrTg2pg4m7UUSk4=@vger.kernel.org, AJvYcCXCS67l7Y/OJRTMCn8fr49vgjgdtdt2VOm50eSoUvBnQXMzmCO8baLS/hVMtNTcOTkOA+4YYL80saKkUBOE@vger.kernel.org
X-Received: by 2002:a05:6102:1607:b0:524:bee7:aeb7 with SMTP id
 ada2fe7eead31-52b19335fc0mr1922454137.3.1756733882584; Mon, 01 Sep 2025
 06:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821141429.298324-1-biju.das.jz@bp.renesas.com> <20250821141429.298324-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250821141429.298324-4-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 15:37:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWdy2YVxmXT2vPj+3OEJpqj+miTVjhCVuEYpXC8iHXPXA@mail.gmail.com>
X-Gm-Features: Ac12FXwsw4oI7WF-9YCLIprWBQXgpKOJ90V9uxM-wiHV0s0WiriytN6thpDqjEs
Message-ID: <CAMuHMdWdy2YVxmXT2vPj+3OEJpqj+miTVjhCVuEYpXC8iHXPXA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] can: rcar_canfd: Simplify nominal bit rate config
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 21 Aug 2025 at 16:14, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Introduce rcar_canfd_compute_nominal_bit_rate_cfg() for simplifying
> nominal bit rate configuration by replacing function-like macros.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Split from patch#3 for computing nominal bit rate config separate.
>  * Updated rcar_canfd_compute_nominal_bit_rate_cfg() to handle
>    nominal bit rate configuration for both classical CAN and CANFD.
>  * Replaced RCANFD_NCFG_NBRP->RCANFD_NCFG_NBRP_MASK and used FIELD_PREP to
>    extract value.

Thanks for your patch!

Your patch is correct, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Still a few suggestions for improvement below...

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -109,16 +109,7 @@
>  #define RCANFD_CFG_BRP_MASK            GENMASK(9, 0)
>
>  /* RSCFDnCFDCmNCFG - CAN FD only */
> -#define RCANFD_NCFG_NTSEG2(gpriv, x) \
> -       (((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->ntseg2)
> -
> -#define RCANFD_NCFG_NTSEG1(gpriv, x) \
> -       (((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->ntseg1)
> -
> -#define RCANFD_NCFG_NSJW(gpriv, x) \
> -       (((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << (gpriv)->info->sh->nsjw)
> -
> -#define RCANFD_NCFG_NBRP(x)            (((x) & 0x3ff) << 0)
> +#define RCANFD_NCFG_NBRP_MASK          GENMASK(9, 0)

I would drop the "_MASK" suffix.

> @@ -1393,6 +1384,28 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> +static inline u32 rcar_canfd_compute_nominal_bit_rate_cfg(struct rcar_canfd_channel *priv,
> +                                                         u16 tseg1, u16 brp, u16 sjw, u16 tseg2)

Perhaps follow the order as used in struct can_bittiming{_const}?
I.e. tseg1, tseg2, sjw, brp.

> +{
> +       struct rcar_canfd_global *gpriv = priv->gpriv;
> +       const struct rcar_canfd_hw_info *info = gpriv->info;
> +       u32 ntseg2, ntseg1, nsjw, nbrp;
> +
> +       if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
> +               ntseg2 = (tseg2 & (info->nom_bittiming->tseg2_max - 1)) << info->sh->ntseg2;
> +               ntseg1 = (tseg1 & (info->nom_bittiming->tseg1_max - 1)) << info->sh->ntseg1;
> +               nsjw = (sjw & (info->nom_bittiming->sjw_max - 1)) << info->sh->nsjw;
> +               nbrp = FIELD_PREP(RCANFD_NCFG_NBRP_MASK, brp);

Perhaps use the order of the function parameters?

> +       } else {
> +               ntseg2 = FIELD_PREP(RCANFD_CFG_TSEG2_MASK, tseg2);
> +               ntseg1 = FIELD_PREP(RCANFD_CFG_TSEG1_MASK, tseg1);
> +               nsjw = FIELD_PREP(RCANFD_CFG_SJW_MASK, sjw);
> +               nbrp = FIELD_PREP(RCANFD_CFG_BRP_MASK, brp);

Likewise.

> +       }
> +
> +       return (ntseg1 | nbrp | nsjw | ntseg2);

Likewise.

> +}
> +
>  static void rcar_canfd_set_bittiming(struct net_device *ndev)
>  {
>         u32 mask = RCANFD_FDCFG_TDCO | RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

