Return-Path: <linux-can+bounces-1078-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2271942ABB
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 11:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880FF1F21509
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376F31AD400;
	Wed, 31 Jul 2024 09:38:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D8F1AD3E4
	for <linux-can@vger.kernel.org>; Wed, 31 Jul 2024 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418680; cv=none; b=rjuk6rj+vFHtzkVcrXdcppV2XxLgHnfNg1qTPOP5dbEP29pJ7wkToQySnkyt2PeU+g83Fae7lKrhGZ1NpQA2/zoU/iG5kWsZnhZHvfQ3UHT5OeSRq4TMT6eNd8BPeYFZK1KeCd/58JayNSLueQP0mODbKsK7rps2nesF+q865j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418680; c=relaxed/simple;
	bh=j99WKEfBnDah/eq5FH9CNsuMV16ZA9Q3V+eV4/bIM6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pcnMxJSd5NPiva1xM5hej1bD3NJzA+hC3T9wVQVOrBpLZ0dwpI/MdA3x6Egl5YjqpCphoubWjocIkb1jO6eG8gubvqIY20bc2a0UdZMvFwIACctY4A6z9nfgykazwcKB6Tt4frM4quw3/kSr/wXMQw5ypNBTM3edyRZbZ6EG/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mO-0005aW-Gj
	for linux-can@vger.kernel.org; Wed, 31 Jul 2024 11:37:56 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mM-003Uk4-75
	for linux-can@vger.kernel.org; Wed, 31 Jul 2024 11:37:54 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E22B6312850
	for <linux-can@vger.kernel.org>; Wed, 31 Jul 2024 09:37:53 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C5E553127CC;
	Wed, 31 Jul 2024 09:37:47 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8ecea590;
	Wed, 31 Jul 2024 09:37:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 31 Jul 2024 11:37:05 +0200
Subject: [PATCH can-next v2 03/20] arm64: dts: rockchip: mecsbc: add CAN0
 and CAN1 interfaces
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-rockchip-canfd-v2-3-d9604c5b4be8@pengutronix.de>
References: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
In-Reply-To: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 David Jander <david@protonic.nl>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=6EUgL/CjJOuGqTkyqYsLA1JOqEcpFRFT9gT8iw/L1o8=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmqgXJF9Cc1ixDSiNozEP7QCK1pHk3So0zPpD6D
 NhOv4wrXB2JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqoFyQAKCRAoOKI+ei28
 bw1zB/9hrWYjRkzwD1EDCLKZXQjjP+t+suvBrweT7nPRgYi41/VDhvNDmesEdTJ5FZ6hd4I8tKx
 KYGBTS3/xTI63WvNqRLG3Dio0B2YA/1bipQ01ioRYuZHP5x/wu0MB4p4rK/c1XzYh9bqPebKjZk
 ZUDHrG9bqBWPJQ6ue5QVfsMkJJEbRnINtWuS4/H9J420XenuSyi2IeH1oM0N8azibdNR+WReHnA
 1aVUUydAeqQF8PC2XU0F7n/OmHE9ROcKhM3fvdNa0L+u46vSGMdf9oDt5HQqW+YRVRR72OsZU+4
 IfD4/W2rQCzIoJ/k5xwcoKRHcN0NYJJX/yNakuWhPrXs9xQm
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: David Jander <david@protonic.nl>

This patch adds support for the CAN0 and CAN1 interfaces to the board.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts b/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
index c2dfffc638d1..b518f430da84 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
@@ -117,6 +117,20 @@ &cpu3 {
 	cpu-supply = <&vdd_cpu>;
 };
 
+&can0 {
+	status = "okay";
+	compatible = "rockchip,rk3568v3-canfd", "rockchip,rk3568-canfd";
+	pinctrl-names = "default";
+	pinctrl-0 = <&can0m0_pins>;
+};
+
+&can1 {
+	status = "okay";
+	compatible = "rockchip,rk3568v3-canfd", "rockchip,rk3568-canfd";
+	pinctrl-names = "default";
+	pinctrl-0 = <&can1m1_pins>;
+};
+
 &gmac1 {
 	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
 	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;

-- 
2.43.0



