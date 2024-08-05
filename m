Return-Path: <linux-can+bounces-1105-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBF8947919
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 12:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BA61C20E5A
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 10:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B4C152196;
	Mon,  5 Aug 2024 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbv+3rne"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014454658;
	Mon,  5 Aug 2024 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852681; cv=none; b=AyGnOKc2Ft7hqLRtwQ6FFoyiqYyQBSjvMuJ04K7MnK1O/HS8VwKKXrjSDNKL1llnBqxGLlNcxa42k+fmo0HUAOsSbkdJDzCFknojF1LChY61Kbg0FX1KsVSij8KYEJtZadeCy9zEViUlqKe58NMfgYwpNg+jflLq/co5AoPUfJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852681; c=relaxed/simple;
	bh=Y0Xi9lYKmT1BemQ3hyO64BittxZDFwIlR/Mz+JVojBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf+1RDZpZovNglFkJTUksZeU5m20XIMcwSnenU9F4cZxVFNjAKn1E8Nf0hDMQvuMTgp0o2A9yP35EeK6B23uSCR+mzl4BCcxLLQO5i2l3NIa2luq+uWovxd0i3C8hItQUK4R/QhrwBW9Bzruf5nOFxY/JCTfjcZr44DQelZVg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbv+3rne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A092AC32782;
	Mon,  5 Aug 2024 10:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722852681;
	bh=Y0Xi9lYKmT1BemQ3hyO64BittxZDFwIlR/Mz+JVojBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbv+3rneucVIfs/QIVqv5N/lw/ShNIZSNt63f3w3XnwTYBCypUDdbP/DMLVWO2T7Z
	 Ui9du5WInuuFGKbUlv6wwwUuFlU/0pNhGcasoIZrXDv5q2+Yk51hqo5Cjy/EL8s7yj
	 jYeh0DXPPLkXdgyCZvf1aGkSmno9gIZ1kR+u0zUuujwDggvotVoJ7a3LIs2g7zuXbQ
	 sX77ytC20GGjEPRNguj0WxbrwVFJyUXg62T2XUYAQ4QIxBEyfNvqYipXoJrs1ITUEp
	 5JY7dynJpIx/FWGoFqvgANLpF7yR7l5ZGm7olvAm6v1W23Kb41vAOWreQojPm+1H3/
	 8GgQ8YfUr6U7w==
Date: Mon, 5 Aug 2024 11:11:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Ilya Orazov <ilordash02@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, a-govindraju@ti.com,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6561
Message-ID: <20240805-fruit-chip-cf08a0e166a3@spud>
References: <20240718210322.37492-2-ilordash02@gmail.com>
 <20240719-ahead-kiwi-995e52bf3e74@spud>
 <CAGCz5HkF_WNZBVpY2SWVf071Pi896BvKFk0jnfNAYX5AKx2Zcw@mail.gmail.com>
 <20240723-dinginess-john-608d0b28293b@spud>
 <CAGCz5H=Gncw+Tr0XaQQhhGWQER5Rs1BcxbkPaJwx9jJ-8j7LGQ@mail.gmail.com>
 <20240723-municipal-snowy-136b08b6db90@spud>
 <CAGCz5HnJKjNj7A0YD2fw20m-NrEs3MoCLwox86mC11Kudq8xbg@mail.gmail.com>
 <CAMuHMdUf=McxMLqb1hgu_-4QkSFJkdWrdtbwiwn9yJoMSi3YWA@mail.gmail.com>
 <20240801-disarray-gesture-ebad121272b0@spud>
 <CAGCz5H=gDfJpfAhH-QbxN5VSDyVtwGU6Zt16z7=sqpTdjkeGqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YyeTlPVfQTmwF6a8"
Content-Disposition: inline
In-Reply-To: <CAGCz5H=gDfJpfAhH-QbxN5VSDyVtwGU6Zt16z7=sqpTdjkeGqA@mail.gmail.com>


--YyeTlPVfQTmwF6a8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2024 at 03:31:52PM +0300, Ilya Orazov wrote:
> > > > > > I made my patch according to a similar one that adds support for
> > > > > > nxp,tjr1443. You can find it's conversation on
> > > > > > https://lore.kernel.org/all/6ee5e2ce00019bd3f77d6a702b38bab1a45=
f3bb0.1674037830.git.geert+renesas@glider.be/t/#u.
> > > > >
> > > > > > I thought we want to hold all PHY chip names in one compatible =
enum
> > > > > > and each in its own of_device_id struct in driver and extend th=
em
> > > > > > where appropriate.
> > > > >
> > > > > Nah, fallbacks are preferred when the programming model is either
> > > > > identical or a "compatible superset" of an existing device. New
> > > > > of_device_id structs should only be used where we need to account=
 for
> > > > > differences in the programming model.
> > > >
> > > > However, I am curious as to why the NXP CAN PHY transceiver was not
> > > > included as fallback compatible. Geert, could you please share your
> > > > thoughts on this matter?
> > >
> > > The TJR1443 looked sufficiently similar to the TCAN1043 to use the
> > > same driver configuration (which is limited to having standby and/or
> > > enable signals or not).  However, I'm not sure it behaves exactly
> > > the same, e.g. in case of reporting an error condition (which is not
> > > yet supported by the driver). The part numbers are also different,
> > > so this is not a simple case of SN74HCxx vs. CD74HCxx.
> > >
> > > Summary: I don't know if they are identical, or if TJR1443 is a
> > > compatible superset of TCAN1043, or vice versa. Hence I went for the
> > > safest way....
> >
> > If we don't know for sure what the craic is with compatibility, then we
> > should leave the existing tjr1443 compatible as-is I think.
>=20
> If I understood the kernel documentation correctly, we use fallback
> compatibles when devices are similar or there is an iterative
> relationship between them. In my case, the TCAN1042 and ATA6561 are
> from different manufacturers, and I'm not sure about their fully
> identical functionality.

It's about programming models being compatible, not identical. The
manufacturer also doesn't matter.

> Therefore, I'll go back to the original idea where I shouldn't use a
> fallback compatible here and must leave it as another compatible
> property with its own of_device_id struct.
>=20
> What do you think about it? In my opinion, this is not a case for
> fallback compatibility.

Why is it not a case, other than the reasons you already mentioned that
I don't agree with?

Cheers,
Conor.

--YyeTlPVfQTmwF6a8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrClRAAKCRB4tDGHoIJi
0hoDAQCY9tO8kPi4NhrIx+5mjOkSmk71Pj6nhwPqPT96T/A2HAD/fEckjh30gAdM
GbuWPs3jBEGfjSY/AAttPREvcluSuQ0=
=kMK7
-----END PGP SIGNATURE-----

--YyeTlPVfQTmwF6a8--

