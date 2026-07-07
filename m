Return-Path: <linux-can+bounces-8088-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NDwzIz8TTWqqugEAu9opvQ
	(envelope-from <linux-can+bounces-8088-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 16:54:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F218C71CE44
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 16:54:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8088-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8088-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D55EF30BDEEE
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81330426423;
	Tue,  7 Jul 2026 14:38:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8290942A151
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 14:38:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435134; cv=none; b=Ga3KZ+iMUDr2dqYw1LWOnEGpCfJXrvBU2s/y2NpODuaoKReQd64lTrVeA+TvV8zXmC3kv93wSYC7pdA+aRcIF7TvW/DAbSTbNIdY85oOuP+qyF+YuA7fkqwm2IdiE2ANrKKWwMxuTsgShpj7wgatGrYZ3iJGU+NnzO1F/q0FvhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435134; c=relaxed/simple;
	bh=5Y0OPEMWm/GmNtMQmTEV/oB6MF5OuOALUtsyLmBM9Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU2ueM6vU4nIEbWIixh8Yn5myF/0AqZvUTEZbRGl1G2GSog2DsuiV1Q8PLXzqgoqtx6zT/99rmF8UpCogNM+hdHiiu5IYGMjNRrNx7/cuF/siZuvn5abh4ZXBJ3Y5bRO92uN7ZIWlzWk398MnuJcedGS6EQngwmNBscINX7TivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 459BE201CD7;
	Tue, 07 Jul 2026 16:38:49 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wh6wj-000bCL-0c;
	Tue, 07 Jul 2026 16:38:49 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E8D0D5625E5;
	Tue, 07 Jul 2026 14:38:48 +0000 (UTC)
Date: Tue, 7 Jul 2026 16:38:48 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v4 6/7] can: bcm: extend bcm_tx_lock usage for data and
 timer updates
Message-ID: <20260707-legendary-beagle-of-joy-6ab722-mkl@pengutronix.de>
References: <20260707-bcm_fixes-v4-0-aa87b8b9d33f@hartkopp.net>
 <20260707-bcm_fixes-v4-6-aa87b8b9d33f@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ome6wnqeesdjuldg"
Content-Disposition: inline
In-Reply-To: <20260707-bcm_fixes-v4-6-aa87b8b9d33f@hartkopp.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8088-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devnull+socketcan.hartkopp.net@kernel.org,m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[pengutronix.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,socketcan.hartkopp.net];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,pengutronix.de:from_mime,pengutronix.de:url,pengutronix.de:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F218C71CE44


--ome6wnqeesdjuldg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 6/7] can: bcm: extend bcm_tx_lock usage for data and
 timer updates
MIME-Version: 1.0

On 07.07.2026 16:32:18, Oliver Hartkopp via B4 Relay wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
>
> Stage new CAN frame content for an existing tx op into a kmalloc()'d
> buffer and validate it there, mirroring the approach already used in
> bcm_rx_setup(). Only copy the validated data into op->frames while
> holding op->bcm_tx_lock, so bcm_can_tx() and bcm_tx_timeout_handler()
> can no longer observe a partially updated or unvalidated frame.
>
> Add a missing error path for memcpy_from_msg() when copying CAN frame
> data from userspace.
>
> Also move the kt_ival1/kt_ival2/ival1/ival2 updates in bcm_tx_setup()
> under op->bcm_tx_lock, and read kt_ival1/kt_ival2/count under the same
> lock in bcm_tx_set_expiry() and bcm_tx_timeout_handler(), closing the
> torn 64-bit ktime_t read on 32-bit platforms.

Can you please update the comment for struct bcm_op::bcm_tx_lock, it
still reads: /* protect currframe/count in runtime updates */

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ome6wnqeesdjuldg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCak0PdgAKCRDMOmT6rpmt
0qSbAP41DUEixUi0h5GqssyZ+sd/grM142T3wVCGUAqVhcVOBQEAimQR0RmEV0aY
rypbH8m18f4Ml6M6uTRELsbVNcnuiwU=
=B2RA
-----END PGP SIGNATURE-----

--ome6wnqeesdjuldg--

