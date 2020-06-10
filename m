Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7891F4F8B
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2020 09:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgFJHsH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Jun 2020 03:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFJHr6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 Jun 2020 03:47:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C86C03E96B
        for <linux-can@vger.kernel.org>; Wed, 10 Jun 2020 00:47:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n23so608663pgb.12
        for <linux-can@vger.kernel.org>; Wed, 10 Jun 2020 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mBmy6hb5a23KMKQCkK27hu5NhYaoTF5cRzQ7jlandjM=;
        b=dp78FMTkX/1hJTaR4QYkcHQUaUVIESR4j5kc63tOAbf8hOuzjuBzZFRWA0YGERKt1q
         Fe+frKwucez80KwyDfZZhvqQ43xy385tpF1u3N1dUcrGgXUnhmSuOgypFwPorgFp/EE1
         x5k1cy/YYVD9vjPMqhXe44SNx7RmE4yLW+x0e1bQIEsKlEDZH+vvW6KgntpZFTDdDNOg
         CxEWx4C19RqCWnHyGto6GJxHQzYTINLSpdxjiRdHvZWdQL9f7VO1x+yLdVkz3iubkSvB
         OIoPprlM3jlTcDXIOMAxCFC/fK1u+pI49c+RO7r94JS8/SsoaDAz/kxUU7jdUEfHxJAD
         JSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mBmy6hb5a23KMKQCkK27hu5NhYaoTF5cRzQ7jlandjM=;
        b=BwEiwVHCgjJSlfY9KpkrVWHpo5DTTKp6NNl55C+3X6tY/7GXHF6R0N4gEUwo5fOOh3
         bN1aQ6DScUUZIkRkKhrvCcLB0TGq20QED3giP1QMOnULRHaj4AYrYT0jFx7k+CQle178
         Mcm+aAkSyElYcVyB+Q4YaABt1BxfFSid2HqtX/ZUgQhGqeQSZyw1y1usM1XWiCNEuoZa
         +WPA9WiU8k+V6TGT6q5FkcLj7Xc8MNo/K6ryrXRp6d/IxkdkMgpcwE7D73vplIXs0+/l
         atLlZlvEFbu7EjVGFh0SZoBYscBisJVz/F8mOCHX0W9cG77OwXCcAf/BzGnsLDUeHobr
         dgZQ==
X-Gm-Message-State: AOAM530RNu6kZ7XE49GFAzTj/vTttjacbsknC82cO8CCKOzwcuGA7BZr
        /535SGHFZcpHSCZOgh+eV+nu
X-Google-Smtp-Source: ABdhPJyKw3UJzSTMp9lhzgNqf67W/XlxmmABmAg82mh6fgAO8XDUkxzjD7gXIfEdOVKdAMsBrIFLJw==
X-Received: by 2002:a63:f854:: with SMTP id v20mr1693743pgj.0.1591775278160;
        Wed, 10 Jun 2020 00:47:58 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:630f:1dba:c41:a14e:6586:388a])
        by smtp.gmail.com with ESMTPSA id u1sm10075040pgf.28.2020.06.10.00.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:47:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@martin.sperl.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 6/6] MAINTAINERS: Add entry for Microchip MCP25XXFD CAN network driver
Date:   Wed, 10 Jun 2020 13:17:11 +0530
Message-Id: <20200610074711.10969-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200610074711.10969-1-manivannan.sadhasivam@linaro.org>
References: <20200610074711.10969-1-manivannan.sadhasivam@linaro.org>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add MAINTAINERS entry for Microchip MCP25XXFD CAN network driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..591b6fc2d83a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10360,6 +10360,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-mcp2221.c
 
+MCP25XXFD CAN NETWORK DRIVER
+M:	Martin Sperl <kernel@martin.sperl.org>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
+F:	drivers/net/can/mcp25xxfd/
+
 MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

