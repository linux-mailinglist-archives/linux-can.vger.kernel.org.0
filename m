Return-Path: <linux-can+bounces-7133-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGnVCcuBumldXQIAu9opvQ
	(envelope-from <linux-can+bounces-7133-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 11:43:23 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9394D2BA1D4
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 11:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4927E3016274
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5362838F241;
	Wed, 18 Mar 2026 10:43:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5D13A7F40
	for <linux-can@vger.kernel.org>; Wed, 18 Mar 2026 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830587; cv=none; b=fyZ4rHXoQUoe3tCyrAWIJU/jtPyKOTGTxmZEl1NyjXXj5vXFzmXstsXN7LnolIPGoo2+t1YWrbatRzxx7WR/TVOT03Uz2wEJngTCY3yKv4h3fUWKeeESxp33soCPNjYM94+NmEkGM3/UjkCupn9IlfWsq5r+IesS2j06ShradeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830587; c=relaxed/simple;
	bh=sMfGnYFhdRR0aK9GSFvWgYJqmLxxE0zQpPzzY6zWNCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRSFO4v8EF+3d2LA507BCI/OKUOd8e/e4V64jCTHV6VbOxjcDMinYkSPnqmkVRC632cP7GIqzEQ7YwI6VcEdLSOuQsrRXczAIFBhBJKXWaKMW+c3VrTDKXp9OQhy5O1rIal2oWl5b9X/W5BYYKzWbIUSl42gydOvwIAfl4M4tlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w2oMB-00007O-N6; Wed, 18 Mar 2026 11:42:31 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w2oMA-000tRR-2y;
	Wed, 18 Mar 2026 11:42:30 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 836A1507596;
	Wed, 18 Mar 2026 10:42:30 +0000 (UTC)
Date: Wed, 18 Mar 2026 11:42:30 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	NXP S32 Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>, 
	Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
	Eric Chanudet <echanude@redhat.com>, Larisa Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH 2/5] can: flexcan: add FLEXCAN_QUIRK_NR_IRQ_2 quirk for
 two interrupt lines
Message-ID: <20260318-meteoric-tentacled-chupacabra-347f1d-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260318092215.23505-1-ciprianmarian.costea@oss.nxp.com>
 <20260318092215.23505-3-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mmaqyshtoip65elf"
Content-Disposition: inline
In-Reply-To: <20260318092215.23505-3-ciprianmarian.costea@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7133-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.915];
	TAGGED_RCPT(0.00)[linux-can,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 9394D2BA1D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--mmaqyshtoip65elf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] can: flexcan: add FLEXCAN_QUIRK_NR_IRQ_2 quirk for
 two interrupt lines
MIME-Version: 1.0

On 18.03.2026 10:22:12, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Introduce FLEXCAN_QUIRK_NR_IRQ_2 quirk to handle hardware integration

I understand, you followed the pattern and introduced
FLEXCAN_QUIRK_NR_IRQ_2.

I think it would be better to describe the actual reason why this IP
integration uses 2 IRQs: it has a dedicated combined bus error and state
change IRQ. What about: FLEXCAN_QUIRK_IRQ_BERR, this would match the
interrupt name from the bindings.

In a separate patch, we could migrate the s32g compatible SoCs to the
new quirk. But that's not subject to this patch series.

> where the FlexCAN module has two separate interrupt lines:
> - one for signaling error and bus state changes

Usually it's "bus error" and "state changes", as the errors happen
visible for everyone on the bus, while the state change is local to the
controller (every controller has it's own state).

> - one for mailboxes 0-127
>
> This is required for NXP S32N79 SoC support.
>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 21 ++++++++++++++++++---
>  drivers/net/can/flexcan/flexcan.h      | 16 +++++++++-------
>  2 files changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f5d22c61503f..a6b15496853c 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -1770,7 +1770,10 @@ static int flexcan_open(struct net_device *dev)
>  				  flexcan_irq, IRQF_SHARED, dev->name, dev);
>  		if (err)
>  			goto out_free_irq;
> +	}
>
> +	if (priv->devtype_data.quirks &
> +			(FLEXCAN_QUIRK_NR_IRQ_2 | FLEXCAN_QUIRK_NR_IRQ_3)) {
>  		err =3D request_irq(priv->irq_err,
>  				  flexcan_irq, IRQF_SHARED, dev->name, dev);
>  		if (err)
> @@ -1791,7 +1794,8 @@ static int flexcan_open(struct net_device *dev)
>  	return 0;
>
>   out_free_irq_err:
> -	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
> +	if (priv->devtype_data.quirks &
> +			(FLEXCAN_QUIRK_NR_IRQ_2 | FLEXCAN_QUIRK_NR_IRQ_3))
>  		free_irq(priv->irq_err, dev);
>   out_free_irq_boff:
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
> @@ -1823,10 +1827,12 @@ static int flexcan_close(struct net_device *dev)
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
>  		free_irq(priv->irq_secondary_mb, dev);
>
> -	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
> +	if (priv->devtype_data.quirks &
> +			(FLEXCAN_QUIRK_NR_IRQ_2 | FLEXCAN_QUIRK_NR_IRQ_3))
>  		free_irq(priv->irq_err, dev);
> +
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
>  		free_irq(priv->irq_boff, dev);
> -	}
>
>  	free_irq(dev->irq, dev);
>  	can_rx_offload_disable(&priv->offload);
> @@ -2213,12 +2219,21 @@ static int flexcan_probe(struct platform_device *=
pdev)
>  	if (transceiver)
>  		priv->can.bitrate_max =3D transceiver->attrs.max_link_rate;
>
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_2) {
> +		priv->irq_err =3D platform_get_irq(pdev, 1);

Please use platform_get_irq_byname()

> +		if (priv->irq_err < 0) {
> +			err =3D priv->irq_err;
> +			goto failed_platform_get_irq;
> +		}
> +	}
> +
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
>  		priv->irq_boff =3D platform_get_irq(pdev, 1);
>  		if (priv->irq_boff < 0) {
>  			err =3D priv->irq_boff;
>  			goto failed_platform_get_irq;
>  		}
> +
>  		priv->irq_err =3D platform_get_irq(pdev, 2);
>  		if (priv->irq_err < 0) {
>  			err =3D priv->irq_err;
> diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/=
flexcan.h
> index 16692a2502eb..f05036ca54f5 100644
> --- a/drivers/net/can/flexcan/flexcan.h
> +++ b/drivers/net/can/flexcan/flexcan.h
> @@ -58,22 +58,24 @@
>  #define FLEXCAN_QUIRK_SUPPORT_ECC BIT(10)
>  /* Setup stop mode with SCU firmware to support wakeup */
>  #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW BIT(11)
> +/* Setup 2 separate interrupts, main and err */
> +#define FLEXCAN_QUIRK_NR_IRQ_2 BIT(12)
>  /* Setup 3 separate interrupts, main, boff and err */
> -#define FLEXCAN_QUIRK_NR_IRQ_3 BIT(12)
> +#define FLEXCAN_QUIRK_NR_IRQ_3 BIT(13)
>  /* Setup 16 mailboxes */
> -#define FLEXCAN_QUIRK_NR_MB_16 BIT(13)
> +#define FLEXCAN_QUIRK_NR_MB_16 BIT(14)
>  /* Device supports RX via mailboxes */
> -#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX BIT(14)
> +#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX BIT(15)
>  /* Device supports RTR reception via mailboxes */
> -#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
> +#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(16)
>  /* Device supports RX via FIFO */
> -#define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
> +#define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(17)
>  /* Setup stop mode with ATF SCMI protocol to support wakeup */
> -#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(17)
> +#define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCMI BIT(18)
>  /* Device has two separate interrupt lines for two mailbox ranges, which
>   * both need to have an interrupt handler registered.
>   */
> -#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(18)
> +#define FLEXCAN_QUIRK_SECONDARY_MB_IRQ	BIT(19)

As I want to change the quirks anyways, just add new quirk at the end.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mmaqyshtoip65elf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabqBkwAKCRDMOmT6rpmt
0vZfAQCcHiduJJiHqQlpBQ+Vi3ackoALdVecg7r1LhFi8U5J3gEA8x/8YRKjyyHq
e8ITNDj/HHimKZHGuSGD2mKfFELkDAc=
=F+OT
-----END PGP SIGNATURE-----

--mmaqyshtoip65elf--

