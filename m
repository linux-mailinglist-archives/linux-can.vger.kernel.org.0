Return-Path: <linux-can+bounces-2790-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23398A30C90
	for <lists+linux-can@lfdr.de>; Tue, 11 Feb 2025 14:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF0D163D23
	for <lists+linux-can@lfdr.de>; Tue, 11 Feb 2025 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBF821D5A9;
	Tue, 11 Feb 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biDPLoeF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDB021772B;
	Tue, 11 Feb 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739279558; cv=none; b=S95t8sVQ+TAPoazkhGPJKXi4QABWKfhgv3wuKiCydqIDv50IkSRhSUaqgrIbhIrrUret0IDa8Y00sL8DrcKCK1YeQwDl67BOgX5UtHk9HrxvSMi1GAs7A3lMZInDzsMCJvwpz8VQ2oex4pFx/8rg7AFs2PHXUZswp0xHVcq5Gtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739279558; c=relaxed/simple;
	bh=vF4SL1wQfg96MCtiLQj+VpIKobClI9f9l9PY0xzClFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQqMbSDXOn5Zu0FNNIpOgYq2r7K2T1HJcvlBQ3xP/NPNHQWMsRIDebtlF52n2LfUrfoEDJVDMlsatGFeuM1sYWpTG2MLi8M0aY3IheXINbfkFb255t92z+PYWd9Jk7lCfOHwvUW0obVWWpJyV42G8DdWPP91/JpV40fSs9Rc41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biDPLoeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AD2FC4CEE6;
	Tue, 11 Feb 2025 13:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739279558;
	bh=vF4SL1wQfg96MCtiLQj+VpIKobClI9f9l9PY0xzClFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=biDPLoeFwNwi6H8SJsKZ39Qpb4PqVUdtssf9azjXtaCmrKQZyr/IgvrTaUg4gVt1Y
	 ztIXi0J8OGedU7unLjIRUp/XQp/eOX1i4L+/Qllo6gZM8xfdMUWqYuFgWRCEoTdzth
	 ecOkyu6eRFAY4HYU+buxIANFxa5IOg2nkQ5UlPrlmTVm76gnbyY+KbtPyee+pNfVSG
	 k+8g7qmrSJ8uf6jqcfYl8QjGC1Uy/rFWWDZRXQHfcEmfa5XOyvw2EayRAFq57QOWhv
	 B0h9gOaQpc90c5LFhTmfi9gWvIofjSLsb0WJmzhHyBkGAoMbFPniIGzbbjW4oKgAUX
	 3nLvFs4QXotKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2400CC0219D;
	Tue, 11 Feb 2025 13:12:38 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 11 Feb 2025 14:12:33 +0100
Subject: [PATCH 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-flexcan-add-transceiver-caps-v1-1-c6abb7817b0f@liebherr.com>
References: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
In-Reply-To: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739279554; l=952;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=+ZZYio4M7OHFLaxgdm65MWmmCFRzyUpLb+CpAcuf2Co=;
 b=2lUyXGvYMswKVuxLmcLHTeHYnSaLQrqe9UTnCD3nA64B4F+12qVf+RJtFCJ7beJU3/Sjb+mYI
 vOK8s12mH4KCMdG39+YqM8Xkum6WYtyDgyDbaFqv82wgZ+woCwHupEe
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Currently the flexcan driver does not support adding PHYs. Add the
capability to ensure that the PHY is in operational state when the link
is set to an "up" state.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 97dd1a7c5ed26bb7f1b2f78c326d91e2c299938a..397957569588a61111a313cf9107e29dacc9e667 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -70,6 +70,9 @@ properties:
   xceiver-supply:
     description: Regulator that powers the CAN transceiver.
 
+  phys:
+    maxItems: 1
+
   big-endian:
     $ref: /schemas/types.yaml#/definitions/flag
     description: |

-- 
2.39.5



