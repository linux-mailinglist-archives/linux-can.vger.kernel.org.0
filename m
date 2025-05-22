Return-Path: <linux-can+bounces-3628-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE14AC063A
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 09:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E9017023C
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 07:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118024E4C6;
	Thu, 22 May 2025 07:54:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB22505BB
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900468; cv=none; b=XZtZkOt2pGuUMupWQXaolgXaB8DD4NaqjHKMzlxjb6T3p7HjdZv9+xhRO3LsCpugD1Ki8LLE5LHJFnn8TJrrbmbqpb1H2I2COz99GMUCsMItGCVNebwzg3FSyaz4AMaaNr2iL0WPh8YjtIO4HBVueii1yu+r+tcpi0HRK36c5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900468; c=relaxed/simple;
	bh=+Y+F6VWNCIM+4oj4V50MLAa/CNm8t4AJOEhW33J3exo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMuJuJVClSuUt9L57Yg/1IA90qyYPae5+G4E7v3nmjZ2l6oEbzR/boSMBEIQGdEnuWBzKOSngtkw8p51S+jobjdvDXSmSE2b1AwWLmnXyoRpUXgiph12/oAWeww59THC+Xmp0y+ysT+RaDHUHAWvpilDlGcTyhcbhpJv/ODhm8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI0kj-00037i-NU; Thu, 22 May 2025 09:54:09 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI0kj-000hFH-1A;
	Thu, 22 May 2025 09:54:09 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009:2000::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6662941714B;
	Thu, 22 May 2025 07:54:08 +0000 (UTC)
Date: Thu, 22 May 2025 09:54:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	kever.yang@rock-chips.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: can: rockchip_canfd: add rk3576
 CAN-FD controller
Message-ID: <20250522-ultra-anaconda-of-engineering-b70332-mkl@pengutronix.de>
References: <20250522074616.3115348-1-zhangqing@rock-chips.com>
 <20250522074616.3115348-2-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="el3mxqe2wkjylcyv"
Content-Disposition: inline
In-Reply-To: <20250522074616.3115348-2-zhangqing@rock-chips.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--el3mxqe2wkjylcyv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/3] dt-bindings: can: rockchip_canfd: add rk3576
 CAN-FD controller
MIME-Version: 1.0

On 22.05.2025 15:46:14, Elaine Zhang wrote:
> Add documentation for the rockchip rk3576 CAN-FD controller.

This should go into the existing rockchip,rk3568v2-canfd.yaml.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--el3mxqe2wkjylcyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgu2BoACgkQDHRl3/mQ
kZxoWggArVZQebS0V1C2TAYZ7DUzq/S/iKGXct7O+HQ5EPqqVj4F+UFWZCg2iipl
kAjfp2wQwHDEjyKhF4nHiyAvdNzhszSPSsSJ1mNyOQlVdD2qoAbmo77mWLQ2t5Pr
ItlW3UvSpa0r9aBLznVabAjLarhTCFUoRbF4VJJcm2hCb7s/ZTfUC2UyOLJ+55vO
byQdkco3aGzexYU7DYwbFmYPcmz588qdUR2TsoDlJChJLZrghSZKZICY/IhJ+Ii+
3lq2nJCR1MPExVq2Qf49FjVXYlybt9qxilf9EUYhBWhDWJJVLiRU3MEDjuTdus5T
ktILX+FYsjoDFsss95L55yEwKAvJZQ==
=jbb9
-----END PGP SIGNATURE-----

--el3mxqe2wkjylcyv--

