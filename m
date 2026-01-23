Return-Path: <linux-can+bounces-6291-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHClG2qxc2liyAAAu9opvQ
	(envelope-from <linux-can+bounces-6291-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 18:35:38 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FF379130
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 18:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F63A3028002
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C354C3EBF00;
	Fri, 23 Jan 2026 17:34:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80637257845
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189687; cv=none; b=PfKs1DiPPOS3l09SiAnp6Os6bKUofxDLZUI8mfrzNQIUKKDPTtoC5zCz0oztlnEtg/3UJVQ2lbiD/yQFE3wGRh4kttA/j9wHNK9zStS0n3l3rcnJwhn2lCQjO5IGZ3d0X8LGxCMDn6xhlywREBoNlBIEXBprP4XaDhi1TDvxGHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189687; c=relaxed/simple;
	bh=vtdAzzhVOVe9/Y1PhsVG2BJtNudXWF8tkJlyUNoO2qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpJ/AoIud9AhD3TQZMN68LhB6lk/8VYUeupuAGvG6Ye0sXsgRSFZgbTLTt7MBYGw8ep/nD9xu9GoqZ5hUPUgW74/cMIokIccZd5rBhK0C6dt3ZDeoufc99KdKJiIenKJKtVRk+kmT91w0wPcc0cx5dX/jtCJuasa8uCag6AVWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjL3S-0000OH-Bl; Fri, 23 Jan 2026 18:34:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjL3S-0028FV-2f;
	Fri, 23 Jan 2026 18:34:42 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 86C784D7155;
	Fri, 23 Jan 2026 17:34:38 +0000 (UTC)
Date: Fri, 23 Jan 2026 18:34:34 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): fix error
 message
Message-ID: <20260123-daft-attractive-bandicoot-f7bd6d-mkl@pengutronix.de>
References: <20260120-gs_usb-fix-error-message-v1-1-6be04de572bc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n3uiydoisa66hbza"
Content-Disposition: inline
In-Reply-To: <20260120-gs_usb-fix-error-message-v1-1-6be04de572bc@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6291-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:url,pengutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91FF379130
X-Rspamd-Action: no action


--n3uiydoisa66hbza
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): fix error
 message
MIME-Version: 1.0

On 20.01.2026 13:52:30, Marc Kleine-Budde wrote:
> Sinc commit 79a6d1bfe114 ("can: gs_usb: gs_usb_receive_bulk_callback():
> unanchor URL on usb_submit_urb() error") a failing resubmit URB will print
> an info message.
>
> In the case of a short read where netdev has not yet been assigned,
> initialize as NULL to avoid dereferencing an undefined value. Also report
> the error value of the failed resubmit.
>
> Fixes: 79a6d1bfe114 ("can: gs_usb: gs_usb_receive_bulk_callback(): unanch=
or URL on usb_submit_urb() error")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/all/20260119181904.1209979-1-kuba@kernel.=
org/
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Added to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--n3uiydoisa66hbza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlzsSYACgkQDHRl3/mQ
kZyNdAf/ZM6uplwHN1qqCPXNRFr+a+BOvsV2bmkFNHxsjVRLgiF/rpLrrljcvEQe
HVH3OIuebdt4w75tg8SG5VmZK7W4zvQZDaPqmEjJoagYUBAcKJzAM2qdrzQsRERJ
jqavdh1O9zJS8VOCvF69Z69yT6O0Q/ZJ5LuIEVo/OUc1AmOlgA/PnQRCX+sZn52u
w5ig8aC/yyyrtBZrC67FbOQbI4lmWX8klJ++b64H9+DkMYkms2tbdNVgN6KQ4aCL
uKS+of3/xNP3h7YVlkVo+/pZIpiQp1hUTfehdrqfVgo6200letNmHyYsj05HR8F/
PXZifyoed9NREkhfVLfyv8altl8EDQ==
=WTEx
-----END PGP SIGNATURE-----

--n3uiydoisa66hbza--

