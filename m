Return-Path: <linux-can+bounces-4189-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745D9B1D251
	for <lists+linux-can@lfdr.de>; Thu,  7 Aug 2025 08:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D69556485A
	for <lists+linux-can@lfdr.de>; Thu,  7 Aug 2025 06:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C5021ADB9;
	Thu,  7 Aug 2025 06:09:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C42116E9
	for <linux-can@vger.kernel.org>; Thu,  7 Aug 2025 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754546988; cv=none; b=hB30mM6SvE5Wf/plzMuujo2fp++ovHuXzYgAT1o5yOcR/il4Dw0r49SdpEvKeR3bAuPGJ6soLg9J1vk793PBbQcufXXS/HXqH3Q+XCJjWSKcb1qNHqT8cTreNX6rN+8oK6uF7zP+6YZuaP+Q7pZ3nkO3S81ggVDjCltouqtDiSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754546988; c=relaxed/simple;
	bh=iej0cdjc27k6Bz33u+4F6cGRHPmWzI4nQIndAd+/u4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mHMS0c5LKZnskjdCYBrx44P2dkCHLA/FHohRhMSiUGVFD6vlVwqnTWk/ereFpLWf+bGKrfY1utRqbVCeuirQ1Ngtxarkc2RlTqCDa1JWidLVaLQD4LK+qdoZCOgj9Ojo+79P3qUmqtFRFyoyxtzGpykCfee6k7YjWVrXNn7Xzms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ujtov-0001WV-IV
	for linux-can@vger.kernel.org; Thu, 07 Aug 2025 08:09:45 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ujtov-00CKXj-0V
	for linux-can@vger.kernel.org;
	Thu, 07 Aug 2025 08:09:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D32FF452513
	for <linux-can@vger.kernel.org>; Thu, 07 Aug 2025 06:09:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D72C74524EF;
	Thu, 07 Aug 2025 06:09:41 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0258dc56;
	Thu, 7 Aug 2025 06:09:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 07 Aug 2025 08:09:30 +0200
Subject: [PATCH v2 1/2] dt-binding: can: m_can: add optional resets
 property
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-stm32mp15-m_can-add-reset-v2-1-f69ebbfced1f@pengutronix.de>
References: <20250807-stm32mp15-m_can-add-reset-v2-0-f69ebbfced1f@pengutronix.de>
In-Reply-To: <20250807-stm32mp15-m_can-add-reset-v2-0-f69ebbfced1f@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=767; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=iej0cdjc27k6Bz33u+4F6cGRHPmWzI4nQIndAd+/u4o=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBolEMeg2lxWTBq3MMvHt25j9u6XXC9I/VkjDdGX
 k/6brPbb9eJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaJRDHgAKCRAMdGXf+ZCR
 nDcfB/46rZcF18AjrXct7AOwzpzUrbFpJPu1JY0dGrhO/g5HBMLJSzpesMYyGxb563gu1Zmh1mR
 xx4xFP3yX7WGilhlxg6wBNSLjoTcMZPy9Tkjuzp55DukC9ZzGJ9DZupfM5ShEykfDIX5VhkkHsM
 mkxUjouLtJt7nt7+M5B9ce0TVLayuf+7BA+cfz4rF9gSdosCXLp5iAwSzxvuvS298zbX2SNxVOX
 M/sqxqPmllLpRIRXKHLiDsvzlEoOSX9dTon8FZZU7PMdz/k7heI8SAOfNBvKg2zJpphKQjSUNLj
 EUwxPLtVM1zI3NvftYu2DsX3zRjSFdknETy1ahWklUxW2Ie6
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The m_can IP core has an external reset line. Add it to the bindings
documentation.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index c4887522e8fe..61ef60d8f1c7 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -50,6 +50,9 @@ properties:
       - const: hclk
       - const: cclk
 
+  resets:
+    maxItems: 1
+
   bosch,mram-cfg:
     description: |
       Message RAM configuration data.

-- 
2.47.2



