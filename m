Return-Path: <linux-can+bounces-1671-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 354B399D7D0
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 22:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE521283F58
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F771BE854;
	Mon, 14 Oct 2024 20:00:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF07148FE1
	for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936048; cv=none; b=iDnY8ViOLBVDRokcrgBIvleJbPWNOWAjmx4E619k8eaQUTkvUlzD+w92dLQUAnl464T3glqtMd8YtcBV0GdUgW7Kqstn6sM8ypTRlh1Uz52/GGIxNNJuB185j8WvEp2Bvl2vIdzO7iaOQtrYPzLVlsqBaZ380VaHTHKFywOvEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936048; c=relaxed/simple;
	bh=LtFg78ICh7cpiEhIi6Wx/4ctLLBiQaqB65fMOae4Obc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWibmVxkCXjzq3EfReGI91xpEHOdUuo5zCCkKFVfqBMhQFrtGASoFxBEjxCDCZXd19SvR0eWgvYG1kMdf7uRsU5Y9P23HLV+Oyaf5tTUsJ0G4TZI3vknG9jOIPYqYl2RlAhsTb6pUM78RGitj34P+iwB4280+e6JdRZA8QrD1dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t0RFC-00077c-9s; Mon, 14 Oct 2024 22:00:42 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t0RFB-001rde-JD; Mon, 14 Oct 2024 22:00:41 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 43DB1352A78;
	Mon, 14 Oct 2024 20:00:41 +0000 (UTC)
Date: Mon, 14 Oct 2024 22:00:39 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	michael@amarulasolutions.com, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] can: dev: add helper macros to setup an error
 frame
Message-ID: <20241014-active-versatile-armadillo-717c4f-mkl@pengutronix.de>
References: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
 <20241014152431.2045377-4-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="enndoee5rattrg6c"
Content-Disposition: inline
In-Reply-To: <20241014152431.2045377-4-dario.binacchi@amarulasolutions.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--enndoee5rattrg6c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.10.2024 17:24:18, Dario Binacchi wrote:
> These helpers can prevent errors and code duplication when setting up a
> CAN error frame.

I personally don't like the ideas of using macros here. Is there a
reason not to use static inline functions?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--enndoee5rattrg6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcNeGQACgkQKDiiPnot
vG9dxggAk3KV5Uvy3lF7m1V7PAG/ln8tUCgwTiJxvQxu+cWz2fsRYDmDJ9ug9mBP
Ztm8qI4lpHVcppbpzlD9C5xqKyoegkUQJsHQKDo1wzil6uqluTczmALmFNQtEeJ1
laVwb0joIDwIqsVKbyNaAM2KuGAP4Ng8aQmShGcGEhNztoswAeysJrcWfl7pKAjB
IBMHpL0FhAms7+QcFChAFSbPVPgqalKfRtxafJBVZokjmk8/siitjnJCFNlDE8WJ
XCMXFIr/yJ2TJWHIq/iSeHlHIWj3S7ujlykzhyqee017KYxuukVWFcL4i/AfouqV
l4coNFPqmKoCb5AWJHg46UusOjBQOg==
=SQ7B
-----END PGP SIGNATURE-----

--enndoee5rattrg6c--

