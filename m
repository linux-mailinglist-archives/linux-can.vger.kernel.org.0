Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC572732E9
	for <lists+linux-can@lfdr.de>; Mon, 21 Sep 2020 21:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgIUTd4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Sep 2020 15:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbgIUTd4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 21 Sep 2020 15:33:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3565920757;
        Mon, 21 Sep 2020 19:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600716836;
        bh=o97U3EzewULg35Mi3mRHRtkdaO0je/TfbdDP9i/jnpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OamyLmUQ3GiG4ZXAPB47n410lBMl6YaTkDa3O3ss/HY3OtbzbatGD8KRX0Z7gvePM
         eHd2Q7l25vrUWPQY307s1gx/oTqn8B8/hete3h9OvLsyPeojGC0+eiurXeaxdd/HSc
         BRvQt/pkGMPDZgjx5fH1P6VS0SwabwkS25dnYf+E=
Date:   Mon, 21 Sep 2020 20:33:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        dev.kurt@vandijck-laurijssen.be
Subject: Re: [PATCH v53 2/6] can: mcp25xxfd: add regmap infrastructure
Message-ID: <20200921193302.GA45062@sirena.org.uk>
References: <20200918172536.2074504-1-mkl@pengutronix.de>
 <20200918172536.2074504-3-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20200918172536.2074504-3-mkl@pengutronix.de>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2020 at 07:25:32PM +0200, Marc Kleine-Budde wrote:

> +static int
> +mcp25xxfd_regmap_nocrc_update_bits(void *context, unsigned int reg,
> +				   unsigned int mask, unsigned int val)
> +{

This doesn't look like the hardware has an update_bits() operation so
why is there a driver specific implementation?

> +static int
> +mcp25xxfd_regmap_init_nocrc(struct mcp25xxfd_priv *priv)
> +{
> +	if (!priv->map_nocrc) {
> +		struct regmap *map;
> +
> +		map = devm_regmap_init(&priv->spi->dev, &mcp25xxfd_bus_nocrc,
> +				       priv->spi, &mcp25xxfd_regmap_nocrc);

Why all these checks to see if things might already be allocated?

> +static void mcp25xxfd_regmap_destroy_nocrc(struct mcp25xxfd_priv *priv)
> +{
> +	if (priv->map_buf_nocrc_rx) {
> +		devm_kfree(&priv->spi->dev, priv->map_buf_nocrc_rx);
> +		priv->map_buf_nocrc_rx = NULL;
> +	}

Why explicitly free managed allocations like this?

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9o/+0ACgkQJNaLcl1U
h9A39gf+JImVo0G2X863KVPu3lFPOwhlw6UGGUhhKKUD2khBbyMVtCD9CtJJiQY7
55EgR4z7Ix+KwIblPyCfwTtc9C1h35gE3xKo3oTEPCOSLCGldb/fGhpQjiXJzKSe
0hJ4JhGKNQwY6FLDo9384vPXQ/5PzXvAR+xmvraemeiveiDNM5pZNUy/2+FP7qe+
qEvagbn2/mIc0dRNdkHrzhIYHqa4X1PVZzcDyUiDQ7bm2mO++R0QMnBAA0h2r2o1
qbDllqx1jlSJdTAjMhSVcnI5qmcIi8VdRKdUXM0ErVM0Z29f/o3Sp0JRMZ9msyPw
Te5I7PcV1Ybkj3iWVt1LaXIizClQkA==
=GLkU
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
