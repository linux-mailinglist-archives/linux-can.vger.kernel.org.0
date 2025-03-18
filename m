Return-Path: <linux-can+bounces-3152-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E694BA6731F
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 12:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E2916EA0E
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52F420A5DC;
	Tue, 18 Mar 2025 11:50:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABB20A5D8
	for <linux-can@vger.kernel.org>; Tue, 18 Mar 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298602; cv=none; b=Td/TmVl89lbLD0y153dDJMJT4drqDGz5+NKUDNc42nPVIBkT9BXMMMfnncNm5FRT0bBtbZH+r2cGIGQkkN8Z6AyqR0fSQAQIXMZyaEoM51qyBdj5I0kofEebupGPmKVIHY0+2I7hksHmsOgsm+SqJk9c4V1d36YHH4SHvXBMRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298602; c=relaxed/simple;
	bh=Yp/qDoMzNatdeWfSitrmJD5Dj3BvZ/Id62v24G+ghLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHkWnwzsvR/Lriqbju7EUNRZOYgH4ThyNH1Rmr4DbCbkV/YriaFVyXYloaLavpoJqxR9Kd85NOX1Bn0W/uPDSXx0wwLWMgJ7SMBbg4mC+NqVcGtQo/RLwDEs7vOqYKr1/JCvrhXQr6z5vOfZmYYc6YtdaygFc7F2DGD6B3y0CxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tuVSC-00017L-8K; Tue, 18 Mar 2025 12:49:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tuVSA-000Q3h-2S;
	Tue, 18 Mar 2025 12:49:51 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C4D743DF919;
	Tue, 18 Mar 2025 11:49:50 +0000 (UTC)
Date: Tue, 18 Mar 2025 12:49:48 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: RE: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
Message-ID: <20250318-inventive-aardwolf-of-security-5934f1-mkl@pengutronix.de>
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
 <20250317123619.70988-13-biju.das.jz@bp.renesas.com>
 <CAMuHMdVbcNqeNXnLRAhS-1g+VrTEwzfLiyNt+WCfuJDuF-Hacg@mail.gmail.com>
 <TY3PR01MB113466DCECC55DDE9913833F186DF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdXbk8gqhd4FFGmFNQRrEwbOToQvr-00LE2pZWoZq65GGg@mail.gmail.com>
 <TYCPR01MB1133298C8595B3CA5D890289486DF2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <TY3PR01MB113465F5D2C480EE3F0B47FA986DE2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ahraxpjumadizmep"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113465F5D2C480EE3F0B47FA986DE2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ahraxpjumadizmep
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct
 rcar_canfd_hw_info
MIME-Version: 1.0

On 18.03.2025 11:26:54, Biju Das wrote:
> Hi Geert and Marc,
>=20
> > -----Original Message-----
> > From: Biju Das
> > Sent: 17 March 2025 16:24
> > Subject: RE: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct=
 rcar_canfd_hw_info
> >=20
> > Hi Geert,
> >=20
> > > -----Original Message-----
> > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Sent: 17 March 2025 15:04
> > > Subject: Re: [PATCH v5 12/16] can: rcar_canfd: Add mask table to
> > > struct rcar_canfd_hw_info
> > >
> > > Hi Biju,
> > >
> > > On Mon, 17 Mar 2025 at 15:46, Biju Das <biju.das.jz@bp.renesas.com> w=
rote:
> > > > > -----Original Message-----
> > > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > Sent: 17 March 2025 14:13
> > > > > Subject: Re: [PATCH v5 12/16] can: rcar_canfd: Add mask table to
> > > > > struct rcar_canfd_hw_info
> > > > >
> > > > > On Mon, 17 Mar 2025 at 13:37, Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
> > > > > > R-Car Gen3 and Gen4 have some differences in the mask bits. Add
> > > > > > a mask table to handle these differences.
> > > > > >
> > > > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > ---
> > > > > > v4->v5:
> > > > > >  * Improved commit description by replacing has->have.
> > > > > >  * Collected tag.
> > > > > >  * Dropped RCANFD_EEF_MASK and RCANFD_RNC_MASK as it is taken
> > > > > >    care by gpriv->channels_mask and info->num_supported_rules.
> > > > >
> > > > > Thanks for the update!
> > > > >
> > > > > All mask values are just the maximum values of various parameters.
> > > > > Hence they could be replaced by the latter, like you already did =
for the RNC mask.
> > > >
> > > > But this will increase memory size, right? Currently we have
> > > > rcar-gen3 and gen4 tables
> > > > 2 tables used by 4 hardware info variants.
> > > >
> > > > If we drop tables and use variable with max values like RNC MASK,
> > > > then this will be like 4 tables for 4 hardware info variants, right?
> > > >
> > > > Please correct me if my understanding is wrong.
> > >
> > > It depends where you store the parameters: in the (two) tables, or in
> > > the (four) hardware info structures...
> >=20
> > OK, you mean replace mask_table->max_val_table, rcar_gen{3,4}_mask_tabl=
e->rcar_gen{3,4}_max_val_table
> > and *_MASK->*_MAX_VAL??
>=20
> The below parameters[1] has mask =3D max_parameter_val - 1.
>=20
> I will update the table as below. Please let me know if there is any issu=
e.
>=20
> struct rcar_canfd_hw_info {
> -       const u32 *mask_table;
> +       const u32 *params;
> };
>=20
> -enum rcar_canfd_mask_id {
> -       RCANFD_NTSEG2_MASK,     /* Nominal Bit Rate Time Segment 2 Contro=
l */
> -       RCANFD_NTSEG1_MASK,     /* Nominal Bit Rate Time Segment 1 Contro=
l */
> -       RCANFD_NSJW_MASK,       /* Nominal Bit Rate Resynchronization Jum=
p Width Control */
> -       RCANFD_DSJW_MASK,       /* Data Bit Rate Resynchronization Jump W=
idth Control */
> -       RCANFD_DTSEG2_MASK,     /* Data Bit Rate Time Segment 2 Control */
> -       RCANFD_DTSEG1_MASK,     /* Data Bit Rate Time Segment 1 Control */
> -       RCANFD_CFTML_MASK,      /* Common FIFO TX Message Buffer Link */
> +enum rcar_canfd_parameter_id {
> +       RCANFD_NTSEG2,          /* Nominal Bit Rate Time Segment 2 Contro=
l */
> +       RCANFD_NTSEG1,          /* Nominal Bit Rate Time Segment 1 Contro=
l */
> +       RCANFD_NSJW,            /* Nominal Bit Rate Resynchronization Jum=
p Width Control */
> +       RCANFD_DSJW,            /* Data Bit Rate Resynchronization Jump W=
idth Control */
> +       RCANFD_DTSEG2,  	  /* Data Bit Rate Time Segment 2 Control */
> +       RCANFD_DTSEG1,  	  /* Data Bit Rate Time Segment 1 Control */

Another option is to evaluate, if you can use priv->can.bittiming_const
and priv->can.data_bittiming_const instead.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ahraxpjumadizmep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfZXdkACgkQDHRl3/mQ
kZzIKggArm5zEMuDWugIeXpkzokgraJLAEO9CdDIrTl1C2aj6c9G4GxMEZRkqYlh
rUyu8gZuRRzohF3B44Vfu7pxqK1bdy2zguUbJOisKQ/vhghkp4GKUmXXCZGSxY8t
9pGvmJVpxKREVP2oNTej+cwH4X5II0fCh76GUfZ4jprTpylNCrZ+RocYyU+znqDk
Fle0Sdq/yDIV1OM5k2bLbtEoGjXgG+vV4r3UFcEyldw/Hag6HeA3AJ7zoG4ksYDR
37D16oc/kms5nzgItmUnB28TJfmvaAWw8W57jVCTNCpOhL+zdk2TUezHT2YCn9N8
qgCYNfSCkgpNw/pU1hzu3wMrgTf7OQ==
=5Uu0
-----END PGP SIGNATURE-----

--ahraxpjumadizmep--

