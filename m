Return-Path: <linux-can+bounces-6125-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85757D1A52C
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 17:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF0443053838
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 16:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C94530ACF6;
	Tue, 13 Jan 2026 16:33:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE732853EE
	for <linux-can@vger.kernel.org>; Tue, 13 Jan 2026 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321987; cv=none; b=Jbk7b7oP2Nf/hM13YwamFEc+IhTIRH/QgIh6BrfUQlu0my/fUAak8X48zXVVUZIjvFHzptvNdKAkAncztjg4zOoBbxdeAcnXJyjaBk1H+eh+HJekPqRZr40cc7Wj0JzMnYA7rZlnLvqjq/4gtlRSdHBMQc6sFmzuZOXYjsmqEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321987; c=relaxed/simple;
	bh=chQPoqsjNrilwJ9flEjl2QGVVbTkL7Ubl2qnccQzr+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fq4B2bi2aWOw7OrtRJNpofcz4OeCcW30nGMl9lq9TBhBSYzIpbIX6brCa+XdZlIwtXojpwItSgJDLS0WaL5HcurhltWs0frXS9f41bR6LHbcSOPZ7GZdiG8DrGwEQ4/hTryt6+4/lAr8vaKoVdfugFMEkkhQ9LRest5xWPfLYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfhKI-0005r8-NS; Tue, 13 Jan 2026 17:33:02 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfhKJ-000S6b-0H;
	Tue, 13 Jan 2026 17:33:02 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 19F8E4CC29B;
	Tue, 13 Jan 2026 16:33:02 +0000 (UTC)
Date: Tue, 13 Jan 2026 17:33:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [can-next 4/5] can: remove private skb headroom infrastructure
Message-ID: <20260113-subtle-meerkat-from-hell-678184-mkl@pengutronix.de>
References: <20260112150908.5815-1-socketcan@hartkopp.net>
 <20260112150908.5815-5-socketcan@hartkopp.net>
 <a9af2a4c-340d-4246-b35d-6fe42a419086@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3haizpcxd4x5kd2t"
Content-Disposition: inline
In-Reply-To: <a9af2a4c-340d-4246-b35d-6fe42a419086@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--3haizpcxd4x5kd2t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [can-next 4/5] can: remove private skb headroom infrastructure
MIME-Version: 1.0

On 13.01.2026 17:27:59, Oliver Hartkopp wrote:
> unfortunately I missed you in CC for this patch set:

You are so sending so many series recently, might be a good time to have
a look at "b4". You can automatically populate the Cc with "b4 prep
--auto-to-cc".

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3haizpcxd4x5kd2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlmc7oACgkQDHRl3/mQ
kZxQHQgAjICiBjUhgxk5Gy7ftsiDgvNrzFawWuvvzxdxR3jFFuncYBZaAAz5Mj3L
vtiKGdbyEzRl0GM5u41fevA3pa6tx5KeP5HY9Wj9tjj1U8hP0nbwVzQslg8LjL62
yx1q3+uLWPRr2DxeBBvu13/GmM2i64v8nXOu4WojADosoVHAnPR6qKMPdgsLcRGR
yftutvjcf6fVM7eqLMzvEp+kKdLatTsT9V54+zl+6vjP5VFbGi3qL/w/liHf8NlI
jlhZrcV1zd5oZaBW9R6FZM1Nwd5qpr0t7wDXemvVLGbFjPrn7J56xQUeLeZpIwLV
ND9CH6Nw9knS1s4b+jfrhWCkx0wxUQ==
=cXR0
-----END PGP SIGNATURE-----

--3haizpcxd4x5kd2t--

