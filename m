Return-Path: <linux-can+bounces-4414-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3097B3ED2A
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 19:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440AA3B7764
	for <lists+linux-can@lfdr.de>; Mon,  1 Sep 2025 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216A341ACE;
	Mon,  1 Sep 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuUQboUP"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC48340DB5;
	Mon,  1 Sep 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746505; cv=none; b=Nj58ImEDhhYGyQWEdh1zmbtUn5QO1e5FBAsE8y39GEVW0vACytx2nb8LrM4eCw2m4W3ivhhShsA1PFRJddValNx3ddhSK4a9wl5krxrIuXzvWQKfYOO7yW9rrH75qcsiQHBAwssZDQ60tFbTJVn2+ou+xHfUePvyAPTXm9iJHdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746505; c=relaxed/simple;
	bh=PDPOiTEuTdicTffGYLtYpS4v2Fg8U7SX/u9tZo9cYOw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OLZ7idokjbUAXgnIAOtP4R3IuvqaZUwkNh1DGlPE/O+ewueoiTKIfHOScadMglT0Mjy+5RaUozXggWwkRtwF64M+1vcmf9XWWDAKI985fuH7qDOY27urtlTzqjJpIQFs5/mAH7O95mBVgSHtAhwDCuekgtMxGzbxDFZx3Y+LbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuUQboUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FEEC4CEFC;
	Mon,  1 Sep 2025 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756746505;
	bh=PDPOiTEuTdicTffGYLtYpS4v2Fg8U7SX/u9tZo9cYOw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FuUQboUPwa7jfW0jY8/itorT30MmAKHf7aVOgoxVfFiOHAnKMV7l+4iTrNXNtzDWI
	 0LANj8JpANoNPSwDABsViyTRwQIHO2PqkFHdrZqEWTJe58xFct3qksB4U7AD7bHtrU
	 F3Iv4DNS7Fse11nOjZfq51PXnXSvzR9vhjMgU9/bDipD/LKDIiddAjqvYGMACvkXLf
	 V1IlzSpx4kUxB/wgxEM6O9E2eWtbcAEAiHFfC7HfL+uKc8w+Wgiveji3aFXtaSWGPC
	 ooxNUo3Eep18sYX2rhoOONXgDjJYLy6q++AeAioMiH3adtnEjx/yKuZbF+FTwh7J3E
	 LOm3Wxy+YdCZw==
From: Vinod Koul <vkoul@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Maud Spierings <maudspierings@gocontroll.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250822-can_phy3-v1-0-73b3ba1690ee@gocontroll.com>
References: <20250822-can_phy3-v1-0-73b3ba1690ee@gocontroll.com>
Subject: Re: (subset) [PATCH 0/2] dt-bindings: phy: ti,tcan104x-can:
 Document TI TCAN1051
Message-Id: <175674649899.186496.9689107932921189012.b4-ty@kernel.org>
Date: Mon, 01 Sep 2025 22:38:18 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 22 Aug 2025 11:20:04 +0200, Maud Spierings wrote:
> The Moduline Display mainboard contains 2 TI TCAN1051 CAN transceivers,
> properly document these and add them to the devicetree.
> 
> Thank Peng Fan for inspiring this patch series.
> 
> 

Applied, thanks!

[1/2] dt-bindings: phy: ti,tcan104x-can: Document TI TCAN1051
      commit: 3d13e378d465e8ae0be1697005342055b07eaf11

Best regards,
-- 
~Vinod



