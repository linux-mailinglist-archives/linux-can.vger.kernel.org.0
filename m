Return-Path: <linux-can+bounces-7592-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPt/GoCfAWpKgwEAu9opvQ
	(envelope-from <linux-can+bounces-7592-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 11:21:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D28F450AC76
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 11:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E054E3227B83
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158F33D6472;
	Mon, 11 May 2026 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ueOAiMa+"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9243C9EC6
	for <linux-can@vger.kernel.org>; Mon, 11 May 2026 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490281; cv=none; b=nH0mIJsPPrYVD9Xn3R+hCNDoiMjJT+HS7edKXL9xTMQsBTxD4vkTDRhy6dw9EmMDTAzBWmTPIZPB6b3IGiJtCWWuFcP/PsbBcJoUg8e1/5hrjkWDVo95mKFuDFymRGnnF6vkeTeGo8PHzuOaPgdChlujQXxFcyWtwojfW8mtuyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490281; c=relaxed/simple;
	bh=PHxUt/BZu52hBJ0XvILTIVRCCcetLa5BJqJayAfrFGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O68Nm1VCxjrlMeYHsQB9KEh6kqzULQALbAQk4xEXy22tpCsnoukTrsxb0iBUAtMAmH8A7we93XH6bYLZTYYpUPGQsmNYIRLypK7nEL+7dyuEkaThn9B/MLlnqPb0Gfy/f8dBbm9IV0gjUoJUFEWodQFc1/NW6Rpv/URXn73lwpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ueOAiMa+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44b052142e1so2211260f8f.1
        for <linux-can@vger.kernel.org>; Mon, 11 May 2026 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778490278; x=1779095078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=utQ0vZd/0ZuAF7qLGsuvxMQfxP2a/tog8cwQawZr+Bs=;
        b=ueOAiMa+Av9mJFWvTt2SsaZXwNtVzDNeAcOfxJXcY4uJxQbnJ9xXNAbQLoV/pq6wsy
         wv9DXXLDLNWpBXMpaHG7oKDr4mDt7WLG8igwAVNnak9uld2pqT3Mvuc9nFY3X/b2qxP/
         b83yjc7lWJZt9Yb1yrCosKMrzfLo/M2RZqBeYxvFAp1YufGA5XKCq0PN8Wwxy9RLir0j
         4epGu6+llW+n5Bn4iULiOaqESx7yqnKGerE6a/thTvfewsfr5b96/ty+MvHRdEZssz1X
         uefnoaXmeL/kQp8Dma15Xph8iBR+niiIFyslGdBXo1acWgiXGLsUaA1E4BMKa9POOTg6
         0MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490278; x=1779095078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utQ0vZd/0ZuAF7qLGsuvxMQfxP2a/tog8cwQawZr+Bs=;
        b=T2mM0m66kCaXcyTfcwJ7R0OAJrzNvROGnzhrHzhcuO7u/+zqsuxUMslvaIRcek3Aej
         6oge2uTRrRbvfBLsPy2rBFgnVS6knoSYsuIs8d9QO9rJ0PCaB9IwAqBhDHMSPaFSv1Ly
         mcijfwV2+dJvJ1qhjHFivD3kdyC7+oWQojFLt6TMBCqNrVFz2dkbfNrCOJtMMhcyW5VI
         Vs6uZWpbblL8tI6z+X3CX0BUUz3g6LyUBJ5hF5Q8YgZEjwxwBOBcSgMRWpERIq6U/nYD
         6/wsFJPWXYpoj/0/z8StBxoFcW4cEzgYQtPnM860DNtU1t38QrT/mL/wT4buZjIiiSkz
         5qvg==
X-Forwarded-Encrypted: i=1; AFNElJ/f/Tzr2WOP00ZcvG6YlZhD8zOv8u6t2hS6V5Ms2n+7w9FwSBqtNhKYPncXrDpSsWr4KxUEb67z3+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5xg/gupMAEqukl2ZLjLtEaQ4orR6fdUkLkDmMmA6hMdQTJ2x1
	+K+9HrMxRamBj0JrF+stvnlnzxvekXKQYxHrzRItyB4uPlLaYCTtvYB+xYY76lE/Zcc=
X-Gm-Gg: Acq92OHVEB9ChLIeeTP8KZQNkrT4OKO0PJMQ198joLgIxcf7j/yYPY/disbYRREQDBm
	lM4aHe8NT4UjgbASyA5EpNIw0O6gPZCRu8/r8q+R/ons3ziwZmXYAs5TcYm7PwEQP+MWCMsWTXC
	giF/h+s+DpANW7FUiwElcdWm9stm95yDhlHEAQWbuRoZka/P0pVH24piOQWs2gwsjw8ZBiOWjnU
	5ymrkbewET4BDHG4OBinG0r3J6UJN9L4iZub4kU1AXH5ioszij9BxRNR8/sbOvWAwydDlc9qiF0
	Tu0GVsKTUEBoM94cSF3iLA3u1SIpsUMMWa0i25mtiBA3TEfUdM/+KAZfvWkfoBey9BXDauizgAI
	YJhIuf7h08U9ux7eGgmGbOMkr+Hvvfssa/+jq1rSme66t6gqAzvatji+aIacO6QuHFcfktS8W51
	1Jps1INsZWrCoi264y3xIbP+AH4dEWSsMa9rjBy7FFjHLdnLP8U33/0HZpgMJIpzmc7u+VAyA8a
	eH+uVRDhqU3vEk=
X-Received: by 2002:a05:600c:698d:b0:489:1ba8:5be9 with SMTP id 5b1f17b1804b1-48e706f0e53mr148064525e9.29.1778490277681;
        Mon, 11 May 2026 02:04:37 -0700 (PDT)
Received: from localhost (p200300f65f114e0841c796eda31a14b3.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:41c7:96ed:a31a:14b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e702e0c70sm189944335e9.6.2026.05.11.02.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:04:37 -0700 (PDT)
Date: Mon, 11 May 2026 11:04:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: m_can: pci: Remove driver_data
Message-ID: <agGbB5XYMrCeuAlO@monoceros>
References: <20260511-topic-mcan-pci-driverdata-v7-1-v1-1-9b7161c1d1ed@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x4gihwp3dlwocsjd"
Content-Disposition: inline
In-Reply-To: <20260511-topic-mcan-pci-driverdata-v7-1-v1-1-9b7161c1d1ed@baylibre.com>
X-Rspamd-Queue-Id: D28F450AC76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7592-lists,linux-can=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Action: no action


--x4gihwp3dlwocsjd
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: m_can: pci: Remove driver_data
MIME-Version: 1.0

Hello Markus,

On Mon, May 11, 2026 at 10:49:16AM +0200, Markus Schneider-Pargmann (The Ca=
pable Hub) wrote:
> @@ -183,8 +183,8 @@ static SIMPLE_DEV_PM_OPS(m_can_pci_pm_ops,
>  			 m_can_pci_suspend, m_can_pci_resume);
> =20
>  static const struct pci_device_id m_can_pci_id_table[] =3D {
> -	{ PCI_VDEVICE(INTEL, 0x4bc1), M_CAN_CLOCK_FREQ_EHL, },
> -	{ PCI_VDEVICE(INTEL, 0x4bc2), M_CAN_CLOCK_FREQ_EHL, },
> +	{ PCI_VDEVICE(INTEL, 0x4bc1), },
> +	{ PCI_VDEVICE(INTEL, 0x4bc2), },

nitpick: typically the trailing comma isn't added if the closing curly
bracket is on the same line.

Otherwise looks good to me

Acked-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@baylibre.co=
m>

(even if you keep the patch as is).

Best regards
Uwe

--x4gihwp3dlwocsjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoBm6EACgkQj4D7WH0S
/k4bIgf/b7vATLUH2PX4AXOB3Rg+KjWJIpFW1M499smXTxdZoXUfCpE9ayiGwZqj
UmZetzUQgOOq35kFz0110rxTkrxtZHyFngyxX46+gWdk2rOY9KKkvvSek/bCbg+x
F9jARgjtKcXhUUh4BpTKfZ3GCdu/ekX5sTB718PSYqWwga6gQdnu4mdJ79ofkRXn
csIIju4LP9zf9KM7ILIHhHhqbaHD4NaQGOZJ2vu6aiyaSyHW3+x2SuQ/ByfVwgEx
3RpxpyJw2RE4obqiqzNDkToqamm36yGeKSqzN4uQLl5xXgncmJP9v1o6DFtMKPx1
lZz1WcN9GmZ+MWTi3s3D/3YRoJb+uw==
=/5zy
-----END PGP SIGNATURE-----

--x4gihwp3dlwocsjd--

