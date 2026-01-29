Return-Path: <linux-can+bounces-6394-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HFmL0BUe2nRDwIAu9opvQ
	(envelope-from <linux-can+bounces-6394-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 13:36:16 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B43B017C
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 13:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AD893014874
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53AC387352;
	Thu, 29 Jan 2026 12:36:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C153803CD
	for <linux-can@vger.kernel.org>; Thu, 29 Jan 2026 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769690173; cv=none; b=iHMrTPx3Dlom7QZ6wbEy5J/5/mNZfQaqZqjYQhUM3NlJASG0OLC9zPEuVG/DppMmyAsvMtgssmAeC230IAHvKX4xnvQgMzTfw88vXd4cRVVbMBpbIlInTW1JDTIBHgJs6XHox13LXHUoKcJiQw3CTcBeqQ9cHjG7Nu1zlqiomKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769690173; c=relaxed/simple;
	bh=dQAe9ckq//bZ4H9nFp+s/GCB+ITknqiVnKHP+WIEw1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fugvLY117+UT557xFNpNdI2EQYSpwDnJRK5ujroQ15WWT/H/KbaAjEkWWDlKp5Sk4V3qe5x5DfeA5ksJJ+M9di3g+zgvsPMOucK3YuSI/kvmLMARKEHFzY26ShKEmfVSolHBGnWDYDKW3WPOnsvuSYwFtYbkP00cA/p0a2mi5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlRFX-00032q-BW; Thu, 29 Jan 2026 13:35:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlRFX-0035NU-1r;
	Thu, 29 Jan 2026 13:35:50 +0100
Received: from pengutronix.de (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9456C4DB1DC;
	Thu, 29 Jan 2026 12:35:50 +0000 (UTC)
Date: Thu, 29 Jan 2026 13:35:50 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, tools@kernel.org, users@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: b4 prep --auto-to-cc fails with 'NoneType' object is not
 subscriptable
Message-ID: <20260129-savvy-vicugna-of-drama-aeefac-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
 <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
 <20260129-versatile-tuscan-mongrel-f9b173-mkl@pengutronix.de>
 <f47126ee-8256-4077-a09c-47a1ed461f65@hartkopp.net>
 <20260129-fortunate-pompous-chinchilla-dcb99f-mkl@pengutronix.de>
 <c5e95a45-9aac-4a67-82b5-ac4ed8ae2844@hartkopp.net>
 <20260129-skilled-placid-lori-f58fb9-mkl@pengutronix.de>
 <1d9966d9-877f-46d4-a2a8-56b6d621bb36@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s4t464t5khomgopt"
Content-Disposition: inline
In-Reply-To: <1d9966d9-877f-46d4-a2a8-56b6d621bb36@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6394-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonic.nl:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38B43B017C
X-Rspamd-Action: no action


--s4t464t5khomgopt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: b4 prep --auto-to-cc fails with 'NoneType' object is not
 subscriptable
MIME-Version: 1.0

On 29.01.2026 11:31:18, Oliver Hartkopp wrote:
> > > I didn't fiddle with https://kernel.googlesource.com/pub/scm/utils/b4=
/b4.git
> > > nor pip.
> >
> > Try the b4.git, you can directly use it after cloning. I'm using it
> > successfully on Forky.

> ~/net-next$ ~/b4/b4.sh prep --auto-to-cc
> Will collect To: addresses using get_maintainer.pl
> Will collect Cc: addresses using get_maintainer.pl
> Collecting To/Cc addresses
>     + To: Marc Kleine-Budde <mkl@pengutronix.de>
>     + To: Vincent Mailhol <mailhol@kernel.org>
>     + To: Oliver Hartkopp <socketcan@hartkopp.net>
>     + To: Robin van der Gracht <robin@protonic.nl>
>     + To: Oleksij Rempel <o.rempel@pengutronix.de>
>     + To: kernel@pengutronix.de
>     + To: David S. Miller <davem@davemloft.net>
>     + To: Eric Dumazet <edumazet@google.com>
>     + To: Jakub Kicinski <kuba@kernel.org>
>     + To: Paolo Abeni <pabeni@redhat.com>
>     + To: Simon Horman <horms@kernel.org>
>     + Cc: linux-can@vger.kernel.org
>     + Cc: linux-kernel@vger.kernel.org
>     + Cc: netdev@vger.kernel.org
> ---
> You can trim/expand this list with: b4 prep --edit-cover
> Invoking git-filter-repo to update the cover letter.
> New history written in 0.41 seconds...
> Completely finished after 0.81 seconds.
>
> ~/net-next$ ~/b4/b4.sh --version
> 0.15-dev-47773
>
> Then I can remove the b4 Debian package again.
>
> Thanks for the support!
>
> Btw. that it does not work neither on Trixie nor on Forky out of the box =
is
> not very satisfying :-/

Hmm, I cannot reproduce the problem with b4.git, maybe you can try
bisecting:

| git bisect start $(git merge-base origin/master v0.14.3) origin/master

then

| b4 prep --auto-to-cc

followed by:

| git bisect good
or
| git bisect bad

depending if auto-to-cc works or not. Then try "b4 prep --auto-to-cc"
again...

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--s4t464t5khomgopt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml7VCMACgkQDHRl3/mQ
kZxDuQf/cMEhc0ixbwaQIdtHSeSNJk48q+cItw4usq0faNPlVjxXRysurlB2AnGi
RacmEZb3vWjtCLqkextSFfkPb6rbmPrqZSucnSM6BI65XV03kIXvliFLoi5qMO0m
hbHnLNeelTyKs0Q+O+LwFb/qypexvvTb9E0u3kjJpq7i54670RKIH8WRIb/SZXzl
9eHeYXAwSSSgXTzYekVgcOzIXOYk9b0zDD+81YFXDCHrPFrQ8Ab6DmLvt+LQrheV
RH6CdVx7t6XH1B1CeMqXpEOayGvs1iDQRJHogKMNmWvhDbyDUVoRWtN/TTrkUAoz
/+GH6mFxu1ny8kry7AFRwwy8rrLzqw==
=dW+7
-----END PGP SIGNATURE-----

--s4t464t5khomgopt--

