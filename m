Return-Path: <linux-can+bounces-72-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B755D80AA20
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 18:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9FE1F21288
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC72038F84;
	Fri,  8 Dec 2023 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptJPFirg"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF6122308;
	Fri,  8 Dec 2023 17:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3329C433C8;
	Fri,  8 Dec 2023 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702055350;
	bh=/IphcbvtWoyG/fdkcm9lA/I86nGtTbDJid5q4OPmEp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptJPFirgLLzF4T9HWYpbubQGoTykPHi7WT2waoDAsLMD6zIR3crBpBCYOU97GrC5M
	 0FTe8NhXD23I5iDp/Pbschttbk74s0fCaip0kwsrcfJJXJtJMdkVcITZJddmTj8K2E
	 2zdXeK8JrovcaeUTLQrqGbypNw8vpDB+XOxpsggn6sorHggDihewFzdAJJKkFnMydF
	 mBmtq9N89lMSWgH76ElNC+T35o3B+lDqEU+X7E+hscnZo9DL03TuOTduToMCkiLRBL
	 rz7Anh7o7D0lZSUYHDOPKpcZ6JkreGHTFnTSvefUOXnxSalgPiyO3wZVDJCH+Ljbom
	 ZAvDReaocRJjA==
Date: Fri, 8 Dec 2023 17:09:04 +0000
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v1 0/7] MPFS clock fixes required for correct CAN clock
 modeling
Message-ID: <20231208-majestic-train-ee55b30de95a@spud>
References: <20231208-sizably-repressed-16651a4b70e7@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FA6cKNTv83r5pITX"
Content-Disposition: inline
In-Reply-To: <20231208-sizably-repressed-16651a4b70e7@spud>


--FA6cKNTv83r5pITX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 05:07:39PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> While reviewing a CAN clock driver internally for MPFS [1], I realised
> that the modeling of the MSSPLL such that one one of its outputs could
> be used was not correct. The CAN controllers on MPFS take 2 input
> clocks - one that is the bus clock, acquired from the main MSSPLL and
> a second clock for the AHB interface to the result of the SoC.
> Currently the binding for the CAN controllers and the represetnation
> of the MSSPLL only allows for one of these clocks.
> Modify the binding and devicetree to expect two clocks and rework the
> main clock controller driver for MPFS such that it is capable of
> providing multiple outputs from the MSSPLL.
>=20
> Cheers,
> Conor.

Whoops, that was meant to get a dry run arg... Please ignore!

--FA6cKNTv83r5pITX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXNNsAAKCRB4tDGHoIJi
0js1AP9ZqKk/YBSEPrALxRtNPh7qmxhWn6pQU0kY4tNa5xZ++wD/b+Aro0mcj91z
Tut9u4n6gLOaDGjwvPG1K/0/eD5mzAg=
=yfBZ
-----END PGP SIGNATURE-----

--FA6cKNTv83r5pITX--

