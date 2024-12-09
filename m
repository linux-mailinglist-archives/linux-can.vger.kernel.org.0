Return-Path: <linux-can+bounces-2346-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAAD9E8FA6
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2024 11:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2811885B17
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2024 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9522921570C;
	Mon,  9 Dec 2024 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="pyinbY8D";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LvZ2+XN3"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48705174EDB;
	Mon,  9 Dec 2024 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738739; cv=none; b=Iipmg7dMwZfWnzrXKX1a2WlcDcHjUAd9ygktC3SOgOp5TdZo4Dl8kPRTmeHA9nmgfJ9EgHZnuoHI65fUwgvgXukF5qdvGtu5LVVuWvHI2ShdTG8TRaJy2N7y2BRiiq00DAWt863GlTzjyta+mjmCwy2eCKfDaELkKXbWk7XUXRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738739; c=relaxed/simple;
	bh=sXo5sAmxXW6ZwYuOXa4/hmYfUCh/0aVkqv6kslgjWWo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PMkK7qMCjWDGD8tAgQMOdw5VkqNzHgNjy+92DPr5r1SZMXw0mtUQyuIuVM5pxJkS07TkOwoRwz+vmf7/OHajPFfczeFefQMrl812sa5wv1aMKK9ZMp7UTnvLXJn79upNQvgz3ho4KY8niDHIUb/t0O4yjc1oDcB2SvEMFEC2+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=pyinbY8D; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=LvZ2+XN3 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1733738736; x=1765274736;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+NyqZAN0t1dGYImX+TcIzJnbZWbtpRtahPMvnfncONY=;
  b=pyinbY8DVRYjZ2yAZZAjlN5N7SxAZc+DZhB+uVeKS3iNfNztrEPo79Bc
   5rSIUmGFDtRs6a7iCDVadh/IYYoZ6Jdlno87beN3BE7iI6JYhlEoGzfGG
   m1TvtaA7dUB7yll5XJD9U6EuyOj0CAf/kGI1RybcbITR9AMhxbii2JLIe
   KgFXJ3Twt+Zfg3VJT8bXlbISTD7IzA0IhDOGUiO7vLEpmq0CkGUAcG5gW
   NQy54qtazjegjP3teW6kg1M6FHr38gEe0lqVaEa62LZEKXhHdqfUeEDCL
   ppWNdnci/5NYPN2wDCpt7RU6TnEW32jEUDZIRcSh9qzmcYUk7/wQBX/sN
   Q==;
X-CSE-ConnectionGUID: nWklzhSzRB+ZfJiZ+kLy6w==
X-CSE-MsgGUID: 5VGgUcgCQxOkmpA6TO/NCg==
X-IronPort-AV: E=Sophos;i="6.12,219,1728943200"; 
   d="scan'208";a="40481917"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 09 Dec 2024 11:05:32 +0100
X-CheckPoint: {6756C0EC-1B-90CD5875-E0265C0B}
X-MAIL-CPID: 9AA2BE679C7A784F3A818C4F316453B2_3
X-Control-Analysis: str=0001.0A682F28.6756C0EC.00E7,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B0AA161063;
	Mon,  9 Dec 2024 11:05:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1733738728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NyqZAN0t1dGYImX+TcIzJnbZWbtpRtahPMvnfncONY=;
	b=LvZ2+XN3i3aNANKBYSt+2iPKWgtjvLhp12UvcgnsyOyi0sv3MptXB33R77DO0j4GnDiM3p
	S73bwGYOGzYtqUJ5f1mgwRR1CnvrB881Q6+8ToS/8pyjTX2b5NLPqZc0xWjgRISX7Q+TZ4
	j7tH5sH/2rSeMbPPE89Equ51bpkccHyJwmciRVBx1035FQ5dxZrOTNfSXNExpPeMrH7YTV
	SHnY5WHXwj34zu2NLn+UXSmPOkttxmiJSz59SLKaSk1thoNkpRAIMHXGd8DtX1Zw7v/pcc
	OrpRnFE+zOFhxwZQEd+xkPzcj1wXx1Av/LnGv8q5Eb2HWJ5RRQHtOWtgG4ATgg==
Message-ID: <b84140959d80439346df949f67882a9136c6977d.camel@ew.tq-group.com>
Subject: Re: [PATCH v4 1/2] can: m_can: set init flag earlier in probe
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Marc Kleine-Budde
	 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Martin =?ISO-8859-1?Q?Hundeb=F8ll?=
 <martin@geanix.com>, Markus Schneider-Pargmann <msp@baylibre.com>, "Felipe
 Balbi (Intel)" <balbi@kernel.org>, Raymond Tan <raymond.tan@intel.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Date: Mon, 09 Dec 2024 11:05:24 +0100
In-Reply-To: <e247f331cb72829fcbdfda74f31a59cbad1a6006.1728288535.git.matthias.schiffer@ew.tq-group.com>
References: 
	<e247f331cb72829fcbdfda74f31a59cbad1a6006.1728288535.git.matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 2024-10-07 at 10:23 +0200, Matthias Schiffer wrote:
> While an m_can controller usually already has the init flag from a
> hardware reset, no such reset happens on the integrated m_can_pci of the
> Intel Elkhart Lake. If the CAN controller is found in an active state,
> m_can_dev_setup() would fail because m_can_niso_supported() calls
> m_can_cccr_update_bits(), which refuses to modify any other configuration
> bits when CCCR_INIT is not set.
>=20
> To avoid this issue, set CCCR_INIT before attempting to modify any other
> configuration flags.
>=20
> Fixes: cd5a46ce6fa6 ("can: m_can: don't enable transceiver when probing")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---

Hi,

what's the status of these patches, are there remaining issues/comments? Th=
ey
still apply cleanly to linux-next.

Best regards,
Matthias


>=20
> v2: no changes
> v3: updated comment to mention Elkhart Lake
> v4: added Reviewed-by
>=20
>  drivers/net/can/m_can/m_can.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index 012c3d22b01dd..c85ac1b15f723 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1681,6 +1681,14 @@ static int m_can_dev_setup(struct m_can_classdev *=
cdev)
>  		return -EINVAL;
>  	}
> =20
> +	/* Write the INIT bit, in case no hardware reset has happened before
> +	 * the probe (for example, it was observed that the Intel Elkhart Lake
> +	 * SoCs do not properly reset the CAN controllers on reboot)
> +	 */
> +	err =3D m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
> +	if (err)
> +		return err;
> +
>  	if (!cdev->is_peripheral)
>  		netif_napi_add(dev, &cdev->napi, m_can_poll);
> =20
> @@ -1732,11 +1740,7 @@ static int m_can_dev_setup(struct m_can_classdev *=
cdev)
>  		return -EINVAL;
>  	}
> =20
> -	/* Forcing standby mode should be redundant, as the chip should be in
> -	 * standby after a reset. Write the INIT bit anyways, should the chip
> -	 * be configured by previous stage.
> -	 */
> -	return m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
> +	return 0;
>  }
> =20
>  static void m_can_stop(struct net_device *dev)

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

