Return-Path: <linux-can+bounces-7534-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD1KKNo6+2nUXwMAu9opvQ
	(envelope-from <linux-can+bounces-7534-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 14:58:02 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6674DA9C4
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 14:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 039C930094DA
	for <lists+linux-can@lfdr.de>; Wed,  6 May 2026 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D60C44A711;
	Wed,  6 May 2026 12:57:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DC3EE1C4
	for <linux-can@vger.kernel.org>; Wed,  6 May 2026 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072278; cv=none; b=dXvkAh0kpKLSvVdxywYTrurRSY8D48TYUxV6h2sk3I6UUzBl6ILX5Mn15riNaJoG7ygCX3TFuLmaB5MgQ6TKPLvjx2nSlK1InNmYBQxzmJG2p1H26T52mWsEZtEQ81iiQIkwcs9WxpayceT6Uq17Ov8MW2GHqbeDGMaeOgLd3Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072278; c=relaxed/simple;
	bh=iJbrNyxmBG2Ren5ebjdr5D28RSWvuVud3cW1gwVNeMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGTK9QfmbsgIJPYEGzz4IK0xVbFm7JPdzyEEm+3IF15tnqZ5noyHq7yM5sbL30vIlgIZNv1AYK0ntdtNKGm9g2/49qe3ZIdSQaKFtrlzzcSWP2CxPp1J5/65IK5UyXwABBdd39NKFf6o3ELnUJk2EDTYQimjftoWo01xQQhyteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKboy-0001Bt-Rc; Wed, 06 May 2026 14:57:48 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKbow-000kKL-2o;
	Wed, 06 May 2026 14:57:47 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 06EEA52F68D;
	Wed, 06 May 2026 12:57:47 +0000 (UTC)
Date: Wed, 6 May 2026 14:57:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Shuhao Fu <sfual@cse.ust.hk>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de, 
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] can: j1939: fix lockless local-destination check
Message-ID: <20260506-lorikeet-of-amusing-pride-95e7e0-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260419140614.GA4041240@chcpu16>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uvvl7zulp7ypxiqr"
Content-Disposition: inline
In-Reply-To: <20260419140614.GA4041240@chcpu16>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 1C6674DA9C4
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-7534-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


--uvvl7zulp7ypxiqr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: j1939: fix lockless local-destination check
MIME-Version: 1.0

On 19.04.2026 22:06:14, Shuhao Fu wrote:
> j1939_priv.ents[].nusers is documented as protected by priv->lock, and
> its updates already happen under that lock. j1939_can_recv() also reads
> it under read_lock_bh(). However, j1939_session_skb_queue() and
> j1939_tp_send() still read priv->ents[da].nusers without taking the
> lock.
>
> Those transport-side checks decide whether to set J1939_ECU_LOCAL_DST, so
> they can race with j1939_local_ecu_get() and j1939_local_ecu_put() while
> userspace is binding or releasing sockets concurrently with TP traffic.
> This can misclassify TP/ETP sessions as local or remote and take the wrong
> transport path.
>
> Fix both transport paths by routing the destination-locality check through
> a helper that reads ents[].nusers under read_lock_bh(&priv->lock).
>
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uvvl7zulp7ypxiqr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCafs6yAAKCRDMOmT6rpmt
0jn2AP4nU7dSWidkz09RligStZN0JTEIbNHuSAfrf1T2COKcZwD/R42YAI4Nuv8z
yYRHmIHFLMyqNrM5NzB2Dxqh3MjqCgs=
=phet
-----END PGP SIGNATURE-----

--uvvl7zulp7ypxiqr--

