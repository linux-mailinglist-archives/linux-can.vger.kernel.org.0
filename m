Return-Path: <linux-can+bounces-1241-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF206966053
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 13:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C027289689
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 11:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A257173C;
	Fri, 30 Aug 2024 11:12:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E944196C6C
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016330; cv=none; b=Sr2se46M+o2XANvnEPqt0QSlLSWOH6x6AV3m2DfpKVvKmkZEiUzwCzGghdqRWISz7SalxgIgY4I1TJdCNETenmEfVG+U295yDsrk1ZEBkoSm+4bsa6Iy/tQMoZWOS9JbFaYRDrcqhuuOse/8kPjy7+Jml/gvXgcFkPftylgsFgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016330; c=relaxed/simple;
	bh=0uNT8ImgCxCg7JiQKh6VUHnPNjEHrlYRQl/TtUDEPOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3Cffq0Rtg2qSXDKYhQSZO2lmUzg/wgG+KBoDCZ3l2JBgJYbtHcfWnoNWKFj8e5mtPYpQqGJRmYzoWGYlMRTp/sAuUPtwJxaIy9jJNMGUfwscOSR0CcSjvXIdhxYb0fXgqtaOXsVBZbsJX0q4Nxvm5YE4v6LEZmUH/tv4a2HE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjzXx-0001Dj-S5; Fri, 30 Aug 2024 13:12:05 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjzXx-0048SZ-4S; Fri, 30 Aug 2024 13:12:05 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CE75032DD39;
	Fri, 30 Aug 2024 11:12:04 +0000 (UTC)
Date: Fri, 30 Aug 2024 13:12:04 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Jocic <martin.jocic@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	extja@kvaser.com
Subject: Re: [PATCH] can: kvaser_pciefd: Use IS_ENABLED() instead of #ifdef
Message-ID: <20240830-incredible-strange-smilodon-b0d52b-mkl@pengutronix.de>
References: <2084fc26b4759606fe78ab7da1a2d73c12f75a9c.1724331802.git.martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="awg3z4b56yguv2k6"
Content-Disposition: inline
In-Reply-To: <2084fc26b4759606fe78ab7da1a2d73c12f75a9c.1724331802.git.martin.jocic@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--awg3z4b56yguv2k6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.08.2024 18:38:59, Martin Jocic wrote:
> Use the IS_ENABLED() macro to check kernel config defines
> instead of #ifdef.
>
> Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>

On platforms with CONFIG_ARCH_DMA_ADDR_T_64BIT not set this throws the
following warning:

| drivers/net/can/kvaser_pciefd.c: In function =E2=80=98kvaser_pciefd_write=
_dma_map_altera=E2=80=99:
| drivers/net/can/kvaser_pciefd.c:1058:30: error: right shift count >=3D wi=
dth of type [-Werror=3Dshift-count-overflow]
|  1058 |                 word2 =3D addr >> 32;
|       |                              ^~

I'm using upper_32_bits() to avoid this warning.
https://elixir.bootlin.com/linux/v6.10.6/source/include/linux/wordpart.h#L14

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--awg3z4b56yguv2k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbRqQEACgkQKDiiPnot
vG/rrwf/Ug7w176Snm4LpilXdnxKFQ6bfMEnsYS3WTTttH20Xx5nl3ALFaj+M+RX
8SAbE4kPLXDyw/wL0K4UWjT8yTOJhRkNcXMSJUzsUsDGoGZKEIoAfVu3TlfeRUYB
oKd5YLVgj0llpg1eP/p4/P/KmpfQ02Xp6zM0+vOi1k+io41IDfWviNbMX+ezfDDi
dbz4oo9hGoHVEo3qP1Z9oWgEKMfOzRlTQLcligSa5+FafHMXi3HWp+sQqmi3BUbE
F0vMJmoKsMRAATgvrVwErZQXto8AInky5HiSxfXEID5mXLM4grArPtgubHOvM8/F
TaKzByMIufW/+Ds+jb2XDHPO6R5Q4w==
=7UMQ
-----END PGP SIGNATURE-----

--awg3z4b56yguv2k6--

