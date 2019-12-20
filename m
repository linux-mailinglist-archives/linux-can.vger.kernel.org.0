Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A530D127897
	for <lists+linux-can@lfdr.de>; Fri, 20 Dec 2019 10:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfLTJ4f (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Dec 2019 04:56:35 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:56319 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfLTJ4f (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Dec 2019 04:56:35 -0500
X-ASG-Debug-ID: 1576835792-0a88183884185f490002-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.static.edpnet.net [77.109.77.154]) by relay-b03.edpnet.be with ESMTP id nmrRzh8yVVTbxSbB; Fri, 20 Dec 2019 10:56:33 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 025B0BD9C0A;
        Fri, 20 Dec 2019 10:56:32 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 08/11] can: c_can: remove unused enum BOSCH_C_CAN_PLATFORM
Date:   Fri, 20 Dec 2019 10:55:24 +0100
X-ASG-Orig-Subj: [PATCH 08/11] can: c_can: remove unused enum BOSCH_C_CAN_PLATFORM
Message-Id: <1576835727-2956-9-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576835793
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 628
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4344 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78781
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

This patch removes the unused enum BOSCH_C_CAN_PLATFORM.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/c_can.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index ebe0676..8387b3f 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -166,7 +166,6 @@ enum reg {
 };
 
 enum c_can_dev_id {
-	BOSCH_C_CAN_PLATFORM,
 	BOSCH_C_CAN,
 	BOSCH_D_CAN,
 };
-- 
1.8.5.rc3

