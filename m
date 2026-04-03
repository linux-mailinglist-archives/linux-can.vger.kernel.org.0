Return-Path: <linux-can+bounces-7336-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKmHORAy0Gl84gYAu9opvQ
	(envelope-from <linux-can+bounces-7336-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Apr 2026 23:33:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2563739875B
	for <lists+linux-can@lfdr.de>; Fri, 03 Apr 2026 23:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7FB3301FA68
	for <lists+linux-can@lfdr.de>; Fri,  3 Apr 2026 21:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB3D5477E;
	Fri,  3 Apr 2026 21:33:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C872344D9A
	for <linux-can@vger.kernel.org>; Fri,  3 Apr 2026 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775251981; cv=none; b=GBvHW+MNV6IHqG8SwOLgPb5he2oCHxS8cEiIhzSiXLGsFO/RjBihKFZBtfPLkhF9v7Dxxp7Qkgn5V7uT9/bhZ6dfJ06yhXt4tzIGpc9YTCg9IFnNZAo7PArWcM4UYKKNWHo7LpuDS938rfzJxnd86HWk5q2xV3xCTY6yyRqPv7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775251981; c=relaxed/simple;
	bh=q0skMoj4lowvz9CgQTgicdnHcJRomybp/YTqiW7C3yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqwRoWAdOG/OJ438usEI20JhTaSASHal2cOf6PI7rC6a6ZiS1EH06YZ+NvF66YjdHVCN2Rt9/FbG+q5jD2bYpFuY+60qwQk1Kro4RysOfPgUbj9spfaQHfPHh4aN0ivoHg5iJovvPHpDiH7f+tbWK95DIPCKo9KtD/whb12fJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w8m8H-0003EF-09; Fri, 03 Apr 2026 23:32:49 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w8m8G-003azb-1Q;
	Fri, 03 Apr 2026 23:32:48 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:1016:1:2db7:52be:76a6:e1b2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E89845154C4;
	Fri, 03 Apr 2026 21:32:47 +0000 (UTC)
Date: Fri, 3 Apr 2026 23:32:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju <biju.das.au@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 3/3] can: rcar_canfd: Handle Bus-Off recovery interrupt
Message-ID: <20260403-accelerated-resilient-lemming-963c0c-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260403095003.104542-1-biju.das.jz@bp.renesas.com>
 <20260403095003.104542-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jrijzultlcfafkn2"
Content-Disposition: inline
In-Reply-To: <20260403095003.104542-4-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,bp.renesas.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-7336-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.462];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 2563739875B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--jrijzultlcfafkn2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] can: rcar_canfd: Handle Bus-Off recovery interrupt
MIME-Version: 1.0

On 03.04.2026 10:50:00, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add handling for the Bus-Off recovery interrupt in the error handler.
> When the channel bus-off recovery interrupt is received, transition the
> CAN state back to CAN_STATE_ERROR_ACTIVE to reflect that the controller
> has successfully recovered from a bus-off event.

This looks wrong, better change the CAN state in
rcar_canfd_state_change(), so that can_change_state() is called and the
user gets informed.

BTW: The transition to bus-off should also be done via this function for
the same reason. This would be a proper fixes patch, that should go in
first.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jrijzultlcfafkn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCadAx4QAKCRDMOmT6rpmt
0njlAQC4ZbhVnjZzuI2iICK9xP0FCpibrmA2l2qjufRhemr/JgD/Z17p/Gj15QLb
1rZSmnqn2T9VPPUcaP5I00ZX2FxLlgw=
=/Pjg
-----END PGP SIGNATURE-----

--jrijzultlcfafkn2--

