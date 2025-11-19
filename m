Return-Path: <linux-can+bounces-5501-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59628C6F260
	for <lists+linux-can@lfdr.de>; Wed, 19 Nov 2025 15:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66CF84FAF4A
	for <lists+linux-can@lfdr.de>; Wed, 19 Nov 2025 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D52363C6C;
	Wed, 19 Nov 2025 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QQDJInVC"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD82328604
	for <linux-can@vger.kernel.org>; Wed, 19 Nov 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560236; cv=none; b=U+BgxC8lMtc+3enQVZbQcsiOKNfwJ0GAJH6HKDElQjVev2Iy98gzuYqaKVuA0pee2IIs+8nnd+FDeK9K/95BYLpYv5IEPWANMc1/xoIXZ/gGsGhotqm0lPzpHHTduLohk4iNTIWOj9Z6uRFZ9zis71voG6kEjLBDQ5QcnC67KYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560236; c=relaxed/simple;
	bh=xrOBH/zqlYxtJPa4oYZinfQykWwnli55FtSZu3cbtZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oexWHDygqvelPXBcrKs2gbRutiV8BMHdWdmKy98uRoDUU3ISrHbFZhjxlLWDhmLvpCrdUCXF4vfRglgiNo06pXzPQXoBoFRuZwAUayAk78o6JaVas3sIz+h9omxhk9FjAbpewulvknv/opWol5gnhUVcXK2hkUhBJxTnPjq+ej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QQDJInVC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so9566951a12.2
        for <linux-can@vger.kernel.org>; Wed, 19 Nov 2025 05:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763560231; x=1764165031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+JebhRh5Ge/kjpdhLwoK42CbOPJ05afP64o/Gn1ji4=;
        b=QQDJInVCNe/IimFd7weJjxsYfzSuvQyyOTtcyYJqkmiBWt+kJf+0Ts8Cv0uoNnr0Pl
         pC4VfMPz2HBVt3+WrbuwoYFa9uXrxMGX9gYgnysl5EZejNE9P6qg65oTGUznmEUolHBA
         PHmgXyD3qjg//BShGTle40xnoBWmdc7B39mx0X4AYLofTpIid0Xly0LpUXSBDFHkw9Y4
         sOyPBaXixmLatuuHPBpVn3gJfiP0uL1IMi3uFBrIB+cE9dlcQTGjHTE9qJRgxBgCdi+O
         JhxTdu293q5VLh6b04VKFjKA/GcLxqOjlWwODXhRQhSn+p7tqyRp8k4B6DD4f6fvR8on
         Lqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560231; x=1764165031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T+JebhRh5Ge/kjpdhLwoK42CbOPJ05afP64o/Gn1ji4=;
        b=guXWZ4xJqfKMW2RSYm6fEb3fMDUyQP6eJL/6o89TXzzQIoRx3Fxvd9LFWiRwgW3hfh
         V/By0mi0H+zAYC9k2AzFfN95/SXADImqo1ZOin/PcX8zWaeCnNX/juWzV+EBH02/WbZE
         +XiXAX4ZbPiY07uBW8tguMpzkOjRT04z6MN/YVuma/W4x31NxEWrgCn0gGYgT++qqiSM
         kuAC8b9IymPx37Fw3dlWTOkA66gqMEe3eYtM1zPFZy08Mr4X1CzBRnS6opG2Fafp8E1R
         JqZ91xykiyke7plJbgBaoGxo1LnFmewVwzTGixq6DZ3Jff4LBALkTw0jaqoMh/kR1HNd
         RP6g==
X-Gm-Message-State: AOJu0YyESnaXzW3R59kHeG3mQ8nu8I2eepjFM81dnXuPHKhH7BiCD3E+
	ADCAGsonx/TTfzPh36QICGyG8UFAjxcJeiZLt5vGsLOqEDoUPiMJVSIPkfsOOUxeuPQ=
X-Gm-Gg: ASbGncthhdB3F88Wb13hetopDTJ8swkA8/XuVS0+qEKfEuqgTLBSeNbYUw9an3m2U7S
	YQLEnpvEXEjZ64QAS8ErakvxBqCv79aNNUQpPEBNHWpDb6ApN7XwylZfLoazlmbdhCD7S4wEtFD
	Qt6sO1rpLyYz4gS9CcjzQE2sQyOAfdNWIOaoi0OjUKfExiEwHqwGRw2X5ObDQy3ZTBaLm3rLvb9
	hq+X2yvfpGwt8oZij7/J8hw/CG3g5D34rrsuRgYx2ZnndJou9k0hnRqSZRhHseErcTAXohC+Rlp
	23pnxrDF0AZAkkwFSu53J8+obkseL7OBvfiyjpNRx3eQVcwmiGnem/PG0WnfSKBdzZuKN3U8Hia
	5r+V8wXfBnX5qK3FsKAxg4SXyRZYRGfBKR7KbBsmhDgQyjwrZLZ3ChjyPbDMiNj8cgZUgjpUOu7
	rrZXA=
X-Google-Smtp-Source: AGHT+IE9e9WaWGxZrPZZHWXHVaz6tBbhmG2ui7g7HgmdfNb2eRRYqxSIfrAKDTcUtc982g6i84EiwA==
X-Received: by 2002:a05:6402:50c8:b0:641:3492:723d with SMTP id 4fb4d7f45d1cf-64350e236b2mr19201514a12.11.1763560230504;
        Wed, 19 Nov 2025 05:50:30 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6433a3d82cfsm15120007a12.2.2025.11.19.05.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:50:30 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 19 Nov 2025 14:50:03 +0100
Subject: [PATCH v2 2/2] MAINTAINERS: Simplify m_can section
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-topic-mcan-reviewer-v6-18-v2-2-f842c3094b18@baylibre.com>
References: <20251119-topic-mcan-reviewer-v6-18-v2-0-f842c3094b18@baylibre.com>
In-Reply-To: <20251119-topic-mcan-reviewer-v6-18-v2-0-f842c3094b18@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=msp@baylibre.com;
 h=from:subject:message-id; bh=xrOBH/zqlYxtJPa4oYZinfQykWwnli55FtSZu3cbtZc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzZ07KX7tx2WZb6cO7G0DXd1pHHou/2NO0LS/58Sy0j6
 kaJGbdcRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzkribDP6uNW9/uKspSfZJ7
 56hFqWb89ZDEk+sldu6z7HZVSr/+vpDhf1HPlU8Sz8XMOJod52zh/7LtT1KTd9uKXTVb/a48TXl
 2jB0A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Simplify the section by using the whole m_can directory. This includes a
few new files, e.g. Kconfig, Makefile, m_can_pci.c and tcan4x5x* which
are all closely coupled to the m_can driver core.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cb4130f66bf80392ca7a0e77a9b930f32a126af8..0904c2fd6b897d8c984ca7b6c35e7a3e0fb65253 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15392,14 +15392,12 @@ S:	Supported
 F:	drivers/net/phy/mxl-86110.c
 F:	drivers/net/phy/mxl-gpy.c
 
-MCAN MMIO DEVICE DRIVER
+MCAN DEVICE DRIVER
 M:	Markus Schneider-Pargmann <msp@baylibre.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
-F:	drivers/net/can/m_can/m_can.c
-F:	drivers/net/can/m_can/m_can.h
-F:	drivers/net/can/m_can/m_can_platform.c
+F:	drivers/net/can/m_can/
 
 MCBA MICROCHIP CAN BUS ANALYZER TOOL DRIVER
 R:	Yasushi SHOJI <yashi@spacecubics.com>

-- 
2.51.0


