Return-Path: <linux-can+bounces-7531-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C/+GuM3+2nUXwMAu9opvQ
	(envelope-from <linux-can+bounces-7531-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 14:45:23 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2FD4DA6CC
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 14:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D19930078B3
	for <lists+linux-can@lfdr.de>; Wed,  6 May 2026 12:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A1B44D682;
	Wed,  6 May 2026 12:45:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B93A44D685
	for <linux-can@vger.kernel.org>; Wed,  6 May 2026 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071521; cv=none; b=jc+FD1HZQYdnZtIkpcpOEORbZWrEcF++sGhDQstWW3jnBY/nMPGUYkcBb1y/r6LV6IfKuIoqMxZhpVfT2ZgmF/jxgkfQpjy/kZ7m2G5p5hMWcvICvsdiK2vxK1yyDVu6UGpcol7S70vdCxaDTa85gqUMZhnBikyiEfQm+9Ct2S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071521; c=relaxed/simple;
	bh=NWovB+LCIxLhpw/65Db564/20c1STyUwksIxlP1/Td8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyRURsZQaLkJS78+G+F54PsPyRWykxtT7I7GN/uSza5BqpIGHIfD2kEFHsDMd/w5a9JwGtN+27ZkS+fb3PK7VoilUu9brwvKXSSTA70NRnqRPwY1fX9w/Vb7X9DDtqqbke7rwBdQU+wHZhvKPMSdPovhOqsEJddmIvDUOKAjmIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKbcq-00034M-Bx; Wed, 06 May 2026 14:45:16 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKbcp-000kJL-2E;
	Wed, 06 May 2026 14:45:16 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D3E2152F658;
	Wed, 06 May 2026 12:45:15 +0000 (UTC)
Date: Wed, 6 May 2026 14:45:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Lee Jones <lee@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
Message-ID: <20260506-hulking-furry-anteater-ca4a04-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260422102239.948594-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e5ekygddi7i4j3qb"
Content-Disposition: inline
In-Reply-To: <20260422102239.948594-1-lee@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 0A2FD4DA6CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7531-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url]


--e5ekygddi7i4j3qb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
MIME-Version: 1.0

On 22.04.2026 11:22:38, Lee Jones wrote:
> Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> synchronize_rcu()") removed the synchronize_rcu() call from
> bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> timers from being rearmed during deletion.  However, it only applied
> this check to op->timer via bcm_rx_starttimer().
>
> It missed the fact that op->thrtimer can also be rearmed by an
> in-flight bcm_rx_handler() (which runs as an RCU reader) via
> bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
> bcm_remove_op() has already cancelled it, leading to a use-after-free
> when the timer fires on the deferred-freed struct bcm_op.
>
> Address the omission by checking the RX_NO_AUTOTIMER flag
> in bcm_rx_update_and_send() before starting op->thrtimer, effectively
> preventing it from being rearmed concurrently with teardown.
>
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--e5ekygddi7i4j3qb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCafs32QAKCRDMOmT6rpmt
0i00AP9R3Sc9X+w8rKl8GVKi2NXhM2bbAWHm7qupV67Rd6be3QD+KwIJuQ1k5KSG
GFlDLPIxzxmgPGm2lDH9nHLH6XQGEAw=
=PShS
-----END PGP SIGNATURE-----

--e5ekygddi7i4j3qb--

