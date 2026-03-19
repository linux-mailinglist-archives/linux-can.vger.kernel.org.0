Return-Path: <linux-can+bounces-7156-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAGAKqQPvGmFrwIAu9opvQ
	(envelope-from <linux-can+bounces-7156-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:00:52 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1CA2CD525
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C9DB3037D71
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD7C3DD51C;
	Thu, 19 Mar 2026 14:59:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2C3DD507
	for <linux-can@vger.kernel.org>; Thu, 19 Mar 2026 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932346; cv=none; b=KmE5GX2r9NE1CLtJzdbi9Myk7PjpBG+rCoezN8Fazh8vFi6Y79CpOTPJcx8XL98e477an0I3SF6z7WfXDlnIvkAukwFBYxotQPLRfbWirxAP9KFmm8exgcLZDU+ogLePGBvdwQNzayGJ8xUEG08klIDHwoZkM2tk9RMCGNeMXcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932346; c=relaxed/simple;
	bh=1yiXtMOcvCX5Oasflckr94JHhNuh6TB5N+lB7Jcvoio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwMfRkvrlfmUFg2Uyn3SNpOzwbwaWlj58jUXEr5SuS1dJTiDFFRxFQr997HdHtgq/rOwDSijyM2RDUsfI6xvD3fQD/3PVFFuFwMYuud7DDZlu9s1o41Bki1jr/vV4vEEqWp1npbdnmx1i3CS4Gh8TbuyooXXbHzVkKPCPkaVw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Epx-0002z4-9T; Thu, 19 Mar 2026 15:59:01 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Epw-0015pH-1K;
	Thu, 19 Mar 2026 15:59:00 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 288895085ED;
	Thu, 19 Mar 2026 14:59:00 +0000 (UTC)
Date: Thu, 19 Mar 2026 15:58:59 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, stable@vger.kernel.org, 
	Ali Norouzi <ali.norouzi@keysight.com>
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
Message-ID: <20260319-dashing-scarlet-angelfish-dfaa67-mkl@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="qkn6m7oyioj5p5vw"
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
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[keysight.com:query timed out];
	TAGGED_FROM(0.00)[bounces-7156-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RSPAMD_EMAILBL_FAIL(0.00)[socketcan.hartkopp.net:query timed out];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.601];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 4D1CA2CD525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--qkn6m7oyioj5p5vw
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

I'm missing Ali Norouzi's S-o-b. It was in the Mail that Linus Torvalds
forwarded us:

mid:CAHk-=3DwheQ2o0B_-EV5H3w=3DZZS2huESOxrvTaub_EbrbAMbgi4A@mail.gmail.com

Ali can I add you S-o-b here?

> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qkn6m7oyioj5p5vw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabwPMAAKCRDMOmT6rpmt
0kUYAQC+sdlujXTrQ8ceG5WQVSeTRLvo//6m9uYLLrurcDomfgD/dCuDwV3w/Uow
M6SQ74U7RwldFln7VLt0kwy6DFAvhgI=
=vkvB
-----END PGP SIGNATURE-----

--qkn6m7oyioj5p5vw--

