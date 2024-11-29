Return-Path: <linux-can+bounces-2273-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E3D9DE68B
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 13:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6444CB21DAE
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 12:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152F3155352;
	Fri, 29 Nov 2024 12:38:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9F153598
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732883905; cv=none; b=e5rsqaglD0ROBp4lJB9OiAcHQ17aVwYS2sy4umlVrZy8oV96MIlNsjZAJvXG5n3pehnugf/0yK1iQb0DKAwvqT79xWNvPZSJgpPinqJe7f0+SArCC1gKvSRN9t+uovCr5ridHtg2upCsPQ7s4ohSJcpRjWPBT3hwyEbX2sma1W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732883905; c=relaxed/simple;
	bh=HDjNQgQen7mMNii9/Os6+9NeI/Nb5G1SpL+7tNiOUrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGWPx4Q/Yj3PyIHmp9xw9JMVQ9scfvHLVOkIrNMrnbzCZ2NzodTSLU4IZ7Ppdo/DI9k71pRqi0VPar3MS6BGclu7lNcFPFKWRxqA15u52vdFJOwqq6m/kpJoW6lWTPDPhYzRgiqFtXRrRbOJbfB7YAMUhcjGyYI6116A3wRVTUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH0GE-0002t8-HQ; Fri, 29 Nov 2024 13:38:14 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH0G9-000n1P-0d;
	Fri, 29 Nov 2024 13:38:10 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 94FD0381218;
	Fri, 29 Nov 2024 12:38:09 +0000 (UTC)
Date: Fri, 29 Nov 2024 13:38:09 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: tcan4x5x: get rid of false clock errors
Message-ID: <20241129-competent-sly-fennec-8d4c85-mkl@pengutronix.de>
References: <20241128-mcancclk-v1-1-a93aac64dbae@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xiuqmwqrtwobyme4"
Content-Disposition: inline
In-Reply-To: <20241128-mcancclk-v1-1-a93aac64dbae@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xiuqmwqrtwobyme4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: tcan4x5x: get rid of false clock errors
MIME-Version: 1.0

On 28.11.2024 09:32:31, Sean Nyekjaer wrote:
> tcan4x5x devices only requires one clock cclk, so call devm_clk_get()
> directly. This is done to avoid m_can_class_get_clocks() that checks for
> both hclk and cclk.
>=20
> tcan4x5x spi0.0: no clock found
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Applied to linux-can-next/testing

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xiuqmwqrtwobyme4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdJta4ACgkQKDiiPnot
vG/3yQf+IJTkhlpcC2crA5/aw+Z89C0+fD4xSVIYcCTBa5CWqSCeRNT2/7eu9T4q
lsEsHebm0Nh4daWwcrnEbz466DBVIBK0JYXLxPGozq7Kd37cV9prvjS7Qq8R0Iis
B/+nc76qEOHW0oPBooBUu+Q2jimqk9oB0eLvmjzm4CIxRGQYCwoFqcBDn6kE4s+I
xLyDgJVadTY49rZygmgGGHvs1epQN9Ofn7mxChfYFc67lLBy2GjdlusHweRMnxIX
zgifWE1EbBfR7HLNevSHgifIpd7JZdpc/67a9w7MrA4sJg7r3OiLPTgVbA9cOER+
c/6nrHyVCfmC62YSpesSUNyWyK4fKA==
=UuaR
-----END PGP SIGNATURE-----

--xiuqmwqrtwobyme4--

