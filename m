Return-Path: <linux-can+bounces-6056-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05120D07C0D
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 09:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56E1B3006A6D
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 08:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA85D86331;
	Fri,  9 Jan 2026 08:18:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00396218E91
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767946733; cv=none; b=khNlvvwzp4f+1Jq5bDaNKm/tCizSg99BJb/WdKHD33MVA1ypSR1WjDyOMTUk6b1hIL8nhtN71B4+fUk4IUwJDSQ9wOE58fkOExFa9UvmwC3D3UjVH/4/S9AcaDI/1ZdU3usHB5feQ7todI02nzw5uf0BU3thkslQg/A8UtX0AyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767946733; c=relaxed/simple;
	bh=qkFSWehH+nMQ8IXJbdbH6EiZaFh67D/C6ofI0vJ2+/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdNfx2RLf0Hy/TiPT+f2iXYI0oOjwrHtarF+3EVFpsKwyHTj4OXj0V/pSfJ/aLwFVGRPfpoobNFFOh+nWPwesitrvapyyKFwH3mPVcve8sp3wISudfMe7EjG4DRpV4jSrasT7ipLN7DttAtrJj2SUzAfyfFagc+4OUSbwL6rnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve7hf-0005Aw-JE; Fri, 09 Jan 2026 09:18:39 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve7he-009oY4-14;
	Fri, 09 Jan 2026 09:18:38 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C19804C95F8;
	Fri, 09 Jan 2026 08:18:37 +0000 (UTC)
Date: Fri, 9 Jan 2026 09:18:35 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Jerry Wu <w.7erry@foxmail.com>, extja@kvaser.com, eeodqql09@gmail.com, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] can: kvaser_usb: kvaser_usb_leaf: Fix some
 info-leaks to USB devices
Message-ID: <20260109-wild-whippet-of-unity-a0f2ce-mkl@pengutronix.de>
References: <tencent_B88CC7093F21BB59E7B4298209F208E02708@qq.com>
 <df1feb99-2996-4a84-8e04-2a850c05b602@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a5ltp35ws52ml7u2"
Content-Disposition: inline
In-Reply-To: <df1feb99-2996-4a84-8e04-2a850c05b602@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--a5ltp35ws52ml7u2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: kvaser_usb: kvaser_usb_leaf: Fix some
 info-leaks to USB devices
MIME-Version: 1.0

On 09.01.2026 08:50:03, Vincent Mailhol wrote:
> +CC: Jimmy
>
> On 09/01/2026 at 02:36, Jerry Wu wrote:
> > Uninitialized Kernel memory can leak to USB devices.
>
> Please explain in your description which field(s) is(are) uninitialized
> in cmd.

Some memory at the end of struct kvaser_cmd is uninitialized, but
usb_bulk_msg() doesn't send the whole struct.

regards,
Marc

P.S.: It may be a coincidence, but Kery Qi's patch [1] had a similar
form. You take the bug class of an existing CVE and search for the same
pattern in other drivers. I like the idea. Please take a little more
time and check whether it really is a bug before sending bug fix
patches. Otherwise please label the patches accordingly.

[1] https://lore.kernel.org/all/20260108082042.1627-1-qikeyu2017@gmail.com/

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--a5ltp35ws52ml7u2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlgudcACgkQDHRl3/mQ
kZxsmgf/aqegzNCiWv5eJ10ppgpjJoxhPEFySCqCravNWBLqAJ8V7q4DFQsK84Lw
J0zNOIuJlSUGb8tHJESCwi98bMddVDQ1ta20WuDXJSEIVQrLxR9yxuiKNXt/aynz
swFBvvZUe2AsKZUcO+N9aKP53HIfH55YFjIRPiB00fldqZKBPtBmuyswTAFLPzBM
lM7pY1pi7n1qalzgeO+1rRzn3J2rnCPVxZcPWsH5zvtJ6gWNBOXgLgu2wKSR+/3f
sKQhb14+fkuSWqydMUzzQJ65Z/16MuZUCoXD7KSK1CxPoy6jdm5tvu/l4H+OQiYY
KGr9pfVot/A5+Ld7A5Iz7uw8q8p8tA==
=MVhU
-----END PGP SIGNATURE-----

--a5ltp35ws52ml7u2--

