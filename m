Return-Path: <linux-can+bounces-3494-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE0BA9D786
	for <lists+linux-can@lfdr.de>; Sat, 26 Apr 2025 06:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737A51BA6905
	for <lists+linux-can@lfdr.de>; Sat, 26 Apr 2025 04:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06011C6FEC;
	Sat, 26 Apr 2025 04:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XYlpFAkA"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FAF42AA5
	for <linux-can@vger.kernel.org>; Sat, 26 Apr 2025 04:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745641440; cv=none; b=bciAXJxNAa68NkTTy5ohVFdDe2hxqhxo+r1hUnvQV5glfpdXFte0VIK5VSHYY5TmBUBc069XEoYOdw1wMGHC5c5phSjVhCyHwwwh2g8ej6pTarDfL+mtmVPOTB63/ao2OpjZuEMz9oxsz5cRHg5g3YatNxKJGP1qqtnNlvB7db0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745641440; c=relaxed/simple;
	bh=t6XEDpuJYQFrAvJiJ92eGcgvRurioFHxhpp9sQylBqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbllrSa9FtcW79qpu2DJadag1j5njcRykRYzjUrXf5X9MauJ59uJ2dtXnEXoYTPW0qXG6uZf6VH+I4k88M8QQEFRnU/F49nVMo2lc5urjS175iKlA1pxlYbGNuVTSGPW/1+CyWUn6dkDAcQgYPTbKVSN3fdpvIDK0vyIsJpWvM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XYlpFAkA; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by smtp.orange.fr with ESMTPSA
	id 8X4runQRsX7PJ8X4vuVwIa; Sat, 26 Apr 2025 06:23:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745641429;
	bh=c0CB69Thedq6b4moBhhaYBmmxqch16Gq7VP3K00v158=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=XYlpFAkAVyrIX0ZGPt4Tchn19dfzEBN5dtBuQsOY7E65pTeXsvLGFdz4Y1Yqqdois
	 YYYv+57X3F95NzYXjD5ASjHj1w4/yTP76uoFtD0ZiP+IFM8wSbBtu09RPE5RLz4UyE
	 M6md8aanNxM3ff87h2jrSh5vrMnsCQpk2C1zPhppkVSBmFa4Rc43dh5NVxx8qIDMVn
	 zYkFK5GBgi6tQKX4UkRA4fjE12YPu7b4pN4j05PYlxGlSYoMwj+955oDQibATxzLWW
	 cVN8u+03z5D0yYxdNwVRwxs8wDAt5uPJ/gaTH1XM1nRnNYcEnCkkS0o27ZFZDm9s2i
	 lpjgMNEvhZuKA==
X-ME-Helo: mail-ej1-f50.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Apr 2025 06:23:49 +0200
X-ME-IP: 209.85.218.50
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac34257295dso491997366b.2
        for <linux-can@vger.kernel.org>; Fri, 25 Apr 2025 21:23:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YzZ0SjkikFE/cqj8r4JRkcGuJzFR3KdDnPX/eaghVboUJ4w0p+q
	f0P3ETrAMHwEkCH/s4WMdoz/JzHh8tZdcuyqhZb6B8GOnE28JtjpziIN3CUc0JdF5xPoB47nmpp
	MaeYiPwInuuywb17Zc71AET76pZk=
X-Google-Smtp-Source: AGHT+IE7Lk7X5ZbSSpY1vzYZKgXNr0mCffsK486q/gTPOj8zjoA189cIqbLn1WQAfKvWq+K4Km4baSpMAAsY+mITop8=
X-Received: by 2002:a17:907:3fa7:b0:ac8:196f:7441 with SMTP id
 a640c23a62f3a-ace7104d3e0mr405000366b.7.1745641425732; Fri, 25 Apr 2025
 21:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425191336.45581-1-kelsey@vpprocess.com>
In-Reply-To: <20250425191336.45581-1-kelsey@vpprocess.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Sat, 26 Apr 2025 13:23:34 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKZK4eZhcTh5Lh8N294Y67FARGvO=r5ZP=P7iZ5ofKXYQ@mail.gmail.com>
X-Gm-Features: ATxdqUFvrVFiDAYJ83DUbpYb8NUXMoD0Jt9dGVxjBIvd8_U17kn5rD2Fbn2o1hE
Message-ID: <CAMZ6RqKZK4eZhcTh5Lh8N294Y67FARGvO=r5ZP=P7iZ5ofKXYQ@mail.gmail.com>
Subject: Re: [PATCH] can: mcp251xfd: make TDC controllable from userspace
To: Kelsey Maes <kelsey@vpprocess.com>
Cc: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kelsey,

The patch looks overall good. I have a few nitpicks.

For the patch title, when you format the patch, use the -v option to
indicate the version:

  https://git-scm.com/docs/git-format-patch#Documentation/git-format-patch.txt--vltngt

Your next iteration will be the version 3, so it will be

  git format-patch -v3 ...

Also add in CC the maintainers. Use ./script/get_maintainer.pl to see
who the maintainers are.

On Sat. 26 avr. 2025 at 04:13, Kelsey Maes <kelsey@vpprocess.com> wrote:
> TDC is currently hardcoded enabled so lower CAN FD data bitrates result in a
> bus-off condition. This patch allows userspace to control TDC as needed.
>
> Demonstration of the feature in action:
> $ ip link set can0 down
> $ ip link set can0 type can sample-point 0.875 bitrate 125000 dsample-point 0.875 dbitrate 500000 fd on berr-reporting on restart-ms 100
> $ ip link set can0 up

We probably do not need this level of details. Can you remove all the
parameters which are not directly relevant to the TDC and let the
framework calculate the sample-point? Also remove the "set can0 down"
command and combine the "set can0 up" together with the configuration
command:

  $ ip link set can0 up type can bitrate 125000 dbitrate 500000 fd on
  $ ip -details link show can0

This way, there is less information to parse and it is more clear to
see what information is relevant.

> $ ip -details link show can0
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
>     link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
>     can <BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 100
>           bitrate 125000 sample-point 0.875
>           tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
>           mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
>           dbitrate 500000 dsample-point 0.875
>           dtq 125 dprop-seg 6 dphase-seg1 7 dphase-seg2 2 dsjw 1 dbrp 5
>           mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
>           tdco 0..63
>           clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0

Nitpick: when you copy the terminal output (or more generally when you
quote any text) a good practice is to prefix the quoted lines with two
spaces. Like this:

  $ echo "hello"
  hello

> $ ip link set can0 down
> $ ip link set can0 type can sample-point 0.875 bitrate 1000000 dsample-point 0.875 dbitrate 4000000 fd on berr-reporting on restart-ms 100
> $ ip link set can0 up
> $ ip -details link show can0
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
>     link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
>     can <BERR-REPORTING,FD,TDC-AUTO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 100
>           bitrate 1000000 sample-point 0.875
>           tq 25 prop-seg 17 phase-seg1 17 phase-seg2 5 sjw 2 brp 1
>           mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
>           dbitrate 4000000 dsample-point 0.800
>           dtq 25 dprop-seg 3 dphase-seg1 4 dphase-seg2 2 dsjw 1 dbrp 1
>           tdco 8
>           mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
>           tdco 0..63
>           clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0
>
> There has been some confusion about the MCP2518FD using a relative or absolute
> TDCO due to the datasheet specifying a range of [-64,63]. I have a custom board
> with a 40 MHz clock and an estimated loop delay of 100 to 216 ns. During testing
> at a data bit rate of 4 Mbit/s I found that using can_get_relative_tdco()
> resulted in bus-off errors. The final TDCO value was 1 which corresponds to a
> 10% SSP in an absolute configuration. This behavior is expected if the TDCO
> value is really absolute and not relative. Using priv->can.tdc.tdco instead
> results in a final TDCO of 8, setting the SSP at exactly 80%. This configuration
> works.

Your patch actually fixes an issue. Can you add this tag?

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip
MCP25xxFD SPI CAN")

@Marc, what do you think about the backport? The TDC framework was
introduced a bit later so it is not possible to apply this patch as-is
to the v5.10.x stable branch. However, it should apply smoothly to
v5.15.x and anything after.

So my suggestion would be to leave this unfixed in v5.10 (this isn't a
major issue either) and just backport it to v5.15 and greater.

> Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>
> ---
>  .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 25 +++++++++++++------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index 3bc56517f..025bfbaa7 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -75,6 +75,15 @@ static const struct can_bittiming_const mcp251xfd_data_bittiming_const = {
>         .brp_inc = 1,
>  };
>
> +static const struct can_tdc_const mcp251xfd_tdc_const = {
> +       .tdcv_min = 0,
> +       .tdcv_max = 63,
> +       .tdco_min = 0,
> +       .tdco_max = 63,
> +       .tdcf_min = 0,
> +       .tdcf_max = 0,
> +};
> +
>  static const char *__mcp251xfd_get_model_str(enum mcp251xfd_model model)
>  {
>         switch (model) {
> @@ -511,7 +520,6 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
>         const struct can_bittiming *bt = &priv->can.bittiming;
>         const struct can_bittiming *dbt = &priv->can.data_bittiming;
>         u32 val = 0;
> -       s8 tdco;
>         int err;
>
>         /* CAN Control Register
> @@ -575,11 +583,13 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
>                 return err;
>
>         /* Transmitter Delay Compensation */
> -       tdco = clamp_t(int, dbt->brp * (dbt->prop_seg + dbt->phase_seg1),
> -                      -64, 63);
> -       val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
> -                        MCP251XFD_REG_TDC_TDCMOD_AUTO) |
> -               FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
> +       if (can_tdc_is_enabled(&priv->can))
> +               val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
> +                                MCP251XFD_REG_TDC_TDCMOD_AUTO);
> +       else
> +               val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
> +                                MCP251XFD_REG_TDC_TDCMOD_DISABLED);
> +       val |= FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.tdc.tdco);

If can_tdc_is_enabled() returns false, tdco is zero. You can move that
last line inside the if:

          if (can_tdc_is_enabled(&priv->can))
                  val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
                                   MCP251XFD_REG_TDC_TDCMOD_AUTO) |
                        FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK,
                                   priv->can.tdc.tdco);

>         return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
>  }
> @@ -2083,10 +2093,11 @@ static int mcp251xfd_probe(struct spi_device *spi)
>         priv->can.do_get_berr_counter = mcp251xfd_get_berr_counter;
>         priv->can.bittiming_const = &mcp251xfd_bittiming_const;
>         priv->can.data_bittiming_const = &mcp251xfd_data_bittiming_const;
> +       priv->can.tdc_const = &mcp251xfd_tdc_const;
>         priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>                 CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
>                 CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
> -               CAN_CTRLMODE_CC_LEN8_DLC;
> +               CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO;
>         set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
>         priv->ndev = ndev;
>         priv->spi = spi;


Yours sincerely,
Vincent Mailhol

