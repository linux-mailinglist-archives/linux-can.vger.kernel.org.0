Return-Path: <linux-can+bounces-6392-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEiDNIs1e2mGCQIAu9opvQ
	(envelope-from <linux-can+bounces-6392-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 11:25:15 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D661AE9BE
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 11:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07E98304E6CC
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 10:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0431338582;
	Thu, 29 Jan 2026 10:19:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895D3385B6
	for <linux-can@vger.kernel.org>; Thu, 29 Jan 2026 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681963; cv=none; b=QrYTcdG7uwJphITLtVPPJ2FhHUKa/t0IJOLe0y3rG/yCpPp4Cz6vA55j+oG7g6DJg3597nzp4jSaqfHX2zgHffKBKpAnXSoQpKMlKR8OJgKjRBXBt0wSLvV4Gs8/6C7UdnDy0ZEJjxCVbVAELcknz3jqa1NU4g+HEr+fiwWUmjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681963; c=relaxed/simple;
	bh=vvTHWqFH6VqyzKJ3RP/fbbA56YG6X2lm7ztCXKgKoLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE/QnmywODvAeXcnibjpYG7NUMGmEY2CmjqPFG3HKyRklCjLLZ085Xx00HWVcuDM9MDy/i7rz/EdqnJcMseCDw51MF6afNQy4WXk53bhrDFYqRuASukMLPi0WDvclU7rKWWXunOo5OruOvfNirIEWI2HdEwkDuhNrL+bPRVPfe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlP7L-0004Xy-Uf; Thu, 29 Jan 2026 11:19:15 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlP7M-0034GD-0y;
	Thu, 29 Jan 2026 11:19:15 +0100
Received: from pengutronix.de (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 55CA84DB010;
	Thu, 29 Jan 2026 10:19:15 +0000 (UTC)
Date: Thu, 29 Jan 2026 11:19:14 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, tools@kernel.org, users@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: b4 prep --auto-to-cc fails with 'NoneType' object is not
 subscriptable
Message-ID: <20260129-skilled-placid-lori-f58fb9-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
 <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
 <20260129-versatile-tuscan-mongrel-f9b173-mkl@pengutronix.de>
 <f47126ee-8256-4077-a09c-47a1ed461f65@hartkopp.net>
 <20260129-fortunate-pompous-chinchilla-dcb99f-mkl@pengutronix.de>
 <c5e95a45-9aac-4a67-82b5-ac4ed8ae2844@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="742vkaufhklikrt5"
Content-Disposition: inline
In-Reply-To: <c5e95a45-9aac-4a67-82b5-ac4ed8ae2844@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6392-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Queue-Id: 3D661AE9BE
X-Rspamd-Action: no action


--742vkaufhklikrt5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: b4 prep --auto-to-cc fails with 'NoneType' object is not
 subscriptable
MIME-Version: 1.0

On 29.01.2026 11:09:50, Oliver Hartkopp wrote:
> > Latest version is v0.14.3, please re-check.
>
> $ b4 --version
> 0.14.3
>
> Same behavior but different line numbers:
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
>   File "/usr/lib/python3/dist-packages/b4/ez.py", line 2907, in cmd_prep
>     auto_to_cc()
>     ~~~~~~~~~~^^
>   File "/usr/lib/python3/dist-packages/b4/ez.py", line 2727, in auto_to_cc
>     logger.debug('added %s to seen', ltr.addr[1])
>                                      ~~~~~~~~^^^
> TypeError: 'NoneType' object is not subscriptable
>
> I upgraded my machine from Debian Trixie to the "unstable" Debian Forky.

nitpick: Forky is "testing"

> I didn't fiddle with https://kernel.googlesource.com/pub/scm/utils/b4/b4.=
git
> nor pip.

Try the b4.git, you can directly use it after cloning. I'm using it
successfully on Forky.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--742vkaufhklikrt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml7NB8ACgkQDHRl3/mQ
kZzhowf/foikiw29eCWcuvd8woChxFKXEECwuEYDTXnSpx8SrRiSR6+Hmt5N2qTy
o8I5vaK/tMi7Q2exJi8J4BWICit0u1KY0jlEyM8IBzRIseBSkUdgOY0aJpK3Q3u5
adzzT7m0tQzB5BdEMw7pFvvn7pp9CSD1PnhfgOa/ZnXA5ukgUkhIWHTyGVkxFyyd
E0EcQdGQbFYsjygaUSY8S1oBKggpkiKK3an/w0ylDyBe51pw85XO743Axx3jgRba
oV6MF2x/C8X0E5mSWzVKvv7lzowPFQH7arAnXsoDmKKtJrqGE83KyyfNk1cNYSLr
9d6la3yH1uTJ+0xs0v6/ZAjBAqfbPQ==
=3ope
-----END PGP SIGNATURE-----

--742vkaufhklikrt5--

