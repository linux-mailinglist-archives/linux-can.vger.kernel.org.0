Return-Path: <linux-can+bounces-7092-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LpGA3wLuGkWYQEAu9opvQ
	(envelope-from <linux-can+bounces-7092-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 14:54:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB4B29AD59
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 14:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00CB83038ADC
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 13:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3DB2874FF;
	Mon, 16 Mar 2026 13:51:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B63F165F1A
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669109; cv=none; b=TpMivVGmC52MnVAS/rjEbTWesBz3FiIpsJjjT+7CKMsmECQzowYPgAALhDw+V+h6VozeOi8j0N5bDOI2Qp3ZidYyDU4+IlyJf9V6jATFjPE3XOEOICk2MqMonQhMcS4W+zDwQLqD+migFK0KAzVz+9fxUFWC9Jd5zuAml2KLbKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669109; c=relaxed/simple;
	bh=kOno8zHRh6SiR8GqzoKBFXeKaues8dzpcdGrYf/NTU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av4q/L9oeFWrQpQGD1+JGuvp88ZueLApAV6P9ypZ8Rhu5/fpWNc4r/Vi/jM/MwvWBLzdyAgkOF5fp+ymqJp8UQG9VPEwozi3QDUv+UHNObjddAlSKNhFfqIegvwx5qwVpFNYwFbHay5YYFSP0UZKBwP345QN+YCCctdZJNan04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w28Lx-0000LJ-VB; Mon, 16 Mar 2026 14:51:29 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w28Lx-000a1e-2O;
	Mon, 16 Mar 2026 14:51:29 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6E217504FCA;
	Mon, 16 Mar 2026 13:51:29 +0000 (UTC)
Date: Mon, 16 Mar 2026 14:51:29 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: mani@kernel.org, thomas.kopp@microchip.com, mailhol@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com, 
	anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v2 2/3] can: mcp251xfd: add support for XSTBYEN
 transceiver standby control
Message-ID: <20260316-fossa-of-extreme-cookies-9c5c40-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260316131950.859748-1-viken.dadhaniya@oss.qualcomm.com>
 <20260316131950.859748-3-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jeks4nuhao5wgxc3"
Content-Disposition: inline
In-Reply-To: <20260316131950.859748-3-viken.dadhaniya@oss.qualcomm.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7092-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: AAB4B29AD59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--jeks4nuhao5wgxc3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] can: mcp251xfd: add support for XSTBYEN
 transceiver standby control
MIME-Version: 1.0

On 16.03.2026 18:49:49, Viken Dadhaniya wrote:
> The MCP251xFD has a dedicated transceiver standby control function on
> the INT0/GPIO0/XSTBY pin, controlled by the XSTBYEN bit in IOCON.

Please add a check to mcp251xfd_gpio_request() that GPIO0 cannot be used
with xstbyen.

> When enabled, the hardware automatically manages the transceiver
> standby state: the pin is driven low when the controller is active
> and high when it enters Sleep mode.
>
> Enable this feature when the 'microchip,xstbyen' device tree property
> is present.
>
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 30 +++++++++++++++++++
>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  1 +
>  2 files changed, 31 insertions(+)
>
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-core.c
> index 9c86df08c2c5..7a152acf4931 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -764,6 +764,29 @@ static void mcp251xfd_chip_stop(struct mcp251xfd_pri=
v *priv,
>  	mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_CONFIG);
>  }
>
> +static int mcp251xfd_chip_xstbyen_enable(const struct mcp251xfd_priv *pr=
iv)
> +{
> +	/* Configure the INT0/GPIO0/XSTBY pin as transceiver standby control:
> +	 *
> +	 * - XSTBYEN=3D1: route the pin to the transceiver standby function
> +	 * - TRIS0=3D0:   set output direction; the reset default is 1 (input),
> +	 *              which leaves the pin floating HIGH and keeps the
> +	 *              transceiver in standby regardless of XSTBYEN
> +	 * - LAT0=3D0:    drive pin LOW =3D> transceiver active (not in standby)
> +	 *
> +	 * All three bits are included in the mask; only XSTBYEN is set in
> +	 * val, so TRIS0 and LAT0 are cleared to 0 atomically.
> +	 *
> +	 * Once configured, the hardware automatically drives the pin HIGH
> +	 * on Sleep mode entry and LOW on Sleep mode exit.
> +	 */

What does the pin do in Config mode?

> +	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
> +				  MCP251XFD_REG_IOCON_XSTBYEN |
> +				  MCP251XFD_REG_IOCON_TRIS0 |
> +				  MCP251XFD_REG_IOCON_LAT0,
> +				  MCP251XFD_REG_IOCON_XSTBYEN);
> +}
> +
>  static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
>  {
>  	int err;
> @@ -800,6 +823,12 @@ static int mcp251xfd_chip_start(struct mcp251xfd_pri=
v *priv)
>  	if (err)
>  		goto out_chip_stop;
>
> +	if (priv->xstbyen) {
> +		err =3D mcp251xfd_chip_xstbyen_enable(priv);
> +		if (err)
> +			goto out_chip_stop;
> +	}
> +

You should configure the pin before bringing the controller into normale mo=
de.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jeks4nuhao5wgxc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabgK3gAKCRDMOmT6rpmt
0jdsAQDHH2DRCgUOHnf0SV94wEC3/aDUYUvR4qQ04gQzQWDWowD/VKT7WZYF4mk6
usG0qTfKBBCeYb90hnKnCcb4KPwZbAk=
=P4Ss
-----END PGP SIGNATURE-----

--jeks4nuhao5wgxc3--

