Return-Path: <linux-can+bounces-937-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B3F91E6FA
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 19:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A60B1F2354F
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F042016EB67;
	Mon,  1 Jul 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwy/Cwe5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA616D4F0;
	Mon,  1 Jul 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856468; cv=none; b=qNiWJ7hg6ts4cN00rbeE41y06xliRSibw3e4gx3wHoXRzOp8Sz8KOfIlgHTuJnCaJGhdXTHMI3vmBnU1ZHRbmDU0PFYUvVF7hfsc4f+f8uuzDFfWeffdes2YsP1PaO5lIsfyPvN75V50OrCLqwm3UtebZSf5zO1uqz0XnGU5HSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856468; c=relaxed/simple;
	bh=2M79EKuCi3pO/TN3rGqmddy5hzrxk2H0nREOY8R3wis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifiiC+1l1DIqv1VtjGBBSF+xEw1boMO+pzJyEyilJOwEdosBAsjCoztkk4nb6Zmv6RmsYY8rcxl4HPDL4tIsADvHl1LWO0DTrAW1C44HirmNhW8ynKR/9pMG0oK679GsDso8tlKGeMDlpkxD7S1zbOcTpl83ccQ75HpVVXDoDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwy/Cwe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6F7C32781;
	Mon,  1 Jul 2024 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719856468;
	bh=2M79EKuCi3pO/TN3rGqmddy5hzrxk2H0nREOY8R3wis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwy/Cwe5KbiPM9h1yGqBlTc2YpppR7qVimWVUnxV3WmFk1DNjr20g0uvIj5pC7ggC
	 OQh2bbvJ7gOU2+CeZa9soDbc46Tb4F1v1koNxz44dMGHMLC+GmxNHypm0PD1nZNbwY
	 ec8vV5qgFP06jGv11FlsXlt9q5NNZF/uEXUzljA1HMYfsSxS+47knqLQK0q00Ej8pr
	 SNujCT/lxPqsRsC4Jtih4PJxqoCfZDyLC4hJLt17V0KYwe9Wchw6B/FJvJ+Qs7p4Gm
	 e4/o3362FO6TjIIGqgVvMgU4sULmuqztP3lacmDHK2NomsM5NqPr3y//MgQdqxDDk/
	 +5r8BO8fV8aVA==
Date: Mon, 1 Jul 2024 11:54:27 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>, linux-can@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, imx@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: can: fsl,flexcan: add common
 'can-transceiver' for fsl,flexcan
Message-ID: <171985646700.176465.4816542361707440956.robh@kernel.org>
References: <20240629021754.3583641-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240629021754.3583641-1-Frank.Li@nxp.com>


On Fri, 28 Jun 2024 22:17:54 -0400, Frank Li wrote:
> Add common 'can-transceiver' children node for fsl,flexcan.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: can@2180000: 'can-transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/net/can/fsl,flexcan.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - rework commit message and add fix CHECK_DTBS warning
> - Add unevaluatedProperties: false
> ---
>  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


