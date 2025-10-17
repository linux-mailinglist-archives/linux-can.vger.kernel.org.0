Return-Path: <linux-can+bounces-5230-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA2BEB1C0
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 19:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B98E4E6628
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 17:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A324C3081C2;
	Fri, 17 Oct 2025 17:43:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B92E3081B8
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723027; cv=none; b=cCN47AmaDYqGwFrVjo4l7/zVfAMQ0t2lYWemokTQWz90RnoNEIJ2ruOZ9vrtL10sj4iXX+y1LQHGkPxu7cgedz6UR2Jsmcr1crYqUWXRMKijITv6hyNToVVVek4GH7RSbfFgVdpzeMb9zl2r1DdlxXNROmpuNH5PhQcUleB+SBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723027; c=relaxed/simple;
	bh=tvVfrDyCjrgaizIQDVq+JAvbDXDop/BLw2Y6kLR4I5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3IeqxUwcTUlmurr/d68HwTLogYN2/+SDDuF0416XizrZ9DF1ZpFY0OH68LNbttmqNCAjMv3GNt2+NXqr+kO8D1KIQk+aouSwjjWDjcwQYS2RsgdYkEr0WBiX9QV4eEY7+rDfR8vonYJdKqRb/QOcR3JnTs6m3L3DYVRmdmiZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9oUP-0007zX-Jy; Fri, 17 Oct 2025 19:43:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9oUP-004631-0d;
	Fri, 17 Oct 2025 19:43:41 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D831C4894D2;
	Fri, 17 Oct 2025 17:43:40 +0000 (UTC)
Date: Fri, 17 Oct 2025 19:43:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Magnus Aagaard =?utf-8?B?U8O4cmVuc2Vu?= <mas@csselectronics.com>
Cc: linux-can@vger.kernel.org
Subject: Re: Exposing CAN hardware from userspace
Message-ID: <20251017-quartz-turaco-of-spirit-d1d893-mkl@pengutronix.de>
References: <ef30ff2e-a283-4aa2-be7c-902acfced35e@csselectronics.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="plwyug7xualvuqbp"
Content-Disposition: inline
In-Reply-To: <ef30ff2e-a283-4aa2-be7c-902acfced35e@csselectronics.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--plwyug7xualvuqbp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Exposing CAN hardware from userspace
MIME-Version: 1.0

On 08.10.2025 08:08:43, Magnus Aagaard S=C3=B8rensen wrote:
> I am attempting to interface with the CAN hardware in a remote device ove=
r a
> network and expose it locally as a SocketCAN bus. The remote device does =
not
> run Linux, but I am able to fully expose the CAN hardware over the network
> using a custom protocol. Latency in itself is not an issue for this use
> case, but accurate timestamping and reliable transmission to the remote i=
s.
>=20
> So far I have found a few userspace tools which could handle the network
> communication aspect (such as socketcand[1] and cannelloni[2]), but these
> all seem to expose the remote side as a local node on a SocketCAN bus and
> not a bus in itself.
>=20
> As there is no CAN hardware locally in my use case, the only option is to
> create a virtual CAN bus via vcan if using the above userspace tools. This
> presents a few issues:
> * The remote timestamp information is not propagated to the local SocketC=
AN
> bus. I.e. the accurate remote hardware timestamp is replaced by a local
> software timestamp.
> * The direction of messages is lost, as all messages are sent into the vc=
an
> bus and thus marked as tx in e.g. candump.
> * Flow control from the remote side is lost, such that local nodes can se=
nd
> CAN frames even though the remote side is fully loaded.
>=20
> Overall, vcan is likely the wrong tool for this job, but I am not aware of
> any alternatives. Are there any options I have missed which can solve the
> above issues without providing a new kernel module? The use case seems
> closely related to the tun/tap driver in the networking stack in general,
> but I am unsure if these could be extended to handle the SocketCAN case.

If I remember correctly the Linux kernel fuzzer sysbot already uses the
tap interface to inject CAN frames into the kernel. Let me see.

> If I were to take the route of a new kernel module, what options do I have
> for exposing the data and control structures of a SocketCAN bus to
> userspace? So far I know of file descriptors as in the tun/tap case, but I
> am not knowledgeable enough in the kernel systems in general to see if th=
ere
> are other options which would be a better fit for bidirectional data and/=
or
> asynchronous messages?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--plwyug7xualvuqbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjygEYACgkQDHRl3/mQ
kZwEnQf/VM4ZVgzODyCTIOE6Kt/X0vF348KTzRUmAyhKouDx3ONosl7d+/W6Utg8
HZ+tdW30FGifAOwOC8pIdsADqmvWHusKdAKRaEOGn+SWTaVRk4n6IGOWARQ99bBi
bupcWiDC3mzvNOTRF0GW8EjA1cStNVAoK9Y84o0n2kHPLhjb/2qjwSQO7j/pwfym
DtNa9X0g9m4YwbQP0RjKdY71ffgVV384A6c31mFGcMjryjK37+4TYsc/G2XM/nvX
Moh/nvvmaTm3oHxOCxa8/0+wIQulTyDiSp1UZ2c+GdXgOmfL08wVUabxwmukPgg3
ON4P9z6Byde2SOsSZtixcK1VNl6qDQ==
=X4/D
-----END PGP SIGNATURE-----

--plwyug7xualvuqbp--

