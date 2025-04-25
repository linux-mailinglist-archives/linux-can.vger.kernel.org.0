Return-Path: <linux-can+bounces-3481-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985E5A9BCCE
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 04:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52B84A65F5
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 02:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913D2154BF0;
	Fri, 25 Apr 2025 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VVOL0YaI"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7953179A3
	for <linux-can@vger.kernel.org>; Fri, 25 Apr 2025 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745548010; cv=none; b=B4QV0dfQZx+Cwo+b3+7sXnAyuT4sIyquJeZ2fedp6TAheREvKLwdLe2TRNXo0iVDNGYDDAGtnvO6I7GxuxGgIYzIrBizt3d+5h7LLeRu6LGkmgxR5qj87tYSYzkhN9/0Av0c6Du6Op7MVfpPiyHGWGTFioV2k9VXEs9lQqXQwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745548010; c=relaxed/simple;
	bh=EqbNGgEFwGQjhYXUjLRcTCB4WctSh6S5IIIQGZfgwuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLz9CLcVlM8vduaGERx6MYYzdd+oTZRrp0ENvGMRf5rV2kI41nfSt/5IndeBPZt0u3cl78ue2nD3HOwph68+3q3AJuxFszItKslVXyc+GiPOnwyD4UshpxDYBGR5hlpROgqmfdHkUE4RR6NakMLJQfVZGCPZyiXdRy7T9up4SOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VVOL0YaI; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f49.google.com ([209.85.208.49])
	by smtp.orange.fr with ESMTPSA
	id 88lvuhaQWGpxt88lzuOj6p; Fri, 25 Apr 2025 04:26:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745547999;
	bh=UAcAIPVAqTZ0x/MTpYVY+oTidn7ytThWUwrKC1ec3KQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=VVOL0YaI8Wj+OxIzxXlPHf3+R612apzcnLzo53GL60GxxbubjBbeAym6x8Z+L3R2h
	 7rd2zcE/lmrdHH0cVX1ICc9KpDEGB/74g361aqs3Cww2k3xLyKzgdsiGnqpqeWLx3m
	 alSzYfdp3rwFNTy1T35MpA0jrlxS2bM1RxL3ZwMR+69XkXH2SnKkBKCJ1RP+yTWbHB
	 a5BCWc0mbPc16mkzDLd/9Gyj30EnnMhYPfRait92FUV1Re/IhFA2QA5tcSXPW5jn2I
	 m+U1OGFJtkllKV4cTs2bE23OhPSNSxAHJabI8daqL28goMjSFB6xZTt5nlssNRoN5p
	 eST6/d9UvEeNQ==
X-ME-Helo: mail-ed1-f49.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Apr 2025 04:26:39 +0200
X-ME-IP: 209.85.208.49
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so3200947a12.0
        for <linux-can@vger.kernel.org>; Thu, 24 Apr 2025 19:26:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YyxvqxJtJXmjqb9UeWEgMV8wCu/KLSUSlMex+5BBCvWExYzrpnX
	qLTlDHj6NlhNGSQWVD3ZC605sT9FO75UkJ827tGnfqobqzUg+eDpkb5vgaECS6QgPi1h1nSTVpe
	dRkPKVlKEwUT+NJnP11MY0Yj2QGA=
X-Google-Smtp-Source: AGHT+IFS6Pd7+o6CdyYZoj4+sFoCzgGqFB1W0tx6oOpTteJt5+ccs6s2Ig8rEgtJRoCpV0bDTi0xRjZnImgXtE41BMY=
X-Received: by 2002:a17:906:6a0a:b0:ac7:9712:d11a with SMTP id
 a640c23a62f3a-ace710f03e9mr56307966b.32.1745547995730; Thu, 24 Apr 2025
 19:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <07F32FCD-D6AF-47E1-A76D-C136F6E5E2A5@vpprocess.com>
In-Reply-To: <07F32FCD-D6AF-47E1-A76D-C136F6E5E2A5@vpprocess.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 25 Apr 2025 11:26:24 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqK9ehF74x+xWAqyTFv4k5kVxxAdsqVeYM0yVXaJtKLxtg@mail.gmail.com>
X-Gm-Features: ATxdqUFk5gwl75ILRQB9TJSzBBkYiYwrLo72nTAa6y0uBQc2hKoE5tbsAmc5l_M
Message-ID: <CAMZ6RqK9ehF74x+xWAqyTFv4k5kVxxAdsqVeYM0yVXaJtKLxtg@mail.gmail.com>
Subject: Re: [PATCH] can: mcp251xfd: make TDC controllable from userspace
To: Kelsey Maes <kelsey@vpprocess.com>
Cc: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kelsey,

On Fri. 25 Apr. 2025 at 02:30, Kelsey Maes <kelsey@vpprocess.com> wrote:
> TDC is currently hardcoded enabled so lower CAN FD data bitrates result in a bus-off condition. This patch
> allows userspace to control TDC as needed. Tested on a Raspberry Pi 4 with a MCP2518FD at 40 MHz and
> arbitration/data bitrates of 125/500, 250/1000, 500/2000, 1000/4000.
>
> Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>

Thanks for the patch.

> ---
> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index 3bc56517f..1180c489b 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -577,9 +577,13 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
>         /* Transmitter Delay Compensation */
>         tdco = clamp_t(int, dbt->brp * (dbt->prop_seg + dbt->phase_seg1),
>                        -64, 63);
> -       val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
> -                        MCP251XFD_REG_TDC_TDCMOD_AUTO) |
> -               FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
> +       if (can_tdc_is_enabled(&priv->can))

Did you test that this function ever returns true? The framework can
normally detect whether TDC should be turned on or off, but for this,
it needs to do some basic calculations using the TDC const values
which you did not provide.

For this, you will need to populate:

  priv->can.tdc_const

To test, use:

  ip --details link show can0

On a low dbitrate, the TDC should be off, but on higher bitrates (e.g.
5 Mbps) you should confirm that the TDCO value is calculated.

> +               val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
> +                                MCP251XFD_REG_TDC_TDCMOD_AUTO);
> +       else
> +               val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
> +                                MCP251XFD_REG_TDC_TDCMOD_DISABLED);
> +       val |= FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
                                                         ^^^^
Once you do the above changes, the tdco will be calculated by the
framework. If I remember well, the mcp251xfd uses a relative TDCO, so
you should use can_get_relative_tdco().

  https://elixir.bootlin.com/linux/v6.14/source/include/linux/can/dev.h#L115

>
>         return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
> }
> @@ -2086,7 +2090,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
>         priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>                 CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
>                 CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
> -               CAN_CTRLMODE_CC_LEN8_DLC;
> +               CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO;
>         set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
>         priv->ndev = ndev;
>         priv->spi = spi;

Your patch is corrupted:

  Applying: can: mcp251xfd: make TDC controllable from userspace
  Patch failed at 0001 can: mcp251xfd: make TDC controllable from userspace
  error: corrupt patch at line 10

It seems it has to do with encoding. Here is what I get

  $ wget https://lore.kernel.org/linux-can/07F32FCD-D6AF-47E1-A76D-C136F6E5E2A5@vpprocess.com/raw
  $ ./scripts/checkpatch.pl raw
  ERROR: patch seems to be corrupt (line wrapped?)
  #64: FILE: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:576:
  mcp251xfd_priv *priv)

  ERROR: spaces required around that '=' (ctx:WxV)
  #73: FILE: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:578:
  +        val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
               ^

  ERROR: spaces required around that '=' (ctx:WxV)
  #76: FILE: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:581:
  +        val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
               ^

  ERROR: spaces required around that '|=' (ctx:WxV)
  #78: FILE: drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:583:
  +    val |=3D FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
           ^


Yours sincerely,
Vincent Mailhol

