Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3F12CA9A
	for <lists+linux-can@lfdr.de>; Sun, 29 Dec 2019 20:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfL2TVh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 29 Dec 2019 14:21:37 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:49943 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfL2TVh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 29 Dec 2019 14:21:37 -0500
X-ASG-Debug-ID: 1577647294-0a881838811ea3530001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.251.adsl.dyn.edpnet.net [77.109.105.251]) by relay-b03.edpnet.be with ESMTP id YoLEJElyW3zDPPBm; Sun, 29 Dec 2019 20:21:34 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.251.adsl.dyn.edpnet.net[77.109.105.251]
X-Barracuda-Apparent-Source-IP: 77.109.105.251
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id C132AC02E52;
        Sun, 29 Dec 2019 20:21:33 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-input@vger.kernel.org
Cc:     linux-can@vger.kernel.org,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 5/6] cap11xx: enable all 8 inputs
Date:   Sun, 29 Dec 2019 20:21:16 +0100
X-ASG-Orig-Subj: [PATCH 5/6] cap11xx: enable all 8 inputs
Message-Id: <1577647277-8298-6-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.105.251.adsl.dyn.edpnet.net[77.109.105.251]
X-Barracuda-Start-Time: 1577647294
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1810
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9940 1.0000 4.2732
X-Barracuda-Spam-Score: 4.76
X-Barracuda-Spam-Status: No, SCORE=4.76 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=UPPERCASE_50_75, UPPERCASE_50_75_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78985
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 UPPERCASE_50_75        message body is 50-75% uppercase
        0.49 UPPERCASE_50_75_2      message body is 50-75% uppercase
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/input/keyboard/cap11xx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index b666e9e..cdcc89b9 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -117,13 +117,13 @@ enum {
 	{ CAP11XX_REG_NOISE_FLAG_STATUS,	0x00 },
 	{ CAP11XX_REG_SENSITIVITY_CONTROL,	0x2f },
 	{ CAP11XX_REG_CONFIG,			0x20 },
-	{ CAP11XX_REG_SENSOR_ENABLE,		0x3f },
+	{ CAP11XX_REG_SENSOR_ENABLE,		0xff },
 	{ CAP11XX_REG_SENSOR_CONFIG,		0xa4 },
 	{ CAP11XX_REG_SENSOR_CONFIG2,		0x07 },
 	{ CAP11XX_REG_SAMPLING_CONFIG,		0x39 },
 	{ CAP11XX_REG_CALIBRATION,		0x00 },
-	{ CAP11XX_REG_INT_ENABLE,		0x3f },
-	{ CAP11XX_REG_REPEAT_RATE,		0x3f },
+	{ CAP11XX_REG_INT_ENABLE,		0xff },
+	{ CAP11XX_REG_REPEAT_RATE,		0xff },
 	{ CAP11XX_REG_MT_CONFIG,		0x80 },
 	{ CAP11XX_REG_MT_PATTERN_CONFIG,	0x00 },
 	{ CAP11XX_REG_MT_PATTERN,		0x3f },
@@ -134,6 +134,8 @@ enum {
 	{ CAP11XX_REG_SENSOR_THRESH(3),		0x40 },
 	{ CAP11XX_REG_SENSOR_THRESH(4),		0x40 },
 	{ CAP11XX_REG_SENSOR_THRESH(5),		0x40 },
+	{ CAP11XX_REG_SENSOR_THRESH(6),		0x40 },
+	{ CAP11XX_REG_SENSOR_THRESH(7),		0x40 },
 	{ CAP11XX_REG_SENSOR_NOISE_THRESH,	0x01 },
 	{ CAP11XX_REG_STANDBY_CHANNEL,		0x00 },
 	{ CAP11XX_REG_STANDBY_CONFIG,		0x39 },
@@ -157,6 +159,8 @@ static bool cap11xx_volatile_reg(struct device *dev, unsigned int reg)
 	case CAP11XX_REG_SENOR_DELTA(3):
 	case CAP11XX_REG_SENOR_DELTA(4):
 	case CAP11XX_REG_SENOR_DELTA(5):
+	case CAP11XX_REG_SENOR_DELTA(6):
+	case CAP11XX_REG_SENOR_DELTA(7):
 	case CAP11XX_REG_PRODUCT_ID:
 	case CAP11XX_REG_MANUFACTURER_ID:
 	case CAP11XX_REG_REVISION:
-- 
1.8.5.rc3

