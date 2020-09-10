Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B32A265340
	for <lists+linux-can@lfdr.de>; Thu, 10 Sep 2020 23:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgIJVaU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Sep 2020 17:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbgIJNwr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Sep 2020 09:52:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135B3C0617A9
        for <linux-can@vger.kernel.org>; Thu, 10 Sep 2020 06:38:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so4627564pfp.11
        for <linux-can@vger.kernel.org>; Thu, 10 Sep 2020 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZNvv8+JQ9K4oMoMWHCuX/xgK/U3xfOuz27z8d5NqEl4=;
        b=NLrcjaL7QRSgAVAS8jKPxO385aRKlma2IZc9/vZQMhc1OR4CsYF79dddiPDoDdr5hl
         A+f5oWPz2KrPAExttKTkJrWVL2wH/71AQimKGR4NqxcSJnyZwbfXx0nvETeNgGCb4mp6
         ubSdBnZwFgzOqAb+cbxQVYpgFOLlqby0bngAfEqcMhaeTdSeqtMOHPHkTicx8Nzt8N80
         t8OFxvmQH9TYPKrdLipE1bAH1uR7OGUkx3N6M39/g94j69yn3VeGThdE1SMrYYa/v3k8
         w5w4sCqS/mjRDgHI5Hmc2x+u5Jf3ARyAfH3tGtSEbYyXSVcZ4c8+9gkKcJbVY+poZT3h
         3v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZNvv8+JQ9K4oMoMWHCuX/xgK/U3xfOuz27z8d5NqEl4=;
        b=NInQ8FKOXSqM4jgs+aLJFIN8gZiQaYGy8yER+nSbzzfRxTczRhoRK3y/sCb35rDMsf
         FfNT6rE9LeQhenT+dcRPjhGSG14hTVj9JLJxxJsVgvGvOTmV6ppEmb7vXzgVhN8EkhIG
         c2Dc3vFI/oKwdU7K8Wm1n0EPILh/YFJjF2JrSzDuPidnJTfnAQ9ngPem7ZV1JZervo3w
         4oMHikjfRY3X0YrrulGdrG5mwoFDmR7/reWq/tkoQmxicegwLPWSKu/qijjKX2jFKqcq
         Spum5vjMMk9DGAeBf/0XKhe0N0b0WiVY6NpqKgLZ81n/VPY+Oj7hWanGtlFo6twI4+Nf
         oHDw==
X-Gm-Message-State: AOAM532UniosedfR9NCiVYGFXcRWQRjj0CNcNWCk5VPV3vzTZCaI27jx
        utPBRiiNTVWXcKTxbPR70DBS
X-Google-Smtp-Source: ABdhPJzW+u4JvdtC188qU8jt9B5t020dsUHriYtFX1t07dZfPWLHMeGvGfPiBb3GayK81YdfH+LNiw==
X-Received: by 2002:aa7:9edb:0:b029:13e:d13d:a059 with SMTP id r27-20020aa79edb0000b029013ed13da059mr5639198pfq.31.1599745118657;
        Thu, 10 Sep 2020 06:38:38 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id o30sm5603801pgc.45.2020.09.10.06.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:38:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org
Cc:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev.kurt@vandijck-laurijssen.be,
        o.rempel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/6] MAINTAINERS: Add entry for Microchip MCP25XXFD SPI-CAN network driver
Date:   Thu, 10 Sep 2020 19:08:06 +0530
Message-Id: <20200910133806.25077-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org>
References: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add MAINTAINERS entry for Microchip MCP25XXFD SPI-CAN network driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5cfab015bd6..e4ddf908a8b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10652,6 +10652,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-mcp2221.c
 
+MCP25XXFD SPI-CAN NETWORK DRIVER
+M:	Marc Kleine-Budde <mkl@pengutronix.de>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
+F:	drivers/net/can/spi/mcp25xxfd/
+
 MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

