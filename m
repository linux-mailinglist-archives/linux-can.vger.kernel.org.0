Return-Path: <linux-can+bounces-6387-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBMiG9YBe2n9AQIAu9opvQ
	(envelope-from <linux-can+bounces-6387-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 07:44:38 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D08A1AC4E1
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 07:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F0443004DAE
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 06:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CF92F3C19;
	Thu, 29 Jan 2026 06:44:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E82E888A
	for <linux-can@vger.kernel.org>; Thu, 29 Jan 2026 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769669072; cv=none; b=uobV2O8CsIzYZ35caTQg4Xi2HSCiLqMHhTrbHwZzWxmh4H/E8/zVE8KFM5y66SEtr9yHDfs20de25LshBGBberu3yf21imX6Zx62/qRI47u0+bFturWq60HwlYmSOxW546hts6Tl1IrmVhiugxeeiFtFkspdd6yIXY7bi/oy2JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769669072; c=relaxed/simple;
	bh=mXmrwsGmQmX7MW8fFkOdMv3Rg0g8EnYtGIgJRk6I23w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNc0z81xRAarf6rsefX5w17SqB1Z8INoNP7R+1sUeUl5e2j9cPREDBOSufocUIpFzBTxroDpBypzXW7Qp/rQS+Fkyn3H/HUFQKHzTErrx4fI39FhxkmWCXLklZpRCH3m2ZWoiuMYBbXim3QSfRT3MOJttVZyFDml7To+3JwO0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlLlS-0007KF-HR; Thu, 29 Jan 2026 07:44:26 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlLlS-0032gZ-2l;
	Thu, 29 Jan 2026 07:44:26 +0100
Received: from pengutronix.de (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D5B314DADAE;
	Thu, 29 Jan 2026 06:44:25 +0000 (UTC)
Date: Thu, 29 Jan 2026 07:44:25 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
Message-ID: <20260129-versatile-tuscan-mongrel-f9b173-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
 <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3b6m56hj4sgwdimi"
Content-Disposition: inline
In-Reply-To: <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6387-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D08A1AC4E1
X-Rspamd-Action: no action


--3b6m56hj4sgwdimi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
MIME-Version: 1.0

On 28.01.2026 10:07:13, Marc Kleine-Budde wrote:
> I'll do. In the mean time, please have a look at b4, it has support for
> sending patches via a web hook.

Hooray for switching to b4!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3b6m56hj4sgwdimi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml7AcYACgkQDHRl3/mQ
kZxaSgf+Mb5ckRX1ZZWduW3yXGxqrmzOAGB4FMC3FJzi6dl+brC5j7IEs4KH0hch
wxfb8/UI0iLHKHcB88Rolxpb6dcXtpILHTpQI3VrMz4EdL0x0/aw20UsDyf9JiMS
ah/YcWjvcBBLR6Hz3YK93RzhDOO+fyf08o9xUcZr04HBXKlT0jKLr+mc2PLehfut
0JiZdWhs8mcteXg++JNZrvE93qv8tcrvEziDSgWutGY3bCY65OZFVJwKplzI0SX0
ZAzVV8hI8As0WYGLEpI/qu/AlkcsYk5fVUTAotCgp8dduS7WjfKMZJYI1x2jtDyn
XPMncei0fMtsCFSU3kQOo1bGBPXXhQ==
=EKea
-----END PGP SIGNATURE-----

--3b6m56hj4sgwdimi--

