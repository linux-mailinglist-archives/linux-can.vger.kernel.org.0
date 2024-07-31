Return-Path: <linux-can+bounces-1074-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE0B9429E6
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 11:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF54BB220A0
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 09:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604BB1AAE0E;
	Wed, 31 Jul 2024 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8GUH++n"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E81CF93;
	Wed, 31 Jul 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416663; cv=none; b=E6DjQqLi2F2me6g2uDBpMARF9jAOoep+/nj+0LilysAlt22gLzOQ+uFaEVF8qBoFIK4H/bEwl2xwcTzzQtdjxCpXICxqbJyvW/YEmSs9/++qmg3edPQloaNBQYyj5ezEF2fvX1bfCZeztdmGVb/lejgDjaaEthXnSzctj7Dd1rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416663; c=relaxed/simple;
	bh=qlrQ42mj9B9KmeAFuisuUfxEP8kY222/qGxSpLmiHus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2LPQpXX5CuByH9vybFqqJrjINP5twZyp0gF9fZy+dbvfI/LyvZy5NsSibYjQ8yc8e/UyPTVH/LenV1NkasSJnB/wegrk1F3TsGf5TKceIbDNU+khMI2JL1OeYcH/0dazEeaAoedzHD5KsVdW5yE2/2Qluf2nnkuv1tYywNPz1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8GUH++n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE1DC116B1;
	Wed, 31 Jul 2024 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722416662;
	bh=qlrQ42mj9B9KmeAFuisuUfxEP8kY222/qGxSpLmiHus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8GUH++nX2ioiBIyXoWexRei+cHlXC+HGvVQhlJmKWE1D9UB9RYvYL1qMHT3hyLkT
	 ksQWHP6uEK9lr57oAbUnwErdnwVmglT9XJGCX30mY46klT+F8TywrC7RNqnYpTg4SZ
	 vmVyNFoV3Z/3wLWPPpI+kYNrBiH/j+tZPT5jM9i7IGFoiDs85TNwxsfxiHQ+v+B/0l
	 Z9+rVFiSw1CI3IQa4Uz8pGx2OX/9KrsP3z2Dug8RPGilF+hsfJ4ZErdlD29sijy+lu
	 6BAT5ZtQ/MnWCAhLX1lb3vpjdG4z4wcp8IoNxP5wJHwM7R/UyvrfXun9gDaLlblFu4
	 0oljdVzE6jI0w==
Date: Wed, 31 Jul 2024 10:04:16 +0100
From: Simon Horman <horms@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	David Jander <david.jander@protonic.nl>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next 19/21] can: rockchip_canfd: add hardware
 timestamping support
Message-ID: <20240731090416.GP1967603@kernel.org>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
 <20240729-rockchip-canfd-v1-19-fa1250fd6be3@pengutronix.de>
 <20240730163014.GC1781874@kernel.org>
 <20240731-powerful-scarlet-bullfrog-6ccccd-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-powerful-scarlet-bullfrog-6ccccd-mkl@pengutronix.de>

On Wed, Jul 31, 2024 at 10:00:41AM +0200, Marc Kleine-Budde wrote:
> On 30.07.2024 17:30:14, Simon Horman wrote:
> > On Mon, Jul 29, 2024 at 03:05:50PM +0200, Marc Kleine-Budde wrote:
> > > Add support for hardware based timestamping.
> > > 
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > 
> > Hi Marc,
> > 
> > This patch seems to break allmodconfig builds on (at least) x86_64
> > when applied to net-next.
> > 
> > In file included from drivers/net/can/rockchip/rockchip_canfd-ethtool.c:9:
> > drivers/net/can/rockchip/rockchip_canfd.h:471:29: error: field 'cc' has incomplete type
> >   471 |         struct cyclecounter cc;
> 
> The required header gets somehow pulled in on arm64, but it even fails
> on arm. Fixed.

Interesting times :)

Thanks for addressing this, and likewise my feedback on other patches
in this series.

