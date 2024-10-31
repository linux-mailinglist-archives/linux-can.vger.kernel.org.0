Return-Path: <linux-can+bounces-1850-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D429B7C22
	for <lists+linux-can@lfdr.de>; Thu, 31 Oct 2024 14:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A4A281BD6
	for <lists+linux-can@lfdr.de>; Thu, 31 Oct 2024 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DB21A0BD0;
	Thu, 31 Oct 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mApx664w"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5696819EED3;
	Thu, 31 Oct 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382493; cv=none; b=iYNKpfmosaO4eFJ0+HUikkriUDHw8qVdloZiCQAQvVvERO9bYMURFskTwQCCLOW1aRdQjCqLBxtonL/Ybpfr1T/I7kNIliqWbVUdETxMwKVS1WtbnsFm59ZAKTUIxSgxESbhHvPsrQLsU42EYADbbuwMebJHro4KGqIi/CSC14A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382493; c=relaxed/simple;
	bh=kDkC7m3oqQSef9XNgURJifDTFYYSx1SP9p0kkZEQfWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oizcyuv2AtTpqioc8EqzrEr16tJCIwIH73fX0mFipd+pxPLAdMvtXjh+yrygnSiQMUg4VlWRMTrfY1T+e5leaL5qKL7/tr3fxat1FpJjrEzBHCBu+i+ZcWMxnGX0X0+x3SNmTD89TYaE/njMhJPB3WNB7DfH2fyq103YN/NzaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mApx664w; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YfnGX28lumgmHTqcDCqW3qOBMVXALqVzMIKCAKmdGws=; b=mApx664wfNelNmFwZvtKGiRYnv
	93XYo7cKA+pbi8bHVTjOKpe3HBoYE1/aQxTha6+TPTBuruhK329JEokzXwv99qWEJ/TViSiYKNygn
	buYHmarpVlAM4pjFQma3wE3rN5u6o0/Igk1MYTtShjc/KbhyKTEGh9SauTiv/EBEKlqDbEX+n2V4I
	lgOe9kVsJbKi2hjZ0jhHOzNW30h7PP9kh9iMftSUMW+4lNMOKotsYVYyvqJeLMh97XP0spsRL/U2M
	vPIDYT+8EHRrheySwWaDXsV1zwFfCdUQufwmIzr6wiq9vzFWcPyJOK8t7eFf7jUta8gerCY3UoEpu
	X+wWAlWA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t6VAS-0005LV-5P; Thu, 31 Oct 2024 14:24:52 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t6VAR-000DTL-26;
	Thu, 31 Oct 2024 14:24:51 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 31 Oct 2024 14:24:22 +0100
Subject: [PATCH 2/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-sel option
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-tcan-wkrqv-v1-2-823dbd12fe4a@geanix.com>
References: <20241031-tcan-wkrqv-v1-0-823dbd12fe4a@geanix.com>
In-Reply-To: <20241031-tcan-wkrqv-v1-0-823dbd12fe4a@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27444/Thu Oct 31 09:34:36 2024)

nWKRQ supports an output voltage of either the internal reference voltage
(3.6V) or the reference voltage of the digital interface 0 - 6V.
Add the devicetree option ti,nwkrq-voltage-sel to be able to select
between them.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index 20c0572c9853424e1d104cbf75d02094a54836c3..f6f8b9e44c0c8dab09a0b7e3bc17d4230fcefab7 100644
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -23,6 +23,12 @@ required property details.
 Optional properties:
 	- reset-gpios: Hardwired output GPIO. If not defined then software
 		       reset.
+	- ti,nwkrq-voltage-sel: nWKRQ Pin GPO buffer voltage rail configuration.
+			        The option of this properties will tell which
+				voltage rail is used for the nWKRQ Pin.
+				Valid values are 0 and 1.
+				0: Internal voltage rail
+				1: VIO voltage rail
 	- device-state-gpios: Input GPIO that indicates if the device is in
 			      a sleep state or if the device is active. Not
 			      available with tcan4552/4553.
@@ -44,5 +50,6 @@ tcan4x5x: tcan4x5x@0 {
 		device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
 		device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+		ti,nwkrq-voltage-sel = /bits/ 8 <0>;
 		wakeup-source;
 };

-- 
2.46.2


