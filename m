Return-Path: <linux-can+bounces-5696-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06681C894B3
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 432E535934E
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B65B301466;
	Wed, 26 Nov 2025 10:27:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF12ECD37
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152877; cv=none; b=nSlRIsePiwKW6ss3C+N6ySbMEiAfOGlMQQ/epO7SYicn2ZE2X/WFiQkmgNPIAbaYsIJW0P0cnJAKfPsUkx3StYhqlvVsRTMVnQeXW5uaiJ5SoDgHu2NkFIIYBJR+cDa0avSRacK6ULCpamiUH4Rtb8pyZUXFdKTmlK7KYjlwh+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152877; c=relaxed/simple;
	bh=W7aDspbM0iq0leOQOnbyQ2Haf6uuCF3WyWlcpU84lZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxMaRLynZ7leHIXcrxspKne2nDSPovUnNGzUryF+VWVCG95ZvxQwC0TMy0Ni2xI0At+GjUseDaVXuc+o0Keys6zFtvsDJA2rcNLTDwlfMyvxbTFBfcTzOG4viewOPubRHn5ipUPQoaAxE7c/kMl7Fbw8qd+9xK8hhB6VXGHh8qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCkT-0002bn-Or; Wed, 26 Nov 2025 11:27:45 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCkS-002aUw-2b;
	Wed, 26 Nov 2025 11:27:44 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 701114A897A;
	Wed, 26 Nov 2025 10:27:44 +0000 (UTC)
Date: Wed, 26 Nov 2025 11:27:44 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju <biju.das.au@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Tranh Ha <tranh.ha.xb@renesas.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] can: rcar_canfd: Fix CAN-FD mode as default
Message-ID: <20251126-nocturnal-busy-honeybee-ca8a15-mkl@pengutronix.de>
References: <20251118123926.193445-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stkmnwnrvhpbo4xn"
Content-Disposition: inline
In-Reply-To: <20251118123926.193445-1-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--stkmnwnrvhpbo4xn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: rcar_canfd: Fix CAN-FD mode as default
MIME-Version: 1.0

Hello Biju,

is this patch ready to go to linux-can?

regards,
Marc

On 18.11.2025 12:39:25, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The commit 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
> has aligned with the flow mentioned in the hardware manual for all SoCs
> except R-Car Gen3 and RZ/G2L SoCs. On R-Car Gen4 and RZ/G3E SoCs, due to
> the wrong logic in the commit[1] sets the default mode to FD-Only mode
> instead of CAN-FD mode.
>
> This patch sets the CAN-FD mode as the default for all SoCs by dropping
> the rcar_canfd_set_mode() as some SoC requires mode setting in global
> reset mode, and the rest of the SoCs in channel reset mode and update the
> rcar_canfd_reset_controller() to take care of these constraints. Moreover,
> the RZ/G3E and R-Car Gen4 SoCs support 3 modes compared to 2 modes on the
> R-Car Gen3. Use inverted logic in rcar_canfd_reset_controller() to
> simplify the code later to support FD-only mode.
>
> [1]
> commit 45721c406dcf ("can: rcar_canfd: Add support for r8a779a0 SoC")
>
> Fixes: 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 53 ++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 49ab65274b51..05dbdf46dd6f 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -709,6 +709,11 @@ static void rcar_canfd_set_bit_reg(void __iomem *add=
r, u32 val)
>  	rcar_canfd_update(val, val, addr);
>  }
>
> +static void rcar_canfd_clear_bit_reg(void __iomem *addr, u32 val)
> +{
> +	rcar_canfd_update(val, 0, addr);
> +}
> +
>  static void rcar_canfd_update_bit_reg(void __iomem *addr, u32 mask, u32 =
val)
>  {
>  	rcar_canfd_update(mask, val, addr);
> @@ -755,25 +760,6 @@ static void rcar_canfd_set_rnc(struct rcar_canfd_glo=
bal *gpriv, unsigned int ch,
>  	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(w), rnc);
>  }
>
> -static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
> -{
> -	if (gpriv->info->ch_interface_mode) {
> -		u32 ch, val =3D gpriv->fdmode ? RCANFD_GEN4_FDCFG_FDOE
> -					    : RCANFD_GEN4_FDCFG_CLOE;
> -
> -		for_each_set_bit(ch, &gpriv->channels_mask,
> -				 gpriv->info->max_channels)
> -			rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg, val);
> -	} else {
> -		if (gpriv->fdmode)
> -			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
> -					   RCANFD_GRMCFG_RCMC);
> -		else
> -			rcar_canfd_clear_bit(gpriv->base, RCANFD_GRMCFG,
> -					     RCANFD_GRMCFG_RCMC);
> -	}
> -}
> -
>  static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
>  {
>  	struct device *dev =3D &gpriv->pdev->dev;
> @@ -806,6 +792,16 @@ static int rcar_canfd_reset_controller(struct rcar_c=
anfd_global *gpriv)
>  	/* Reset Global error flags */
>  	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
>
> +	/* Set the controller into appropriate mode */
> +	if (!gpriv->info->ch_interface_mode) {
> +		if (gpriv->fdmode)
> +			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
> +					   RCANFD_GRMCFG_RCMC);
> +		else
> +			rcar_canfd_clear_bit(gpriv->base, RCANFD_GRMCFG,
> +					     RCANFD_GRMCFG_RCMC);
> +	}
> +
>  	/* Transition all Channels to reset mode */
>  	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
>  		rcar_canfd_clear_bit(gpriv->base,
> @@ -823,10 +819,23 @@ static int rcar_canfd_reset_controller(struct rcar_=
canfd_global *gpriv)
>  			dev_dbg(dev, "channel %u reset failed\n", ch);
>  			return err;
>  		}
> -	}
>
> -	/* Set the controller into appropriate mode */
> -	rcar_canfd_set_mode(gpriv);
> +		/* Set the controller into appropriate mode */
> +		if (gpriv->info->ch_interface_mode) {
> +			/* Do not set CLOE and FDOE simultaneously */
> +			if (!gpriv->fdmode) {
> +				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
> +							 RCANFD_GEN4_FDCFG_FDOE);
> +				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
> +						       RCANFD_GEN4_FDCFG_CLOE);
> +			} else {
> +				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
> +							 RCANFD_GEN4_FDCFG_FDOE);
> +				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
> +							 RCANFD_GEN4_FDCFG_CLOE);
> +			}
> +		}
> +	}
>
>  	return 0;
>  }
> --
> 2.43.0
>
>
>

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--stkmnwnrvhpbo4xn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkm1h0ACgkQDHRl3/mQ
kZyJuAgAq2FOlHUV52XfpxRR2+m0m+UE2yvwz98x7L+pnHL6pcvEEEkLZflA7a5A
3uH91fr012Lecu0tf4kjSYla74RaC8D4i9MquPyxlzf5zPByLPPRlotJsDFd7eBX
bAgZCGzIUnUjl8QEGr8ruiB2D3kYYgftEVUpjFnhR+M/2w61wgs60XG26UAi6Bgn
Y0pldqXZt9GwnyTmem2un3JvNJ+nSjnPsZ23T5r3ajEe9dFifpul/lnxSfy7cuoz
LJPAtjlcFCmIy/Xr+MM0HSaf7v1qrwwzDIyzOSsRNLyHA2+Ew9zE0NPbjoev1OHp
iwuQn69f0i8DR3CmuRcIIlhbuGXzow==
=C4/R
-----END PGP SIGNATURE-----

--stkmnwnrvhpbo4xn--

