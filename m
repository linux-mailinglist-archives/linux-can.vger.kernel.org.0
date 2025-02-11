Return-Path: <linux-can+bounces-2789-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D19A30C8F
	for <lists+linux-can@lfdr.de>; Tue, 11 Feb 2025 14:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E90166079
	for <lists+linux-can@lfdr.de>; Tue, 11 Feb 2025 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2920215799;
	Tue, 11 Feb 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ar4oSygU"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C8E1F152B;
	Tue, 11 Feb 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739279558; cv=none; b=qXKmm14VqFw3VPClqtJHLtzAApQ30HDSyBKIW5h6WePOAeLeFyFpc+nypmoJEBmLdLrmGBZwMYFsUY7NnyHg1RlsDENhUc/RQinLy9VeBTsipDG6ETJSnKijbIi26tlpfaHAuzyqFdBzXbH7NdS40nUe5dXE9XYZ60C6Ujyuec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739279558; c=relaxed/simple;
	bh=pHH/VEEhxtp933DBvxvTJBeVNZvU1cFfZn4f6xruDAg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GuLst7QSkxMkkkS+xLpFuTtkOBMtrcLVdO5l8JOKDYInYTFh1z0q3M746BNECtQ8bylaFYZSUOmYdHG29wTp88Aa8qwY71eqiHyhJk4JnJSkx/OSdnZgO56kPx2O22ddx7fi0fSAIJbK/461IU4i7Ev/xp1WUpr5GcODeQJnlYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ar4oSygU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 013BAC4CEDD;
	Tue, 11 Feb 2025 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739279558;
	bh=pHH/VEEhxtp933DBvxvTJBeVNZvU1cFfZn4f6xruDAg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ar4oSygUNIQ7aj+doemEW6RSfa1lqU1dQYrqtswL2bEZe/xaEfhl55bqz6aWG8pTg
	 IlS+epjuibhwMpU3lrt+3b+QEfafaaiDaFKerqrLZtptBC6XR1slBLgjGf+uvOjPDJ
	 P/8CjJlfo39oqPQwFqbIyS0zBLlSebFajOws7dx5cVZ5hva1trWgVLaTXSlGzcKkTh
	 1y0ecBcPziQ4uJACkD790RbBnpBIcjNR9KqxCpNS50bxYVIEcAHdVoSw0lCot10EAN
	 31vnM9/LAWVlFxh59yh54GQe7tX2bnlUzyfZD35MCbhgYLtQnChGsbu5yGW/1TRr1H
	 iY9ZaUYZWMa+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ED5C0219B;
	Tue, 11 Feb 2025 13:12:37 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH 0/2] can: flexcan: add transceiver capabilities
Date: Tue, 11 Feb 2025 14:12:32 +0100
Message-Id: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMBMq2cC/x3MwQqDMAwA0F+RnA3UIkr3K8NDSNMtIJ0kQwTx3
 y0e3+Wd4GIqDq/uBJNdXX+1Yeg74C/Vj6DmZoghjkMMCcsqB1NFyhn/RtVZdBdDps1x5lLSGAK
 nOEErNpOix9O/l+u6ATJiZQJuAAAA
X-Change-ID: 20241209-flexcan-add-transceiver-caps-7cff9400c926
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739279554; l=821;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=pHH/VEEhxtp933DBvxvTJBeVNZvU1cFfZn4f6xruDAg=;
 b=WlTqqLZLzBKjiYAoPHIMvVBaRbXtH8tZTHH4nAvNgXwPAyXvmeaavGtHuHWYTXerNY6+kR+Vs
 Q1/h0A2wtWOAYmXfjSNsvY9kjhfJfGlBgebQ1JWOEA9bwW7YMN7AltP
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

Currently the flexcan driver does not support adding PHYs. Add the
capability to ensure that the PHY is in operational state when the link
is set to an "up" state.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Dimitri Fedrau (2):
      dt-bindings: can: fsl,flexcan: add transceiver capabilities
      can: flexcan: add transceiver capabilities

 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |  3 +++
 drivers/net/can/flexcan/flexcan-core.c             | 25 ++++++++++++++++------
 drivers/net/can/flexcan/flexcan.h                  |  1 +
 3 files changed, 23 insertions(+), 6 deletions(-)
---
base-commit: 25cc469d6d344f5772e9fb6a5cf9d82a690afe68
change-id: 20241209-flexcan-add-transceiver-caps-7cff9400c926

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



