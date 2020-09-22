Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7A3274426
	for <lists+linux-can@lfdr.de>; Tue, 22 Sep 2020 16:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgIVOYs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Sep 2020 10:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgIVOYr (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 22 Sep 2020 10:24:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 654842395B;
        Tue, 22 Sep 2020 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600784686;
        bh=yoHreTyYSZEF3nybTeK/Klzn1WzHKctyRn7s2fD9JWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Skt91DRMoWlAwIiF8R4RO5VPNnm4XiMC+1uGODrIQ2CaPc+0qGD1KumL0umi7cAth
         lsnxwYeCxndgulcV92owmdaqixicY7p8AAl3wDbR296CKbEgu1FQCHEDlTG1IvLGKu
         hMNJt4OMP43LGn7rdWldwWqS5mU0Y3j4T9+3xsLM=
Date:   Tue, 22 Sep 2020 15:23:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        dev.kurt@vandijck-laurijssen.be
Subject: Re: [PATCH v53 2/6] can: mcp25xxfd: add regmap infrastructure
Message-ID: <20200922142353.GV4792@sirena.org.uk>
References: <20200918172536.2074504-1-mkl@pengutronix.de>
 <20200918172536.2074504-3-mkl@pengutronix.de>
 <20200921193302.GA45062@sirena.org.uk>
 <1ae4a116-c741-fcb6-7ef7-110fd0c8c771@pengutronix.de>
 <20200922121305.GT4792@sirena.org.uk>
 <e483ba1f-5958-4ba6-e82e-be611247ccd1@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PSXRUCbmiibGgnYg"
Content-Disposition: inline
In-Reply-To: <e483ba1f-5958-4ba6-e82e-be611247ccd1@pengutronix.de>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--PSXRUCbmiibGgnYg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 03:56:38PM +0200, Marc Kleine-Budde wrote:
> On 9/22/20 2:13 PM, Mark Brown wrote:

> > This feels like a non-idiomatic way of doing this - usually you'd
> > enumerate then allocate the extra maps (using regmap_reinit_cache() to
> > replace the regmap used to do the enumeration).

> I have implemented two regmap clients for this driver. One does transfers with
> CRC, the other one not. Both are REGCACHE_NONE.

Hrm, right.  The assumption when that was written was that nothing
fundamental would change about the regmap format but we should probably
extend to allow that since it's the general idea.  However it looks like
that might not be needed here.

> For autodetection the driver initializes the regmap which does transfers with
> CRC. Then it detects the chip variant and maybe that variant works properly
> without CRC. The CRC regmap is not needed anymore, so the buffer used to
> linearize the data, is freed.

That flow sounds sensible but the way the code is written it's really
not clear that this is what's going on since there's only one init
function with no indication that it'll be invoked multiple times, the
logic for detection is in a completely separate place and functions by
changing the quirk flags underneath this code - just reading the regmap
handling alone you'd be hard pressed to spot that this is what's going
on.  It might be clearer to have an explicit function to generate the
regmap for detection and then call the current function _reinit(),
which would also allow it to be a bit more explicit about the
transitions (if it only needs to handle the CRC->no CRC transition).
Failing that at least some comments about what's going on would be
useful, even just a "this will be called twice because...".

--PSXRUCbmiibGgnYg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9qCPgACgkQJNaLcl1U
h9CNmAf7BAOds8D5KGX0F3S1ab6FA9rxkzC7Jn1lUyqBziKYLCDZ8h4+0pwogze/
XsqqHQhv1m899aFPs5REP9PPfpnWzA8WNqRcu5qUH3YMBH/L7vrnmXe8XxXiWDl/
ErQV/E5B+EWAZ93dta0OdLFvw3d1yFcoyDitQvyNFJuAyG5OeAhGVWYalw/+XKmE
JqVJPn+AyqE8pyde4WoNkf4MMGWy4VOEc3VONua2Wlr2IcwYelVgbNjLaw3skWcf
Dc+tMEHOz/qiGv0y5DHL6qS+bviXvd4P+0ly/kLm+owxoBGVEXUbhxKKkS7c/L74
wJuHVE/P7oLe6g3uOsTkpgD5WKbchQ==
=AJLf
-----END PGP SIGNATURE-----

--PSXRUCbmiibGgnYg--
