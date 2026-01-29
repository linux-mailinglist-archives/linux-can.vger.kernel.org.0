Return-Path: <linux-can+bounces-6389-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AWpEpcde2msBQIAu9opvQ
	(envelope-from <linux-can+bounces-6389-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 09:43:03 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0426AADA47
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 09:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA1BE3013260
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 08:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14C237B417;
	Thu, 29 Jan 2026 08:42:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A137BE80
	for <linux-can@vger.kernel.org>; Thu, 29 Jan 2026 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676165; cv=none; b=MDlBrDMG5PiPTm1Q3UFxRPQXFQ+RD5D9wbYk9RvkenA6mnFHnFv2IkZn5kLqgjeBH/U4TS+/8/63FrcrLUkD4zca5Bc9AcsDdBSKlkhJLeJedMC1+ykhcEj6QS6icwMNw8mHkLFRGIdgy/EqAFq4bq6ZJWAcKyvz4IBnmTR4L4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676165; c=relaxed/simple;
	bh=zw5B7N0kdtIpraKfLwgFLXeOdknd15iGUFeI/rVON+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjBsy55nLUIyJRwtnRmiVKIKfd1axuvSUPAED21wxEPXrhjqAkY8nwxxq+dR/tfr3HusWZIALKVd8/XhfApzMRmLnw1tQ8O4xTsmFAPWTwgNnOWpGCeW6KgwRDXLESmgipKJY0MB9YWBXEqrGnLxT4cYUXJOFV2ZqgUKd1Ehqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlNbt-0002Bv-B5; Thu, 29 Jan 2026 09:42:41 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlNbt-0033WL-2A;
	Thu, 29 Jan 2026 09:42:41 +0100
Received: from pengutronix.de (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B5AB24DAED6;
	Thu, 29 Jan 2026 08:42:40 +0000 (UTC)
Date: Thu, 29 Jan 2026 09:42:40 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
Message-ID: <20260129-horned-python-of-ampleness-188335-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
 <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
 <20260129-versatile-tuscan-mongrel-f9b173-mkl@pengutronix.de>
 <f47126ee-8256-4077-a09c-47a1ed461f65@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j3ifscwvihbxtgbx"
Content-Disposition: inline
In-Reply-To: <f47126ee-8256-4077-a09c-47a1ed461f65@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-6389-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0426AADA47
X-Rspamd-Action: no action


--j3ifscwvihbxtgbx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
MIME-Version: 1.0

On 29.01.2026 08:49:24, Oliver Hartkopp wrote:
> On 29.01.26 07:44, Marc Kleine-Budde wrote:
> > On 28.01.2026 10:07:13, Marc Kleine-Budde wrote:
> > > I'll do. In the mean time, please have a look at b4, it has support f=
or
> > > sending patches via a web hook.
> >
> > Hooray for switching to b4!
>
> Yes! Unfortunately one of the most relevant features does not work:
>
> $ b4 prep --auto-to-cc
> Will collect To: addresses using get_maintainer.pl
> Will collect Cc: addresses using get_maintainer.pl
> Traceback (most recent call last):
>   File "/usr/bin/b4", line 8, in <module>
>     sys.exit(cmd())
>              ~~~^^
>   File "/usr/lib/python3/dist-packages/b4/command.py", line 417, in cmd
>     cmdargs.func(cmdargs)
>     ~~~~~~~~~~~~^^^^^^^^^
>   File "/usr/lib/python3/dist-packages/b4/command.py", line 83, in cmd_pr=
ep
>     b4.ez.cmd_prep(cmdargs)
>     ~~~~~~~~~~~~~~^^^^^^^^^
>   File "/usr/lib/python3/dist-packages/b4/ez.py", line 2835, in cmd_prep
>     auto_to_cc()
>     ~~~~~~~~~~^^
>   File "/usr/lib/python3/dist-packages/b4/ez.py", line 2655, in auto_to_cc
>     logger.debug('added %s to seen', ltr.addr[1])
>                                      ~~~~~~~~^^^
> TypeError: 'NoneType' object is not subscriptable
>
>
> $ b4 --version
> 0.14.2

I'm using b4.git https://kernel.googlesource.com/pub/scm/utils/b4/b4.git
and it works for me.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--j3ifscwvihbxtgbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml7HX0ACgkQDHRl3/mQ
kZxR6wf+JGfITUabQbWls0Q8ovmiTb7DAAuJNirj1IYXLWaHjU/EZzNucTelqhG5
u1fqkPpPA6EnPjjzGrNkVOKCZTiOPq1fZy1fXGFtqyzkZdUNjE7W9pL+J0X0bLDp
JyTR2KdHcNnC9+5ammu7Qx33ax8JrmFU6f8sG158tlLL4r6zBZGS/5KDBngif4Sw
cWEMUEWI5H2/Cqd6P+xvyGqljSObz89MJiu4EInE0NK2AOpotQcsQ1arFvCJi2I9
ftd6KgY93EdXwkcfo/iQH9XU7bnF9iXkdOHJvrG2YdeRzlyAJ6qvXM50OeelLnHW
mjvonkIZ9LZQxVnHaK5JjWTAX81Jkw==
=2EOx
-----END PGP SIGNATURE-----

--j3ifscwvihbxtgbx--

