Return-Path: <linux-can+bounces-6287-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJFzCtaGc2krxAAAu9opvQ
	(envelope-from <linux-can+bounces-6287-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 15:33:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB89771E4
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 15:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAA7730263F6
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA0930EF9D;
	Fri, 23 Jan 2026 14:31:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F972E6CD0
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178710; cv=none; b=lNvMhhijWzCD6ALAsJqa2ke1sCxJ5B4DxtLmmQRs0CmGxD385eVk6X8stS4MHnpCAX/JKRCv7QBdvxrqPrYY9l9849EqIhPK2EcoeZVtPS3ymV6tmPXoMiYqAfGVGbFrcgNEbJVSOW82or6ZRmcYhfNLiFSkaxHcebZe+NTWNH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178710; c=relaxed/simple;
	bh=u02GwXRx/A0WC6Ue1VfSCIyv/rMheYFfEMb6OK12mM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EItKPdzoSmhmI0y/M6U5oz+zWhjmKYULcxkj+4H+K8kZJeL7rdd4mVhOomQZvz5tu5e9o/CLxl9WkLa0xt0aJ1JnX/XEZCGuF+0xU1U7si3zv3pPep8KOWG+4afQ4fhFFlDSJNa6hHH8Ovlv2WYjbnZg1y+LXcMnvz/M6nGlJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjICF-0004yp-Il; Fri, 23 Jan 2026 15:31:35 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjICE-0026nL-0E;
	Fri, 23 Jan 2026 15:31:33 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 252E54D6FA7;
	Fri, 23 Jan 2026 14:31:33 +0000 (UTC)
Date: Fri, 23 Jan 2026 15:31:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: mailhol@kernel.org, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, linux-can@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] can: at91_can: Fix memory leak in at91_can_probe()
Message-ID: <20260123-hospitable-chinchilla-of-ampleness-3a3dc9-mkl@pengutronix.de>
References: <20260122114128.643752-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3jpayozdp2hz6erm"
Content-Disposition: inline
In-Reply-To: <20260122114128.643752-1-zilin@seu.edu.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6287-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DB89771E4
X-Rspamd-Action: no action


--3jpayozdp2hz6erm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: at91_can: Fix memory leak in at91_can_probe()
MIME-Version: 1.0

On 22.01.2026 11:41:28, Zilin Guan wrote:
> In at91_can_probe(), the dev structure is allocated via alloc_candev().
> However, if the subsequent call to devm_phy_optional_get() fails, the
> code jumps directly to exit_iounmap, missing the call to free_candev().
> This results in a memory leak of the allocated net_device structure.
>
> Fix this by jumping to the exit_free label instead, which ensures that
> free_candev() is called to properly release the memory.
>
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
>
> Fixes: 3ecc09856afb ("can: at91_can: add CAN transceiver support")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3jpayozdp2hz6erm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlzhkEACgkQDHRl3/mQ
kZx03ggAi3E2w9AI+DGs2tOuxHVLebgXoSpPUUIuIxhn8tXnC2AcMmA7SYWzCIQS
iltOSOnHrEkAMJ3Bc9OoX2i0URUhLx2GKqWe85nr4p8h45RMdIBQ3pvd9IQA+Fvw
0S3nVDlIlKiAWHTqhr2EsvYk9ScFKiycAkMnIF/kukQBHGA4ehtwpB0rwUBnFTz1
nctCk9n51pMUF6tDNCtWOmuEY4hIrGC/FEDA8W3TNSmm/Va/1gDyHpkLCAxUvOUj
/JhfcilvS2wvFADf9DgsQGSvh8qGhJ8XRHOQD+PllWJlD3VLc/BgxQZMJ2kVb77p
qx1a4m95wMVNIY4NO9gYv/ASK9lyZA==
=PTx7
-----END PGP SIGNATURE-----

--3jpayozdp2hz6erm--

