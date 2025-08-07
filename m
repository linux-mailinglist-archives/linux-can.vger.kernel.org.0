Return-Path: <linux-can+bounces-4193-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A209CB1DB70
	for <lists+linux-can@lfdr.de>; Thu,  7 Aug 2025 18:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D80627437
	for <lists+linux-can@lfdr.de>; Thu,  7 Aug 2025 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D3526D4D8;
	Thu,  7 Aug 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb8C12SR"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A21940A1;
	Thu,  7 Aug 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583200; cv=none; b=gwiWwVjnrR5/RaSE/Vfg28IZq4AtClj7tJO1XPiRsQ0eKVKe5Ihm6W246uMkAB6rZtOADKlbOe9x5BEJwb5zrQ/7a8A+0Q+f3wKwcBfuzIVTHYaNjkDGgPhOOkeuABwylOCUbqr5OgW8n/RI73+FZjYqAzpSEnl5+oEBllbFIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583200; c=relaxed/simple;
	bh=IQPqKFUBZOqlBbuHBV2txu01LxbimFRPE66N8YJtaCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjhipqpIhhonAjKqR/sptLOczlf+nG1Z0nUPUifgd0X8/wDLmdhEhkNK2SivcRxs7b3utKQ3LARUt8bR840ouZqAsyWhPTVyQOgSpbZUr0yg76KPGDjTZOntcMpQMxdEWtgNi/HLa4ZD+MMeP6z88RL/qicsBIe96ixZ15VcKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb8C12SR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4429FC4CEEB;
	Thu,  7 Aug 2025 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754583196;
	bh=IQPqKFUBZOqlBbuHBV2txu01LxbimFRPE66N8YJtaCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kb8C12SRmA/TCjvwM17rooJf+h6BfX17To5G2qICOvSQ7rgY6iEy5iB2BdNO6I+wg
	 QtiKQCPlMs2wxf0Fk0XeV8vRqHdGuzaPcWd98lPlVLbDVtFwUNHfQtYctPTwKpYuOn
	 zHXhgN5/QlqEgt8DAwYUJkk7sppkZBMn31yWzntAkQi8rhE6H6W4pIRZfAZ2Pf6wJx
	 0RnqGxEA2h3hPkrWxlLGFxkIHy+6sPVXfB9x3J3DiprbAUxRJGPltD8buyC+KpAWeF
	 AZVKC2TgRR6e6YaEPpN0ELZfPbXVN+bQiEQjyjzftbEkAVp7tQyDsOWE9oh0FhGLRs
	 yHwPnjRhXpK3Q==
Date: Thu, 7 Aug 2025 17:13:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, linux-can@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-binding: can: m_can: add optional resets
 property
Message-ID: <20250807-polar-ruse-b30ef402c9fa@spud>
References: <20250807-stm32mp15-m_can-add-reset-v2-0-f69ebbfced1f@pengutronix.de>
 <20250807-stm32mp15-m_can-add-reset-v2-1-f69ebbfced1f@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="95eIz5YQcH/glHyT"
Content-Disposition: inline
In-Reply-To: <20250807-stm32mp15-m_can-add-reset-v2-1-f69ebbfced1f@pengutronix.de>


--95eIz5YQcH/glHyT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 08:09:30AM +0200, Marc Kleine-Budde wrote:
> The m_can IP core has an external reset line. Add it to the bindings
> documentation.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--95eIz5YQcH/glHyT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJTQlgAKCRB4tDGHoIJi
0kUJAP9nSDad7BkpEvlqTnkas2ereywm7R/blr7FIwjgf3067AEA/KXy2nxKIAPs
Jh3qLPDZl+RhlWwEh2w4flquuzXXAgU=
=gIXt
-----END PGP SIGNATURE-----

--95eIz5YQcH/glHyT--

