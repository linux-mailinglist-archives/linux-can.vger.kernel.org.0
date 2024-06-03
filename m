Return-Path: <linux-can+bounces-697-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812278D8007
	for <lists+linux-can@lfdr.de>; Mon,  3 Jun 2024 12:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5001F25647
	for <lists+linux-can@lfdr.de>; Mon,  3 Jun 2024 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D78082C6B;
	Mon,  3 Jun 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XiBHJ921"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16155107A8
	for <linux-can@vger.kernel.org>; Mon,  3 Jun 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410743; cv=none; b=OPHJ/28FYkJvIS5cabsC0A2/MR1VXpKE5dfT202+tJOVE5VrDSACku06flGbary9CuVU75/DVsAYyezYSwBAmXFob8Rv2SfmWTWwXc8HeUyan5dukEL07KxSsCcCT5qvT/PzOvMlnSMQUZ2smRRQ14CGg98B/jGUm1zElR8heM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410743; c=relaxed/simple;
	bh=6gacXq5vJZFo4/JcqCc7ZeWC71yxhq7d5UAbsSFdcC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfAMG5mgxVxk8Vxg/RJX1BrcMEM9SAbMik00+dlqlaFBMebRQ2aHiRfj0Gtu4uTmaAKW67unRsJYPWr5qze0fDjGWykSTSciuQOKryMs2jEfVwkTVhCm8qL1VcpTTYjc3lmCmelI2woq8/8qwXjGH/9iBAPoxYipAgerKiojQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=XiBHJ921; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=eLfG
	Lt7Q7gxinXk9NTwg5OBgUI0WVKgLDksuWhB/zrU=; b=XiBHJ921SyhGcAit6aoF
	aOJUOF+zmtUPIA1eAx/87IROUBrg5WKdoKs2fiucNTbzjwrgANeyfz+L7n2f1Bo+
	UNv/XYjbIWB2OKBAgCP5NNEUz8RdeVugll/N9h1MqgqkpzitlCaG0yzR0+5wDMFl
	VVAEEbxy6eUjAAX+zDeG22Pp47H4Y3vFAyIcrXmQBfp/zy37MRH3S5PkULwCevKt
	8G+kEvIPRnXRsAcaVMX0EmMFbFXNTbKFrwryogsy5bUNov72O7GFZMJe3jA1bRj9
	nNOoc2Z70r7Dj2GgY7AZ/Tsez9H04SISfXstjZ0JZnk0S3G7aDki/72ZTB33Iv4l
	Rw==
Received: (qmail 1921309 invoked from network); 3 Jun 2024 12:32:16 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 12:32:16 +0200
X-UD-Smtp-Session: l3s3148p1@SS3Z2PkZyoAgAwDPXzLGAH1eNELjOc3g
Date: Mon, 3 Jun 2024 12:32:15 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] can: rcar_canfd: Simplify clock handling
Message-ID: <d5orw4madur5e5rx2kcnkop5e333rhd43ngy7spphnm4sqylya@mvwitvshclax>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org
References: <cover.1716973640.git.geert+renesas@glider.be>
 <2cf38c10b83c8e5c04d68b17a930b6d9dbf66f40.1716973640.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="enazmods4fveag25"
Content-Disposition: inline
In-Reply-To: <2cf38c10b83c8e5c04d68b17a930b6d9dbf66f40.1716973640.git.geert+renesas@glider.be>


--enazmods4fveag25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 11:12:13AM +0200, Geert Uytterhoeven wrote:
> The main CAN clock is either the internal CANFD clock, or the external
> CAN clock.  Hence replace the two-valued enum by a simple boolean flag.
> Consolidate all CANFD clock handling inside a single branch.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Nice simplification!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--enazmods4fveag25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZdm6wACgkQFA3kzBSg
KbZ4OxAAgd4GBocBLfl/h6rGu6FYbawWMIoahmg+8Gp/IoXCOs8MyvgKkp180ZS1
F3zlBj1x98U4cK6UzsVOPgyDJTHh32G7c2d0g6xVBf185XMuwWU6Kh/agqj7aAH/
u2M4eJHhKS2PfOCHNteNtN65Q+pFfDEKNc1ogb3SwKQMyD2QtyUWVfBzjNxHp8oW
qNH724EjoIvFkf4XrZjzk2MuiOxf1bui081C4rVv2oEKk5ZKsyZ11j+AVZuyct/e
GG91tkoB5KWlogZu2ED8Pb0MngPz5XsyC6v0rTWljRWBbWcpE+GVHAIDNSdlPDw4
RBNY1HE7XIl/Q23Y4KuHQb7s6+cQ7edxOhxuRM+w42G/rvJatnmmdDo8MdJD/gvt
c3z4kiG99+I3Udu2IVVVB1tYyr69Z72SBvrRSdkdUM4z494X2lV5cZ578KnHRtbo
LGQb70ZgJ2GgcRHZVwUQIVQpyBcfjpTz5a9c1ynf9/FXORSJAJjEB8WXn/Y4fexB
ED0EEXSDoZFELRxLgqwRVUcCppxyXNE6sghE0g0j9D/TD4KdTCztgLqddk4+rdqL
mueNp9kZc7c21lrwXtymft9tNfRMZIRhQLQbFilxpE2NnzrECXK/GrzmDQqziFgX
SsPIs31hZgvKHOSRhPulPnPjNsKcI7dQC38aThitLYIGyhSfbW0=
=0tSn
-----END PGP SIGNATURE-----

--enazmods4fveag25--

