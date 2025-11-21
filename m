Return-Path: <linux-can+bounces-5546-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD996C77F99
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAF924E2E0B
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F752D5A0C;
	Fri, 21 Nov 2025 08:47:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D83B233711
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714832; cv=none; b=WIJpUN9HJRsjZoMptq1j+QmWufRKf9tigu2zq9go94MsLs+sxOE1NQrgh5b10oOyyo8oEhnbFG3RwNL20Rq2i/UX+wMVddxqqfZVFs1aLqNhFkFrRKerefm9CCDcSZwN5/wme6B6KIRSNN57ZgL2ZqiFtdfXdpx8Yhkj6CRQ7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714832; c=relaxed/simple;
	bh=gYLAJvvZV+SaLxQH9usQ3gB6F2hegDrONsDGoPWHu6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5c0JPCiTOtyqV2lenLmXBwMY9bnQ7Ft62OjIF075Meqr1iU5SAEvnwBscIojIe8oIHHtuQrUJy2O0gHY9EIp7P04SE7O8tRraGGIaN8nAE4Ea7/dS9K09Ycpt3Q7flBwn1n+wWA4hhAbItwb6XH6WDyEKfVS9EMCjN9w2Xniyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMMnL-0007cO-Fk; Fri, 21 Nov 2025 09:47:07 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMMnL-001YXH-0D;
	Fri, 21 Nov 2025 09:47:07 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BC9B14A459D;
	Fri, 21 Nov 2025 08:47:06 +0000 (UTC)
Date: Fri, 21 Nov 2025 09:47:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, 
	Stephane Grosjean <stephane.grosjean@hms-networks.com>
Subject: Re: [canxl v4 16/17] can: dev: can_get_ctrlmode_str: use capitalized
 ctrlmode strings
Message-ID: <20251121-meticulous-authentic-hippo-a88adc-mkl@pengutronix.de>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
 <20251121083414.3642-17-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eeymc7mwivxidyx6"
Content-Disposition: inline
In-Reply-To: <20251121083414.3642-17-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--eeymc7mwivxidyx6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [canxl v4 16/17] can: dev: can_get_ctrlmode_str: use capitalized
 ctrlmode strings
MIME-Version: 1.0

On 21.11.2025 09:34:13, Oliver Hartkopp wrote:
> Unify the ctrlmode related strings to the command line options of the
> 'ip' tool from the iproute2 package. The capitalized strings are also
> shown when the detailed interface configuration is printed by 'ip'.
>
> Suggested-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev/dev.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 1de5babcc4f3..32db9f69844d 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -90,43 +90,43 @@ EXPORT_SYMBOL_GPL(can_get_state_str);
>
>  const char *can_get_ctrlmode_str(u32 ctrlmode)
>  {
>  	switch (ctrlmode & ~(ctrlmode - 1)) {
>  	case 0:
> -		return "none";
> +		return "(none)";
>  	case CAN_CTRLMODE_LOOPBACK:
> -		return "loopback";
> +		return "LOOPBACK";
>  	case CAN_CTRLMODE_LISTENONLY:
> -		return "listen-only";
> +		return "LISTEN-ONLY";
>  	case CAN_CTRLMODE_3_SAMPLES:
> -		return "triple-sampling";
> +		return "TRIPLE-SAMPLING";
>  	case CAN_CTRLMODE_ONE_SHOT:
> -		return "one-shot";
> +		return "ONE-SHOT";
>  	case CAN_CTRLMODE_BERR_REPORTING:
> -		return "berr-reporting";
> +		return "BERR-REPORTING";
>  	case CAN_CTRLMODE_FD:
> -		return "fd";
> +		return "FD";
>  	case CAN_CTRLMODE_PRESUME_ACK:
> -		return "presume-ack";
> +		return "PRESUME-ACK";
>  	case CAN_CTRLMODE_FD_NON_ISO:
> -		return "fd-non-iso";
> +		return "FD-NON-ISO";
>  	case CAN_CTRLMODE_CC_LEN8_DLC:
> -		return "cc-len8-dlc";
> +		return "CC-LEN8-DLC";
>  	case CAN_CTRLMODE_TDC_AUTO:
> -		return "fd-tdc-auto";
> +		return "TDC-AUTO";
>  	case CAN_CTRLMODE_TDC_MANUAL:
> -		return "fd-tdc-manual";
> +		return "TDC-MANUAL";
>  	case CAN_CTRLMODE_RESTRICTED:
> -		return "restricted-operation";
> +		return "RESTRICTED";
>  	case CAN_CTRLMODE_XL:
> -		return "xl";
> +		return "XL";
>  	case CAN_CTRLMODE_XL_TDC_AUTO:
> -		return "xl-tdc-auto";
> +		return "XL-TDC-AUTO";
>  	case CAN_CTRLMODE_XL_TDC_MANUAL:
> -		return "xl-tdc-manual";
> +		return "XL-TDC-MANUAL";
>  	case CAN_CTRLMODE_XL_TMS:
> -		return "xl-tms";
> +		return "TMS";

Here the prefix "XL-" is dropped. Was that intentional?

We should move this patch to the front, so that new members could be
added in uppercase from the beginning.

Marc

>  	default:
>  		return "<unknown>";
>  	}
>  }
>  EXPORT_SYMBOL_GPL(can_get_ctrlmode_str);
> --
> 2.47.3
>
>
>

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--eeymc7mwivxidyx6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkgJwUACgkQDHRl3/mQ
kZzcIwf+KTdVN2l+L5ddLwca64nX/allEpVdL8A6LJbYHqto+hNe/US3HkproyCu
8YegGQzoHtl9R6B5Ll0zhD4L9sbPWIm0G/F9W8dyUMlxYuv1Z2fZE4g/GZNV0yVo
cTry0xkcu+XiqxJe5wMmOlT+plzbDQf2LstoVNCoOom7Cm8LNT2qOJ/TITxS63W7
xq1xbtn+d4ZdZTDO9tFxC3GWs9lNfRdTaAgalOJOcbEXkJI3sGBJZPQ6ebIGemGO
U3OJaTPE+urMYbYwtbz/Q9qdgYWsF38CBrqeXMjCuYQtIZ0kVUCv1zxfOZ98KtIY
SxjCUvFtpOia2Cd8dZkbgOQ04F8afw==
=0oLf
-----END PGP SIGNATURE-----

--eeymc7mwivxidyx6--

