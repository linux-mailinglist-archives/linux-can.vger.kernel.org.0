Return-Path: <linux-can+bounces-7426-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNu1G8Xd8Wn3kwEAu9opvQ
	(envelope-from <linux-can+bounces-7426-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 29 Apr 2026 12:30:29 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C91E492F38
	for <lists+linux-can@lfdr.de>; Wed, 29 Apr 2026 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F1BB3022912
	for <lists+linux-can@lfdr.de>; Wed, 29 Apr 2026 10:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F8B3D8913;
	Wed, 29 Apr 2026 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="bjgsjhgb"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D9A3D8121
	for <linux-can@vger.kernel.org>; Wed, 29 Apr 2026 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458625; cv=none; b=Ajzu/1mb+YSjXc+u0cyu981ILeUBKOpj3gpKAZd6WO36Kl7Gw4pVGW0POyVJk2gZpPsgwrkY2cucHv1jVAzlYGPzXc+/q6quqc8fO1o89TnttwzCB7ncuCBOeihj5GBAR7eRPX+0RnAKtU1XXFs3uwVnG4ctV6bIR9eeP+NdpSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458625; c=relaxed/simple;
	bh=8k+/eJ+oplAKwa6y8hgdOMX1aMdC7hSdvQ+WDtJexew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b//gt07hlS8NbwD6myle8QO4HDMf1JPhtegkvkDjsNvA/jVZJAvr3d8IsDX2hykwbAI3Sqn7hsodtcJ3MgMv5dDiPgmGACzOAF70Ev1NfbYmG1RMIN8RrpxyBq1JcAVaBTV5rGwEd0MlpE/0j8jUDBQz/vHeECxAdiNiKzXMwVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=bjgsjhgb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488d2079582so144955275e9.2
        for <linux-can@vger.kernel.org>; Wed, 29 Apr 2026 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777458622; x=1778063422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4K3CX6fQVp3G5LFrOMSsx2n8N4FljSdUREsN/3Z40rY=;
        b=bjgsjhgb4OsQIhvq0fHIIxH0cSCfCKFi1n04zU6r75eqdWhQPXahMcQUfQFXi6x1c5
         f1EyEG4/TtvYx4j+IWrkk3EN2bJqSqqYEfCaZUZFwPZbs6rIfdATuqntg9fG5HiVNba2
         r0lTsBgGML1akn11CEmCoZCHkaIgPiOsDNuZ7gj5RHLeFHOwxfhfzcaUeB2AWvElJsry
         5fj6nLHhewUeWD8JULg4yJMi+laRDU89fHvNln0y1E5h1oGbHnWhypceJ0UD/0TGuDQd
         k7p9RoPpJxxncom3FjG4LGEQ/eLJEriLw8incVpA5TwDHKQ331+s6B09FQXSkdLw9DXs
         LVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777458622; x=1778063422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4K3CX6fQVp3G5LFrOMSsx2n8N4FljSdUREsN/3Z40rY=;
        b=DtgUgbDshwxLfFBMchsAQlci70BmP1+LNwepKcebj6NUa1dmUhXS/tYDWbX4uyfO4Z
         +v7huCRL/iu0R5Mx4m6/zYi1ikEOmvTa5nwrLsz3+8jBbLD2L/Gblhsrjb1GlXOI8G8p
         wnV4qDkQDbUvnW08PrGBTxvDpBe79dwE1MP1Wu+URcgE1VjGI2xaq68O3JzdkR4xj9dS
         sjfD1sQRr5g4vmXMhOGKgRnoSFWG0OAoeO0e7ffTzDaCkLC2rESVTThissDtJ/GvZ8MA
         Bc0b2O/zEwoqZQcEkkVnnWkilFTYnjE1CbFi9PhchB0n/JrWpbcaZEAo05zERLKe531r
         4c6g==
X-Forwarded-Encrypted: i=1; AFNElJ9HRwO2VB/YQUsMK5TYr27OmE7+gY17dgtT+nssZNyFfSNOb6YKuIsPUG8AKLZf+U5QhkOEFgpEnr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ZLyv9/mxtszI49uy8E894z4uHQ6hVY86d89BniJATYhPQKVZ
	NH4VQSO12GvQL64lo2MGDu3KOCO3B+5rn5f9zCR3rKIA8yrId1ox8V+rf7sLt4APPcM=
X-Gm-Gg: AeBDiet7sZoRiuuHaqGzLfre84qp9qOXAq9yq+UKsnfQ9uLhqb8VCttqfwRcZ7GaaPe
	K4fdfmJDoTybZv0F+ejY1750WNqjdoYrRT72+8TrpHJdh8/KoHBB8jcfFbdglgnJ5y1zBDHugx7
	Mb+6oxa45Ak+9vf+YkSIHQQ0FScXLK8ulrRj9hAPJFK70EfXXcEHYe4Li5/l4wl8xkGoG0M9gT7
	W83/tZuQaYroJP1meRvTVqxIoc8kVSslJf6Fjv/cMzqBRxREHGcmUTmvc8BDnIhgzqnqnMPTLfV
	5lnJqTto2X4Qd7LKYx8zj2IrwTaHs4SAi3Z6FT9glpDpDcvLg3rJuB0uKaG16+PEKHUQYjyjjsI
	11i3g0bDApxkif3sHCD0knS8HFrL3I+SFyImr7T6EA19jNEXCHDPl6Dm+K2Vek6QOT0v5IbVZDX
	HvyedbaxEWVqMYV1QP6FhiaFzS1VGFYzuLx7JoqdSta+dX0K6/HE+UqSTdnGcFIzNSxsiWK5hsx
	1v8zTfehkcBm4rZE+Pe8VLuMg==
X-Received: by 2002:a05:600c:a4f:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-48a7b543796mr66187605e9.23.1777458621928;
        Wed, 29 Apr 2026 03:30:21 -0700 (PDT)
Received: from localhost (p200300f65f114e08936c55da887fa426.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:936c:55da:887f:a426])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a7c57b641sm47160965e9.6.2026.04.29.03.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:30:21 -0700 (PDT)
Date: Wed, 29 Apr 2026 12:30:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vincent Mailhol <mailhol@kernel.org>, 
	Krzysztof Halasa <khc@pm.waw.pl>, Johannes Berg <johannes@sipsolutions.net>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Steffen Klassert <klassert@kernel.org>, 
	David Dillow <dave@thedillows.org>, Ion Badulescu <ionut@badula.org>, 
	Mark Einon <mark.einon@gmail.com>, Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Manish Chopra <manishc@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, 
	Denis Kirjanov <kirjanov@gmail.com>, Jijie Shao <shaojijie@huawei.com>, 
	Jian Shen <shenjian15@huawei.com>, Cai Huoqing <cai.huoqing@linux.dev>, 
	Fan Gong <gongfan1@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Yibo Dong <dong100@mucse.com>, Simon Horman <horms@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Jiri Pirko <jiri@resnulli.us>, 
	Francois Romieu <romieu@fr.zoreil.com>, Daniele Venzano <venza@brownhat.org>, 
	Samuel Chessman <chessman@tux.org>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Kevin Curtis <kevin.curtis@farsite.co.uk>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Stanislav Yakovlev <stas.yakovlev@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Thomas Fourier <fourier.thomas@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
	Kory Maincent <kory.maincent@bootlin.com>, Zilin Guan <zilin@seu.edu.cn>, 
	Marco Crivellari <marco.crivellari@suse.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Jacob Keller <jacob.e.keller@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Yeounsu Moon <yyyynoom@gmail.com>, 
	Denis Benato <benato.denis96@gmail.com>, Yonglong Liu <liuyonglong@huawei.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Yicong Hui <yiconghui@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, MD Danish Anwar <danishanwar@ti.com>, 
	Nathan Chancellor <nathan@kernel.org>, Sai Krishna <saikrishnag@marvell.com>, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Larysa Zaremba <larysa.zaremba@intel.com>, 
	Joe Damato <joe@dama.to>, Double Lo <double.lo@cypress.com>, 
	Colin Ian King <colin.i.king@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-parisc@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-rdma@vger.kernel.org, oss-drivers@corigine.com, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
Message-ID: <afHdAUpvfYa7A3AE@monoceros>
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
 <20260429-responsible-clever-coyote-6b79f1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3grpbpcumi4i3vj3"
Content-Disposition: inline
In-Reply-To: <20260429-responsible-clever-coyote-6b79f1-mkl@pengutronix.de>
X-Rspamd-Queue-Id: 1C91E492F38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7426-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pm.waw.pl,sipsolutions.net,baylibre.com,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,infradead.org,ti.com,dama.to,cypress.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]


--3grpbpcumi4i3vj3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
MIME-Version: 1.0

Hello Marc,

On Wed, Apr 29, 2026 at 11:10:21AM +0200, Marc Kleine-Budde wrote:
> On 28.04.2026 19:18:44, Uwe Kleine-K=F6nig (The Capable Hub) wrote:
> >  	},
> > -	{ 0,}
> > +	{ }
>=20
> Nitpick: can you convert the terminating entry to follow the same style
> as the rest of the driver:
>=20
> diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/=
plx_pci.c
> index a03553b80a5d..d69ff0ccfd94 100644
> --- a/drivers/net/can/sja1000/plx_pci.c
> +++ b/drivers/net/can/sja1000/plx_pci.c
> @@ -353,8 +353,8 @@ static const struct pci_device_id plx_pci_tbl[] =3D {
>                  PCI_DEVICE_SUB(ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVI=
CE_ID,
>                                 ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_=
SUB_DEVICE_ID_BIS),
>                  .driver_data =3D (kernel_ulong_t)&plx_pci_card_info_asem=
_dual_can,
> -        },
> -        { }
> +        }, {
> +        }
>  };
>  MODULE_DEVICE_TABLE(pci, plx_pci_tbl);

That might be subjective. I also see some value to have the terminating
entry stand out a bit in the formatting and so I usually kept the entry
as it was.

If you prefer I can rework the can drivers at least to match your taste.

As you didn't object to have the can drivers converted as part of the
drivers/net patch, I assume that part is OK for you?!

Best regards
Uwe

--3grpbpcumi4i3vj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnx3bkACgkQj4D7WH0S
/k6JpggAqaPu+dVWg39EGo869zm4GExkyk9Cfi0y4X05WE8coeYG2q3U4oD1x05e
mbEJVHdpAHnBcB/vafRjFDSueFN1LbdYKyqmCOoSEVZm6FUryg3uez5LBTQ1H2M+
HSSsw95R2MJqtNxxGphk2Cr4lR3yVrG+oJpIot8CPMMed7xddK4yn7AdrudrcYAv
fhOuS+7KEB4g6yajDT95eF2Jj+hN7rzcU0+g6TBO5Gd3GnLwIhG6FG4iZnwnaU8Z
FqH+sC+KN85L/JYWezdPXgx5DnHkrmX1530hPFowO9u5SBLf6zBmbuKUgF8CdU4H
gSp6StxoogXj+z4H3WJRpNSbxjHwNQ==
=BqTG
-----END PGP SIGNATURE-----

--3grpbpcumi4i3vj3--

