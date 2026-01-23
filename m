Return-Path: <linux-can+bounces-6279-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P1VAkt6c2mowAAAu9opvQ
	(envelope-from <linux-can+bounces-6279-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 14:40:27 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F16276673
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 14:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EE3430252B2
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705461A262D;
	Fri, 23 Jan 2026 13:40:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03B30AAD8
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175624; cv=none; b=T4msbAB6IaNG6ntjGrytMWHD5V9oUtHB0drFiClsO9tYEJGe2EOIPLbG5Ky2DeAWy5oXIUgJhHAFS5bTgjpEC2fpxuuZ+4HsNE1qMLvu4aoRpMXo7VToKUOCfg3i8iyNaL2FAD7zWcP7FIHn6NJsg1gthzeWUlDJE554I0KIZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175624; c=relaxed/simple;
	bh=bHhN/X83Kg5ZF3/XElyrTHU4tvAipP8W3O53B/ms7N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/k6hBE3M6fMvAnzAGlqBBihZfcFCWqXQafhPaotrxXy77UN8jFk+z9hoKLkCnLuS4gUN+Yc+yq1UOZSxodPSpXnridFDIAsHfrJfRF3P4gf5VhTIkfCOqIlq/oRsT//wp+ZuTtOYOjEIMcUZfeqCZuDGts7W5X2NZUdfFK0o/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjHOc-0006TK-Ke; Fri, 23 Jan 2026 14:40:18 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjHOc-0026It-1p;
	Fri, 23 Jan 2026 14:40:17 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 93C324D6F04;
	Fri, 23 Jan 2026 13:40:17 +0000 (UTC)
Date: Fri, 23 Jan 2026 14:40:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
	Michael Tretter <m.tretter@pengutronix.de>
Cc: Achim Baumgartner <abaumgartner@topcon.com>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH can-next v2 0/2] can: sja1000: clean up CAN state handling
Message-ID: <20260123-crouching-woodlouse-of-defiance-7f6aa5-mkl@pengutronix.de>
References: <20260123-sja1000-state-handling-v2-0-687498087dad@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hizeqaccdesa32ix"
Content-Disposition: inline
In-Reply-To: <20260123-sja1000-state-handling-v2-0-687498087dad@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6279-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 7F16276673
X-Rspamd-Action: no action


--hizeqaccdesa32ix
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v2 0/2] can: sja1000: clean up CAN state handling
MIME-Version: 1.0

On 23.01.2026 11:16:25, Marc Kleine-Budde wrote:
> The CAN controller triggers an EPI interrupt when it enters the error
> passive state or transitions back to error active. Rather than tracking
> state in the driver, the CAN controller state should be derived from the
> TX/RX error counters using can_state_get_by_berr_counter().
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hizeqaccdesa32ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlzejwACgkQDHRl3/mQ
kZzAxAf6A1Y0/5ovSAzmvNmqBdegR4wBeHQQOzx8j2tLSHa6GBceTnturZgNATQU
B6HOOrmgX9VgrHbW2HAJUspzQVPBKUceIR1IfG1imx+C+tkFioO9Ni/FU03BkdRh
Ax1+g5zUNVpsGaugs+5PHsqE6lyhpTPpSsuvJBEX/D0nl1boXwxK0xcCbjqarlxA
V5HHscYVSmlxPC5CWH4rTr0fZdbG+BmfXCrq+IwHVfN78PqhckxuocR5wVj189+D
jvGtAO1ImjHmQGIBTcDsaPYn6eTDH6kXm0gUp3cpgI1sSI0/wfpXc3Xli0zMGlyi
aRotfO2ZkLH2uyc0SPChdyxCliEuiQ==
=FIOY
-----END PGP SIGNATURE-----

--hizeqaccdesa32ix--

