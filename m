Return-Path: <linux-can+bounces-1892-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB1D9BC9C3
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 10:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770711F22EEF
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 09:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64631D172A;
	Tue,  5 Nov 2024 09:57:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD51CDA3E
	for <linux-can@vger.kernel.org>; Tue,  5 Nov 2024 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800634; cv=none; b=CUWW8ZBQd13B2q0686vld95dmniFprnqWToyCiRY9jBjU2BmVPYeITdCkznSw3RolXw0EBNb5McUmfKFtQnlRrtdrbnDBIDsB+nGrzzvu/SEHnCD7RcEZSbzdhmt40AaxlHKrtZW893fUI32mcoNCaSp/YXFXwBE2seToKTGF5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800634; c=relaxed/simple;
	bh=bWfRFMdu5Mou+MP11wkuQW0oadnXD4+02p8gUO3LjV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqRrqARLfqY3W3m6klJtmw/Dpj64q8TLqokx+1T8ccFk/PxFProQZQ/2HsucKSMLJqeusD91Adu4Bx3bJtObzjwwcidgudPQU1UTq9RCURyo/oEUsPUlAnMsT4AdtQeMldMC/dCNStCmpwZa8Borv1cjKi+gEXBJBALBQVcFmTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t8GJ3-0000BZ-89; Tue, 05 Nov 2024 10:57:01 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t8GJ2-0027iP-27;
	Tue, 05 Nov 2024 10:57:00 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E809636A3B6;
	Tue, 05 Nov 2024 09:56:59 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:56:59 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr, manivannan.sadhasivam@linaro.org, schuchmann@schleissheimer.de, 
	thomas.kopp@microchip.com
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
Message-ID: <20241105-crazy-petrel-of-tempering-cb8f6f-mkl@pengutronix.de>
References: <20241104-ludicrous-quartz-kakapo-07219e-mkl@pengutronix.de>
 <20241105082801.32475-1-renjaya.zenta@formulatrix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="taswtfcc5gqp4v3a"
Content-Disposition: inline
In-Reply-To: <20241105082801.32475-1-renjaya.zenta@formulatrix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--taswtfcc5gqp4v3a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
MIME-Version: 1.0

On 05.11.2024 15:28:01, Renjaya Raga Zenta wrote:
> Hi, Marc and Sven,
>=20
> On 25.10.2024 15:50:37, Sven Schuchmann wrote:
> > this looks good to me!
> > I have no crashes here anymore.
>=20
> On , Marc Kleine-Budde wrote:
> > Thanks, can I interpret this as a Tested-by: and add it to the patch?
>=20
> Sorry, I'm also experiencing this kind of issue.=20
>=20
> [  217.906113] mcp251xfd spi0.0 can1: IRQ handler mcp251xfd_handle_tefif(=
) returned -22.
> [  217.913946] mcp251xfd spi0.0 can1: IRQ handler returned -22 (intf=3D0x=
bf1a0010).
>=20
> Even with this patch applied, I still can reproduce the issue with:
>=20
> cangen <can-interface> -g1 -c8 -L12 -fbx -I2 -Di

Can you follow the instructions in

| https://lore.kernel.org/all/20240929-upbeat-carrot-whippet-bc3e9c-mkl@pen=
gutronix.de/

and send me the "/var/log/devcoredump-*.dump"?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--taswtfcc5gqp4v3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcp6+gACgkQKDiiPnot
vG/UYgf9GpctOn6nEyLVisoyWFMAWEJoNE7ptiU28FINnJd+BxN0jGnlRnAJZbIC
K/dr5tCgV6iJNaY7fy0wVusU4tRNuoK3wz/2I1FghPIv95mgGJ3XuOZkn4YI4lcQ
kP/z0/igeCdSORZdTWPZDiF++WW/rPdEUmplFWp9ySIHcCMEpVs57hNLboxZBR8G
cJgrE9LswgIua9vA/7DIQVESzFfRFcETgXwEpm7VgHPYjUijWqfKHKZW7IBTqFH4
PC1jeKKRmuzNLr547ohlx7HmihZ3Y60AK6CwFOZEoSugaNwwzJv9VcODTQ248Nr7
3ND+50iuGdk7XsAXafou6Di/+V5WBg==
=tNV6
-----END PGP SIGNATURE-----

--taswtfcc5gqp4v3a--

