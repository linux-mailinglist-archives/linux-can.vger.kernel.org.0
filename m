Return-Path: <linux-can+bounces-970-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ABD92F26D
	for <lists+linux-can@lfdr.de>; Fri, 12 Jul 2024 01:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C291C2296E
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 23:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3751D1A0711;
	Thu, 11 Jul 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEqEsqRQ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4B130487;
	Thu, 11 Jul 2024 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720738874; cv=none; b=EawHOtrxghdik09B/k06myXyLCAHtbA4NDN3WAjgDzX9wB4zg7qpKxfxUUjwivoCykyZdXyEynfZgURIMvGb3yM5efuXCtLYRMRnku7EwxcJD2alUaeFruGNax3887UfWEYINot0GjbKYZFR5AqoEIbMo2uOzm6MAZ8NfhGf0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720738874; c=relaxed/simple;
	bh=RO8Wi7LsNtSVOjKnh3Rni8Wc0vJub79bAX4WF0NF7I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLyFFbAbdRL7oKOPYb2k+rWfUt5CAUCXwo/AY3YosT763ECR8+5ejxFnn9imjFPPFjfVGACqiEyvU69DGShURg9fhX0rdtrr1KOg/DhNWVQPcOIERpl/egzVATgNXs04cNloD11gWuXpFQagPruCaMigWGQpdt2TkRHac9Zyp2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEqEsqRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA63C116B1;
	Thu, 11 Jul 2024 23:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720738873;
	bh=RO8Wi7LsNtSVOjKnh3Rni8Wc0vJub79bAX4WF0NF7I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZEqEsqRQev9iXBeDGgSmnzFrn9OIDqFUpGTpLxG39mo9KBlR6fq58g8/PcqBskKxC
	 bSf0XISzieldwrsLVu1LNiZ34NJdbHv2+B9/762vwEJ0wfm+2wrhNkIdfyaLnJ8rWx
	 CgYEBePCiFVZfJfenCK+2ubzTT1ewXd536KQuz67+MDtki2N4BkVjGooK46hXGcyuF
	 ibiZ4LmBsMUdOGkfvtmHSiNbQD07iGG0Ex1E5VZrNtS3h+7G2hFwCm0EAopoVMvGe+
	 Xn3Li/5UX2FihJD89E/sujt3ZHenrx7bSSEzJjkO2NdxN+PEiqweJrC2988c7ulBz8
	 RLYLec+hLfyHw==
Date: Thu, 11 Jul 2024 17:01:12 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, han.xu@nxp.com,
	Eric Dumazet <edumazet@google.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, haibo.chen@nxp.com
Subject: Re: [PATCH 3/4] bingdings: can: flexcan: move fsl,imx95-flexcan
 standalone
Message-ID: <172073887154.3280495.283425972699397722.robh@kernel.org>
References: <20240711-flexcan-v1-0-d5210ec0a34b@nxp.com>
 <20240711-flexcan-v1-3-d5210ec0a34b@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-flexcan-v1-3-d5210ec0a34b@nxp.com>


On Thu, 11 Jul 2024 14:20:02 -0400, Frank Li wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The flexcan in iMX95 is not compatible with imx93 because wakeup method is
> difference. Make fsl,imx95-flexcan not fallback to fsl,imx93-flexcan.
> 
> Reviewed-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


