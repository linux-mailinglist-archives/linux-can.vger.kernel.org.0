Return-Path: <linux-can+bounces-6592-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGAQCG0Il2lmtwIAu9opvQ
	(envelope-from <linux-can+bounces-6592-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 13:56:13 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A02B715EC77
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 13:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A12230162AD
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 12:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6968E3382D3;
	Thu, 19 Feb 2026 12:56:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1893B3191BB
	for <linux-can@vger.kernel.org>; Thu, 19 Feb 2026 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771505769; cv=none; b=pszjLIm6S8ZvO06GEdpwgiFqdZ9wTEbXbmK4/exmHnNbY0xkCixyyLNTzaoM9iMLkafphFW6WHkygvZ4D6xoXy9fPEZ0+MIruUdrX/zPlpbftudfu80BxzWfqV00EEWYe5Z3zMGOLll4KiUnjwv4Sc8WnovA8v6xjEEIYvG4oaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771505769; c=relaxed/simple;
	bh=ivKbjAmyhrQ7tGdaiyTQlleEfdJbW4IRCe3X66s5/os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PC99LgYaljYv2wse4wcl4rtmyU7s0avjyBwxFQ0SGpjpjejQ6crVFPUQ9LC+0MFvTffbiFQhIs+GM3MWZy1MwbN7Hgl1DDZRci7msw4yupr7h2blkZ4vGH/xgd1zIodE0pd1JAoa9ACJV5ei1cKN+6YzFZyyB0fYgSse2VizCsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vt3Zd-0007yT-Fr; Thu, 19 Feb 2026 13:56:05 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vt3Zb-001a1m-2u;
	Thu, 19 Feb 2026 13:56:05 +0100
Received: from pengutronix.de (ip-185-104-138-130.ptr.icomera.net [185.104.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 882814EC316;
	Thu, 19 Feb 2026 12:56:04 +0000 (UTC)
Date: Thu, 19 Feb 2026 13:55:50 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH] can: bcm: fix locking for bcm_op runtime updates
Message-ID: <20260219-thistle-ocelot-of-courtesy-993832-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260218-bcm_spin_lock_init-v1-1-592634c8a5b5@hartkopp.net>
 <bd8fa6fc-3858-4b55-b186-aa5c773e19fa@hartkopp.net>
 <20260219-dancing-waxbill-of-purring-f94271-mkl@pengutronix.de>
 <77eacdb9-54c4-49a1-a4e3-1cd26ee1623f@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3drxvzrap7zb7udw"
Content-Disposition: inline
In-Reply-To: <77eacdb9-54c4-49a1-a4e3-1cd26ee1623f@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6592-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A02B715EC77
X-Rspamd-Action: no action


--3drxvzrap7zb7udw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: bcm: fix locking for bcm_op runtime updates
MIME-Version: 1.0

On 19.02.2026 13:53:05, Oliver Hartkopp wrote:
> > Ok - Please test your with LOCKDEP enabled.
>
> Yes. I enabled it since a while.

Good!

> Btw. I'll do some tests today. The code is really easy to understand and
> I've discussed it with Google AI ;-)
>
> Let's see what the Patchwork AI will tell.
> Would it make sense to add some more automatic checks to our new patchwork
> instance like we have for netdev?

Yes, feel free.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3drxvzrap7zb7udw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaZcIUwAKCRDMOmT6rpmt
0rv1AQCdINHKG1cTPP3WIebcFCa5n9wKhju8o8R829LXHyvdCgD/cpSogcijcEet
iHLsNxERbvn/LV7lA1lmkkiY1fY4UAk=
=8NsI
-----END PGP SIGNATURE-----

--3drxvzrap7zb7udw--

