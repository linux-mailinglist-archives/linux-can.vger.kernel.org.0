Return-Path: <linux-can+bounces-2340-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081539E42DF
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 19:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01C4161FCE
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 18:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D1620DD5E;
	Wed,  4 Dec 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bd0Xbr6j"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359B205AB3;
	Wed,  4 Dec 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335048; cv=none; b=d/JkQIgNNe+O7hM0f8UhrIWf6G5ycUlwI8lJ1627kf9wW3H+HA86q1mfluAPkaumy2Fp8dojV2oqT5U0nRQ79ID/zhvmdTqXB3zTNJM6KZZP+CgL0RJu66fi/TElS8HEVfvPwrSknQ9w8agJ3DzkdvAtC+C6yCyrqvTK2jP5OIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335048; c=relaxed/simple;
	bh=fRm35phSCi0EmPT/12kcBIjSxz6bokgCNDk6aPPR/cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKFeGEqL/jRY09PKO0mtJUpegHkBzSZqZ5M07I4fup3sAAqi9W70oCdGn9G8n7Z5V8nu3bifhZHbTztEr1PayIwE7wCWmbyFGwyStPQFQWr7Xnqb18r3su4KUgNb+1cX379CcktYV8FJLzk5BSjBdOW5UMaMTZk1AvAVoeKBZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bd0Xbr6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628BFC4CECD;
	Wed,  4 Dec 2024 17:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733335048;
	bh=fRm35phSCi0EmPT/12kcBIjSxz6bokgCNDk6aPPR/cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bd0Xbr6jmrflsoHW+OZX7mall4XMctVjbcrEbOGL60yk+e2Sa510Hj5gWSJM6L2xv
	 ESmXIprCwQnW5BBEbaUB65DGppEE/na9xiIzQoMBy3IM59q61rbziJkcDmMn/Pa+Bz
	 y6pEfAK97iRf+fXSE2lm3MLHzomeKV/2/CqdHyiZ88LCqXH+kKGKexzptRxygHihRR
	 KX6EsaVYhXEWcAjlA2oKRmektH3b2u24QLWpUPrK1yCmN2rL3Gst0zMU1rsWSwXPHJ
	 O2t6LZx3RAJyTLnp6t7yoNnhkuCOQSbadOz3hnP0Yz/EdE1CudU5Q4E1Krm5Hz+X5+
	 YJHW45/zM9uCQ==
Date: Wed, 4 Dec 2024 17:57:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>, imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3
 SoC support
Message-ID: <20241204-huddling-relic-6551aa8beec6@spud>
References: <20241204074916.880466-1-ciprianmarian.costea@oss.nxp.com>
 <20241204074916.880466-2-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CMzb9H7q+z7hhOj8"
Content-Disposition: inline
In-Reply-To: <20241204074916.880466-2-ciprianmarian.costea@oss.nxp.com>


--CMzb9H7q+z7hhOj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2024 at 09:49:13AM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>=20
> Add S32G2/S32G3 SoCs compatible strings.
>=20
> A particularity for these SoCs is the presence of separate interrupts for
> state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>=20
> Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
> same restriction for other SoCs.
>=20
> Also, as part of this commit, move the 'allOf' after the required
> properties to make the documentation easier to read.
>=20
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--CMzb9H7q+z7hhOj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1CYAwAKCRB4tDGHoIJi
0ojXAQD35pJEVUUkNYvL4Sv0axRGyQZmAydMOCY8naTz/X24ewEA4n760u+2pmJ/
C5VZYMvbrNjp6WINRrIX6r1n7LJkow8=
=fSpC
-----END PGP SIGNATURE-----

--CMzb9H7q+z7hhOj8--

