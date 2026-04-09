Return-Path: <linux-can+bounces-7358-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PbVKFfV12lZTggAu9opvQ
	(envelope-from <linux-can+bounces-7358-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Apr 2026 18:35:35 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E303CDB30
	for <lists+linux-can@lfdr.de>; Thu, 09 Apr 2026 18:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DF033006D45
	for <lists+linux-can@lfdr.de>; Thu,  9 Apr 2026 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624CE364E8B;
	Thu,  9 Apr 2026 16:35:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA0333F58B
	for <linux-can@vger.kernel.org>; Thu,  9 Apr 2026 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752530; cv=none; b=nKuKNVDkKJmQ+obGQPGIKkhQng501YI17F3J/rNtBjDlC+39NylFsZMoYg692phYrbDMCaCJfcEdOruZrYbCzObqXDrwbh9VLdW8yh2OrxTZOxbFzpGfMmzDpQmClTc82hj6NEqBv2Mafsgd+xdIIunlv8imbPxyHoYvv6Fb4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752530; c=relaxed/simple;
	bh=f2+Ov9I0QMumTDERg1B1djauh9hMnOKfRKKUYfjt9Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0VBvxHOXsVRE58dz9/pnh2C3fyqgmMPR1mRpgVoYJfsVWjn1SA+kZeHfg3kZlf7cE/vxtL8xG+1BqcpuCKAG/Un/RrCEON03LJf3l2w+a1t2qfdwL2+orhMgODxlTaxMM6VKmAnRviIWkZ6xAdTMundGiiyHFalHH9ZJFPFUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wAsLk-0007Db-Ie; Thu, 09 Apr 2026 18:35:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wAsLk-004YDR-0b;
	Thu, 09 Apr 2026 18:35:24 +0200
Received: from pengutronix.de (ip-185-104-138-116.ptr.icomera.net [185.104.138.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 80F34518B04;
	Thu, 09 Apr 2026 16:35:23 +0000 (UTC)
Date: Thu, 9 Apr 2026 18:35:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Sam P <sam@bynar.io>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH net] can: raw: fix ro->uniq use-after-free in raw_rcv()
Message-ID: <20260409-generous-bronze-prawn-71138a-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <26ec626d-cae7-4418-9782-7198864d070c@bynar.io>
 <4fe2b2fd-e3f3-445f-9e06-411bfd9dd906@hartkopp.net>
 <1b7e62a3-a63c-4d0b-9d12-7dfc986bde05@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xuab3hb6webbgjl6"
Content-Disposition: inline
In-Reply-To: <1b7e62a3-a63c-4d0b-9d12-7dfc986bde05@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-7358-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 95E303CDB30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--xuab3hb6webbgjl6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: raw: fix ro->uniq use-after-free in raw_rcv()
MIME-Version: 1.0

On 09.04.2026 17:40:33, Oliver Hartkopp wrote:
>
>
> On 08.04.26 21:32, Oliver Hartkopp wrote:
> > On 08.04.26 16:30, Sam P wrote:
>
> > > Fixes: 514ac99c64b2 ("can: fix multiple delivery of a single CAN
> > > frame for overlapping CAN filters")
> > > Cc: stable@vger.kernel.org # v4.1+
> > > Assisted-by: Bynario AI
> > > Signed-off-by: Samuel Page <sam@bynar.io>

Applied manually.

> > Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>
> @mkl: The patch failed to apply as it has some text formatting errors and
> DOS line breaks.
>
> I've re-send the patch with proper formatting and included my Acked-by he=
re:
>
> https://lore.kernel.org/linux-can/20260409130814.72175-1-socketcan@hartko=
pp.net/

Without your S-o-b I cannot take the patch.

thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xuab3hb6webbgjl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCadfVMwAKCRDMOmT6rpmt
0vP2AP0QHSPADPk4cvkr59o8izEHwuxacRL4BwT4nPBsSlevsQEAmCOzizdrTIju
KFICahAfIZxBHC9U9Q6MRdt/Xh6d1AU=
=NTSO
-----END PGP SIGNATURE-----

--xuab3hb6webbgjl6--

