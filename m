Return-Path: <linux-can+bounces-1832-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0767E9B4511
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 09:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9C91C21F0F
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2A82038DD;
	Tue, 29 Oct 2024 08:57:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566E1DFE11
	for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192237; cv=none; b=Zh7lH5mybHLHRCVaz3PB8vaHWbdStUISm5bgjQOImpMSCmt7sD0+q4AMvSK0J/5LvlE19rJ7KPvvlFbSkaKO9ucZps+OjvVEIVIPIm3q5/jo7O2WDBQBIT8oBMTKL88rgQIZLjcP9WBoqS01HKIhhIXqvXM0byQAgtd8sTpkBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192237; c=relaxed/simple;
	bh=4Pz5cTRPw11z909m2kjm8d52XeDCnWJJZk62a3PC1cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUtA7zG7jpn4e4+OvdYIW09BL7Byh6o12ANdl5lODoNRH1qL3drnU2M49uVEqMlaj3YIlR9zhq6o3kSqf8kPcbLthlyCCbOcOpBc4UHzITMdZ4rUygpeEMFGEixGG5SzE+bYvDihYv6qcAMullc5AHNJUDyHbMsCL+4YWwhnKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5i2L-0002Tc-Cv; Tue, 29 Oct 2024 09:57:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5i2K-000zna-2n;
	Tue, 29 Oct 2024 09:57:12 +0100
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8C7793613D6;
	Tue, 29 Oct 2024 08:57:12 +0000 (UTC)
Date: Tue, 29 Oct 2024 09:57:12 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/6] can: dev: add helpers to setup an error frame
Message-ID: <20241029-ancient-sepia-tamarin-26e5af-mkl@pengutronix.de>
References: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
 <20241029084525.2858224-4-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ukyjm6xwt5qzlrb"
Content-Disposition: inline
In-Reply-To: <20241029084525.2858224-4-dario.binacchi@amarulasolutions.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--2ukyjm6xwt5qzlrb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 3/6] can: dev: add helpers to setup an error frame
MIME-Version: 1.0

On 29.10.2024 09:44:47, Dario Binacchi wrote:
> These helpers can prevent errors and code duplication when setting up a
> CAN error frame.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

AFAICS in the flexcan driver we don't need the "if (cf)" checks, do we?
Having repeated NULL pointer checks don't feel right.

Marc

>=20
> ---
>=20
> Changes in v2:
> - Replace macros with static inline functions
> - Update the commit message
>=20
>  include/linux/can/dev.h | 46 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>=20
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 0977656b366d..1b09d30dae32 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -168,6 +168,52 @@ static inline bool can_dev_dropped_skb(struct net_de=
vice *dev, struct sk_buff *s
>  	return can_dropped_invalid_skb(dev, skb);
>  }
> =20
> +static inline void can_frame_error_init(struct can_frame *cf)
> +{
> +	if (cf)
> +		cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +}
> +
> +static inline void can_frame_set_err_bit0(struct can_frame *cf)
> +{
> +	if (cf)
> +		cf->data[2] |=3D CAN_ERR_PROT_BIT0;
> +}
> +
> +static inline void can_frame_set_err_bit1(struct can_frame *cf)
> +{
> +	if (cf)
> +		cf->data[2] |=3D CAN_ERR_PROT_BIT1;
> +}
> +
> +static inline void can_frame_set_err_ack(struct can_frame *cf)
> +{
> +	if (cf) {
> +		cf->can_id |=3D CAN_ERR_ACK;
> +		cf->data[3] =3D CAN_ERR_PROT_LOC_ACK;
> +	}
> +}
> +
> +static inline void can_frame_set_err_crc(struct can_frame *cf)
> +{
> +	if (cf) {
> +		cf->data[2] |=3D CAN_ERR_PROT_BIT;
> +		cf->data[3] =3D CAN_ERR_PROT_LOC_CRC_SEQ;
> +	}
> +}
> +
> +static inline void can_frame_set_err_form(struct can_frame *cf)
> +{
> +	if (cf)
> +		cf->data[2] |=3D CAN_ERR_PROT_FORM;
> +}
> +
> +static inline void can_frame_set_err_stuff(struct can_frame *cf)
> +{
> +	if (cf)
> +		cf->data[2] |=3D CAN_ERR_PROT_STUFF;
> +}
> +
>  void can_setup(struct net_device *dev);
> =20
>  struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_s=
kb_max,
> --=20
> 2.43.0
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2ukyjm6xwt5qzlrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcgo2UACgkQKDiiPnot
vG/cPwf+NgF87abqp/jRHSmzOHRF7D/nsE46qfdm16FjPfy7w2Vbstddg1KFFSxk
OyXLkA0HckvPhrU3ox8gXlgjBNc89Brjr+n0KtNCltDGucjrOf+sD5Zzxd4yD/L9
Otn8hurW5rVW57yWIp0wZ1zYqL83uLPkUs07uHugVQYOFauHN0wK1BabHeBzA9n2
W9FBc//hrmHdPg58xE2PcPyA6mEjcQ66wuWtX/RCaZn/Ew//1sYluNonfvOlUdXg
ytpe9IQJLrohvOKRgYoWg3i5m1izzxztM4cSlUzrLEhTfLhwo9XlzSwDyMUAEWuz
r6i3GlBpTS5O37LJlY7Ec0RLeLWYjQ==
=/nIP
-----END PGP SIGNATURE-----

--2ukyjm6xwt5qzlrb--

