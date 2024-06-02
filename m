Return-Path: <linux-can+bounces-695-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B38C48D7439
	for <lists+linux-can@lfdr.de>; Sun,  2 Jun 2024 10:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DD31F2156C
	for <lists+linux-can@lfdr.de>; Sun,  2 Jun 2024 08:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E00171D8;
	Sun,  2 Jun 2024 08:03:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A86AD59;
	Sun,  2 Jun 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717315397; cv=none; b=YkWnFFU7lbRv4sFws2P/azxqh+uFO8RehjISr6JUcIvPgqYH2FHSDxJMucDiNu2hOhqX8SrUZkgDxRqNWQFsz+AxK0v9DGk41tvwv9Iy4S53dbP6Q1Fb4Ksec9OqMPPPHu/fY4sMNPkHLoFpkBStoeUpMGUYIv21i90S0XJXwXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717315397; c=relaxed/simple;
	bh=yKPK/NtDfn6mI3z0T1fVgXyIK3NlZ3bRAmi1lDAYxMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZoMxen4m8C/bSrJbbmcvP6xdLK6WyQ1DoxwGwrly9UguxyjzxffapzjOJUaZWschR431pGsPSSg1YJTPQ4l1UiGd47Ov5lao2b2/PeTtOyw2FU8tE+khsnwRruJZbWX2P55LSgMbcHGsx75A+mP6fM0K1HLkhY99p74voTrknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-702555eb23bso781763b3a.1;
        Sun, 02 Jun 2024 01:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717315395; x=1717920195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKGTqymitwuSSvE//rhOmRtXD7moCcqza47DyUX/qKE=;
        b=DGEsSqtvL3kXWRBG1TZaMkRM/1Wh9WJK2mMr/R0743rvhn6S8qXYdGD/Cfnz5vhQNV
         oZj5jm/uqgit64RD7pz5UsKL3GDy0z+tBEwPEG8n7yxxU1ij/iL4eVhNCvMIKYGULV9s
         VjKNG6jwO6AYJsCcq2PCECdiSXRleMEnbUnRuC2zqoGiJMtrhhSkJm3pTZEWZ1KsW2uJ
         KiBi0CpRqkaF/Wwc7hO8ncqMHCqH0D6Lre892Lv1uIrQ61IabjXFYVckq4FbSRBp+SY9
         VH+REhkqDEIuQMErvhUWS8ZMP0/N+tO86sNPpvwWrlgpLFUTNwbge8f0cbM7qquMnXaj
         wY5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBwFGuPX9mFB+5C+Vubnl3OKhOLGpXdqhMDWA9UQoVB9m/FmnxyX7kTePENGhPKFjcllP5MVPMQM3Q7uo+a8l1cKmD9V8adRywv8hKgcwtolZuozdTtzXkftsLqC47fRdDB4UeMsqhFe78utJXuc5NGL2UhJcev0dSgv72EC9V4KmgnP4=
X-Gm-Message-State: AOJu0YwtBcrIIVHrUPFsTaIR4Gxg/45KUdsyuwmzFSHychdfoi6XmlKl
	yqeL6XPkPpEgCIFYt5MUQpOpmfS8Z1MEgpdMQm6KT0MnWVJSwoITk5om7rGVMrVzclj5mCAIN0K
	frtmBopx48/9DXYrxEvLJc29bDd/0i0i7
X-Google-Smtp-Source: AGHT+IG9Z+v5sGePu/ouFexS/nYiKkKVnIjYOHr62JDsq7X5tw/5cjo8g/k8r/yrJTmJAz8F1XwzxLO/JVJWbbs3GTM=
X-Received: by 2002:a05:6a20:914d:b0:1a9:a32d:17cc with SMTP id
 adf61e73a8af0-1b26f141cf0mr6508132637.18.1717315394490; Sun, 02 Jun 2024
 01:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716973640.git.geert+renesas@glider.be> <2cf38c10b83c8e5c04d68b17a930b6d9dbf66f40.1716973640.git.geert+renesas@glider.be>
In-Reply-To: <2cf38c10b83c8e5c04d68b17a930b6d9dbf66f40.1716973640.git.geert+renesas@glider.be>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Sun, 2 Jun 2024 17:03:02 +0900
Message-ID: <CAMZ6RqKZdo1Mk=tY-vqCm0YYr_Qk8m53+LHXqeM+1LL=S=+RqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] can: rcar_canfd: Simplify clock handling
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed. 29 May 2024 at 18:12, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The main CAN clock is either the internal CANFD clock, or the external
> CAN clock.  Hence replace the two-valued enum by a simple boolean flag.
> Consolidate all CANFD clock handling inside a single branch.

For what it is worth, your patch also saves up to 8 bytes in struct
rcar_canfd_global (depends on the architecture).

Before:

  $ pahole drivers/net/can/rcar/rcar_canfd.o -C rcar_canfd_global
  struct rcar_canfd_global {
      struct rcar_canfd_channel * ch[8];               /*     0    64 */
      /* --- cacheline 1 boundary (64 bytes) --- */
      void *                     base;                 /*    64     8 */
      struct platform_device *   pdev;                 /*    72     8 */
      struct clk *               clkp;                 /*    80     8 */
      struct clk *               can_clk;              /*    88     8 */
      enum rcar_canfd_fcanclk    fcan;                 /*    96     4 */

      /* XXX 4 bytes hole, try to pack */

      long unsigned int          channels_mask;        /*   104     8 */
      bool                       fdmode;               /*   112     1 */

      /* XXX 7 bytes hole, try to pack */

      struct reset_control *     rstc1;                /*   120     8 */
      /* --- cacheline 2 boundary (128 bytes) --- */
      struct reset_control *     rstc2;                /*   128     8 */
      const struct rcar_canfd_hw_info  * info;         /*   136     8 */

      /* size: 144, cachelines: 3, members: 11 */
      /* sum members: 133, holes: 2, sum holes: 11 */
      /* last cacheline: 16 bytes */
  };

After:

  $ pahole drivers/net/can/rcar/rcar_canfd.o -C rcar_canfd_global
  struct rcar_canfd_global {
      struct rcar_canfd_channel * ch[8];               /*     0    64 */
      /* --- cacheline 1 boundary (64 bytes) --- */
      void *                     base;                 /*    64     8 */
      struct platform_device *   pdev;                 /*    72     8 */
      struct clk *               clkp;                 /*    80     8 */
      struct clk *               can_clk;              /*    88     8 */
      long unsigned int          channels_mask;        /*    96     8 */
      bool                       extclk;               /*   104     1 */
      bool                       fdmode;               /*   105     1 */

      /* XXX 6 bytes hole, try to pack */

      struct reset_control *     rstc1;                /*   112     8 */
      struct reset_control *     rstc2;                /*   120     8 */
      /* --- cacheline 2 boundary (128 bytes) --- */
      const struct rcar_canfd_hw_info  * info;         /*   128     8 */

      /* size: 136, cachelines: 3, members: 11 */
      /* sum members: 130, holes: 1, sum holes: 6 */
      /* last cacheline: 8 bytes */
  };

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index b828427187353d6f..474840b58e8f13f1 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -508,12 +508,6 @@
>   */
>  #define RCANFD_CFFIFO_IDX              0
>
> -/* fCAN clock select register settings */
> -enum rcar_canfd_fcanclk {
> -       RCANFD_CANFDCLK = 0,            /* CANFD clock */
> -       RCANFD_EXTCLK,                  /* Externally input clock */
> -};
> -
>  struct rcar_canfd_global;
>
>  struct rcar_canfd_hw_info {
> @@ -545,8 +539,8 @@ struct rcar_canfd_global {
>         struct platform_device *pdev;   /* Respective platform device */
>         struct clk *clkp;               /* Peripheral clock */
>         struct clk *can_clk;            /* fCAN clock */
> -       enum rcar_canfd_fcanclk fcan;   /* CANFD or Ext clock */
>         unsigned long channels_mask;    /* Enabled channels mask */
> +       bool extclk;                    /* CANFD or Ext clock */
>         bool fdmode;                    /* CAN FD or Classical CAN only mode */

Notwithstanding comment: you may consider to replace those two booleans by a:

          unsigned int flags;

This way, no more fields would be needed in the future if more quirks are added.

>         struct reset_control *rstc1;
>         struct reset_control *rstc2;
> @@ -777,7 +771,7 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
>                 cfg |= RCANFD_GCFG_CMPOC;
>
>         /* Set External Clock if selected */
> -       if (gpriv->fcan != RCANFD_CANFDCLK)
> +       if (gpriv->extclk)
>                 cfg |= RCANFD_GCFG_DCS;
>
>         rcar_canfd_set_bit(gpriv->base, RCANFD_GCFG, cfg);
> @@ -1941,16 +1935,12 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>                         return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
>                                              "cannot get canfd clock\n");
>
> -               gpriv->fcan = RCANFD_CANFDCLK;
> -
> +               /* CANFD clock may be further divided within the IP */
> +               fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
>         } else {
> -               gpriv->fcan = RCANFD_EXTCLK;
> +               fcan_freq = clk_get_rate(gpriv->can_clk);
> +               gpriv->extclk = true;
>         }
> -       fcan_freq = clk_get_rate(gpriv->can_clk);
> -
> -       if (gpriv->fcan == RCANFD_CANFDCLK)
> -               /* CANFD clock is further divided by (1/2) within the IP */
> -               fcan_freq /= info->postdiv;
>
>         addr = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(addr)) {
> @@ -2060,7 +2050,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, gpriv);
>         dev_info(dev, "global operational state (clk %d, fdmode %d)\n",
> -                gpriv->fcan, gpriv->fdmode);
> +                gpriv->extclk, gpriv->fdmode);
>         return 0;
>
>  fail_channel:
> --
> 2.34.1
>
>

