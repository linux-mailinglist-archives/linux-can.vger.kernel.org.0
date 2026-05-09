Return-Path: <linux-can+bounces-7583-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K9PA2zX/mlrxAAAu9opvQ
	(envelope-from <linux-can+bounces-7583-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 09 May 2026 08:42:52 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD694FE4AE
	for <lists+linux-can@lfdr.de>; Sat, 09 May 2026 08:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B613C301EC73
	for <lists+linux-can@lfdr.de>; Sat,  9 May 2026 06:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3C037B018;
	Sat,  9 May 2026 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="LBwtehCn"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379637266D
	for <linux-can@vger.kernel.org>; Sat,  9 May 2026 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778308965; cv=none; b=jkI1pumqTZi0HPWJ3YXh699ze+9gGxG1QZ3vyr4OZmSyt9UcBaiITPcmqLYM39ZrfskXNlPSX94pwGz4s+Z/bx1IUSLNBwL9sEirhWGrdO7Fb5ZDhY0A9/z7PsCJmAE4sMogi7SAkff0nlbyOM2blcuGmwv9DDYS10M/zv+OcV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778308965; c=relaxed/simple;
	bh=GEoZHVYUfoQ2POcefbZ30StKEf4EcthVZSlNu+ybULg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbqDZGoW7GA+l3Tzfb5rEpVv3YMlvexqzhm+M16XoZTctlyQWGHlYp/khTgGTaaQSZzCTWFmmc14F48/y4BW1BANXN5GIIYJVWcwe40D7noY0hNdCRXXDfeMasdFIM+uEd4O4UIrYFJFbCVfEXw0Rxb4wK3ZsiWP4YEUtfP8JHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=LBwtehCn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso28875885e9.0
        for <linux-can@vger.kernel.org>; Fri, 08 May 2026 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778308961; x=1778913761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4fgHjlyy8GzHWAXn0Fq+FtEi3bvrm+LBlHiRLm/LF+E=;
        b=LBwtehCnVnt1LSPaLhGBjUpvt9AHuJe++D8N1GND9y9fEeQUrbT08NsgDWrjMRiCZX
         Oai69xD2ujhjI5AGxRONa7dRZZ9r9/b49t0H3OtMwCIdc4Geb5hg9wBUlLqh+aCaQcmo
         molnJ7cw8fli9tHj1rhGx+8I0SwAWMyw2nY1QphfZbkbxQ13gDBfO+WX0mEfmU2DVqyt
         0mY4jhMzSAnZaIUepB1EvkNlXFQBW0m35cuADjp+A/YIrSruos8i7WOavVxAey+KBokR
         TCq0lYtrQ7DZPmL8opIKozyqd8Tc+XwaS7S56i84XbhMTg6q7OYEeoqU44yS6aRlFEnf
         2PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778308961; x=1778913761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fgHjlyy8GzHWAXn0Fq+FtEi3bvrm+LBlHiRLm/LF+E=;
        b=k09gRpazJB7nJrDzqyYsRBVHwz5+i36KckWH9E7XyTbYeoW4ixVyo2psiMXRwYBp/e
         9ov+LtEFQt60DPVi7E9/7BxOMLMcepzftgTepvFH8bJax+/NI5gwJUXnHU1LmCIbNx7O
         0MDfqC3NbERT1OQYDGTUEj8mxOkbaDCUulxcPRuUlk57Hyq48Nqc09JfCG7dWE2B/6Xt
         VuH7AVEnHdvJPaObmx9Ke5iQ4WSqs30c+1JY8K2LpTnuyfnByVsVJ0hTCxUVFmzsHEy9
         5k/vFN88WLy/R8T9l3jyNbv00StmJXrBcWPRUspqakKKMesTAbwlbBF9dmrrdHfyeJ+y
         1giQ==
X-Forwarded-Encrypted: i=1; AFNElJ98b4xmKMtW4g3NdfSPWwVdhrbDQFFloigGgxdwaefzOTeqV/p+2EGxa81BaDKuVpTQAzOVpAX2hb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgGGGr1CSu17KO/zhYm/mnun/qV73EJGIUU6Q4auZQAEN/V5t
	UTVi3S1ooAoU8YhuS4/Zj1RQhGUpBsWz6Ob+SXtdEpmtGOhtqzsPRkdrrDE6slgb7f8=
X-Gm-Gg: Acq92OG3N2qXjgzVIyd26e3Vi69n5VU6oTZ6ZJxC7FxRr3QvrC9QWbJVQ2Bqpe7WyPC
	d0MRe0V9eFfgKqNmBJbNkExq53tXxEiW8HlRxYvDWQh637N20r/N+M+1sS9GcIOzM7DiNKwYcQe
	KJl0Uw1LZNhlZH/M+zwraCQIEvzYJVGH8B4IDw4ENpp42BxRZPpUzn2uOaiuVdAw+W3PrNv8VzL
	eRWVZnpqHKnfPP1KZv/UwKQO/vkkuBoldhUrdk+yJtCADkpGSP+7yQQjJqGnF1i4oEIkYdPN92/
	51/30uIn52aw0sFTJvhrRTjWKImBMaz4Zdv9YvhFymvsWyKJAQ2j5r+jZVPVAaZ7l7qGIkkpcpc
	9dvy37jpVGp4KFVb4J8AcpeFQldPCJ0/vQSRcosDhn/I3C6DUHezdFnzxtW/HGxViolILGadL71
	A8QP0xu7b7ip2DJEdfM3/4ZErhZs/GJlSjN+lg35k=
X-Received: by 2002:a05:600c:4f51:b0:48d:1a94:56c with SMTP id 5b1f17b1804b1-48e51f3054cmr269055545e9.18.1778308960358;
        Fri, 08 May 2026 23:42:40 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e6db1e1a1sm15355095e9.34.2026.05.08.23.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 23:42:38 -0700 (PDT)
Date: Sat, 9 May 2026 08:42:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Grzeschik <mgr@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Krzysztof Halasa <khc@pm.waw.pl>, Johannes Berg <johannes@sipsolutions.net>, 
	Steffen Klassert <klassert@kernel.org>, David Dillow <dave@thedillows.org>, 
	Ion Badulescu <ionut@badula.org>, Mark Einon <mark.einon@gmail.com>, 
	Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Manish Chopra <manishc@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, 
	Denis Kirjanov <kirjanov@gmail.com>, Jijie Shao <shaojijie@huawei.com>, 
	Jian Shen <shenjian15@huawei.com>, Cai Huoqing <cai.huoqing@linux.dev>, 
	Fan Gong <gongfan1@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Yibo Dong <dong100@mucse.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Jiri Pirko <jiri@resnulli.us>, 
	Francois Romieu <romieu@fr.zoreil.com>, Daniele Venzano <venza@brownhat.org>, 
	Samuel Chessman <chessman@tux.org>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Kevin Curtis <kevin.curtis@farsite.co.uk>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Stanislav Yakovlev <stas.yakovlev@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Kees Cook <kees@kernel.org>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Thomas Fourier <fourier.thomas@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>, 
	Zilin Guan <zilin@seu.edu.cn>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Marco Crivellari <marco.crivellari@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Arinzon <darinzon@amazon.com>, Yeounsu Moon <yyyynoom@gmail.com>, 
	Denis Benato <benato.denis96@gmail.com>, Yonglong Liu <liuyonglong@huawei.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Yicong Hui <yiconghui@gmail.com>, MD Danish Anwar <danishanwar@ti.com>, 
	Nathan Chancellor <nathan@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Ian Lin <ian.lin@infineon.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Double Lo <double.lo@cypress.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-parisc@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, oss-drivers@corigine.com, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH net-next v2 0/2] Rework pci_device_id initialisation
Message-ID: <af7WyUi8jEzInj5z@monoceros>
References: <cover.1778149923.git.u.kleine-koenig@baylibre.com>
 <20260508153452.6a1a9044@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pa3si5htqwvg7uxg"
Content-Disposition: inline
In-Reply-To: <20260508153452.6a1a9044@kernel.org>
X-Rspamd-Queue-Id: 7BD694FE4AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7583-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,pengutronix.de,pm.waw.pl,sipsolutions.net,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,amazon.com,infradead.org,ti.com,infineon.com,cypress.com,baylibre.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_GT_50(0.00)[81];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--pa3si5htqwvg7uxg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v2 0/2] Rework pci_device_id initialisation
MIME-Version: 1.0

On Fri, May 08, 2026 at 03:34:52PM -0700, Jakub Kicinski wrote:
> On Thu,  7 May 2026 12:50:18 +0200 Uwe Kleine-K=F6nig (The Capable Hub)
> wrote:
> >   net: Consistently define pci_device_ids using named initializers
> >   net: nfp: Drop PCI class entries with .class_mask =3D 0
>=20
> There's a transient build failure between these two patches,
> you should probably reorder them?

I did build test with the first patch only, using gcc on x86 and arm64.
I guess this is about the ambiguity I mentioned in the cover letter and
maybe using clang? I'll try to reproduce and fix.

Best regards
Uwe

--pa3si5htqwvg7uxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmn+11kACgkQj4D7WH0S
/k623gf/Q5yF7db6dzmHCyOj113/GHbgzci3Yxu4CEcdvsPNimdU2fG1YgBtP6nM
r1i/YnPw6mQRQh4Qq7870HLsc/WC4sNLH9xZ3NjusUle3e5XMEkpB3mxW2hH/UzB
b0H3xhJvSgiMvib07RqvaVi8kUtsRwkCSR/2zVeSQ2EsMZxwRzV2P09lA/wTiPhB
Hxl7XbIAvVTsDMnnDW4UcyR/xqwsoEjLpTqPSymYwgE9A7kCU1/JD8EO+CNKisYk
AXjQUXekCwI/z5gR4lWMD0xqU7WtNMVfI48Bi7t3gVYPaJTnyY/z0PJuUfKvA8BP
Ar9LmlMuhzaJTsnOdLsr4fzHOJuHdg==
=2L5C
-----END PGP SIGNATURE-----

--pa3si5htqwvg7uxg--

