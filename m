Return-Path: <linux-can+bounces-6440-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nRvEAwQffmmhVwIAu9opvQ
	(envelope-from <linux-can+bounces-6440-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 16:25:56 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98708C2AB9
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 16:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B154F3001FEB
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08A424A049;
	Sat, 31 Jan 2026 15:25:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A51A9F97
	for <linux-can@vger.kernel.org>; Sat, 31 Jan 2026 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769873149; cv=none; b=TYkXOiRSdsakjsMjOUp6jyZsTJSRzAbE3B9U1vziigCXSFUGxgQBimJVPVCAgGVaUkiqsF0hXIm5k7NVfqFQ9xVqG65rjAoIUtyKE3cZAWsaPctvydSqwtSYQHJiQQOvDfMhnhZgdzHRPKSQdroSzXbvxxa933Sx0zQKP8tia8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769873149; c=relaxed/simple;
	bh=BdovoKI6OG7sW+h/gQpv1pby9Qx5VlZ16fPfUttnzLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYUiB1xy5J2QqRnPCIDmIdOJcYz2po+JrnJGKu1Dp7v5UTySpKEJk+NsVejs573XQ3zsiZjHmFh1cwCZVGFjWGDKnHtO3x6rOs98ACHa7m1KioOcg5wxjpBPiWu2fXWV3syiT5PqAo8sLSSgiXw3CqZ9AS8n5h4hlSodUBxUogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vmCqz-00050f-FB; Sat, 31 Jan 2026 16:25:41 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vmCqz-003QhL-1w;
	Sat, 31 Jan 2026 16:25:40 +0100
Received: from pengutronix.de (unknown [IPv6:2001:67c:1810:f051:561c:856e:5964:a6ed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A4EB34DC703;
	Sat, 31 Jan 2026 15:25:39 +0000 (UTC)
Date: Sat, 31 Jan 2026 16:25:36 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, 
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>, 
	Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH net-next] net: can: ctucanfd: remove useless copy of
 PCI_DEVICE_DATA macro
Message-ID: <20260131-placid-porcelain-mandrill-9cb027-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260130114134.47421-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="htmvnm2vu23qyowl"
Content-Disposition: inline
In-Reply-To: <20260130114134.47421-1-enelsonmoore@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6440-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,cmp.felk.cvut.cz,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98708C2AB9
X-Rspamd-Action: no action


--htmvnm2vu23qyowl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] net: can: ctucanfd: remove useless copy of
 PCI_DEVICE_DATA macro
MIME-Version: 1.0

On 30.01.2026 03:41:33, Ethan Nelson-Moore wrote:
> The ctucanfd driver has its own copy of the PCI_DEVICE_DATA macro. I
> assume this was done to support older kernel versions where it didn't
> exist, but that is irrelevant once the driver is in the mainline
> kernel. Remove it.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Added linux-can-next

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--htmvnm2vu23qyowl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml+Hu0ACgkQDHRl3/mQ
kZzV+Af9HZBrRyGfjocuz4rpY6n4QSWZDeQuOFHG6UEaaQAaNXR23ebz1OMZfeZN
oZme1LP2mTB1C4tbQX5HXudVp/wiJdX2JZB/I9gwB1xsLCO2ImBBiZePlVjvjP5b
k+xiKcS8I4BfmfRiBmT9CwqFnOfzICOVflgp7TGa061Qf96LnnMy/HWHCLQ+eYmO
0XbgLSUn712qHi/ProratJMqaj6qgwFK4X6lBmWpOlOMlXqrdSDGXPXCnAT+Udv3
4qHc3uE7Urv/nRi8tRvKLn+RICYrJevTcalvG3RPQttVuH1FOzr/id4/Rz9J73HB
tFhTXKjvcqfG00BHiNK0bNeDXfJGBQ==
=usAq
-----END PGP SIGNATURE-----

--htmvnm2vu23qyowl--

