Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FF456B912
	for <lists+linux-can@lfdr.de>; Fri,  8 Jul 2022 13:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbiGHL5r (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 07:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbiGHL5p (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 07:57:45 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A409A9B186
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 04:57:43 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 19so4788878ljz.4
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 04:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NXXsssa0Oa6oVbfFuUiaggrtfmN/lTLlD62fIs+3ZQ=;
        b=sOHfse0AAcON9w5KxuOUzegiWmY2TUSeuhg1IQmN92qayvo+ggbrXT7R+3gzgN442w
         XXTlhM8YWBKjw/a/mcsBfw7poepc4cew2krU/9B5uS+9yB9VghmFrtslu7U7mRKAfgZ2
         Edjsx6vSK0l+fhTfv3iPbBu6y99iGByz1KbX7ToWaFfN+do1qFUH66d3iJElf4QtIOdr
         oEN7KdKIJEZcuf2jmiscIJcmJMFnuomUP8hLPTPabHARz+FxWw/Cng2L5oMp9jgUK9gb
         8Rahz1GYYDByZIhw/picTilLLe8oxCPoP1YXeUvb06zrpzxID1hJXfRFlacoc1Qm68ZG
         7HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3NXXsssa0Oa6oVbfFuUiaggrtfmN/lTLlD62fIs+3ZQ=;
        b=deq9tY1p3+udjQwirJJlgVAAiKQvk7sm0WbOe2XN1tjdMiY9veXWM+W0i1f+ozEJem
         cyODpBRGP3A0VcZscUJxw07mXJ8GS95cNFFymO+YimfgZJ5+xksogxTBQ+ovA6u7Bb7O
         WNuhQWs0qOZNRUvKLqdD49DU9ZnAs62srySpD5+8ccJR9XfWpqtlMj0LafnZcLaMmeWN
         JSNtc18/g3pMRSCUCSuy3LuI6wkgsk35WrEmYVz8UOvSQUA7BxqnBYbsisLCJfGRixzN
         zPwXHfkCTzD/Z4RbWAxRo65fPPBg6h3wq6dWAAKi+EZs/cwPOE+2Pe3kD8LedYIWXEZ+
         fTzA==
X-Gm-Message-State: AJIora89vpUtAC13v/tDzAwBseml5vDb5qcXspVgQb73FyXMbm9VhfFI
        Gz3c26t0tqfm95EEJdBrS+bBCLsf2j/f7w==
X-Google-Smtp-Source: AGRyM1vljMUHY0wAFQlh/gXkApxyL110HsrU6rWKrgb+iA/5emDsJWKU+lMABZAmsdeGDfA2hnrvZA==
X-Received: by 2002:a2e:a901:0:b0:25d:244e:842c with SMTP id j1-20020a2ea901000000b0025d244e842cmr1790796ljq.406.1657281462011;
        Fri, 08 Jul 2022 04:57:42 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e9ec7000000b0025a724f2935sm7336199ljk.137.2022.07.08.04.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:57:41 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 07/15] can: kvaser_usb_leaf: Set Warning state even without bus errors
Date:   Fri,  8 Jul 2022 13:57:01 +0200
Message-Id: <20220708115709.232815-8-extja@kvaser.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708115709.232815-1-extja@kvaser.com>
References: <20220708115709.232815-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi>

kvaser_usb_leaf_rx_error_update_can_state() sets error state according
to error counters when the hardware does not indicate a specific state
directly.

However, this is currently gated behind a check for
M16C_STATE_BUS_ERROR which does not always seem to be set when error
counters are increasing, and may not be set when error counters are
decreasing.

This causes the CAN_STATE_ERROR_WARNING state to not be set in some
cases even when appropriate.

Change the code to set error state from counters even without
M16C_STATE_BUS_ERROR.

The Error-Passive case seems superfluous as it is already set via
M16C_STATE_BUS_PASSIVE flag above, but it is kept for now.

Tested with 0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")

 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 6488eae7f00c..8f9e2707998d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -961,20 +961,16 @@ kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
 		new_state = CAN_STATE_BUS_OFF;
 	} else if (es->status & M16C_STATE_BUS_PASSIVE) {
 		new_state = CAN_STATE_ERROR_PASSIVE;
-	} else if (es->status & M16C_STATE_BUS_ERROR) {
+	} else if ((es->status & M16C_STATE_BUS_ERROR) &&
+		   cur_state >= CAN_STATE_BUS_OFF) {
 		/* Guard against spurious error events after a busoff */
-		if (cur_state < CAN_STATE_BUS_OFF) {
-			if (es->txerr >= 128 || es->rxerr >= 128)
-				new_state = CAN_STATE_ERROR_PASSIVE;
-			else if (es->txerr >= 96 || es->rxerr >= 96)
-				new_state = CAN_STATE_ERROR_WARNING;
-			else if (cur_state > CAN_STATE_ERROR_ACTIVE)
-				new_state = CAN_STATE_ERROR_ACTIVE;
-		}
-	}
-
-	if (!es->status)
+	} else if (es->txerr >= 128 || es->rxerr >= 128) {
+		new_state = CAN_STATE_ERROR_PASSIVE;
+	} else if (es->txerr >= 96 || es->rxerr >= 96) {
+		new_state = CAN_STATE_ERROR_WARNING;
+	} else {
 		new_state = CAN_STATE_ERROR_ACTIVE;
+	}
 
 	if (new_state != cur_state) {
 		tx_state = (es->txerr >= es->rxerr) ? new_state : 0;
-- 
2.36.1

