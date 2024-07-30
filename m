Return-Path: <linux-can+bounces-1063-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05200941938
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 18:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF89F1F24BB2
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DE51898EB;
	Tue, 30 Jul 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1/ysDqu"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF98BE8;
	Tue, 30 Jul 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357020; cv=none; b=CYN/q8ZHlpL+5h5JcZ1zCY7bhQtZBaqeIZBl2mR4QriByJ48v9/45VHZcs0N2Gz21SXME/42uO4tkm+jzkr2UrZZ2ZQGwBt+EFL+SW7Ee2i9Lu57nrQgJe8ciZAB/vKIvRMiBDmbIRsFlsFnVj49A8qMqfuqHKS4HHgp9JFwpCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357020; c=relaxed/simple;
	bh=lhNcZ8ZEN5axq+CHqFJ7t45r9e7XQ0fIr4cY5Y/XNZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nApnmZvjujNQCR/i8doJC0pIWwSEeTY9khIJ9SVTLWdV9srFAsYlnwJwtQLIzuUKCa/mlejBBT/jNxWeH/zxn36VQgLF1QHKbjAjCvvdSVX7NAQIcuCPlE6Felxi+05EyTOiZlT3SvLhkwvArJhh5YP2m+2uklqSvg6brtLOPYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1/ysDqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D675CC4AF0A;
	Tue, 30 Jul 2024 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722357020;
	bh=lhNcZ8ZEN5axq+CHqFJ7t45r9e7XQ0fIr4cY5Y/XNZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1/ysDqurtwedhyL2BI5lr4jACXoOR7RkG3q1LQ0Mt8chwVcNtO3dpKsOTH3YNYY3
	 q9M8YFUT6zqNswbQgxugD9D9IDziuZNP4nKZD2V2nhsrkNDP0D8Z1c1ZnAVKg2xBuo
	 yuIhLuhquJGC/eSxVqxJYKQvrp1baRY/n66TGzb97Ei7Y+NZArkn3t8Ma9jIPuQPsp
	 JXypy/Uf5ZHtmPNIoNC59tfmA25QgasPj/tWs4BHOtWTptZsPa1lSzehYQ5ngw4vsZ
	 JeVlu0uR1SyUu69PG78cGazGnYYNdK3ZGVQDzMt+4h5v2OoE84NyCag8LcmdGJOKH5
	 /CyLOjWq5LKhw==
Date: Tue, 30 Jul 2024 17:30:14 +0100
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
Message-ID: <20240730163014.GC1781874@kernel.org>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
 <20240729-rockchip-canfd-v1-19-fa1250fd6be3@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-rockchip-canfd-v1-19-fa1250fd6be3@pengutronix.de>

On Mon, Jul 29, 2024 at 03:05:50PM +0200, Marc Kleine-Budde wrote:
> Add support for hardware based timestamping.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Hi Marc,

This patch seems to break allmodconfig builds on (at least) x86_64
when applied to net-next.

In file included from drivers/net/can/rockchip/rockchip_canfd-ethtool.c:9:
drivers/net/can/rockchip/rockchip_canfd.h:471:29: error: field 'cc' has incomplete type
  471 |         struct cyclecounter cc;

...

