Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9253F2B0C32
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 19:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgKLSEh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Nov 2020 13:04:37 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:41519 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgKLSEg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:04:36 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id CD5ACFF1DB
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JufoMD76ZN8j for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:04:34 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 03/16] can: ems_usb: Fixed non C99 style initialization
Date:   Thu, 12 Nov 2020 19:03:33 +0100
Message-Id: <20201112180346.29070-4-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
References: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

A non C99 style struct initialization was fixed

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index a70bda631e4e..a9819287e6a7 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -553,12 +553,13 @@ static int ems_usb_write_mode(struct ems_usb *dev, u8 mode)
  */
 static int ems_usb_control_cmd(struct ems_usb *dev, u8 val)
 {
-	struct ems_cpc_msg cmd;
-
-	cmd.type = CPC_CMD_TYPE_CONTROL;
-	cmd.length = CPC_MSG_HEADER_LEN + 1;
-
-	cmd.msgid = 0;
+	struct ems_cpc_msg cmd = {
+		.type = CPC_CMD_TYPE_CONTROL,
+		.length = CPC_MSG_HEADER_LEN + 1,
+		.msgid = 0,
+		.ts_sec = 0,
+		.ts_nsec = 0
+	};
 
 	cmd.msg.generic[0] = val;
 
-- 
2.26.2

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
