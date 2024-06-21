Return-Path: <linux-can+bounces-828-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 664BA911ED5
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5591F266E2
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984B615A49F;
	Fri, 21 Jun 2024 08:32:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353B130ADA
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958723; cv=none; b=jf6OcGRAUd3gMk37jyKew7RWMYLS4KkmPPzzmeZDZBqg0CkXzjAtE7NjL7cTFtCkeKtEN+KYE64PA5Dub9rEdhVzzMy32Pb7mhp9Ytdd+GXixrOwVvwwFnIBciz961XkfZe/rVb4N7SzV7tVil0S3g1xiriwpicQSN9Eg2ksENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958723; c=relaxed/simple;
	bh=IpBagYZfFxzIZNLBKRNa1kygKkFEVvFsYpdmT48/Kls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cow+whZb3IXzI7rrZMuTjwAElXgdV7u51YbElZ4kCGCJ5pdL4pJOKcW5BDmtXCMRoRqkeWCoXxKbohZJC28JoMEw1jLli/zDjtM61W4PBORckeATsoRkXkpjFGEjenYZFG95/zLOBF9CL9IcHGZJ8cwt1JkP4aLx39r3MSy3Rfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZgc-0000NL-JT; Fri, 21 Jun 2024 10:31:58 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZgc-003tow-58; Fri, 21 Jun 2024 10:31:58 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D6DDB2EE57A;
	Fri, 21 Jun 2024 08:31:57 +0000 (UTC)
Date: Fri, 21 Jun 2024 10:31:57 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Jocic <martin.jocic@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	extja@kvaser.com
Subject: Re: [PATCH 0/3] can: kvaser_usb: Add support for three new devices
Message-ID: <20240621-tan-meerkat-from-avalon-420d1d-mkl@pengutronix.de>
References: <20240612141946.3352364-1-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ezc623yamailycvq"
Content-Disposition: inline
In-Reply-To: <20240612141946.3352364-1-martin.jocic@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ezc623yamailycvq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.06.2024 16:19:43, Martin Jocic wrote:
> This patch series adds support for the following devices:
> * Vining 800
> * Kvaser USBcan Pro 5xCAN
> * Kvaser Mini PCIe 1xCAN

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ezc623yamailycvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ1OnsACgkQKDiiPnot
vG+OQggAlP14/cp8yNXXNnnswf5Pyucu3KGXTxu7x1O63+iZEE1Fmm+DwA0Py/3b
36HXmJyzSv2qS+bwPxCEeTJ0lTQQF64QDsgX9FUIlm/fSA07ZM2RIdRRzwpxBscq
VuOoM2Jh0rAmBNLqRr+rmOLtNAT9KnQlrBw80z/VpOiDW6u31ZoIppDh6PpvG1Rb
gtX9KCqqomi4cVFnLl1Is8e0w2fsPFuE+toM07vklSn7alFUVsGsms9ro5kr66OL
URcP2eK8NP6AQtmOeQkuBzNihvhXH8dRvHF7lWls3H6wqd+rYdr+TfZsaVfo5bkW
viNs2MmwgBo6DFK71VV17XOswr89cg==
=xtFI
-----END PGP SIGNATURE-----

--ezc623yamailycvq--

