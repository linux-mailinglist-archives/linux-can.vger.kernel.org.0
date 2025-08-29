Return-Path: <linux-can+bounces-4390-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8290AB3B6FC
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 11:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9024189DB5E
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 09:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFD4302776;
	Fri, 29 Aug 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhJRQSm5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341A6F53E;
	Fri, 29 Aug 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459209; cv=none; b=MOAJYKkv1UjpwQlJ33ws9ZW0w+ODtNhBBKUQranVpST/6v5/VEki7pTpZEKl6eZ7o8iktOil6LciQRVtBugr7Kxa3j6z3ZjBURAaa6mNxOGBhSrmDc/3WgpAjWfc9AsfXAO/phwd4avTmkJA9oXAPw/ITS3vOdJ0WlQJzIa7Z98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459209; c=relaxed/simple;
	bh=XKpDXSN+sByAS9cR9W+5ZzKQ3tc8PFlTmx1lTt++ZzA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gQ9Y+SjrReNpTt3kxCU+i2eyhi98XeQ4S+6kZZnPeCQE6MT/pwANI2IiOAaEbZh9gpSPPADMH/NgjHIDkoTZNhJR4xWCynj7MBE+ReCrOoYHGF7WdvDwZ/Zty8mMm81IZ2ogtkom0+9a3z8ePHYAc2G0LytnvosKrIw0H2StOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhJRQSm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFEC1C4CEF0;
	Fri, 29 Aug 2025 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756459208;
	bh=XKpDXSN+sByAS9cR9W+5ZzKQ3tc8PFlTmx1lTt++ZzA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GhJRQSm5FZkI67SZV5HCgiXYa0YHQKtFQebSIMUg5eqmjxC3zbp+GjLnNVxwkVrqX
	 gbx3q5eb7qxHnoUYuVQq16oHGcpbTfkHAV1BlF5uErfbN+zgJwp4p0hN+OoEwMOge1
	 7lSbhxfjK1Gj8yTLCeoFUKmQa7V8jJ6O2wW7MiysqEjxA5XYwABsXvLiUdtV6Q2CZ6
	 qC0T+s4Yh/y5YgEZiZyWAKm0Gl78GNpDQERNZF+vUtRRuhqsbKAsXzrvSkUH6aZgEk
	 U5qM6HA9nEeHEV/tuxPPm0wd4HB8RGotZBbIu+hbzvvLeDL0T7UhCfHAZZ9ht3uPHC
	 n8RnCoiobwQzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D38CA0FF9;
	Fri, 29 Aug 2025 09:20:08 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v2 0/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
Date: Fri, 29 Aug 2025 11:19:57 +0200
Message-Id: <20250829-tja1145-support-v2-0-60997f328979@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL1wsWgC/2WNQQ6CMBBFr0JmbQ2tLaIr72FYQGeUMUrJtBIN4
 e5WElcu30v++zNEEqYIx2IGoYkjhyGD2RTg+3a4kmLMDKY0rtybSqVbq7V1Kj7HMUhSWHmP3qL
 Bdgd5NQpd+LUWz03mnmMK8l4PJv21v1b915q0KhV1WNuDRWedP92Zup5Etj48oFmW5QN8iP0Js
 QAAAA==
X-Change-ID: 20250726-tja1145-support-d6ccdc4d2da3
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756459207; l=1179;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=XKpDXSN+sByAS9cR9W+5ZzKQ3tc8PFlTmx1lTt++ZzA=;
 b=uF/G+Ymv8uMPZbfuVrFQ+2Se6z+fKUghr5aAI/7wQ2Jqvwy8CMPBxyHMXi7V8Ws6++kwLMbOL
 JyyXS6qtkYxBJMIeLmWXXO0RgsJxbDJeb2yhKs4Xvij1jn3UavaWpbM
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

Add basic driver support for NXPs TJA1145 CAN transceiver which brings the
PHY up/down by switching to normal/standby mode using SPI commands.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v2:
- bindings: Change node name in example to can-phy
- bindings: Fix order of properties, reg property is second
- bindings: Change compatible to match filename
- change compatible to nxp,tja1145-can
- Link to v1: https://lore.kernel.org/r/20250728-tja1145-support-v1-0-ebd8494d545c@liebherr.com

---
Dimitri Fedrau (2):
      dt-bindings: phy: add support for NXPs TJA1145 CAN transceiver
      phy: add basic support for NXPs TJA1145 CAN transceiver

 .../devicetree/bindings/phy/nxp,tja1145-can.yaml   |  79 +++++++++
 drivers/phy/Kconfig                                |  10 ++
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-nxp-tja1145.c                      | 185 +++++++++++++++++++++
 4 files changed, 275 insertions(+)
---
base-commit: e373c183bc8a4a421f14ea0dd1edf4f8fd79537f
change-id: 20250726-tja1145-support-d6ccdc4d2da3

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



