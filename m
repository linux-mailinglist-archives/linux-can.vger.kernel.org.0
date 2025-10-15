Return-Path: <linux-can+bounces-5195-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE3BDD27D
	for <lists+linux-can@lfdr.de>; Wed, 15 Oct 2025 09:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D511889A64
	for <lists+linux-can@lfdr.de>; Wed, 15 Oct 2025 07:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD4830F803;
	Wed, 15 Oct 2025 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2hOcqS5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C237233D85;
	Wed, 15 Oct 2025 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513846; cv=none; b=YGceZctsaKbuBFEqIWFOxbzMS8Qy8Yjg+idi/l8D122giK0fKfNdvOzzWJE2rc2bmS9WjPUvsNXSJDPn3zrCSTeED9hndLw09P9n3EekFqe0JoBcNc/Rm+kBvw2g7hlXWizylRe5cauU0cTFvAPPgtGNVrzuIQMrpV2Bv/1YPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513846; c=relaxed/simple;
	bh=Oi5QOWrlBOX6yjuVT9iWF7d8j671eUjkCoZ0gfy4CMQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HbRk7vrq1agc6o/rv1M+O6NaemocgJU/7diyyVTjf4vcqRHyQ3p0gGc8Gw473jyzhrJRuE3I3oAwT5EAD5R0pulpHU8luX3SXnXhjhN3Y9FJEhlmaINiY4BDIXaaZ1Zthc9ZFnLH1JsYb8ZIskpvau4/Ou2X8TmciwA7VIMBXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2hOcqS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5758C4CEF8;
	Wed, 15 Oct 2025 07:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760513845;
	bh=Oi5QOWrlBOX6yjuVT9iWF7d8j671eUjkCoZ0gfy4CMQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=A2hOcqS57kZ4iJbJ55KoJcKe+geXFHO0h7z6Jsw15/tWyfCBebXPQtbLCYwlrSlDA
	 6A345Y7S7IYHL0sDB9Zn6MK9qedrUPfxN7tdK03nDOcygnhV5Q7P5m7QgPt8LpJs1b
	 V6Og/aN6uH/syRscNZk4ljy5dPuqnh5hqfspd1HKkpOuPG42HwLhsyyp0YzNNf7Imf
	 H+XfRormyGxMG/hgzYwYYVPjJkg4MatRqWE9pjza3lB9IoSssUJDruxeKsQfrxtHQJ
	 cZcZo7WHBeW/jBs/UOjlLzYaugQR7HAOxwbDCESmZmv0iINwVDmuoEp3p0qENhJBEv
	 RzyXaEsKMa16g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B90CCCD185;
	Wed, 15 Oct 2025 07:37:25 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v4 0/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
Date: Wed, 15 Oct 2025 09:37:07 +0200
Message-Id: <20251015-tja1145-support-v4-0-4d3ca13c8881@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNP72gC/23N0Q6CIBTG8VdpXEeDA6h01Xu0LhSOSStxYK7mf
 PfQrdqyy/+3nd8ZScTgMJL9ZiQBBxedb1PI7YaYpmzPSJ1NTYCBYjlktL+UnEtF473rfOipzYy
 xRlqwpSDpqgtYu8ciHk+pGxd7H57Lg4HP69sqVtbAKaNY2UJqaZVU5nB1WDUYws74G5m5Ab5EA
 XpNQCIypnVeCyh0rv8Q4kNwxsWaEImQpbYgVY0sy3+IaZpejYzTjjcBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760513844; l=1889;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=Oi5QOWrlBOX6yjuVT9iWF7d8j671eUjkCoZ0gfy4CMQ=;
 b=mPtPFEbP4lBXsbQ5kzDNF6r8woIMJ57Bjg3T/ImFi75H7cQwfG6o+SE6c571+dwh9D3G/2nG9
 CrfMlvJiIVXB60dK0CgTrpHMofbu0z3gGbrJrI0jIeQy+OOuc3uUikf
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
Changes in v4:
- Change compatible to: nxp,tja1145 (Connor)
- Mark spi-cpha as required (Connor)
- Switch from unevaluatedProperties: false to
  additionalProperties: false (Connor)
- Remove double newline after tja1145_rd_table (Marc)
- Link to v3: https://lore.kernel.org/r/20251013-tja1145-support-v3-0-4a9d245fe067@liebherr.com

Changes in v3:
- bindings: fix SPI bus unit address format error
- bindings: added resolution of discussion into commit msg
- Checked binding with:
  make dt_binding_check DT_SCHEMA_FILES=nxp,tja1145-can.yaml
  Missed it for V2, didn't do it intentionally. Sorry.
- Link to v2: https://lore.kernel.org/r/20250829-tja1145-support-v2-0-60997f328979@liebherr.com

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

 .../devicetree/bindings/phy/nxp,tja1145.yaml       |  80 +++++++++
 drivers/phy/Kconfig                                |  10 ++
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-nxp-tja1145.c                      | 184 +++++++++++++++++++++
 4 files changed, 275 insertions(+)
---
base-commit: 920852baf6bdffb2818c0de8ff3437d8f6570dc2
change-id: 20250726-tja1145-support-d6ccdc4d2da3

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



