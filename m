Return-Path: <linux-can+bounces-7616-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MLiFxGKBGoxLQIAu9opvQ
	(envelope-from <linux-can+bounces-7616-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 16:26:25 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DDD53505A
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 16:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 425AB3086DE5
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 14:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61E13A0EB1;
	Wed, 13 May 2026 14:17:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A392391829
	for <linux-can@vger.kernel.org>; Wed, 13 May 2026 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681852; cv=none; b=ZJIDWkdMomLmmZdZqURKXN5nkbEkFNQ3/7S4KP8xCowDbV2XFGgv3eS6hnZqRWiPr2ERcVtawKccH8y2ZjUTIy4RcjRF+J8f5+tw5vKmJm0WEiaSEmc/XhTAh4bm+/blT2NlXIooVNy6d/zSfhtFazXNvCkM8ht7wDG2vccfoL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681852; c=relaxed/simple;
	bh=/BE9TG1Fk5TI3zLpfvJc5b3fl57SB+n3RbZGkVx74gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLu3ieTeGjKg2ILTFXvstlGYMnDX4iXAxQxKcqHc/E3VXo0fT3izjO3eIqWy4cchVSaLY9UZ3BXezcJyImrIuk4jjfG+1m8x68v08inMrNE1vDK5gLoYoSSVETZQmvqwVJ/5qTUX5GbY4WPpO4EX/zgX0PIHzusdKpopOeLABsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=fail smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wNAOV-0007a6-QK; Wed, 13 May 2026 16:17:03 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wNAOT-000c0f-33;
	Wed, 13 May 2026 16:17:01 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A4192535C39;
	Wed, 13 May 2026 14:17:01 +0000 (UTC)
Date: Wed, 13 May 2026 16:17:01 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Lee Jones <lee@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, 
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net 2/6] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
Message-ID: <20260513-abstract-purring-inchworm-f6daa3-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260507112321.439968-1-mkl@pengutronix.de>
 <20260507112321.439968-3-mkl@pengutronix.de>
 <20260508151237.7d0a9105@kernel.org>
 <20260513135913.GA305027@google.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qtrf4g5yl45ftvik"
Content-Disposition: inline
In-Reply-To: <20260513135913.GA305027@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 05DDD53505A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7616-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--qtrf4g5yl45ftvik
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 2/6] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
MIME-Version: 1.0

On 13.05.2026 14:59:13, Lee Jones wrote:
> On Fri, 08 May 2026, Jakub Kicinski wrote:
>
> > On Thu,  7 May 2026 10:22:24 +0200 Marc Kleine-Budde wrote:
> > > Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> > > synchronize_rcu()") removed the synchronize_rcu() call from
> > > bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> > > timers from being rearmed during deletion.  However, it only applied
> > > this check to op->timer via bcm_rx_starttimer().
> >
> > All AIs point out this is insufficient:
> >
> >     reader (bcm_rx_handler, RCU) | writer (bcm_delete_rx_op)
> >     -----------------------------+-------------------------------
> >     test op->flags (no AUTOTIMER)|
> >                                  | op->flags |=3D RX_NO_AUTOTIMER
> >                                  | bcm_remove_op()
> >                                  |   hrtimer_cancel(&op->thrtimer)
> >                                  |     /* not armed: no-op */
> >                                  | call_rcu(bcm_free_op_rcu)
> >     hrtimer_start(&op->thrtimer) |
> >     return from RCU section      |
> >                                  | grace period elapses
> >                                  | bcm_free_op_rcu() -> kfree(op)
> >     thrtimer fires               |
> >       bcm_rx_thr_handler(op)     | <-- UAF
>
> Noted.  Leave it with me and I'll follow up shortly.

Please send a new patch against net-next/main, I'll drop this one.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qtrf4g5yl45ftvik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCagSH2wAKCRDMOmT6rpmt
0tWyAQC3l2PbvtVVQNQ6aODpspmYDpaF7w5WBzZcBZa5MWG7KwEA9W628gmT8PS1
TFsQBqRDZxUWef3a8P3jxsTvyDV10ww=
=2lAk
-----END PGP SIGNATURE-----

--qtrf4g5yl45ftvik--

