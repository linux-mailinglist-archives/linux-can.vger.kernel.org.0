Return-Path: <linux-can+bounces-2467-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407199F854E
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 21:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA17164DB9
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 20:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483B3201026;
	Thu, 19 Dec 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SnLw+Tf2"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA29A1FF609
	for <linux-can@vger.kernel.org>; Thu, 19 Dec 2024 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638355; cv=none; b=oH8eoVuK5z/MljHDZprE3ZzLf5QcGygmvJZgZYLROT0HJQNg3MGaTPU+Hlhe698XsrIz87UcI2AiP7gvWJuidqLTo3vbKT6BDK4uqhLJ8x7F0dm0mzi+47JwToz9sZmQa2Q+WReivbr+fwssALHbk55wRswYudN7s+bq3O8eKRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638355; c=relaxed/simple;
	bh=QvPC9XT2nTzuBVKU8Y0OkYtXeaFjH0JRpNZRrR05gzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0Gd6NlYhvnQ5DEmIiX97u6aQm7g3NVza/TOzMVGIaRNOte747h60GLnAlej61lkhWpfwSvo5qQG0EHiQpVv155fG6I5h8MDYlwB5JFRzsbhAZAAyaqzo35FZLrNM5l1Toek79ff/n0xd18mBBkAlmfXC6kcCVIF4tm1wmQ+b24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SnLw+Tf2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aabbb507998so223045366b.2
        for <linux-can@vger.kernel.org>; Thu, 19 Dec 2024 11:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734638351; x=1735243151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9z+OFIo6oYvRs30dPwtO+gLECAhFDSFhyF+Jm1Y9wnQ=;
        b=SnLw+Tf2rZViKlc+V7t1D8e3z3fpd1uD5s+SJUFoXd0UkHTZTNaoeIl/79r/YbVXep
         aIPDHNvrTkifvkVIVMTvKSKjd5jFvigE9sqPq441WgLbFPJjfJuisotqxVqjxKBSHA+a
         dUBnNpadWjhUEz/yhs+tNl7bkNmohauxrYMJla5JawiRNEgS3Ee+loZPREnPWD5lNmaW
         TGe6EaEnm7loaINWiu/j0vl0Na2OmvC7wxpnT6GU6CHNSUoFYFMRXOPa0rOVDbFWMeqP
         SqKulM/EUmeUxZHk8WLcE26QrI94V43tje7BfPu4AMHhaOX3HT6vx4qoWPI+3anQrThm
         H6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734638351; x=1735243151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z+OFIo6oYvRs30dPwtO+gLECAhFDSFhyF+Jm1Y9wnQ=;
        b=kEBRFSef33gB5nqssAqAQRaEbp/4x/3gAGkvSGf8h5ksrkcnUu2sx0eygOimOX8QKT
         tW4yltuCrelZEAd/c3IeshCsK9mwpKUBmEWLmR3mfOO3KoXi7dtWKxp98t7yjfTsA9dB
         OJ91eHi/+VsHa886wv695FjXocEUBg2PbU8k1fPTspEyh+b8e1PcdK1Oq59pt6aOrz2+
         cLo1DOqddC+FHRyrveIZDnSYyI7AdLBN3/NX9QUEK+TMq8hkBSJcXNydGIIFkXKZ0tjD
         XjFRod54bvvxqCdgh56zDRXxsgqgAW9c1Azn3JnMkNPZDDghZEewXsT5VuGk/lt9i3K/
         L3BA==
X-Gm-Message-State: AOJu0YwUeMH35izfeROsztMWUYtZW/55bUBvX62olw2m/Y78W0YgQpYf
	ZS0eQPNuYf5wKaWl9qalx5jC9HdCaprK64lYtvoiKQjC5TLVLYyYrkKfjqe5s/s=
X-Gm-Gg: ASbGncvRmX6Nad/mE3pu0uiEPRuFknPc1dXqWZAVIyTCFxmk4tvG/JQr27pQmKicDvP
	PeK+yzchqsglfPd/jlxTMKjTxl1ZIcjMyZ8df7/1mkBHZp9ZSOQvt3JSN9qyQA0OE6SpaSl+yXF
	7feQNmRXAy2jCtzReG/re+UqWV6djB7q9lXARw7wjQyfcF54Ik/p6Wtx0FWlfmxbAZwk5qsEu35
	yiIDGL1lh6RHZBLBxoz3CCzl08tyNboEhn2C8xRlSeei9QvKA==
X-Google-Smtp-Source: AGHT+IF4QehdfOuEvDMqzB9MY4lPolUTGRMgbZDTTZ30MZlE7/TjNW2+5MWxblm0XOXTHJASMqJcPw==
X-Received: by 2002:a17:907:6d17:b0:aa6:8211:ff85 with SMTP id a640c23a62f3a-aac2d479750mr6446266b.35.1734638350970;
        Thu, 19 Dec 2024 11:59:10 -0800 (PST)
Received: from localhost ([2001:4090:a244:82f5:6854:cb:184:5d19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e894781sm97668366b.44.2024.12.19.11.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:59:10 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 19 Dec 2024 20:57:57 +0100
Subject: [PATCH v6 6/7] arm64: dts: ti: k3-am62a-mcu: Mark mcu_mcan0/1 as
 wakeup-source
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-topic-mcan-wakeup-source-v6-12-v6-6-1356c7f7cfda@baylibre.com>
References: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
In-Reply-To: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=msp@baylibre.com;
 h=from:subject:message-id; bh=QvPC9XT2nTzuBVKU8Y0OkYtXeaFjH0JRpNZRrR05gzg=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJTqn6Hqj1OYj4hs2fjkpBZl9sNVrwPbMm60vH0xXVTv
 onsrKedO0pZGMQ4GGTFFFnuflj4rk7u+oKIdY8cYeawMoEMYeDiFICJFB5k+B/sFhC+ul/0kEPe
 742zNtvt/yYQbtX24KrUqrP8c+1bpTYzMrQeOJiUdmw+t6m6tPe1CfzCWh8FzRY9ySycxqF5sCf
 0Ci8A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
accordingly in the devicetree.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index 0469c766b769e46068f23e0073f951aa094c456f..7f88f284ea5daeba189976d03dbd048626104b77 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -161,6 +161,7 @@ mcu_mcan0: can@4e08000 {
 		clocks = <&k3_clks 188 6>, <&k3_clks 188 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source = "suspend", "poweroff";
 		status = "disabled";
 	};
 
@@ -173,6 +174,7 @@ mcu_mcan1: can@4e18000 {
 		clocks = <&k3_clks 189 6>, <&k3_clks 189 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source = "suspend", "poweroff";
 		status = "disabled";
 	};
 };

-- 
2.45.2


