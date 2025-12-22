Return-Path: <linux-can+bounces-5901-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F055FCD6A60
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 17:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A5C3032977
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D24426056A;
	Mon, 22 Dec 2025 16:21:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6738311953
	for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766420475; cv=none; b=tioUM0JcXnEWW11tXLhx3aOr28Fcg+iXGM7YCHNMtdIK22f+Qpdv2pAGDbK1mIj8YQnrzbVUru8FQgNzpBBH9XpRbPwJGtwPFJqBfTB4Ng77YYjjrnFnBA9HCfLLDE80gbzpFyYRn12ElG4PeDVKRyV/IzqxLeXComcc9dNqrJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766420475; c=relaxed/simple;
	bh=RHfkqee+3g9nSYlyyUZ23eocZzUqzMj5vznMA7wzwQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7Q8NmKqVJ2wltD+EQ+zXglhHKcLcdJyGN5EqeOylLMh6P7fsjsGL0iWZHt5T9X4nh28Yuxt7h30gBzPaf/xmeUFn3pHSjLusLZMqidnYoBpWQWtBp60dJGjS71UCyR5TtQo9uNsVhi4UuV+7CRB2v3FkIpZkkYeA6IaYclExAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vXieU-0006q9-Kk; Mon, 22 Dec 2025 17:20:54 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vXieS-006xlV-3D;
	Mon, 22 Dec 2025 17:20:53 +0100
Received: from pengutronix.de (2a02-8206-24fb-1700-38f4-91de-2aaa-7f2a.dynamic.ewe-ip-backbone.de [IPv6:2a02:8206:24fb:1700:38f4:91de:2aaa:7f2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 50FAD4BCF51;
	Mon, 22 Dec 2025 16:20:52 +0000 (UTC)
Date: Mon, 22 Dec 2025 17:20:49 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ondrej Ille <ondrej.ille@gmail.com>
Cc: Andrea Daoud <andreadaoud6@gmail.com>, 
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	netdev@vger.kernel.org
Subject: Re: ctucanfd: possible coding error in
 ctucan_set_secondary_sample_point causing SSP not enabled
Message-ID: <20251222-kickass-oyster-of-sorcery-c39bb7-mkl@pengutronix.de>
References: <CAOprWotBRv_cvD3GCSe7N2tiLooZBoDisSwbu+VBAmt_2izvwQ@mail.gmail.com>
 <CAA7ZjpY-q6pynoDpo6OwW80zd7rq3dfFjQ1RMGzJR4pKSu7Zzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ialxhezysaxggjo"
Content-Disposition: inline
In-Reply-To: <CAA7ZjpY-q6pynoDpo6OwW80zd7rq3dfFjQ1RMGzJR4pKSu7Zzg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--4ialxhezysaxggjo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: ctucanfd: possible coding error in
 ctucan_set_secondary_sample_point causing SSP not enabled
MIME-Version: 1.0

On 22.12.2025 16:51:07, Ondrej Ille wrote:
> yes, your thinking is correct, there is a bug there.
>
> This was pointed to by another user right in the CTU CAN FD repository
> where the Linux driver also lives:
> https://github.com/Blebowski/CTU-CAN-FD/pull/2
>
> It is as you say, it should be:
>
> -- ssp_cfg |=3D FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x1);
> ++ ssp_cfg |=3D FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x0);

This statement has no effect, as 'ssp_cfg |=3D 0x0' is still 'ssp_cfg'.
IMHO it's better to add a comment that says, why you don't set
REG_TRV_DELAY_SSP_SRC. Another option is to add create a define that
replaces 0x1 and 0x0 for REG_TRV_DELAY_SSP_SRC with a speaking name.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4ialxhezysaxggjo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlJb9gACgkQDHRl3/mQ
kZyzfgf/SfPB5HD+R0CUspItF3HhUjEbcFL919kOplwJYBtTpw8OeoZWx8KK7EzU
YLlJ/pxBOqgvWRaS04/T8mER+4uyzO3XXM06HIH6+weo86uDLSBm5PhVatgsxKD7
QcDTaw2WNZk78tb+yyMZjQwAoSXIQyFNpM8S/zQYLLoBYygssJXx5AipPdiFFUS2
IhnFhYFXToQ1XsbHC2Ec0w/Ombsdf5N0ZGb7kyb11ldtEocnLc2UA11XlF70Sqwb
vSvIK1wA4fbnAObjtICQD4np3VqeaHeRqr+eEizkUIOjj6YJ8mIcaFPIAF6QqQfR
nDMy7OjY1M2cLhiDyC7CrJdjWNZC6w==
=F78G
-----END PGP SIGNATURE-----

--4ialxhezysaxggjo--

