Return-Path: <linux-can+bounces-1575-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1889989B4F
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77343281E5B
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 07:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC9F1547DB;
	Mon, 30 Sep 2024 07:22:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE46E15445B
	for <linux-can@vger.kernel.org>; Mon, 30 Sep 2024 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680937; cv=none; b=nh0gGPzFG+j7Iobsr5U08tLals1zJ01rKjWUaQzIO0M9ZTtPAnWCY7D4ZRcHKZgrK7hB01w6AmpdaaqrsSs4q33Rxj8WGHB5hGtSdg8VQUmrg9t9ylr7K7DATSy5T2ouoKna+8s4DoFZ4Ceq/sU1g7n0lAB9HGiOzkNqCdGvonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680937; c=relaxed/simple;
	bh=Mt8gAG2Fz4l8LRwmQzbi8y4MQUeMLkk8myWsqS/t2XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyJiQIwx7/UXYWsZp86yhBYNoVYjC6VpQyHobuioGdeSQqQI5Kb9kpuaesBza3wL4OLxnxv3d6fkfUFTI/7RQrh6N++X8e2hq2eNhSftYj+2npnZfJrrS878ooGqi2PorK/Xt95WNQAOyBH74PAbOSvDaGz+vdOtoiB/xQYIFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1svAjT-0004Bb-AQ; Mon, 30 Sep 2024 09:22:11 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1svAjS-002ZtP-Jf; Mon, 30 Sep 2024 09:22:10 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4FEAA3466B8;
	Mon, 30 Sep 2024 07:22:10 +0000 (UTC)
Date: Mon, 30 Sep 2024 09:22:09 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: AW: AW: IRQ handler mcp251xfd_handle_tefif() returned -22
Message-ID: <20240929-keen-rook-from-valhalla-2b776c-mkl@pengutronix.de>
References: <FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240925-simple-nondescript-porcupine-d66a23-mkl@pengutronix.de>
 <FR3P281MB15522178FE612C6B5B728C2BD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240926-pragmatic-colorful-lyrebird-dc8068-mkl@pengutronix.de>
 <FR3P281MB1552B40D19AF9DE8CA8150AAD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="btv4fe7eijsvxscl"
Content-Disposition: inline
In-Reply-To: <FR3P281MB1552B40D19AF9DE8CA8150AAD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--btv4fe7eijsvxscl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.09.2024 18:52:19, Sven Schuchmann wrote:
> my observations so far:
> The EINVAL is returned by=20
> err =3D mcp251xfd_tef_obj_read(priv, hw_tef_obj, tef_tail, l);
> inside mcp251xfd_handle_tefif()
>=20
> I modified mcp251xfd_tef_obj_read() like so:
>=20
> 	err =3D regmap_bulk_read(priv->map_rx,
> 				mcp251xfd_get_tef_obj_addr(offset),
> 				hw_tef_obj,
> 				sizeof(*hw_tef_obj) / val_bytes * len);
> 	if (err) {
> 		dump_stack();

As you already have located the call with "len =3D 0", we don't need that
dump_stack() anymore.

> 		netdev_err(priv->ndev,
> 			   "Offset=3D%d, sizeof(*hw_tef_obj)=3D%ld, val_bytes=3D%d, len=3D%d).=
\n", offset, sizeof(*hw_tef_obj), val_bytes, len);
> 	}
>=20
> and now I get:
> [   45.672211] CPU: 0 PID: 1643 Comm: irq/47-spi1.0 Tainted: G         C =
        6.6.51-pi-v8+ #3
> [   45.672240] Hardware name: Raspberry Pi Compute Module 4 Rev 1.1 (DT)
> [   45.672247] Call trace:
> [   45.672254]  dump_backtrace+0xa0/0x100
> [   45.672274]  show_stack+0x20/0x38
> [   45.672284]  dump_stack_lvl+0x48/0x60
> [   45.672300]  dump_stack+0x18/0x28
> [   45.672313]  mcp251xfd_handle_tefif+0x360/0x538 [mcp251xfd]
> [   45.672349]  mcp251xfd_irq+0x410/0xda0 [mcp251xfd]
> [   45.672373]  irq_thread_fn+0x34/0xb8
> [   45.672382]  irq_thread+0x174/0x260
> [   45.672393]  kthread+0x11c/0x128
> [   45.672407]  ret_from_fork+0x10/0x20
> [   45.672426] mcp251xfd spi1.0 canfd1: Offset=3D3, sizeof(*hw_tef_obj)=
=3D12, val_bytes=3D4, len=3D0).
> [   45.672450] mcp251xfd spi1.0 canfd1: IRQ handler mcp251xfd_handle_tefi=
f() returned -22.
> [   45.672459] mcp251xfd spi1.0 canfd1: IRQ handler returned -22 (intf=3D=
0xbf1a0010).
>=20
> len=3D0 looks strange to me here.

Yes, the regmap_*() functions return an error if called with "len =3D 0".

> This zero len is coming from inside mcp251xfd_handle_tefif()
> err =3D mcp251xfd_get_tef_len(priv, &len);
>=20
> I also modified this one:
> 	len =3D (chip_tx_tail << shift) - (tail << shift);
> 	*len_p =3D len >> shift;
>=20
> 	if (*len_p =3D=3D 0) {
> 		netdev_err(priv->ndev, "len=3D%d, chip_tx_tail=3D%d, tail=3D%d, shift=
=3D%d\n", len, chip_tx_tail, tail, shift);
> 	}
>=20
> and I get this:
> [   54.645392] mcp251xfd spi1.0 canfd1: len=3D0, chip_tx_tail=3D1, tail=
=3D1, shift=3D6
>=20
> But I am not sure if the len=3D0 is really the problem..?

Yes, "len =3D 0" is the problem here. So far the driver assumes that if
there is a TEF interrupt there must be events in the TE-FIFO, i.e. the
length must be !=3D 0.

> > I've already send a mail to stable to include these in the next
> > stable release.
>=20
> Perfect!

Meanwhile the patches are queued for the next stable releases:

| https://lore.kernel.org/all/2024092734-tackle-outlying-ae73@gregkh

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--btv4fe7eijsvxscl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmb6UZ4ACgkQKDiiPnot
vG+sHQf/RY7mNqQesuaWvfnN9plC+usTDSczzHQLnKcLwyNxtEIBB34JcM7LmcJ4
/FTqNCca7rTYQlU835C1dW2/t5SHESNtGEQ79TKUnHr9Tgy/GHfGVRM4SEKyE0Wc
DOajtBbkScmsbukEHMvzF85rzcGaX7YTmRHVp+GaD+0KNSSFvjtEly4yDqtVOSko
Aq7i6nVUkC1GIPQyqs8NoeeYcXX+kfKkReKFEP6R7xqp87AFAi4rWAftUJF/+uLp
/hbd52tgq92jjwBQSm5qoeQLmdyZhXWSosu4S3q0kFYB/rgDLTihZZzNjI/jrwVm
GtaKlH3EXToL0iFdqvwagzkZ5qiIfQ==
=dy14
-----END PGP SIGNATURE-----

--btv4fe7eijsvxscl--

