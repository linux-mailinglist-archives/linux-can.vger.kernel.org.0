Return-Path: <linux-can+bounces-7588-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D9vL22SAWrsegEAu9opvQ
	(envelope-from <linux-can+bounces-7588-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 10:25:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3446B50A0CE
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 10:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F8F7306B53C
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D83A7F6B;
	Mon, 11 May 2026 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="cQIU96ZZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2893AA4E1
	for <linux-can@vger.kernel.org>; Mon, 11 May 2026 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486389; cv=none; b=p75Y1n/x38FRVszU/M9b+mFqi6x35vPzGMqX8xREFtUD2G8XVEVa+g50g+Kmkq1xofPlZPHCFElDd3XHhlJzrZ/evIBGfhV99LZWIwFuYJsq+mTgnMCtlgnG71Rvb00f7JMiFjQC5O01NvFjrJ+AnVehS5qOBoBPltnyyJBURBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486389; c=relaxed/simple;
	bh=i1zCLooDTb3wEbYyDrwVPlj0Omm/eL4DtVgIxP9ct3k=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=R/ETHNfETPLrFUlxh5DTxt6KOluAHcZZmfMLDa6NikN37sKBO0mOsaQ/AgpBy8Lv3GVU8b9KK+Jw/ytISbtHn3o7lbYJBI8NSMRw/X+vBfe/uBf1ti5/rBujkJ+CXec71eF1iNYHPVurde+S08c+8d4R3iQ8gn0lE/ij+gNhX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=cQIU96ZZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44b330c5cc6so2886822f8f.1
        for <linux-can@vger.kernel.org>; Mon, 11 May 2026 00:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778486375; x=1779091175; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=evKU95qzmOPURGGdpiQVMbL+Y3Z7PWXtVi6x0E3nQDE=;
        b=cQIU96ZZsVl+BSxeqSwg6bOiSm/YjW7S1JT92pyuF88KO0u9leAO6FmEkgxGezjMeW
         OLXJPTvZNDXaHOdRRu9oLnGRbXhmBxcfh1YV8jeC+1HH1BYPPricFYJ+umAz+Cf/TSgx
         JE1oXgnhyBGh2sRQf5d1P9gztRiT9fN4SdMNNOeE95GcOZ4BZsX5avxrNrp88VOUjRKe
         Bo5lI1nwMAmqXpoiZYpSeN4Ou4HO1Vnz0q5jcrBszw95/jnoxPM332cU17bJyDkQnTSd
         7lmdzh0DTpliBBlUD7fQpyP4Z6cKl2i16DTXFQyp8kINk8ffm+maPRUUW1igE8JATLtP
         UUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778486375; x=1779091175;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evKU95qzmOPURGGdpiQVMbL+Y3Z7PWXtVi6x0E3nQDE=;
        b=lma8LuwIHzq1syc+E/IiDvnSoKTWVdx+l42fh4WkqaP5HWV9S2gk50Bkv1uQ4u7AWf
         6TT64gaSmt75RMrwyCLWq71jKg9uuQvl9+qdcFr6Fj9OqIc0aR9zo08ESxBP5InIAH++
         2EHWde1eW4Aj2j/Q0ub5Pp++OoP0aVKtEKaRPSHhu06HNSn9vE6zhZvhYNx/9vgUyrpm
         MCH6hCfAhbmiYfITa/5jwc40H9p3OmKsnFemHDp+i2oUGVdILn9sqOKyIUVT7iz4YpXS
         q0/R2O/sAlZa/oSX0MzqH4qbo6JyAiaFORLvCotT+TUazjSLi+bqvS8sAuWybZ7znbEM
         U3hA==
X-Gm-Message-State: AOJu0Yw6Auv5mBHrYvtBcc5uYc6Ma+wevSDFQdXCrc53C5jU+dYphpwZ
	mMzfSWfl+vvhg36KxJnBQ9kkKaxtCywbnYGeo+XuKXx9/SohgmVlcrdrm9Q/gnqnRnU=
X-Gm-Gg: Acq92OFBc63m4UcgnuluXQ9DtJ3FnEGk3F/Wn6I37ekpP1WSxoDsA8IOJVCMV+Dc8kg
	mTGK3Hj1QnlVIkUkOXQmTmOuPhXmOnQXZVmsBp056Nx7I+UW33TQ+0AyQSmE5GEBS7dSxze89Ea
	QSvtrSpDAugTBhF4bqf5Q/cxuTI45U9llXFm7JwPh2I8zCyGljkjBrNfnsgxEkrrZDTEuC/yGec
	T+9cw1Ed0ligwvmyafF4EAES66KI3yNWcUokLQ6kv2GKMYeplJKGbr2c2OdrmVWVxy3e96hbFir
	Prg0Qg/KPPpTxgVTZ6sMjFapxdTxS6EnOTMbc6qzjte7zspEfGfaNHSyqV4HIqBldESxbX+I4H4
	uMvJVfHC/HGWvIze9MlPpscxy4ZY1xCHE9J7dgisqu8WWt4nVfWiKmyj0mX+p4dYL2B0N/vAXuQ
	bu3cK1CLA1Pv60gg5WF4U=
X-Received: by 2002:a05:6000:26c2:b0:439:b8b2:fad0 with SMTP id ffacd0b85a97d-4515b056c1dmr35869941f8f.5.1778486374746;
        Mon, 11 May 2026 00:59:34 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:9bf6:accf:de42:f1be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548bb51d40sm22897020f8f.0.2026.05.11.00.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=38a47fb6435d7fc03ee9696be0fbca146abd0d11baf38fdd6591304f5541;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 11 May 2026 09:59:26 +0200
Message-Id: <DIFOSTNQW7OL.2MDUYPI8UXMBK@baylibre.com>
To: <phucduc.bui@gmail.com>, <msp@baylibre.com>, <mkl@pengutronix.de>,
 <mailhol@kernel.org>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: m_can: Use of_property_present() for wakeup-source
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260504050702.34013-1-phucduc.bui@gmail.com>
In-Reply-To: <20260504050702.34013-1-phucduc.bui@gmail.com>
X-Rspamd-Queue-Id: 3446B50A0CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7588-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FREEMAIL_TO(0.00)[gmail.com,baylibre.com,pengutronix.de,kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[msp@baylibre.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

--38a47fb6435d7fc03ee9696be0fbca146abd0d11baf38fdd6591304f5541
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon May 4, 2026 at 7:07 AM CEST, phucduc.bui wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> The 'wakeup-source' property is declared as a phandle-array in both YAML
> bindings and Device Tree source files. However, the driver currently
> uses of_property_read_bool() to check for its existence.
>
> According to the function's documentation, usage on non-boolean property
> types is deprecated. Switch to of_property_present() to comply with the
> recommended API for checking the presence of a property.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

I think this is a fix for
  04d5826b074e ("can: m_can: Map WoL to device_set_wakeup_enable")

Can you please add a Fixes:?

Otherwise:

Acked-by: Markus Schneider-Pargmann <msp@baylibre.com>

Thank you
Markus

> ---
>  drivers/net/can/m_can/m_can.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index eb856547ae7d..16f80607e150 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2464,7 +2464,7 @@ struct m_can_classdev *m_can_class_allocate_dev(str=
uct device *dev,
>  		return ERR_PTR(ret);
>  	}
> =20
> -	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"=
))
> +	if (dev->of_node && of_property_present(dev->of_node, "wakeup-source"))
>  		device_set_wakeup_capable(dev, true);
> =20
>  	/* Get TX FIFO size


--38a47fb6435d7fc03ee9696be0fbca146abd0d11baf38fdd6591304f5541
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCagGMXhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlM7
pAEAhhu1AaipeqeeDQEJKa/CXEHZC6qvcZiEXE4jnKYyttUBAKqdJbD4PME+FjIV
2nSjIdooa+qljz5tpRzzLskrN5QH
=XZAl
-----END PGP SIGNATURE-----

--38a47fb6435d7fc03ee9696be0fbca146abd0d11baf38fdd6591304f5541--

