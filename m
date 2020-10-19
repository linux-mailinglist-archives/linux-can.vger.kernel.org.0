Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991DC292C9B
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 19:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgJSRYZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 13:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730186AbgJSRYY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 13:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603128262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=GlNRdQUy+AGKN2OBLvxM70f2rqnujuydEmx9LlvXhbI=;
        b=Q3Jgr3BrhQzhigcNJUaEORw9rWB07AC//WSRAfoiMAVHW3CITMcFtmxOEU7dWJNJNe/TJ9
        hFrFYfXhSuJfpvl5U0v9bEuhdIlZcBL1zKCotbU+E2u7v2+fr8xFy2bbB/4Q4o+o3LwlEN
        Q+5QZ48luMj1H4u84T/V1Q0zEvajjOA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-s9ahMQwAPRCcE6qLBUgikQ-1; Mon, 19 Oct 2020 13:24:19 -0400
X-MC-Unique: s9ahMQwAPRCcE6qLBUgikQ-1
Received: by mail-qv1-f71.google.com with SMTP id v4so342557qvr.19
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2020 10:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GlNRdQUy+AGKN2OBLvxM70f2rqnujuydEmx9LlvXhbI=;
        b=hs/IOXzt4LymbWr/6XGVGy1DY9JT/L6L2DISIkSV10y7kEx6W9I8iCotaA+VTcLLUw
         Lo4UeRYJF7V9wmONOF21BlIRdNYPJ/CL+zNMIs4GfYA+D6YAk17k6Ncfk7gky0Vf9bxk
         P+OAsxJMQA/p7FAsREU3yBkp8/qpgBUcZNEP8ZY9qB3C4r/lyVyT1qRrVDJWhHEqmJJ/
         4Z2GQamwRAgq1JT9lNx6XtATKpPNiKl8ecNdniRmnB2Ll7+6/AOpm58Yp39YbW7zI684
         JfbuJddjyJUOS+AHi/HG3/usDMOXoPNHyikmegNOIbJdXjAW1NPhE6LP811hGkUVWAgV
         yYlw==
X-Gm-Message-State: AOAM530urFq5UHuE+l1gnPDcevaONR6PFmGMKSj/1Z/rY7EUCJdJfjOV
        3ekjBWvl3xFMY/EklaeB2PS76TkIfVlB8vLlbNHp336hTcTmaqgqG99W/1lFhaRGk5S14Zi42iG
        QiQfZXjAz2ZOXX+Nt24JR
X-Received: by 2002:ad4:456c:: with SMTP id o12mr941397qvu.48.1603128259064;
        Mon, 19 Oct 2020 10:24:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1IY0STp8Q6ypEf1lWhvSs2JcyK6xaHXzjj4/dVdBi8JhNegNGdN/AJqDRKfg+58L+7+NNYg==
X-Received: by 2002:ad4:456c:: with SMTP id o12mr941370qvu.48.1603128258823;
        Mon, 19 Oct 2020 10:24:18 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s22sm222627qtc.33.2020.10.19.10.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:24:18 -0700 (PDT)
From:   trix@redhat.com
To:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        kuba@kernel.org, thomas.kopp@microchip.com,
        dan.carpenter@oracle.com, dev.kurt@vandijck-laurijssen.be
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: can: remove unneeded break
Date:   Mon, 19 Oct 2020 10:24:12 -0700
Message-Id: <20201019172412.31143-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index c3f49543ff26..9c215f7c5f81 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -75,11 +75,11 @@ static const char *__mcp251xfd_get_model_str(enum mcp251xfd_model model)
 {
 	switch (model) {
 	case MCP251XFD_MODEL_MCP2517FD:
-		return "MCP2517FD"; break;
+		return "MCP2517FD";
 	case MCP251XFD_MODEL_MCP2518FD:
-		return "MCP2518FD"; break;
+		return "MCP2518FD";
 	case MCP251XFD_MODEL_MCP251XFD:
-		return "MCP251xFD"; break;
+		return "MCP251xFD";
 	}
 
 	return "<unknown>";
@@ -95,21 +95,21 @@ static const char *mcp251xfd_get_mode_str(const u8 mode)
 {
 	switch (mode) {
 	case MCP251XFD_REG_CON_MODE_MIXED:
-		return "Mixed (CAN FD/CAN 2.0)"; break;
+		return "Mixed (CAN FD/CAN 2.0)";
 	case MCP251XFD_REG_CON_MODE_SLEEP:
-		return "Sleep"; break;
+		return "Sleep";
 	case MCP251XFD_REG_CON_MODE_INT_LOOPBACK:
-		return "Internal Loopback"; break;
+		return "Internal Loopback";
 	case MCP251XFD_REG_CON_MODE_LISTENONLY:
-		return "Listen Only"; break;
+		return "Listen Only";
 	case MCP251XFD_REG_CON_MODE_CONFIG:
-		return "Configuration"; break;
+		return "Configuration";
 	case MCP251XFD_REG_CON_MODE_EXT_LOOPBACK:
-		return "External Loopback"; break;
+		return "External Loopback";
 	case MCP251XFD_REG_CON_MODE_CAN2_0:
-		return "CAN 2.0"; break;
+		return "CAN 2.0";
 	case MCP251XFD_REG_CON_MODE_RESTRICTED:
-		return "Restricted Operation"; break;
+		return "Restricted Operation";
 	}
 
 	return "<unknown>";
-- 
2.18.1

