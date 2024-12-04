Return-Path: <linux-can+bounces-2331-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC0B9E3507
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 09:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A588B37EA9
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9079B18C930;
	Wed,  4 Dec 2024 08:05:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884AE155C97
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299559; cv=none; b=RRQkyJky47qLOo2fbfxXpyu9M1HOLsrW8aDq4c7htOElBl4yiC5Krcw9MB0eSpK0wXkgqH08dRGJRVaA7J5fJ64mY+6t8GG39sq6uqCbgrd2DbQYb8vAQ2AQooiJQRGLEHb5X48PDhgkbkY2Q4In81bTiUVoQxfk8Ne3wjwai6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299559; c=relaxed/simple;
	bh=TFk100t4oChT5j4+F4h+MI9bm4tyQpBRk98BNOzwQfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcuuG3RwWnYhdy9pM69tZiFX3s1gj3Dsrx8DkAUl2tc0JKX9xbeoBUSiY+n8PdNupI7FUUkGq6+UOUtsJNJGQVHGQYxbiBLUebizQUr4LSdde3h3oONsLPlWr8ysCi0LTvw2Fk9ed5yGKGB1s+diONK1LUq5Z/OHazthleds2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tIkOC-0004wH-5O; Wed, 04 Dec 2024 09:05:40 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tIkOA-001c9E-2o;
	Wed, 04 Dec 2024 09:05:39 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3FAF8385421;
	Wed, 04 Dec 2024 08:05:39 +0000 (UTC)
Date: Wed, 4 Dec 2024 09:05:38 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, NXP S32 Linux <s32@nxp.com>, imx@lists.linux.dev, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH v4 3/3] can: flexcan: add NXP S32G2/S32G3 SoC support
Message-ID: <20241204-chipmunk-of-unmatched-research-e89301-mkl@pengutronix.de>
References: <20241204074916.880466-1-ciprianmarian.costea@oss.nxp.com>
 <20241204074916.880466-4-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ewgk54txqho2u6s4"
Content-Disposition: inline
In-Reply-To: <20241204074916.880466-4-ciprianmarian.costea@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ewgk54txqho2u6s4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/3] can: flexcan: add NXP S32G2/S32G3 SoC support
MIME-Version: 1.0

On 04.12.2024 09:49:15, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>=20
> Add device type data for S32G2/S32G3 SoC.
>=20
> FlexCAN module from S32G2/S32G3 is similar with i.MX SoCs, but interrupt
> management is different.
>=20
> On S32G2/S32G3 SoC, there are separate interrupts for state change, bus
> errors, Mailboxes 0-7 and Mailboxes 8-127 respectively.
> In order to handle this FlexCAN hardware particularity, first reuse the
> 'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq handling
> support. Secondly, use the newly introduced
> 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk which handles the case where two
> separate mailbox ranges are controlled by independent hardware interrupt
> lines.
>=20
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---

Looks good to me!

Unrelated to this patch, but I want to extend the "FLEXCAN hardware
feature flags" table in "flexcan.h". Can you provide the needed
information?

> /* FLEXCAN hardware feature flags
>  *
>  * Below is some version info we got:
>  *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err =
RTR rece-   FD Mode     MB
>  *                                Filter? connected?  Passive detection  =
ption in MB Supported?
>  * MCF5441X FlexCAN2  ?               no       yes        no       no    =
    no           no     16
>  *    MX25  FlexCAN2  03.00.00.00     no        no        no       no    =
    no           no     64
>  *    MX28  FlexCAN2  03.00.04.00    yes       yes        no       no    =
    no           no     64
>  *    MX35  FlexCAN2  03.00.00.00     no        no        no       no    =
    no           no     64
>  *    MX53  FlexCAN2  03.00.00.00    yes        no        no       no    =
    no           no     64
>  *    MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no    =
   yes           no     64
>  *    MX8QM FlexCAN3  03.00.23.00    yes       yes        no       no    =
   yes          yes     64
>  *    MX8MP FlexCAN3  03.00.17.01    yes       yes        no      yes    =
   yes          yes     64
>  *    VF610 FlexCAN3  ?               no       yes        no      yes    =
   yes?          no     64
>  *  LS1021A FlexCAN2  03.00.04.00     no       yes        no       no    =
   yes           no     64
>  *  LX2160A FlexCAN3  03.00.23.00     no       yes        no      yes    =
   yes          yes     64
>  *
>  * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
>  */

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ewgk54txqho2u6s4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdQDU8ACgkQKDiiPnot
vG/0PAf+LSUwLnlxSvT5Jr4AbggMyghAkIAtN+WSik13Bc58adVUmQxUKXw/pFUT
bRhErPWGJqhtcMCAb/3fETKKhwEV9tnSGx4AYiHw+8q9mAKiy6CxCd6bKh/AKUmK
vtgAQ5kJL1OAVDMZ8w9DQ0ncqjYhd25D/Rw0gKI9MvMmQK2jaaInweR2t2iSNTB8
d9P4B8jklNS2+4r9xRsCKTMbSLt0eGpC1ti7z0FeopPYaVdhZIJ0JmC7zVAXoEx/
bXkTdyHSHJADnu7hrlAVoSWv8R0fGm3yeK1NTAkcZZwvbBj5zlcbRXPM985auMhc
7WT9QnQH+31jNMRyjKYIvneKbmwdMw==
=19Vs
-----END PGP SIGNATURE-----

--ewgk54txqho2u6s4--

