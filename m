Return-Path: <linux-can+bounces-2214-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6389D8629
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 14:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7431228513A
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E819A192D67;
	Mon, 25 Nov 2024 13:18:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0F17D378
	for <linux-can@vger.kernel.org>; Mon, 25 Nov 2024 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540716; cv=none; b=Xu5A7D4MqIExFfo01ghCAM/8/TnJgtRf4mOtG9+7Gv7M908l1gVFVjZYa3WhCiRreB5/cfFAnJ9lCAgakGmB+OYg+3ZKdTcnrmlzYjEm1kt0GcKCucr0csxURDAwQk2Kcp8Rseft8+NZboP5JxM5fxRGyY03GxTtDn+fZ/z9FDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540716; c=relaxed/simple;
	bh=Cr/4YnOto+zDt3wTsz3l/e4zwhgtZc41A40xSRS6piA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/zyTgik5zZEkqh0Ql9h8Oy14joZDPZJydbgReqZSZX2fAJFNnquTQRbqC/ZAJdNJ1RoHm2ueNk0ZUxWrK56PHMCDhicn9lMdSE2VEcV+vLjPXYKeHj3e4bUXOyKe+gQkwBjrxnSPY1iSEz12Oq0xjU/G51SoO7dMxg9drr31c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFYyy-0000bO-JT; Mon, 25 Nov 2024 14:18:28 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFYyx-0005RW-1I;
	Mon, 25 Nov 2024 14:18:28 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D2BC037CCFF;
	Mon, 25 Nov 2024 13:18:27 +0000 (UTC)
Date: Mon, 25 Nov 2024 14:18:27 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr, manivannan.sadhasivam@linaro.org, schuchmann@schleissheimer.de, 
	thomas.kopp@microchip.com
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
Message-ID: <20241125-miniature-magnetic-quoll-453e2e-mkl@pengutronix.de>
References: <20241124-fervent-unyielding-macaw-1c66fb-mkl@pengutronix.de>
 <20241125124613.29162-1-renjaya.zenta@formulatrix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iba6cvlc56y2whi6"
Content-Disposition: inline
In-Reply-To: <20241125124613.29162-1-renjaya.zenta@formulatrix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--iba6cvlc56y2whi6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
MIME-Version: 1.0

On 25.11.2024 19:46:13, Renjaya Raga Zenta wrote:
> Hi Marc,
>=20
> On 11/25/24 6:01 PM, Marc Kleine-Budde wrote:
>=20
> > I've just send a patch [1] to work around this issue. However not
> > tested, as I cannot reproduce the problem here.
> >
> > [1] https://patch.msgid.link/20241125-mcp251xfd-fix-length-calculation-=
v1-1-974445b5f893@pengutronix.de
>=20
> I've tested this patch and it no longer crashes with the previous reprodu=
cer.
>=20
> Thanks for the fix and detailed explanation.

I myself needed the detailed explanation to understand what was going
on :)

If I have some time, I'll add statistics to get a feeling how often this
happens.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--iba6cvlc56y2whi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdEeR8ACgkQKDiiPnot
vG/rDQf/Tn/rY/JESNoam/ZiieezFDfmbvbyWy1OO2zw25FHOKPDPz/P443WM+U6
kymZrm8r76Lx21V2UsWCupHd3KGEGq0s5oj3noClK0bkDk46XoSFS/adzKNKK5Dt
RAjcuVWRtqaD8k4AqBO2d/95Jb3irfPTBloC0Fqge16AUu2hGAPLJVEvVqsOZHks
IJSTp59SAGDwAGqoDWpxulAxwI5rt4aaadoR07QpmiI5EEn6OtxEkba65hlUKV6a
HsJ0/C6gwVc2RNZMArfTsVh5uKsALOoH7IWV3Z05J6C4e7CjWVjMT/8x32HKY7WV
nHI7oAEeDjnMJYh1mq6FIZWSfSV0Ew==
=bMY9
-----END PGP SIGNATURE-----

--iba6cvlc56y2whi6--

