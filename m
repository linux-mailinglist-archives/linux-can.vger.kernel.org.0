Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D30112CA99
	for <lists+linux-can@lfdr.de>; Sun, 29 Dec 2019 20:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfL2TVg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 29 Dec 2019 14:21:36 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:49935 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfL2TVg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 29 Dec 2019 14:21:36 -0500
X-ASG-Debug-ID: 1577647292-0a881838821e9eb50002-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.251.adsl.dyn.edpnet.net [77.109.105.251]) by relay-b03.edpnet.be with ESMTP id nLP9ivC5iCUY5JBe; Sun, 29 Dec 2019 20:21:34 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.251.adsl.dyn.edpnet.net[77.109.105.251]
X-Barracuda-Apparent-Source-IP: 77.109.105.251
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 95BFCC02E4A;
        Sun, 29 Dec 2019 20:21:33 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-input@vger.kernel.org
Cc:     linux-can@vger.kernel.org,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 1/6] cap11xx: set device driver_data
Date:   Sun, 29 Dec 2019 20:21:12 +0100
X-ASG-Orig-Subj: [PATCH 1/6] cap11xx: set device driver_data
Message-Id: <1577647277-8298-2-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.105.251.adsl.dyn.edpnet.net[77.109.105.251]
X-Barracuda-Start-Time: 1577647293
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 660
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8039 1.0000 2.2578
X-Barracuda-Spam-Score: 2.26
X-Barracuda-Spam-Status: No, SCORE=2.26 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
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
index 688e2be..16287ab 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -346,6 +346,8 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
 	if (!priv)
 		return -ENOMEM;
 
+	i2c_set_clientdata(i2c_client, priv);
+
 	priv->regmap = devm_regmap_init_i2c(i2c_client, &cap11xx_regmap_config);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
-- 
1.8.5.rc3

