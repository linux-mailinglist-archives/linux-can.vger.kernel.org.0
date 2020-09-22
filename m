Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EF92741DB
	for <lists+linux-can@lfdr.de>; Tue, 22 Sep 2020 14:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIVMN6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Sep 2020 08:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgIVMN6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 22 Sep 2020 08:13:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ACCD2395C;
        Tue, 22 Sep 2020 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600776838;
        bh=oK462pC7AzAQShPgdsCfQC5ud0JAaXMl4+21uF0T0WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NcpvZqSlOYGWbV4PvWez1PSUmz79P4X+B/G8pViCWG32tl+KP42/YWJmV0d+QY/AB
         HLVkEhcYcKlBfWtd9uteJiFYyJBaaME3Pg/k2qKaA9PNRr28jyyN11e9ssv9S+IA4H
         6jogDxSPIMp47PVv4BS+AEnmVNMSzIM8NmnUMrwo=
Date:   Tue, 22 Sep 2020 13:13:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        dev.kurt@vandijck-laurijssen.be
Subject: Re: [PATCH v53 2/6] can: mcp25xxfd: add regmap infrastructure
Message-ID: <20200922121305.GT4792@sirena.org.uk>
References: <20200918172536.2074504-1-mkl@pengutronix.de>
 <20200918172536.2074504-3-mkl@pengutronix.de>
 <20200921193302.GA45062@sirena.org.uk>
 <1ae4a116-c741-fcb6-7ef7-110fd0c8c771@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zfSPj0+0wxNpTjLN"
Content-Disposition: inline
In-Reply-To: <1ae4a116-c741-fcb6-7ef7-110fd0c8c771@pengutronix.de>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--zfSPj0+0wxNpTjLN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 07:57:49AM +0200, Marc Kleine-Budde wrote:
> On 9/21/20 9:33 PM, Mark Brown wrote:

> >> +	if (priv->map_buf_nocrc_rx) {
> >> +		devm_kfree(&priv->spi->dev, priv->map_buf_nocrc_rx);
> >> +		priv->map_buf_nocrc_rx = NULL;
> >> +	}

> > Why explicitly free managed allocations like this?

> The driver covers two chips, the mcp2517fd and the mcp2518fd. Due to erratas we
> need different quirks for these variants. Further you can configure if regmap
> should use transfers with or without CRC checks (separately for register access,
> RAM access in RX and TX path).

> It's possible to distinguish between chip variants by reading/writing a
> register, so we first init the regmap with CRC mode, autodetect the chip
> variant, and then re-init the regmap with the quirks of that detected variant.

> The mcp25xxfd regmap init is written so that resources that are allocated first,
> but not needed due to different quirks are then freed (both regmap and the
> buffers for rx/tx).

This feels like a non-idiomatic way of doing this - usually you'd
enumerate then allocate the extra maps (using regmap_reinit_cache() to
replace the regmap used to do the enumeration).

--zfSPj0+0wxNpTjLN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9p6lAACgkQJNaLcl1U
h9BBCQf9GDLD0ovijfc/aga6KTfhFG55OIXcMjEyj1KtIY5TGxJ9KpM7g0a+0fwL
VrK14DiwK2r8GWuQxHbefm5YUx9pbK/27VWAL2kpu3sAGB61NZ7qk+R+UdehXVos
SUPegh3ME/V22C3nQa/RyISzyWebGX3zfjyOSDVoyD/kmXFvhde+F6ZIsLapafwZ
Be2h9f+frDjB9LbXoMMCGNJEEsHOkOFqYWSkIK7kKhnIM1Im5ln6WtLFBvi+429w
UAl0Ekh3DHTTvhdukKPMwdK72xjOrp3ApPkY/vO0hVdsWxOjzsNUT1be8pYUgNAL
t4rUaITwlj8DlxOEkg6ejL0VAr4TkA==
=nOzb
-----END PGP SIGNATURE-----

--zfSPj0+0wxNpTjLN--
