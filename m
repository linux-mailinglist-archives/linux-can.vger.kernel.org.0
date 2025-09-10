Return-Path: <linux-can+bounces-4595-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB72B50B16
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 04:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487E63AA459
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 02:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D2623ED5E;
	Wed, 10 Sep 2025 02:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tL2iQTK7"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C251A9F8D;
	Wed, 10 Sep 2025 02:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757471638; cv=none; b=RYiNMavPFLandqtHJtEEzrXxnhvRIiLmqe0IMaN15Dy1pUb+Y1MKsqMQ5lbhajTk4fp1kuGvKx6mv138/ROAymi3tMlPr9KyzeSfWt0KpJkpqsQZEJmAAu+UOcUTcYA068saHLy8yVrP+MaUp2Fwc3pYbSr429fNNIe6Tho+QmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757471638; c=relaxed/simple;
	bh=NyQYty60WG79Ajy9YjwZu9E6f2nEyB4rPacOiU0exWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+oiix4AoIrjglFuhXEs9rhJV4rF+2wv327gzHyMyfXPvu0gYKMo9TEAS4NGK1HhR5Qs9dMpWZGOOIks6KainoWsuulkcww1QK8Dvwyat6g3304y91pdHTC8cq1eGL0XaU0lhzhpVJYiHINg7RZet7dZo1wBAKIacSFc04YOJI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tL2iQTK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8169BC4CEF4;
	Wed, 10 Sep 2025 02:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757471637;
	bh=NyQYty60WG79Ajy9YjwZu9E6f2nEyB4rPacOiU0exWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tL2iQTK7/qoJqZPfXtGtfD+boglUsVkU1PN/sLlQnbaC6+bBW2/XOzSmXAHKMmy1N
	 Y17/ertrfN/z7mlVbt1yBWIKc28ZOv9g5Kt1rNcenjRau06OI3RtHZqhHJYJgsEHSx
	 Cxw7YAeKNXA0bNFZZVQM8CypEwVDk34dSMqMT9hrNu5Cw/yJBzH28kkrAT9CLJqgM1
	 vzOwTKZe1POUVmIkBZyxLYV7q+0TVGzT5E6uG7ttNCcP8Vwo5Zf+AWi2ehEWMwfiNf
	 T5ofNzGCJViHFPzrfVVCYxgka3MYOXrFppQveQsgH0hCa1ytO31N5VE8dSp1DrxUfr
	 U1K3jxqSEAfvw==
Date: Tue, 9 Sep 2025 21:33:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	Aswath Govindraju <a-govindraju@ti.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v6 1/9] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA105X/1048
Message-ID: <175747163614.3662311.16406999049647270497.robh@kernel.org>
References: <20250909-can-v6-0-1cc30715224c@nxp.com>
 <20250909-can-v6-1-1cc30715224c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-can-v6-1-1cc30715224c@nxp.com>


On Tue, 09 Sep 2025 13:40:11 +0800, Peng Fan wrote:
> The TJA1048 is a dual high-speed CAN transceiver with sleep mode supported
> and no EN pin.
> 
> The TJA1051 is a high-speed CAN transceiver with slient mode supported,
> but only TJA1051T/E has EN pin. To make it simple, make enable-gpios as
> optional for TJA1051.
> 
> The TJA1057 is a high-speed CAN transceiver with slient mode supported
> and no EN pin.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 69 +++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


