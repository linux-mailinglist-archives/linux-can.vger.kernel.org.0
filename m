Return-Path: <linux-can+bounces-6936-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA3rGplVqWli5gAAu9opvQ
	(envelope-from <linux-can+bounces-6936-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 11:06:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 705B120F591
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 11:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40F3130B6894
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D69537C0EC;
	Thu,  5 Mar 2026 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="kuQ6wgoy"
X-Original-To: linux-can@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D953783B5;
	Thu,  5 Mar 2026 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704406; cv=pass; b=JTqu1JzKzrEzlhqVc5TyrK72gmp9gf3LB7fpV/hILgcf5X0LvNfh6S1kLmSfYs9Chwsj4oQAbG/DI33xZ9M/OdpcZxiWjSyJGguqw80WKKrV+fvAJG11De/ctvvDNT9CtArh7iR8MI1RI7Q3SnY9fq3mRBlbin2Q9UOJGiA4cTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704406; c=relaxed/simple;
	bh=D7W50Gyx79F1BQJBBcvSYt9GNLrXBM4NZSb+Xw2SOq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAP5e7WHh5z6I+QPBlkK/PtDYW/R11767JXN7MpMcBf8W5LTMYV0QwEscS97mdzAF7pSouj+YqEpNtdnml6aYS/h8PcNrQkKLdo0QxwgDh6CYN5224CmjtZlkOkRH4/Vq6XIe2r2IGTEFh+76G1ZMCXmViKX6mG1g1Eka/IwyTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=kuQ6wgoy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1772704388; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ILbpyWSpgsHBsljKSeJYbS7Vw03gooRrhFM0zfvSJ0mMnsLhlex4dZfvu0oPRIpkKO47xszQ2NfzHWwj0pqoFXT4WttLKvDbi1tiW3nCRR4ojr4Vznpxn72wH7dC+ms4XVRbfVzqDJCc2LgWtNUaXznEcvPGtkEc57jsG4V4QXU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772704388; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nzu6bAtb37Rscm3wTe12q1wA4WbiMxsyc0YgbMDmKhU=; 
	b=mYJnA6goY8gyGl8bcxdTO/ByoiY0b4sP3KBwTqzQqQEu2c5WKfTddS9Fe6+yv32bTaxDKYI77aHYbYDm3y0nylvB+35tg6Dif1cn+oIsHiwDCXjvuTbZTh5SotriBERyVv4hZBgBiBYR/T0QbFyyAxO9Bo5rJckG1guguTRV57Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772704388;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=nzu6bAtb37Rscm3wTe12q1wA4WbiMxsyc0YgbMDmKhU=;
	b=kuQ6wgoyu9T6YeGL0SUqZ9zx8isgTeA+3UHBcaeWieFRMa3K4z+NnEetspD5wWZI
	TL1RG3LK6Yh1ZgrkSKhInXGy6ScbB4h0qNcCIN3ps5vMT5cv/qWX4tybyGlWVkJHBrt
	Vz08HTmqhf50ivIQbgSUcJHFeQhtd9qRZpIk3S4c=
Received: by mx.zohomail.com with SMTPS id 1772704385504238.17185557574544;
	Thu, 5 Mar 2026 01:53:05 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 8DA0C180891; Thu, 05 Mar 2026 10:52:59 +0100 (CET)
Date: Thu, 5 Mar 2026 10:52:59 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, spacemit@lists.linux.dev, 
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 19/22] power: supply: cpcap-charger: include
 missing <linux/property.h>
Message-ID: <aalSUJI5jFG2kJBL@venus>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-20-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2vxe7ox52jklnq2g"
Content-Disposition: inline
In-Reply-To: <20260304175735.2660419-20-vladimir.oltean@nxp.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/272.682.15
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 705B120F591
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6936-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,collabora.com:dkim,collabora.com:email,nxp.com:email]
X-Rspamd-Action: no action


--2vxe7ox52jklnq2g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH phy-next 19/22] power: supply: cpcap-charger: include
 missing <linux/property.h>
MIME-Version: 1.0

Hi,

On Wed, Mar 04, 2026 at 07:57:32PM +0200, Vladimir Oltean wrote:
> This file uses dev_fwnode() without including the proper header for it,
> relying on transitive header inclusion from:
>=20
> drivers/power/supply/cpcap-charger.c
> - include/linux/phy/omap_usb.h
>   - include/linux/usb/phy_companion.h
>     - include/linux/usb/otg.h
>       - include/linux/phy/phy.h
>         - drivers/phy/phy-provider.h
>           - include/linux/of.h
>             - include/linux/property.h
>=20
> With the future removal of drivers/phy/phy-provider.h from
> include/linux/phy/phy.h, this transitive inclusion would break.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: Sebastian Reichel <sre@kernel.org>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/cpcap-charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/=
cpcap-charger.c
> index d0c3008db534..24221244b45b 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -21,6 +21,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
> =20
>  #include <linux/gpio/consumer.h>
> --=20
> 2.43.0
>=20

--2vxe7ox52jklnq2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmmpUncACgkQ2O7X88g7
+prvUBAAiDlamBegg+ohGQtBVAORFIULNrYOBZOk8AG1Qluc6NS+fOqK9Cpw1hjn
4u0f9h1GsBhjBMOb0dS/kxcNWI+xKiTxrMzu4llAu0C9WimbA0CieynGh2b2a3Ja
R/9RQ6pXqPuVZk+7oVlT6gk++/w8TU83M31vyXL0Kx786QzieoSbOvgyZqhEwLez
W41hmnYSkPas6nVkhjp0mnP7eqYQRhXLBeFJgUWhgXvy5YMVAfRrso3DK5JA7hB3
4q8qNISMg2IrcIDMdDaTKVq+3+Ba1z8pRgr4WpIaOpH+Gsq8e8tzt/SEsGt/4SIY
bKuAPMOCmsYuR8RskVyUWJiWX4qt4/YIRU01cg2xxXP404xIKR49X9Z12aEOKjg8
DoBnNzlrSRN/RP85te7hG74Mbc/eVL2fJM9dL+7yZylsv03FFoeii0d+a50bbrQT
QfQy75KNMSMkb7BDrpalL0DhG9bJoZn96pso0p4aD+viqdbpIybrsgMhuUv9DKVS
2rIsnhe/N1gPds7wwpt/4shjn93YGbngre66mxi0y0YvvBQqc3eCf4YbPkGttJ0g
18vYhd7giJO8RE2ApEXsQzT6eKtQFPh01zUJhxvemKoAb6hr3Tptep+/2bn4BVzY
k3rY5iRgS6ono6DZg08TuLXoB3Ck/kz2OE+ntIibQIQNa0GY/4w=
=oTrF
-----END PGP SIGNATURE-----

--2vxe7ox52jklnq2g--

