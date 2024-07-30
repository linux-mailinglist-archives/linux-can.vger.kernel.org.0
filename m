Return-Path: <linux-can+bounces-1065-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9189419E6
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 18:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33381F2782B
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763AF1898E9;
	Tue, 30 Jul 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYx05w+l"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C11A619B;
	Tue, 30 Jul 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357456; cv=none; b=rDNEmQcWpe9CNKWmqoC1ijuv3MtmyQKQtgFXydnB0Dxf4ONfPxPY/DJg3a3AilnMpidrxx/abv1l/XnR9bOKQVFMNxo//6Fi4Xo14YXLopGwi4XyijTo3xmlTtsjbwqDtk7kaAuxYCBFSE56LWZPbOJKOEGK/NhivBAFrZSf8Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357456; c=relaxed/simple;
	bh=IZnrgju2UE3ttoRGRDJsGzu6kxTRyR3poGUPLXgoINI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2GBGzIF7rpSEj9ZAWZnXNLMMqxsifRRVqvG/z59/zxXA3NaZXeSkpmWXG6C+0nMK0hxOWYwsKCGZmwe/GsTyY13kncRVgFXh8/2QZDZa6h0m8IAgGnZX41xq4H+oge2MZsixOupxBCgMuncOXfF/rz5vVfG6PNo9XdmVg1LCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYx05w+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403A6C32782;
	Tue, 30 Jul 2024 16:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722357456;
	bh=IZnrgju2UE3ttoRGRDJsGzu6kxTRyR3poGUPLXgoINI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYx05w+lggKad+7kxiOgbr3aKEnJcYXVTcXpmJO1psJ0eXGxezWdzPfeQ7m7yfbnj
	 Odo7L/ufXiILOqVGaWgqQL57V/HWqSWUA1vEbTzj9YpeQyPNshVNDfvayjAhGeCFsn
	 ND2RFfavrtRypdFsjgj4KkbBGhryQi7ZXF2MpNVaAtoXXbkTubysnkO55Q0X6zAd+r
	 8kkWTaz4YmZzEAf2dAjeLq6ZylejpAeUaWIktYWkceR5d3H/+4X4E2PpSLeEZS8dIS
	 xrzwTH9EqndBn6IAMN+lH5U5+p+VF/ex0sngo2SoQ3nCrjkmjp8STkDkmWC9QwTwMR
	 2RaO6Vn/jjc0Q==
Date: Tue, 30 Jul 2024 17:37:30 +0100
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
Subject: Re: [PATCH can-next 11/21] can: rockchip_canfd: add functions to
 check if CAN-FD frames are equal
Message-ID: <20240730163730.GC1967603@kernel.org>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
 <20240729-rockchip-canfd-v1-11-fa1250fd6be3@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-rockchip-canfd-v1-11-fa1250fd6be3@pengutronix.de>

On Mon, Jul 29, 2024 at 03:05:42PM +0200, Marc Kleine-Budde wrote:
> Add a pair new functions to check if 2 struct canfd_frame are equal.
> The 1st checks if the header of the CAN frames are equal, the 2nd
> checks if the data portion are equal:
> 
> - rkcanfd_can_frame_header_equal()
> - rkcanfd_can_frame_data_equal()
> 
> This functionality is needed in the next patch.

nit: I would squash this into the next patch as
     rkcanfd_can_frame_header_equal() is defined but
     unused in this patch, which is flagged by
     allmodconfig W=1 builds.

...

