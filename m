Return-Path: <linux-can+bounces-7150-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NB5A3H5u2llqwIAu9opvQ
	(envelope-from <linux-can+bounces-7150-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 14:26:09 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA852CBF12
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 14:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD433305F48F
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 13:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D473D5223;
	Thu, 19 Mar 2026 13:23:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5F3D47BE
	for <linux-can@vger.kernel.org>; Thu, 19 Mar 2026 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926624; cv=none; b=jGYc24mC0wbhAq0reN6b/HHlcKuBMq9fQEP0rTbq0hReO15RTrF3nnZ6yOT5e2Kf5EVthR+d24YtvRVxpW1pbEHDRiHrN1tk/YlA07oNV0RcF3Gtsy5f33cjgrgO0LL8F/FBmcvDmh/kOnSpsMteK6STJDpH9gj/JViDsDfAqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926624; c=relaxed/simple;
	bh=uNW6BjilSvE+bR0GNtRXXctuv2crWCYxzr3GteCa+Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j77uqNb43zt69Rlnofqj9YI74iciDaET3nMaUYlLM4wjedXi7Ty0EH/IeVkREyMuwKHXXpJ9/UvjVNlHY1h3m+TRPlcy3hOxhBAQ6ZtLBGVQKJEC2CBETeXkNQxHcQjHcNOPpcueXYxT9YZSPe3jFXuJzljjXf15bEXlg+04xWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3DLe-0006DC-Ei; Thu, 19 Mar 2026 14:23:38 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3DLd-0015FW-2A;
	Thu, 19 Mar 2026 14:23:37 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6263E5084BE;
	Thu, 19 Mar 2026 13:23:37 +0000 (UTC)
Date: Thu, 19 Mar 2026 14:23:37 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, stable@vger.kernel.org, 
	Ali Norouzi <ali.norouzi@keysight.com>
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
Message-ID: <20260319-upbeat-urban-reindeer-5da5c2-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260318165120.17560-1-socketcan@hartkopp.net>
 <20260318165120.17560-2-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4nq2tczzse4w3sfi"
Content-Disposition: inline
In-Reply-To: <20260318165120.17560-2-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7150-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.710];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url,keysight.com:email]
X-Rspamd-Queue-Id: 7EA852CBF12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--4nq2tczzse4w3sfi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
MIME-Version: 1.0

On 18.03.2026 17:51:20, Oliver Hartkopp wrote:
> isotp_sendmsg() uses only cmpxchg() on so->tx.state to serialize access
> to so->tx.buf. isotp_release() waits for ISOTP_IDLE via
> wait_event_interruptible() and then calls kfree(so->tx.buf).
>
> If a signal interrupts the wait_event_interruptible() inside close()
> while tx.state is ISOTP_SENDING, the loop exits early and release
> proceeds to force ISOTP_SHUTDOWN and continues to kfree(so->tx.buf)
> while sendmsg may still be reading so->tx.buf for the final CAN frame
> in isotp_fill_dataframe().
>
> The so->tx.buf can be allocated once when the standard tx.buf length needs
> to be extended. Move the kfree() of this potentially extended tx.buf to
> sk_destruct time when either isotp_sendmsg() and isotp_release() are done.
>
> Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
> Cc: stable@vger.kernel.org
> Reported-by: Ali Norouzi <ali.norouzi@keysight.com>
> Co-developed-by: Ali Norouzi <ali.norouzi@keysight.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

AI-bot

| https://netdev-ai.bots.linux.dev/ai-review.html?id=3D19f0e15f-5d42-43a4-a=
9e1-632cf3d9182c

suggested:

Fixes: 96d1c81e6a04 ("can: isotp: add module parameter for maximum pdu size=
")

which makes sense.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4nq2tczzse4w3sfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabv41gAKCRDMOmT6rpmt
0pwpAQDnDRnwd0DUF3Tf0GAN9HmBjoQLHY2lU95VLL9kDWeatgD/Q7RBk8/wlAMa
j3n++K2IoNZZsM9erIICgFmg9tS0ugE=
=Vw7Z
-----END PGP SIGNATURE-----

--4nq2tczzse4w3sfi--

