Return-Path: <linux-can+bounces-4639-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DE0B51623
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 13:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937CE3A63D5
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742582D0C70;
	Wed, 10 Sep 2025 11:55:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A325FA29
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757505308; cv=none; b=D+1KHMDaqS02jDfYS1eUmJKbUytCioLva0RoXXBEuKKk2VY2GDzS+ME8YBhPRNfj6ehb2HNXDYcUIC8Q6dlO4csJlKwU7k/7G+npCguba8gkYOfYGn7ogwihBO/x5gMZt+V3F35IEd2S7TBLIfimb4nrE6/b66oDXj9wk93notI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757505308; c=relaxed/simple;
	bh=FIxh4HV8ajYloHRuoo7IEkLUt2ilb1sz89928uRH6mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQv+xR7AdveuRdhQX19Zp8hUBeIgRNpSvvBTiRWRYy1KRxAbZzkqtCK9SDN0iXjqbYAvjqkrV9iVn2nX9xF46bGuEaK+qhQbD3JckgcXmIGBv4IprzDM5L1aVEsNKquL8gRUULH3obUygnYF+kn/D2prPd9oTL+oVY/SGtj714M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwJPc-0005jR-9P; Wed, 10 Sep 2025 13:54:56 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uwJPb-000aG6-09;
	Wed, 10 Sep 2025 13:54:55 +0200
Received: from pengutronix.de (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A919746AE4C;
	Wed, 10 Sep 2025 11:54:54 +0000 (UTC)
Date: Wed, 10 Sep 2025 13:54:54 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH net 2/7] selftests: can: enable CONFIG_CAN_VCAN as a
 module
Message-ID: <20250910-imported-intelligent-magpie-fb5302-mkl@pengutronix.de>
References: <20250909134840.783785-1-mkl@pengutronix.de>
 <20250909134840.783785-3-mkl@pengutronix.de>
 <00a9d5cc-5ca2-4eef-b50a-81681292760a@ovn.org>
 <aMEq1-IZmzUH9ytu@dcaratti.users.ipa.redhat.com>
 <aME2mCZRagWbhhiG@dcaratti.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ffo7pr4ivbg3gljm"
Content-Disposition: inline
In-Reply-To: <aME2mCZRagWbhhiG@dcaratti.users.ipa.redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ffo7pr4ivbg3gljm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 2/7] selftests: can: enable CONFIG_CAN_VCAN as a
 module
MIME-Version: 1.0

On 10.09.2025 10:28:08, Davide Caratti wrote:
> hi,
>=20
> On Wed, Sep 10, 2025 at 09:37:59AM +0200, Davide Caratti wrote:
> > > ...
> > > # 4.13 [+0.00] # Exception| lib.py.utils.CmdExitFailure: Command fail=
ed:
> > >         ['ip', '-netns', 'rhsbrszn', 'link', 'add', 'foo', 'type', 'v=
xcan']
> > > # 4.14 [+0.00] # Exception| STDERR: b'Error: Unknown device type.\n'
> > >=20
> >=20
> > > Best regards, Ilya Maximets.
> >=20
> > thanks for spotting this, I was testing the patch with:
> >=20
> >  # vng --kconfig
> >  # yes | make kselftest-merge
> >  # grep ^CONFIG_CAN .config
> >=20
> > Then it's probably safer to drop the first hunk - or restore to v1
> >=20
> > https://lore.kernel.org/linux-can/fdab0848a377969142f5ff9aea79c4e357a72=
474.1755276597.git.dcaratti@redhat.com/
>=20
> And I see that the build [1] is doing:
>=20
>   CLEAN   scripts
>   CLEAN   include/config include/generated arch/x86/include/generated .co=
nfig .config.old .version Module.symvers
> > TREE CMD: vng -v -b -f tools/testing/selftests/net/config -f tools/test=
ing/selftests/net/af_unix/config
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>=20
> [1] https://netdev-3.bots.linux.dev/vmksft-net/results/291401/build/stdou=
t=20
>=20
> while the enablement of CONFIG_CAN_VCAN is still necessary, the contents =
of selftests/net/config need to be preserved.
> @Jakub,  @Marc, we can drop this patch from the series and I will respin =
to linux-can ? or you can adjust things in other ways?

You can send me a new or an incremental patch (which I'll squash into
the original one). Then I'll send a new PR.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ffo7pr4ivbg3gljm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjBZwsACgkQDHRl3/mQ
kZyIigf9HpmqSq+5Iucbtgwx1bdPQ+n7+mXz8v1SL+bZfWkRtlxmmhyiVqw5E4Bb
2GKeh7sb0FN9CwZdsLvt95aloKc1lr8XvlE5NVN5155zWS9MfXOIVlcsZRDCBhs4
GYZbqXHG0qJC0e/Jl4EcijjIFX0c4Kayw/TyClJ9dPLhrbgqHRbM+Qx7OvBiLoj1
uq2lAbDrPjbKkQlHd+YPkKeCcXOD4ZcnGfRnIQQ07HEVdR9ffLoRaG8ZGvDn3YMW
DXmZdDpQ9aZb/h6BjZ8SVbXf+Rp+nmOJoRuham1SoSi2m5elWOA7dpTDLTk45ZaC
mmDc/ZwT9VSwS2IV9YK5GT2ZRr2g4A==
=Sriy
-----END PGP SIGNATURE-----

--ffo7pr4ivbg3gljm--

