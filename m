Return-Path: <linux-can+bounces-2274-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCE59DE69F
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 13:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4191CB21A00
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12C155352;
	Fri, 29 Nov 2024 12:43:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7516199934
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732884236; cv=none; b=jU1Xo+G2qNrlxAOJMY9VQ7lu2tuC6vJefN5DK9LhWQje0HA+k+dXOQIZzfTfXHRateXlegq6Y27wjIRSSy+tgqwm523AXL3hWd2d/kBnVl2kp56P4o2G3JE18kq2vFd6AmDbUI+bPp9+I0PpTsji3ETIMxjLRBawCCFqhi/5LLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732884236; c=relaxed/simple;
	bh=NTSz5gwA4107nePYwmw10itH9A9C/xXBIcQiN0xMn6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W63c9Km4UYlUJ2kZLsGgYfwUeGUPzyrR06tP+jqPxgcgjvqmqKa52ST4BjBjunEZ3Ek+7eXZvQWeS2dOiNLaisQ6DZk27MReNBQIRfhC2gJMZPicEAwIiSRBl0n2OXapXRn/CmkZr1li8u43MPJ8Z1/Utiq0or1i0dw9irdBpBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH0LT-00045D-0h; Fri, 29 Nov 2024 13:43:39 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH0LR-000n1t-0v;
	Fri, 29 Nov 2024 13:43:38 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B67CF381226;
	Fri, 29 Nov 2024 12:43:37 +0000 (UTC)
Date: Fri, 29 Nov 2024 13:43:37 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Charan Pedumuru <charan.pedumuru@microchip.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: net: can: atmel: Convert to json schema
Message-ID: <20241129-excellent-optimal-rattlesnake-b352fa-mkl@pengutronix.de>
References: <20241120-can-v3-1-da5bb4f6128d@microchip.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dfxtl2sovlzdezlx"
Content-Disposition: inline
In-Reply-To: <20241120-can-v3-1-da5bb4f6128d@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dfxtl2sovlzdezlx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] dt-bindings: net: can: atmel: Convert to json schema
MIME-Version: 1.0

On 20.11.2024 13:58:08, Charan Pedumuru wrote:
> Convert old text based binding to json schema.
> Changes during conversion:
> - Add a fallback for `microchip,sam9x60-can` as it is compatible with the
>   CAN IP core on `atmel,at91sam9x5-can`.
> - Add the required properties `clock` and `clock-names`, which were
>   missing in the original binding.
> - Update examples and include appropriate file directives to resolve
>   errors identified by `dt_binding_check` and `dtbs_check`.
>=20
> Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
> ---
> Changes in v3:
> - Modified the commit message with reasons for each change
> - Link to v2: https://lore.kernel.org/r/20241003-can-v2-1-85701d3296dd@mi=
crochip.com
>=20
> Changes in v2:
> - Renamed the title to "Microchip AT91 CAN controller"
> - Removed the unnecessary labels and add clock properties to examples
> - Removed if condition statements and made clock properties as default re=
quired properties
> - Link to v1: https://lore.kernel.org/r/20240912-can-v1-1-c5651b1809bb@mi=
crochip.com

Applied with fixing indention in example.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dfxtl2sovlzdezlx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdJtvYACgkQKDiiPnot
vG8hDAf/RR6qkSZh/4/lRzmSO1k04OMiEoWCXmhlM3ceBWDO7RKSUFaV5SO+bJ28
oFpMj2ly5MimZpjnm8oaeFGPCBl5l4dY0YJn/Ghw7wZeS/Kvsg1MLQmaZ6GeP0EX
6YizPxq9+0ZqAO4YwA2RZtA4CxLdB28XWDj9pIuFTxrSaWq1s9LZ1rcYHXX7tZry
TM6ZxAKA5IcWrMLS3/uN/unIPAOID7av9vTyM98YeGe1kgQ7KSOZJ7m7oraOPnvr
/+ZrGQveyEHDwNfbKQ9o4khWkp77w+pVttx86+SZtxMBgFeqcIQpGHc8qZo9Szik
jBXrO5qN25gTCXiz2LUXeW2MNtjNnA==
=Yz1e
-----END PGP SIGNATURE-----

--dfxtl2sovlzdezlx--

