Return-Path: <linux-can+bounces-7561-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AFkLnug/GksSAAAu9opvQ
	(envelope-from <linux-can+bounces-7561-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 16:23:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0454EA172
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 16:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DE843012C99
	for <lists+linux-can@lfdr.de>; Thu,  7 May 2026 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D85140148B;
	Thu,  7 May 2026 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="FkhbCI6+"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214F3FA5CD
	for <linux-can@vger.kernel.org>; Thu,  7 May 2026 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163829; cv=none; b=fSo9+gQcmncaCKZ4VsFwL8xx8Ej77EJia+L+UfC/hf10V2JOCIT16hVFHamVWaWXtGsZ9Ntb9VU8QS21rnSG8sSHnRMd+dc0jqHJfwlX9L9O6kDJzzArPOobjKItqlP4KOxqW5obx4YjHx0Qco+YNJB3aVJGUwMxQYsoVRKXW9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163829; c=relaxed/simple;
	bh=9PPgK4QLRSfTOdseskC5krVmq0BpGiNeGu5HCLmSg74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emzg2Q69iUIXF16+Q9PbtGdxhhxvtzNtCxMBnBwGlAh8Wt6UkIt3uPUoFynK8iLVgJwYEmLeY7jWZgjT9vYh7XN3l6Jk3owfG3kgvwOPxAmEBVaaKm4yoHfglfmXqXH26LyloKgGZRqDAAPIS6K8mS4499hcHw2eXYhVcDDwYIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=FkhbCI6+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso8777345e9.3
        for <linux-can@vger.kernel.org>; Thu, 07 May 2026 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778163825; x=1778768625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KHdHPIlg8ERzV5KgqRTDZ9XRFXSHKLYAiHw6AYH9eg4=;
        b=FkhbCI6+5iGRjZDWKXPWkgyGSB1Rtp2FJO25fv5YVM16EJDf3nQ5DeNsCnKRIgo1XU
         uYA8+soz4vGtGZuuTPHPPzyTCxMA8S/u3Jvv4OyRF2C0E4r+JlNe1O18B9vI1CnKstde
         tLkvxSE+Hmnm8QuomilBsAonXLuiPktzZIyoFhJMUnyyTWtGKVk2/ti8+5wSakHBTh/7
         cDqssVgVtg5yEpeaFOgOlWn4Zg59DYfOH/bGBAkGbB7Xe3xnuyT3XgkLtxweJel+Vt+y
         j1NhpAGJf9fnl/RVWEPYVHjuxpH/ju12RbWfGCzFUsNxu+Ao2910f8UhhE05burJWSmZ
         OUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778163825; x=1778768625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHdHPIlg8ERzV5KgqRTDZ9XRFXSHKLYAiHw6AYH9eg4=;
        b=oKESKyWyoakLMH3iXypTvAIZD4/C1OiKgVHAkkvNbljn+ehukBU0M9Ig3fHPwhYNAC
         2MuPX5LLIxPKHIudf10CF+lJIL9yE6EaDialDOccjB1tbpdUz7F3XIl1DlXlcok3rZ4I
         WfOBcDPpfUfjWEHCl7kfxdA9qyTfvJZO50XEXka8y2ywpHfpOpKfm+kRDLfKN2YVBpox
         181qjmL9m8pE1n+24JNoS14AY9zgsm7w2v4gxFZ/xn1VAw/ZlpT3RayXLQckm7g5k6kl
         sdCNIA1t8RntVf/Y4vJBGO6Xk9Rb+++mMga17gNyMBB3j+2x4vSYLMV3Q5t5t+pm5B8l
         q8yg==
X-Forwarded-Encrypted: i=1; AFNElJ9Jc1tjTOwLECVBg0/g6/N9bZFiiKHedXeYHQTKRHagcS8BulfoQ/T+30JqgawfoPd1RqR+hldKhrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiX98h/zwbSrAsl0ny32EKwLGp5D8FHVjjBEdI3oSQLYq/xJBK
	NSK10w5q0Zu2CVGOo3+rEhcCDzK+PeflMX18tj+a4WWavCa8TEq8YgMQ5QK7uPP7pUg=
X-Gm-Gg: AeBDieunoKFvk+7igUWpY/9fDdJlSr0h0wcg9jZSjYmgDcU0GowQCEggl/TZnDBBbh0
	hOtGzHzI4+Y/YqWzBVIu5r2Hj7vwgusU9p27JnA7YFBVSzvbxOdqSDl3wULe2HGdAWW1iTXRmjh
	B4bCUHWbx5/CxEl3qUCsaJ468Dz00b8uG9RMjNXxHA30wupQSEhGzRTI0XwQK9/oiQMFZmfeCM0
	tTRGFzmcvnDewHi4PfX36IdVf5G6efRDxwGI7123HjgBsAdQSc6RpHC0B114+PhSchVVEshApOU
	2Nkgrxe25U0wukq+YSQFsA1TCEg7pPuvnWY1M+Z0AjvhBtqCN6lMFYBKkVbDurxYylJH1US37f1
	eEdfm4XbqHUUX5/3V/5pUxw6N37ky6x/uEqy+2WE9zyVYZSe7HZR/2e+eJLrMc3Ce1PWpiOYMLu
	6zqDERHVV5jeLBNNcrShkOmw28+aX12VIEocy4mD9ZaET2lER0Vqa9I0DQnlQUjbThVQiXeja6d
	Y6n7D3G1PfaPrpewm0C47U7McrHI3YaNNst
X-Received: by 2002:a05:600c:628e:b0:48e:60a3:220a with SMTP id 5b1f17b1804b1-48e60a32224mr33559005e9.0.1778163825055;
        Thu, 07 May 2026 07:23:45 -0700 (PDT)
Received: from localhost (p200300f65f114e08e9fd60f450b139aa.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:e9fd:60f4:50b1:39aa])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e538a8159sm137501655e9.6.2026.05.07.07.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 07:23:44 -0700 (PDT)
Date: Thu, 7 May 2026 16:23:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Michael Grzeschik <mgr@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vincent Mailhol <mailhol@kernel.org>, 
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
Subject: Re: [PATCH net-next v2 1/2] net: Consistently define pci_device_ids
 using named initializers
Message-ID: <afyfa4E4rNbkMYTk@monoceros>
References: <cover.1778149923.git.u.kleine-koenig@baylibre.com>
 <76da4f44d48bdde84580963862bf9616bee5c9e9.1778149923.git.u.kleine-koenig@baylibre.com>
 <20260507-healthy-gainful-fox-500552-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2r3luua3e55dgqvk"
Content-Disposition: inline
In-Reply-To: <20260507-healthy-gainful-fox-500552-mkl@pengutronix.de>
X-Rspamd-Queue-Id: 7D0454EA172
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
	TAGGED_FROM(0.00)[bounces-7561-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,pm.waw.pl,sipsolutions.net,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,amazon.com,infradead.org,ti.com,infineon.com,cypress.com,baylibre.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
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


--2r3luua3e55dgqvk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v2 1/2] net: Consistently define pci_device_ids
 using named initializers
MIME-Version: 1.0

Hello Marc,

On Thu, May 07, 2026 at 12:55:45PM +0200, Marc Kleine-Budde wrote:
> > +	}, {
> >  		/* ASEM Dual CAN raw -new model */
> > -		ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
> > -		ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID_BIS,
> > -		0, 0,
> > -		(kernel_ulong_t)&plx_pci_card_info_asem_dual_can
> > +		PCI_DEVICE_SUB(ASEM_RAW_CAN_VENDOR_ID, ASEM_RAW_CAN_DEVICE_ID,
> > +			       ASEM_RAW_CAN_SUB_VENDOR_ID, ASEM_RAW_CAN_SUB_DEVICE_ID_BIS),
> > +		.driver_data =3D (kernel_ulong_t)&plx_pci_card_info_asem_dual_can,
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

After the conversation in the v1 thread it was unclear to me if you
stand by your opinion, so I kept the format as it was. I interpret your
repetition of the nitpick as request to rework the can drivers for the
next revision (if that happens).

Best regards
Uwe

--2r3luua3e55dgqvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmn8oGwACgkQj4D7WH0S
/k5magf/eyQ23u39ybxkW2OdbwK59q0fpRutP/sxrKWuT6tv8V2fFyOeuGTCjF38
S+nSwmuH/rU1tyi6cJiCBx8U/lrBqlri55tfqDeMMmEdaTgDx/f8rLh5gw/OXR6w
iiW3jwdOchqKMQAWW0XFekrRumOxBYByCEve5jEyzQwjs4cggMP+GUBgYLi9VMsu
p0EMeC469BJE9KTtF0MQoLVR4xXQebXlYBWyCtn6NXuHOWYlZbFW4NYx1YQADQGM
vg8UmTZiP5QB08RryLszWVJxAzMjkvPj8VPLDjxs5zDqJDt6Zbm3G+mNqj3JHLlV
t3qw6OQQis3J/F/BMUIXdtL08Ss0JA==
=i/K5
-----END PGP SIGNATURE-----

--2r3luua3e55dgqvk--

