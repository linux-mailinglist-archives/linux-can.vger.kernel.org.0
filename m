Return-Path: <linux-can+bounces-2845-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0D1A3A0D7
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 16:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806BA3A4684
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 15:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D0C26B2AB;
	Tue, 18 Feb 2025 15:12:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4417726988D
	for <linux-can@vger.kernel.org>; Tue, 18 Feb 2025 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891570; cv=none; b=hl+D/MSVJZss9xy85mFO3V0Q/b640ibjEcWz84EQo2wHI3/aAZav2R/+ArVL897qH4pmmef92LoLyCnitFt9CyIYo909T50jkl1SPx5X0GvYxVk/vPncswPUauiM5AWmmqMYisyNy5H99JfR7fBFwzq1yiaA+S/ySrem65ngefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891570; c=relaxed/simple;
	bh=L7aaLIfRvxb7Oq9/EHqXH2z3bzm6VnUkkgDNwqb/6Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDbKLv4QXuN/0ZyXsWZiM4r0Un6sa6Gyg2WGKSQt0O1owHuR8HurywHwBjJG54dC2r/llGKh+7wx50pJGSl7BcfzuXSXRXJIaJZGGlcGIFjNnJYqEJjd2lWA2AdHbdAj72osDktbmrC9P3ROiLypdFLFmwrRLpQLZs4YJby2lnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkPHB-0005I0-P4; Tue, 18 Feb 2025 16:12:45 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkPH9-001cAv-2Z;
	Tue, 18 Feb 2025 16:12:43 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6A6663C5E73;
	Tue, 18 Feb 2025 15:12:43 +0000 (UTC)
Date: Tue, 18 Feb 2025 16:12:43 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Matt Jan <zoo868e@gmail.com>, Xu Panda <xu.panda@zte.com.cn>, 
	Yang Yang <yang.yang29@zte.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com
Subject: Re: [PATCH] can: ucan: fix out of bound read in strscpy() source
Message-ID: <20250218-pompous-diamond-bumblebee-dd4293-mkl@pengutronix.de>
References: <67b323a4.050a0220.173698.002b.GAE@google.com>
 <20250218143515.627682-2-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5qd3mzqgavgshvsc"
Content-Disposition: inline
In-Reply-To: <20250218143515.627682-2-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5qd3mzqgavgshvsc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: ucan: fix out of bound read in strscpy() source
MIME-Version: 1.0

On 18.02.2025 23:32:28, Vincent Mailhol wrote:
> Commit 7fdaf8966aae ("can: ucan: use strscpy() to instead of strncpy()")
> unintentionally introduced a one byte out of bound read on strscpy()'s
> source argument (which is kind of ironic knowing that strscpy() is meant
> to be a more secure alternative :)).
>=20
> Let's consider below buffers:
>=20
>   dest[len + 1]; /* will be NUL terminated */
>   src[len]; /* may not be NUL terminated */
>=20
> When doing:
>=20
>   strncpy(dest, src, len);
>   dest[len] =3D '\0';
>=20
> strncpy() will read up to len bytes from src.
>=20
> On the other hand:
>=20
>   strscpy(dest, src, len + 1);
>=20
> will read up to len + 1 bytes from src, that is to say, an out of bound
> read of one byte will occur on src if it is not NUL terminated. Note
> that the src[len] byte is never copied, but strscpy() still needs to
> read it to check whether a truncation occurred or not.
>=20
> This exact pattern happened in ucan.
>=20
> The root cause is that the source is not NUL terminated. Instead of
> doing a copy in a local buffer, directly NUL terminate it as soon as
> usb_control_msg() returns. With this, the local firmware_str[] variable
> can be removed.
>=20
> On top of this do a couple refactors:
>=20
>   - ucan_ctl_payload->raw is only used for the firmware string, so
>     rename it to ucan_ctl_payload->fw_str and change its type from u8 to
>     char.
>=20
>   - ucan_device_request_in() is only used to retrieve the firmware
>     string, so rename it to ucan_get_fw_str() and refactor it to make it
>     directly handle all the string termination logic.
>=20
> Reported-by: syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-can/67b323a4.050a0220.173698.002b.G=
AE@google.com/
> Fixes: 7fdaf8966aae ("can: ucan: use strscpy() to instead of strncpy()")
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Wow! Thanks for the detailed analysis and description of the problem!

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5qd3mzqgavgshvsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme0o2cACgkQDHRl3/mQ
kZytMggAlOpCdCseY1s9c4i4Xvy44ljOu0rFWqlN7GHt0rnLQnvEBOoeYSx7SaLh
n/Reu84ambrq7ww9qo2lkpFb6ctB+SoWAu7vtNYGNXsTSQO3tagh2JC4tZqnDgdI
jfIezRGY1M+IsPlOmHCTQog/JlYzaDf7PZI7oZm8IexTc2IAEev3oxNorQG82GDW
M1pH3kjh4tUOIFXXAPR5J8+aQ2hFKJRYscp9aHLEXpH6keHYd6by0mm4mVwY6M8n
vvowbnrhbFy0sAvirKUQE6CPkaU6P0s+wcSWkIw8gsGiBA+TIOFikEUNvaKukISh
oXstTykBt/YdOa0xDB3ta4SOI11l+g==
=ze/O
-----END PGP SIGNATURE-----

--5qd3mzqgavgshvsc--

