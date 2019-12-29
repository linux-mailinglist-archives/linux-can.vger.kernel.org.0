Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99712CA9B
	for <lists+linux-can@lfdr.de>; Sun, 29 Dec 2019 20:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfL2TVh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 29 Dec 2019 14:21:37 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:42880 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfL2TVh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 29 Dec 2019 14:21:37 -0500
X-ASG-Debug-ID: 1577647294-0a7ff5137b265c1c0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.251.adsl.dyn.edpnet.net [77.109.105.251]) by relay-b01.edpnet.be with ESMTP id yUDvh10sWLWjvfTu; Sun, 29 Dec 2019 20:21:34 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.251.adsl.dyn.edpnet.net[77.109.105.251]
X-Barracuda-Apparent-Source-IP: 77.109.105.251
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id BC5CBC02E50;
        Sun, 29 Dec 2019 20:21:33 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-input@vger.kernel.org
Cc:     linux-can@vger.kernel.org,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 4/6] cap11xx: add register definition for LED_LINK
Date:   Sun, 29 Dec 2019 20:21:15 +0100
X-ASG-Orig-Subj: [PATCH 4/6] cap11xx: add register definition for LED_LINK
Message-Id: <1577647277-8298-5-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.105.251.adsl.dyn.edpnet.net[77.109.105.251]
X-Barracuda-Start-Time: 1577647294
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 968
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5668 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78985
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/input/keyboard/cap11xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 5a7eaed..b666e9e 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -46,6 +46,7 @@
 #define CAP11XX_REG_CONFIG2		0x44
 #define CAP11XX_REG_CONFIG2_ALT_POL	BIT(6)
 #define CAP11XX_REG_SENSOR_BASE_CNT(X)	(0x50 + (X))
+#define CAP11XX_REG_SENSOR_LED_LINK	0x72
 #define CAP11XX_REG_LED_POLARITY	0x73
 #define CAP11XX_REG_LED_OUTPUT_CONTROL	0x74
 
@@ -139,6 +140,7 @@ enum {
 	{ CAP11XX_REG_STANDBY_SENSITIVITY,	0x02 },
 	{ CAP11XX_REG_STANDBY_THRESH,		0x40 },
 	{ CAP11XX_REG_CONFIG2,			0x40 },
+	{ CAP11XX_REG_SENSOR_LED_LINK,		0x00 },
 	{ CAP11XX_REG_LED_POLARITY,		0x00 },
 	{ CAP11XX_REG_SENSOR_CALIB_LSB1,	0x00 },
 	{ CAP11XX_REG_SENSOR_CALIB_LSB2,	0x00 },
-- 
1.8.5.rc3

