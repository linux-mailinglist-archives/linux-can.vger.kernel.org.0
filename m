Return-Path: <linux-can+bounces-5499-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9503C6AEDC
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 18:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A93F52D4D0
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 17:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59D35FF7F;
	Tue, 18 Nov 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRCAJX0o"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DED35A954;
	Tue, 18 Nov 2025 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486298; cv=none; b=ucmLC20sjsLRf737NfdNjM2V6DcnKcmi6NTI+9y0xczreENKzVYTlM3zNNJcHGbr0L2bAMGAp+vvPk7hvCuI+cUD6W+rNGyJ0VOQD1krmxU5QE4QSM5GBxBVXS+NzBRk4bVVG3fkowcQYZriMLPW/HtFPGunZYzHYteGyde/h2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486298; c=relaxed/simple;
	bh=1wHwuQs+KyZl1yodXT0yg2BEqvi1f1TTUhu+LxUU8GQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ObOw0t/6Udx9569Ow2UusoBHAgx0KImnNqqkgFCbqr9cQYA84Fed2/GdA7x4cQpEREKQ0DadeH7W8Yi5s1kORhgOLK/RIM0EAK9LnbieZwo9jiBAk/QsOw1htqtEDcmDwumDRKiS0eA6xMAwSQ5Hl/9t1WkRo5SBGrpy1DixElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRCAJX0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1A7C4CEF1;
	Tue, 18 Nov 2025 17:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763486298;
	bh=1wHwuQs+KyZl1yodXT0yg2BEqvi1f1TTUhu+LxUU8GQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LRCAJX0oKd0lqfZIIz9qm2DQH9x++4W0Rqi4wLfSn7Gaeiu3LgztD6PqX4xut/MP4
	 pc8KyM8sEBvZ3zG0x/UBt7gSHiElvE4IThaggzpADKhINojZkohQXHkJLRa+w/oojJ
	 KTEbmVeTN3E32VSabX+mxr7/CjiJ7kAv0xysHrovD8PdGs7/3/nGsTeSbtsttNeZdK
	 SA7HohyzyJ2x5xKotD6EBSFbiq3Zo63zThivF8bfzoJTq2Wz/rWOjXXYd/5SY6jK71
	 DeT5rTgq7uLGNdhlEXUgOgQvYErjn7mpbLGjIPBR//zGRnREFKT8aWy0okkz9c7ad9
	 CDLTaHo3ttjDA==
From: Vinod Koul <vkoul@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20251001-can-v7-0-fad29efc3884@nxp.com>
References: <20251001-can-v7-0-fad29efc3884@nxp.com>
Subject: Re: (subset) [PATCH v7 0/8] phy: phy-can-transceiver: Support
 TJA1048/TJA1051
Message-Id: <176348629150.62598.2560301627293635701.b4-ty@kernel.org>
Date: Tue, 18 Nov 2025 22:48:11 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 01 Oct 2025 21:22:31 +0800, Peng Fan wrote:
> TJA1048 is a Dual channel can transceiver with Sleep mode supported.
> TJA105{1,7} is a Single Channel can transceiver with Sleep mode supported.
> 
> To support them:
> patch 1: add binding doc
> patch 2/3: To support dual channel,
>    - Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy
>      has two channels.
>    - Introduce can_transceiver_priv as a higher level encapsulation for
>      phy, mux_state, num_ch.
>    - Alloc a phy for each channel
> patch 4: Simplify code
> patch 5: Add TJA1051,7 support
> Others: Update dts to use phys.
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: phy: ti,tcan104x-can: Document NXP TJA105X/1048
      commit: 05ace63d0bcfe131e741923394c7ce03322a141e
[2/8] phy: phy-can-transceiver: Introduce can_transceiver_priv
      commit: c77464bd9b4155891a135e51f8e916e1ab94fc14
[3/8] phy: phy-can-transceiver: Add dual channel support for TJA1048
      commit: 6e9fe9409e10ed25b43928062832037752630979
[4/8] phy: phy-can-transceiver: Drop the gpio desc check
      commit: d02a7eb12924b7473a62d5a6c9e670fe5bf6e4b7
[5/8] phy: phy-can-transceiver: Add support for TJA105{1,7}
      commit: b817f505926b8ffbdea8aa87b66a622acb9b96e9

Best regards,
-- 
~Vinod



