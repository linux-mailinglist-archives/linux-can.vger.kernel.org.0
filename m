Return-Path: <linux-can+bounces-8369-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wXFAJyb6VWoQxQAAu9opvQ
	(envelope-from <linux-can+bounces-8369-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 10:58:14 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BD07529E8
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 10:58:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8369-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8369-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27E36301991A
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE3F43B494;
	Tue, 14 Jul 2026 08:57:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B7143B4A6
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 08:57:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019469; cv=none; b=jgUEIFt3mY7DcpACsXF80J51ppvjuWLxEu1T2dGsfip3A3TVDipm9QiTqAeH2lAeCt0yI88CmCPbDonDZpCuDmT/h7tDw2A49ipoh0e03LdRZcZGMDckH8OWSUT37sYVtinCaTRN9pYbm4YYZ7ij42sO9/rV5kCLZw82vGBNL4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019469; c=relaxed/simple;
	bh=3yLT0AaNYK2nW4ISnNaJjamMnClHH+lnjWVIh112V0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5OMis9iCoh70e7CiQef5qpNiIogZDgcEkpdIw5at2tSUSZtn3TvxxXmXUlb6ZIXEwKR+unbMCOPuDitjcLPt3xRuxnmODzv/9m6D1052d7qHZOSI17CBXricVmLfNKsysxNnGuWWDvtB+TJnjTuYiVOqXSlkZXMm6xbCr+7Ro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A32B4202203;
	Tue, 14 Jul 2026 10:57:44 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wjYxU-001k67-1p;
	Tue, 14 Jul 2026 10:57:44 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D99165686BC;
	Tue, 14 Jul 2026 08:51:04 +0000 (UTC)
Date: Tue, 14 Jul 2026 10:51:04 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: mailhol@kernel.org, linux-can@vger.kernel.org, 
	Alexander =?utf-8?B?SMO2bHps?= <alexander.hoelzl@gmx.net>
Subject: Re: Weekly net upstream? - Re: [PATCH] vxcan: fix Kconfig
 description stating no local echo provided
Message-ID: <20260714-vole-of-sheer-leadership-1bf399-mkl@pengutronix.de>
References: <20260619090035.17769-1-alexander.hoelzl@gmx.net>
 <1f3a3c0d-71a6-4c7d-9e08-5e19f1999af2@hartkopp.net>
 <ef991c9b-276d-44e9-a48c-7bf52f69ea0a@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wnjuh664akrie766"
Content-Disposition: inline
In-Reply-To: <ef991c9b-276d-44e9-a48c-7bf52f69ea0a@hartkopp.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,pengutronix.de:url,pengutronix.de:from_mime,pengutronix.de:mid];
	TAGGED_FROM(0.00)[bounces-8369-lists,linux-can=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmx.net];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:alexander.hoelzl@gmx.net,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9BD07529E8


--wnjuh664akrie766
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Weekly net upstream? - Re: [PATCH] vxcan: fix Kconfig
 description stating no local echo provided
MIME-Version: 1.0

On 14.07.2026 08:55:32, Oliver Hartkopp wrote:
> I would be glad if you could upstream this patch together with the now
> sashiko-approved fixes for can-bcm and can-isotp:
>
> https://lore.kernel.org/linux-can/20260712-isotp-fixes-v10-0-793a1b1ce17f=
@hartkopp.net/

If I understand you correctly, you say that the issue sashiko claims to
be in patch 3 (mid:20260712181155.B42EA1F000E9@smtp.kernel.org):

>> [High] Lockless state transition in the timeout handler creates a
>> race condition that causes timeout errors to be silently dropped or
>> misattributed, leading sendmsg() to erroneously return success for
>> timed-out transfers.

is a preexisting problem?

> https://lore.kernel.org/linux-can/20260709-bcm_fixes-v12-0-61c06291bf1c@h=
artkopp.net/

Can you clarify these claims:

https://lore.kernel.org/all/20260709203552.D473D1F00A3D@smtp.kernel.org/
https://lore.kernel.org/all/20260709204058.5BEED1F000E9@smtp.kernel.org/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wnjuh664akrie766
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCalX4dQAKCRDMOmT6rpmt
0t3KAP0ZB6RygrvWgxW4h1BvtVykhLcXF7oRkhgdmIxcqwCZMgEAnMhIe2vOc4Er
OcxA3sKF8JkXZF6/RwgEDbxWJsCn5w4=
=E98S
-----END PGP SIGNATURE-----

--wnjuh664akrie766--

