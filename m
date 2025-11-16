Return-Path: <linux-can+bounces-5444-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B25CC617A8
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 16:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDED236167B
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD642F90CE;
	Sun, 16 Nov 2025 15:44:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A81E2834
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763307857; cv=none; b=tni/F/VqJnisMwd5t2QJ+a/Xy3bsqKmVwzAPUMgE7ORk1ggDSK23Cvvoo/MTVpiJiFlO+PSU00zVzZIIvMaqLmHe2/qVrCYlQHpbxc+/0GU+cbRNR2n3VwMzVNiGhALKGik049TDn67NUWclBpzImywg0OQigkr8AHUOrEbvmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763307857; c=relaxed/simple;
	bh=H3tEJofUrq0Emqx3M1MlIfhw7ICeXPNnNUPyWg5azE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5ApiGwPMI9KVMwZY36zkUJOmA3fdMWD4M8KEB5JkefbVVC9ogP3TzQXW7CTXFb3uvZ5LH5EsktJZY18Dq6p6V0A4N/5Yr4n49GOHT7bXjPgyht1mwgjOIha8u99x7kPzWMjAhg7PTHwJXP66u48y1P0VOC0jHNgh3Es8NfhMCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKeuy-0005Ia-8K; Sun, 16 Nov 2025 16:43:56 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKeuw-000lf6-30;
	Sun, 16 Nov 2025 16:43:54 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B4D654A02F8;
	Sun, 16 Nov 2025 15:22:52 +0000 (UTC)
Date: Sun, 16 Nov 2025 16:22:50 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Vincent Mailhol <mailhol@kernel.org>, "magnus.damm" <magnus.damm@gmail.com>, 
	Tranh Ha <tranh.ha.xb@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: RE: [PATCH] can: rcar_canfd: Fix controller mode setting for
 RZ/G2L SoCs
Message-ID: <20251116-deer-of-total-apotheosis-2ce1cc-mkl@pengutronix.de>
References: <20251030120508.420377-1-biju.das.jz@bp.renesas.com>
 <20251112-warping-ninja-jaybird-22edde-mkl@pengutronix.de>
 <TY3PR01MB11346974232A057A7D5B6EBAD86CBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="342downr2s5n6lny"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346974232A057A7D5B6EBAD86CBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--342downr2s5n6lny
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [PATCH] can: rcar_canfd: Fix controller mode setting for
 RZ/G2L SoCs
MIME-Version: 1.0

On 15.11.2025 13:57:13, Biju Das wrote:
> Hi Marc, Geert,
>
> > -----Original Message-----
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > Sent: 12 November 2025 08:47
> > Subject: Re: [PATCH] can: rcar_canfd: Fix controller mode setting for R=
Z/G2L SoCs
> >
> > On 30.10.2025 12:05:04, Biju wrote:
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > The commit 5cff263606a1 ("can: rcar_canfd: Fix controller mode
> > > setting") applies to all SoCs except the RZ/G2L family of SoCs. As per
> > > RZ/G2L hardware manual "Figure 28.16 CAN Setting Procedure after the
> > > MCU is Reset" CAN mode needs to be set before channel reset. Add the
> > > mode_before_ch_rst variable to struct rcar_canfd_hw_info to handle
> > > this difference.
> > >
> > > The above commit also breaks CANFD functionality on RZ/G3E. Adapt this
> > > change to RZ/G3E, as well=C2=A0as it works ok by following the
> > > initialisation sequence of RZ/G2L.
> > >
> > > Fixes: 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Applied to linux-can.
>
> There are 3 modes for CANFD on RZ/G3E
>
> 1) CAN-FD mode
> 2) FD only mode
> 3) Classical CAN only mode
>
> In the "FD only mode", the FDOE bit enables the reception and transmissio=
n of CAN-FD-only frames.
> If enabled, communication in the Classical CAN frame format is disabled.
>
> On RZ/G2L, currently, CAN-FD mode is enabled by default and
> On RZ/G3E and R-Car Gen4, currently FD-only mode is the default.
>
> Prior to commit 5cff263606a1010 ("can: rcar_canfd: Fix controller mode se=
tting)
> RZ/G3E and R-Car Gen4 are using incorrect code for setting CAN-FD mode. B=
ut fortunately,
> it sets the mode as CAN-FD node, as the channel reset was executed after
> setting the mode, that resets the registers to CAN-FD mode.(Global reset,=
 set mode, channel reset)
>
> The commit 5cff263606a1010 makes (Global reset, channel reset, set mode),=
 now
> align with the flow mentioned in the hardware manual for all SoCs except =
RZ/G2L.
> But because of the earlier wrong code, it sets to FD-only mode instead of=
 CAN-FD mode.
>
> Is it okay to drop this patch so I can send another patch to make CAN-FD =
mode
> as the default for RZ/G3E and R-Car Gen4?

Yes. I'll drop this patch now.

> As an enhancement, we need to define a device tree property to support FD=
-only mode
> for RZ/G2L, RZ/G3E and R-Car Gen4. Please share your thoughts on this.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--342downr2s5n6lny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkZ7DsACgkQDHRl3/mQ
kZymkAf/VSOUZK3IudRdzA+MK5ODwmvKV2wiiMMtS1FHfxH7PDBAd+kXGagNNhvB
25ob7J/De4gP8RfS98wp7AG1RF4b+dbj83aYpEcba4ByXAZUTzQACJN/Xkj6Vqk9
QX9vlNk4sTJuJ2s4ddtKjlXCJsXk8HqtwgJ1lS4+u46wJuH1JVuaepdyCOdn+iwD
W7QMKBr+0Zuhssw22xb+uhCkGrN2KQ517LQKmIL72/A4Lfq/yeus3L1rUNQSRa+g
ZCix0jvPsF26qBtzogVPkOejTnHDK0qoR8AfpdVE4DYN1FF/BfIYxU1TjnHOsTrz
MdXDivK6kSFyK8DPYhRy3RPCAMfYvA==
=EIRn
-----END PGP SIGNATURE-----

--342downr2s5n6lny--

