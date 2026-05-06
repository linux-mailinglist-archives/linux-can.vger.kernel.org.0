Return-Path: <linux-can+bounces-7532-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BGpG6E5+2nUXwMAu9opvQ
	(envelope-from <linux-can+bounces-7532-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 14:52:49 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DCA4DA8A7
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 14:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC7A9300E385
	for <lists+linux-can@lfdr.de>; Wed,  6 May 2026 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6177441030;
	Wed,  6 May 2026 12:48:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17DA3EFD3B
	for <linux-can@vger.kernel.org>; Wed,  6 May 2026 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071688; cv=none; b=P1aEpeGIe4ZPV3O+CJecrJoMkjVQ7Y0ykeZ4ACcQvO6t7BRTBJyKhh6GO6exXh12JZFZr0Hyt1RwRszqLA2qFWwnPsdgET7x0X70G0Tl42RWf61Z4QkSvJwn8IpMB0/8Lla+F3WLgf9SoU32wzTSzxNIxDr0sRy4UPS0pNDZc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071688; c=relaxed/simple;
	bh=f+MgXWTZW7NxZnsuHMEfsC/6WJQ6yziCzw85Th9/dck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOrcNCG/2BZp8r3bWpUCZTl11MBVOwKLwaEkLJGuaIdJKJQLdXy//YumhSVDhRFFb/fwf+gXq94nCgywx4ahpJWFMcdgniF7YJGEmYKMAsgg5QinZf6N0G7lxRenJx++TQre/KfvfjPKQncuS5NZi1U3VIGfIAt90ZDV4JBHT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKbas-0001we-N5; Wed, 06 May 2026 14:43:14 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKbar-000kJ3-0T;
	Wed, 06 May 2026 14:43:13 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 49B9852F64C;
	Wed, 06 May 2026 12:43:13 +0000 (UTC)
Date: Wed, 6 May 2026 14:43:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Eulgyu Kim <eulgyukim@snu.ac.kr>
Subject: Re: [PATCH] can: raw: add locking for raw flags bitfield
Message-ID: <20260506-finicky-polite-cobra-b6112b-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260504111928.41856-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ed4ch4wkvqfhct2"
Content-Disposition: inline
In-Reply-To: <20260504111928.41856-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: C9DCA4DA8A7
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-7532-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url,hartkopp.net:email]


--6ed4ch4wkvqfhct2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: raw: add locking for raw flags bitfield
MIME-Version: 1.0

On 04.05.2026 13:19:28, Oliver Hartkopp wrote:
> With commit 890e5198a6e5 ("can: raw: use bitfields to store flags in
> struct raw_sock") the formerly separate integer values have been integrat=
ed
> into a single bitfield. This led to a read-modify-write operation when
> changing a flag in raw_setsockopt() which now needs a locking to prevent
> concurrent access.
>
> Instead of adding a lock/unlock hell in each of the flag manipulations th=
is
> patch introduces a wrapper for a new raw_setsockopt_locked() function
> analogue to the isotp_setsockopt[_locked]() approach in net/can/isotp.c
>
> Fixes: 890e5198a6e5 ("can: raw: use bitfields to store flags in struct ra=
w_sock")
> Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Tested-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied with Closes tag instead of Link after Reported-by.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6ed4ch4wkvqfhct2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCafs3XgAKCRDMOmT6rpmt
0niNAQD0Vol0XmTZe+Ojfdj645vpYmfdImfkEavwAs8fkl51HAEA/Rh9QnvYuPup
xz43TlZXvdaFQ323BaEDWyLfigC6vQM=
=5cih
-----END PGP SIGNATURE-----

--6ed4ch4wkvqfhct2--

