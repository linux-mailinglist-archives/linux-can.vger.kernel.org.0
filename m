Return-Path: <linux-can+bounces-5144-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61269BD23D5
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06CAE349588
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981962FD1D4;
	Mon, 13 Oct 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je7/Q9dg"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A882FD1B6;
	Mon, 13 Oct 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347170; cv=none; b=d4/zbETJRK9/bCk2khN9oiEIe0rpZOHVxmNvU5u0LGM44RDOShWk1R0KLLQQ1T08WvqN8YSJFhJJ0SrONnRoJyfrjC9iRGO5kHs7QEy7WPPoGPOC/EFt9yeHF+2tuoY2RvbXq6jpPNW22cF7CJxhiKKR0rjCJrwRg8V97Tc910Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347170; c=relaxed/simple;
	bh=DD7IBJHeQ8o/jhi5QgFhDQOe2dxMtOoT5L78yQPxeMk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WXRVzrHZfDd+KxZKooh8tLY1VoJR2P2eTV0NCcCblSqcnhQtJd8tLFBUPlEopQms+E/a+hkzJnWdUXzxgEbZ0lRZ/sgLl+aQ+Ud24tGEHkjQMoFDyM0in6uxz0V9Bg13tM+rSHpWBhKHjOPXRSf0p6bEyE3E8gSk1kYc8pDahWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Je7/Q9dg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22FEBC4CEE7;
	Mon, 13 Oct 2025 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760347170;
	bh=DD7IBJHeQ8o/jhi5QgFhDQOe2dxMtOoT5L78yQPxeMk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Je7/Q9dgrk5e2fghLh8TD5fxfA/uwU/+9E+kobL2ut4DICEffqstXQQkPidOHdGOo
	 jjYMoWcg86wDDlIFCm6hE9dNVbV6cQVvlWfaYh9TikePowPvaUYa7P37zXFwoZAIWY
	 jyOMPB9gRe/ekbsV9ZBzeBc8G1+PMHE6nyAe1Ee+em5CgLmPjYzhtjGHdfD+nsWY/s
	 KXA5E67uu7bDSGKRhhmljPLiW3ro5Up5Bbw47J8OudLiqIT5qUBV7lNdf8gErW8ps/
	 YagblQSfpN6mD6AeAGIRAw5MBdI9N84lOjKiikK0psT/83b2bms391+bcoQqLJbwDg
	 fERYpoonj7G0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10808CCD185;
	Mon, 13 Oct 2025 09:19:30 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v3 0/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
Date: Mon, 13 Oct 2025 11:19:17 +0200
Message-Id: <20251013-tja1145-support-v3-0-4a9d245fe067@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABXE7GgC/2XN0Q6CIBTG8VdpXEeDIyh01Xu0LhSOSStxYKzmf
 PfQrbXl5f/bzu9MJGJwGMlxN5GAyUXn+xzFfkdMV/dXpM7mJsBAsgpKOt5qzoWk8TkMPozUlsZ
 YIyzYuiD5agjYutcqni+5OxdHH97rg8SX9WupjZU4ZRQbq4QWVgppTneHTYchHIx/kIVL8CMU6
 C0BmSiZ1lVbgNKV/iPmef4ABCgwJvQAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760347168; l=1548;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=DD7IBJHeQ8o/jhi5QgFhDQOe2dxMtOoT5L78yQPxeMk=;
 b=ZRnpk9YG8ASHR8WG5ZA1i3FsQK8yIJ+Z0JZ6GRA9tzyJsw0vYU+L4prkFIu5L82Ix4T8JroDF
 CS7U3JPWslFAMp38rAdVv6bKFM9b4lHy3sYfGpBc14fVXGf18D9xNOh
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

 .../devicetree/bindings/phy/nxp,tja1145-can.yaml   |  79 +++++++++
 drivers/phy/Kconfig                                |  10 ++
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-nxp-tja1145.c                      | 185 +++++++++++++++++++++
 4 files changed, 275 insertions(+)
---
base-commit: 920852baf6bdffb2818c0de8ff3437d8f6570dc2
change-id: 20250726-tja1145-support-d6ccdc4d2da3

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



