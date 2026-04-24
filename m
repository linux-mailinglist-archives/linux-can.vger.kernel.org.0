Return-Path: <linux-can+bounces-7399-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOmVC9DA62ngQwAAu9opvQ
	(envelope-from <linux-can+bounces-7399-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 24 Apr 2026 21:13:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ACF462B9F
	for <lists+linux-can@lfdr.de>; Fri, 24 Apr 2026 21:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FAC030401BB
	for <lists+linux-can@lfdr.de>; Fri, 24 Apr 2026 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74BD3FA5C4;
	Fri, 24 Apr 2026 19:09:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E76D3F9F5D
	for <linux-can@vger.kernel.org>; Fri, 24 Apr 2026 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057741; cv=none; b=gb4PR2M0mFB/AsrRJeonlvnSx7sTxzZ1kU53+ZtfEDAFz+JCxvwLHdmjWqfYo62eYc6/hRnfmLqtoTXH0stAliH6YBPFWtcGh0ttxJwUTb7TNfdHBEYNhluZlzjZENQo5jSLFF8G0cP/ezoU5ObjCEVVoYMgP+z5iYn5fVgDyzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057741; c=relaxed/simple;
	bh=jwMlpZF8GsjJhdUJuefzT6sJ1zypCj9hS/rSEG8CI9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIOtPpkixUZZdsnLSUS6/KVFsp/DdNpAaoqB6CJDNPg/hYzk89OUKwY7qOybeLUpTl6iTh0sNyD8yuX6JQ828tbLTyiPeupJw2DdxUlf4RIBdi6epODpK1g5T+UCPKPd6ZoDVeo4cqjvnEiRwHmeYdcW5IqMQkRAy9PnmhGrY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wGLtY-0005oW-8Q; Fri, 24 Apr 2026 21:08:56 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wGLtX-0072V0-1w;
	Fri, 24 Apr 2026 21:08:55 +0200
Received: from pengutronix.de (unknown [61.8.152.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BD7F5523E71;
	Fri, 24 Apr 2026 19:08:54 +0000 (UTC)
Date: Fri, 24 Apr 2026 21:08:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Lee Jones <lee@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
Message-ID: <20260424-magic-snobbish-rabbit-0865cf-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260422102239.948594-1-lee@kernel.org>
 <6cc6eec9-2e8a-4a39-955a-0eeefc93fe97@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="memm5zrcwuusv3if"
Content-Disposition: inline
In-Reply-To: <6cc6eec9-2e8a-4a39-955a-0eeefc93fe97@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 85ACF462B9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7399-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[]


--memm5zrcwuusv3if
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
MIME-Version: 1.0

On 22.04.2026 14:55:50, Oliver Hartkopp wrote:
>
>
> On 22.04.26 12:22, Lee Jones wrote:
> > Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> > synchronize_rcu()") removed the synchronize_rcu() call from
> > bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> > timers from being rearmed during deletion.  However, it only applied
> > this check to op->timer via bcm_rx_starttimer().
> >
> > It missed the fact that op->thrtimer can also be rearmed by an
> > in-flight bcm_rx_handler() (which runs as an RCU reader) via
> > bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
> > bcm_remove_op() has already cancelled it, leading to a use-after-free
> > when the timer fires on the deferred-freed struct bcm_op.
> >
> > Address the omission by checking the RX_NO_AUTOTIMER flag
> > in bcm_rx_update_and_send() before starting op->thrtimer, effectively
> > preventing it from being rearmed concurrently with teardown.
> >
> > Signed-off-by: Lee Jones <lee@kernel.org>
>
> Many thanks for the investigation and the fix!
>
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Can we add a Fixes: tag?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--memm5zrcwuusv3if
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaeu/wgAKCRDMOmT6rpmt
0qvgAP0YB648S+kkWC/OvsATdInDYbqTJbRTzdwFcwAY6yss8QEAp62x9syCtm+5
rkM5IoZOyAirO6Z7STglT5wnMmefvAQ=
=Urk5
-----END PGP SIGNATURE-----

--memm5zrcwuusv3if--

