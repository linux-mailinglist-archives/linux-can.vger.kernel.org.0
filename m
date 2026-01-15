Return-Path: <linux-can+bounces-6169-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24192D25245
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 16:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A703031A35
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA1B350A09;
	Thu, 15 Jan 2026 14:58:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14F343216
	for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489133; cv=none; b=rhgNa/taHquKqzQAI38Q37a2/+rLnZo5mbkFME504DWhfYAJGitpD/DzH7AKYvBOM9H4PmzAwA0IueGmEAaBtpWmzdqC3ZqKWy+2XMKiURUGm5WHZUpeuj9aFj5fCBnDfUw665PwZmIGIR9WigNeCowPTp9vY5rZphKmCEHC0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489133; c=relaxed/simple;
	bh=VT44SYXQEX3u4SwLFe8kfJJAddN9qQhAm7tvl8FcLtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYAxHXmROPqMqlDWTV/29yNR+ARl6/9+IXiOIs9l2SP+idiBdzxnJYRiXi9HePzkcM6eHvAzYlM0WQ/PbEjM6Lq7ltDxrmSChm2PoUOMGJqTPfhXy0uo99cXLf26ouO5MxwRUCsE0HFiP7XSaOP1dK7cale6fwzQmvx/g00/Vv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgOoE-0005RB-L1; Thu, 15 Jan 2026 15:58:50 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgOoE-000lmF-2r;
	Thu, 15 Jan 2026 15:58:50 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E578F4CDB7C;
	Thu, 15 Jan 2026 14:58:49 +0000 (UTC)
Date: Thu, 15 Jan 2026 15:58:49 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Francesco Valla <francesco@valla.it>
Cc: linux-can@vger.kernel.org
Subject: Re: [QUESTION] How to support partial networking
Message-ID: <20260115-inventive-quartz-kestrel-4cab43-mkl@pengutronix.de>
References: <aWgKD8AG-C9YlFRe@bywater>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h7zkbmqs2zfsbpue"
Content-Disposition: inline
In-Reply-To: <aWgKD8AG-C9YlFRe@bywater>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--h7zkbmqs2zfsbpue
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [QUESTION] How to support partial networking
MIME-Version: 1.0

Hey Francesco,

On 14.01.2026 22:26:39, Francesco Valla wrote:
> I am starting to develop a driver for the TJA1465 SIC CAN transceiver
> from NXP [0], which among other things supports partial networking, and
> I was wondering whether it has already been discussed or not how to
> support such a feature.

Not yet.

> For those not familiar, partial networking is an automotive-oriented
> feature that allows to wake-up selectively through CAN traffic some ECUs
> while leaving others in a quiescent state. This can be used for example
> for periodic maintenance tasks, diagnostics or updates.

The ethtool interface provides an interface to configure wake-on-lan
settings, see the man page of ethtool:

| wol p|u|m|b|a|g|s|f|d...
|        Sets Wake-on-LAN options. Not all devices support this. The
|        argument to this option is a string of characters specifying
|        which options to enable.
|        p   Wake on PHY activity
|        u   Wake on unicast messages
|        m   Wake on multicast messages
|        b   Wake on broadcast messages
|        a   Wake on ARP
|        g   Wake on MagicPacket=E2=84=A2
|        s   Enable SecureOn=E2=84=A2 password for MagicPacket=E2=84=A2
|        f   Wake on filter(s)
|        d   Disable (wake on nothing).  This option clears all previous op=
tions.

> It is typically
> implemented inside a trasceiver, which is always powered and stores in
> a volatile memory a list of CAN IDs (plus masks, much like the SocketCAN
> filtering works) that shall lead to the wake-up of the ECU.

Commit 04d5826b074e ("can: m_can: Map WoL to device_set_wakeup_enable")
extended the m_can driver for WOL support in. In that use case the m_can
IP core itself is powered and wakes up the system on CAN traffic. The
driver uses the "Wake on PHY activity" for this.

=46rom your description I think "Wake on filter(s)" would fit for your use
case. ethtool also provides the interface to configure filters and use
them for Wake-on-LAN. However the filter interface only supports
Ethernet and/or IP related filters yet.

A basic CAN transceiver driver is located in
"drivers/phy/phy-can-transceiver.c"

The TJA1465 PHY driver would be an SPI client driver that implements the
struct phy provider, similar to "phy-can-transceiver.c".

The ethtool callbacks end up in the CAN driver, but we don't have an
interface to the PHY to configure CAN PHY specific settings. I think you
can extended the union phy_configure_opts for this:

| /**
|  * union phy_configure_opts - Opaque generic phy configuration
|  *
|  * @mipi_dphy:	Configuration set applicable for phys supporting
|  *		the MIPI_DPHY phy mode.
|  * @dp:		Configuration set applicable for phys supporting
|  *		the DisplayPort protocol.
|  * @lvds:	Configuration set applicable for phys supporting
|  *		the LVDS phy mode.
|  * @hdmi:	Configuration set applicable for phys supporting
|  *		the HDMI phy mode.
|  */
| union phy_configure_opts {
| 	struct phy_configure_opts_mipi_dphy	mipi_dphy;
| 	struct phy_configure_opts_dp		dp;
| 	struct phy_configure_opts_lvds		lvds;
| 	struct phy_configure_opts_hdmi		hdmi;
| };

Let's add a "struct phy_configure_opts_can" here.

What do we need to configure?
- bitrate (CAN-CC only?)
- enable/disable WoL
- set filters

> In the context of the Linux kernel, this can be probably be implemented
> in a number of ways:
>
>  - as a device-specifc capability (accessible e.g. through sysfs)
>  - at phy level
>  - in the generic CAN subsystem
>  - ?
>
> I did not find a previous discussion neither in the mailing list nor in
> public presentations, but maybe some discussion already took place
> privately or I missed something.
>
> Any idea or preference? If not, I'll try to come up with a proposal and
> submit an RFC.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--h7zkbmqs2zfsbpue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlpAKYACgkQDHRl3/mQ
kZwkXAf7BhXid4qUq7fvwcB/bkctWR+qVnv8h62LjpFEcIcT1/a+ldPttQKmHByi
1OE8jR4XKlmgF/RzgiqFO5oO1QizpR1bI7W5dEtosYDX3M5/ZwjcWxpHDW0a2U9x
oTdZjHeICubQNorlgzmaHhK2ixJWoye4Rd20eEkUD/pHhLg7gzwXw7wcpdMfVMtK
7IGg1IMJJcoET/MsK4ZikUeZoqCn00YD0GNQeEcnPjCJBsewXVZw9zrsa+97elZK
65koYDFM0yCP5uMKOJk43MorCWkwmBASEktrGbuBakTAvaPqhiKx1zTePEtwwO2d
2jMUM4RotTTgzwGyZpEEzGSk/hR8Dg==
=GbPi
-----END PGP SIGNATURE-----

--h7zkbmqs2zfsbpue--

