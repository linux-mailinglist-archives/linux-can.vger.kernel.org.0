Return-Path: <linux-can+bounces-4298-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC79B312C5
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 11:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1E5A0874A
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8682EB5C9;
	Fri, 22 Aug 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ithyFqKz"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797CC2E7163;
	Fri, 22 Aug 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854409; cv=none; b=OD90LtVzbrzo1LIy9Sh0sxOarrGNmdu9ejj1sH8Aum/0hIJ6OHh6/qtOnM3JkZRvbH11Cua+hFMVw8/5UwjlOQslZQqsxQXaYClyj2BsvOpXjTUNh/HF2IZ1zI9YDqnEpXJrMbkOGm5+jB+TRXlNMaA2tOJgjx2xvJutIIMurhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854409; c=relaxed/simple;
	bh=pJwGTa7qHTBfaL9aAmiyFWO5jIhPuYuiPmJDsbad+Pk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gIuSJ9AxOeeqXjTQ/Ez23Se0Kek5Rtj/zijFw6S6CnPGvHVKiryJAsTNCL5fJgYvX2WvzoC/y+QavJWym8xQvAZrPiJAU8ZBEQhMLWsxJA8ySzRPpICXjWMjijyZXqCEVvnJqvXv+BLndR/LTUyDZr9NDuH4yeYIIkm692xWnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ithyFqKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00678C4CEF1;
	Fri, 22 Aug 2025 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755854409;
	bh=pJwGTa7qHTBfaL9aAmiyFWO5jIhPuYuiPmJDsbad+Pk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ithyFqKzBpsqFCto1lla25dIcWrrpms+WcZ1ObPegaM+CFRAK84nk4Sd5sV5Xf7Q2
	 TBnllAA+zXV7007H4f4Y64zvbMDXzLPRKXV08Ke2Plp6HSS28EZydNfLuPKb6TIoZR
	 OGz5HECLHLEzX/yKeHvhM4PwovzDVWvrzTPxMRsU5aC4V2eH3dE1/ktNlB6zqR5E+9
	 oYxZrq2GL2CgjPTzlCxrw2Gbx2i+UsDha+6UH/YqELRgdguxjInI7lNJUoNBfyXDY5
	 jGcHp4BL0YcAOrB2IkxVlVKdpB+l2cRaQ21UBrn0qO+z/0DQmOG7eqDwFRykQqPvW7
	 4lc9u6X/6xwRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F41CA0EEB;
	Fri, 22 Aug 2025 09:20:08 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Subject: [PATCH 0/2] dt-bindings: phy: ti,tcan104x-can: Document TI
 TCAN1051
Date: Fri, 22 Aug 2025 11:20:04 +0200
Message-Id: <20250822-can_phy3-v1-0-73b3ba1690ee@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQ2qGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyMj3eTEvPiCjEpjXVMTozRTQxOTZMtUUyWg8oKi1LTMCrBR0bG1tQB
 jqt2YWgAAAA==
X-Change-ID: 20250822-can_phy3-542f5144c9e5
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755854408; l=796;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=pJwGTa7qHTBfaL9aAmiyFWO5jIhPuYuiPmJDsbad+Pk=;
 b=aHvGYtqv3q+QlxMdbuZHJYuNTM+a/CTkqkpJlO5kTKnARtfvn9Yn5wTvrT/45eBcUvBYDcmUg
 NFQXckPE6eAApx+Djex8Konhp03Twirzntgp3C5YrKWzmdCzfpbqyyN
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

The Moduline Display mainboard contains 2 TI TCAN1051 CAN transceivers,
properly document these and add them to the devicetree.

Thank Peng Fan for inspiring this patch series.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
Maud Spierings (2):
      dt-bindings: phy: ti,tcan104x-can: Document TI TCAN1051
      arm64: dts: freescale: imx8mp-moduline-display-106: Use phys to replace xceiver-supply

 .../devicetree/bindings/phy/ti,tcan104x-can.yaml   |  1 +
 .../imx8mp-tx8p-ml81-moduline-display-106.dts      | 46 +++++++++++-----------
 2 files changed, 23 insertions(+), 24 deletions(-)
---
base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
change-id: 20250822-can_phy3-542f5144c9e5

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>



