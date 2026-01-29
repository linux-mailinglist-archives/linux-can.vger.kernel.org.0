Return-Path: <linux-can+bounces-6390-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BKLEfEee2msBQIAu9opvQ
	(envelope-from <linux-can+bounces-6390-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 09:48:49 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F45ADB5C
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 09:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 504FC3007942
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA3C2BEFFB;
	Thu, 29 Jan 2026 08:48:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D5126ED25
	for <linux-can@vger.kernel.org>; Thu, 29 Jan 2026 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769676526; cv=none; b=Mz8MLc8lZCneooD6cykmGRAnHFryGOD7xu0W1YHZjlqbelEAO09maN3bJuN7SAMP8q0QdW0n8TSmj6YtQqKCQBgkR8YvMjeqvi3nyg7ueg2cZ9kv6KO4L/w82+JGGMykvo19xpJy8tXzP0QvijWrXrRjq/XrbrBg6YHzgl5hUyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769676526; c=relaxed/simple;
	bh=NRsZjmqvlVLR3v+6zlHqoSNiF4sJH06p4+abFk/zQNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+s13fTkpsmjx64Fkx6ws5j8e+HC4y91esCCerXcGHvkROzjBdOmt67w6DLSFK0/Tvzcl2frsUSyIUuaHesVwwvNam9rwbjSu9e7p7/3RoGWEUVCLt4LCpfEcW4O/JqAKPhRC6HBEH3YQ7/98sxlQwvgSY0a6nndSbJ4ssyC6Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlNhf-00036W-Tl; Thu, 29 Jan 2026 09:48:39 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlNhg-0033Wp-0s;
	Thu, 29 Jan 2026 09:48:39 +0100
Received: from pengutronix.de (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 567294DAEF6;
	Thu, 29 Jan 2026 08:48:39 +0000 (UTC)
Date: Thu, 29 Jan 2026 09:48:39 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, tools@kernel.org, users@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: b4 prep --auto-to-cc fails with 'NoneType' object is not
 subscriptable
Message-ID: <20260129-fortunate-pompous-chinchilla-dcb99f-mkl@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="3iqyk4zdrryuggun"
Content-Disposition: inline
In-Reply-To: <f47126ee-8256-4077-a09c-47a1ed461f65@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6390-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4F45ADB5C
X-Rspamd-Action: no action


--3iqyk4zdrryuggun
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: b4 prep --auto-to-cc fails with 'NoneType' object is not
 subscriptable
MIME-Version: 1.0

Cc +=3D tools@k.o, users@k.o, konstantin@l.o

On 29.01.2026 08:49:24, Oliver Hartkopp wrote:
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

Latest version is v0.14.3, please re-check.

> While get_maintainer.pl itself works ...
>
> $ scripts/get_maintainer.pl net/can/bcm.c
> Oliver Hartkopp <socketcan@hartkopp.net> (maintainer:CAN NETWORK LAYER)
> Marc Kleine-Budde <mkl@pengutronix.de> (maintainer:CAN NETWORK LAYER)
> linux-can@vger.kernel.org (open list:CAN NETWORK LAYER)
> linux-kernel@vger.kernel.org (open list)
>
> At least posting via b4 relay works fine and downloading of the v2 patchs=
et
> you sent was comparably easy too.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3iqyk4zdrryuggun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml7HuQACgkQDHRl3/mQ
kZy6wQf/SOXJskvOmHGRDVoMEXCbx/s5FYPCDK/oyF+hJb/xwzGZSJssn+dvZT4E
aWTW9RM4mxwrHLWgwvY/ZPwzBALQItqC4C4ndoWBSXitfQeLclnBR9IlTPBXXmbi
EVT5sWXnP24cfAMXPQCQXK3Ln3prQDc1QS/eOTvVR9TL0wBhTNxCwifH3wWIfdTt
N3nYg7amv6S5y206BB+aA2Xz1MNH2Xy7jNTb9PhB7mD+I9tLLsnyrN5CrGpWdJ6p
Wbr4LwpKoA9SLgUNcmOpYQF6OcbQhrYXkeCR2jFGNZZGWYDnZgdYg88CWOI66pfM
dhPKWAK36CoD4HdzmkBCB7b6gT+Z2w==
=SbsS
-----END PGP SIGNATURE-----

--3iqyk4zdrryuggun--

