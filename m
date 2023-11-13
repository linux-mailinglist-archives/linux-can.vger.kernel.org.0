Return-Path: <linux-can+bounces-11-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 844EE7E9CD5
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 14:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F6DEB209BA
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 13:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF711F618;
	Mon, 13 Nov 2023 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="I0sgutXH"
X-Original-To: linux-can@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E71DFD9;
	Mon, 13 Nov 2023 13:15:08 +0000 (UTC)
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2A5D7E;
	Mon, 13 Nov 2023 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cVVrL3n8fF3IeKqYks3FdsyfVM1zMSPfQaRac7y9ksA=; b=I0sgutXHYSf8BfwGPf6fckoYGG
	VBNiV/74qnn07W4JdxSvJ1qCTUP21PgEWPjiAnzRtZMTaLadr9/MDp3yuEXJ7yDPhmAwSE1YC5kaM
	DrVuFFTfSsSsFX4gEu5VUBFuqsxw73QMmmvPwdu2BQiEU/JQBsDJymQOJUcwOGpegQ+HPfYpLC3IP
	JegW9Z+z5zBJz4aYV2eilMmlMpyHrTd2vO+ZzLsy0l/PWK74fax4AVjfO9xzhi/IICj1JyZsS8y5y
	SyHyKnpKqEsSo9f9NRfVQo+pmG1g0eRLYSQDf+6TNuQcB6SGaBE7h6TZF8s5NZSpZZbjnQFpvXIqJ
	NNKhSRBg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1r2WmG-0007Gj-7I; Mon, 13 Nov 2023 14:14:56 +0100
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <martin@geanix.com>)
	id 1r2WmF-000XPJ-J6; Mon, 13 Nov 2023 14:14:55 +0100
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH v3 3/3] dt-bindings: can: tcan4x5x: Document the wakeup-source flag
Date: Mon, 13 Nov 2023 14:14:52 +0100
Message-ID: <20231113131452.214961-4-martin@geanix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231113131452.214961-1-martin@geanix.com>
References: <20231113131452.214961-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27092/Mon Nov 13 09:38:20 2023)

Let it be known that the tcan4x5x device can now be configured to wake
the host from suspend when a can frame is received.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---

Change in v3:
 * New patch

 Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index 170e23f0610d..20c0572c9853 100644
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -28,6 +28,8 @@ Optional properties:
 			      available with tcan4552/4553.
 	- device-wake-gpios: Wake up GPIO to wake up the TCAN device. Not
 			     available with tcan4552/4553.
+	- wakeup-source: Leave the chip running when suspended, and configure
+			 the RX interrupt to wake up the device.
 
 Example:
 tcan4x5x: tcan4x5x@0 {
@@ -42,4 +44,5 @@ tcan4x5x: tcan4x5x@0 {
 		device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
 		device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+		wakeup-source;
 };
-- 
2.42.0


