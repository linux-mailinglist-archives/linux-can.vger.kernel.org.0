Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E841F4F67
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2020 09:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgFJHp1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Jun 2020 03:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgFJHpZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 Jun 2020 03:45:25 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587F3C08C5C6
        for <linux-can@vger.kernel.org>; Wed, 10 Jun 2020 00:45:23 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bg4so650922plb.3
        for <linux-can@vger.kernel.org>; Wed, 10 Jun 2020 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mBmy6hb5a23KMKQCkK27hu5NhYaoTF5cRzQ7jlandjM=;
        b=ozHbKmHvb28+iRGd9myPIYtpesyrfnme4ad6GKCdJ1tYawHaW7VZxstkzgovVgeT5W
         ICdxDBw/wLmuBAnI/nc7Ue9csPpFKwUczWrf8WKtIJ488USHOc+Nd1F3Znw2AAedAhN7
         0GGM6m0rBqL09iYDtuKC4LEaqhpBJ+IwkATu/ORI8r97eW4PAt3gQe0GDXJFzP/x0EnV
         pktPdj7OGduVeFfJ+0Rzyv13UZOxaieWfWFX40ptaFfPUJ14cEWdnQhg7Um7PPp0ft5u
         TY29UJo8hFOtxn2OAauM88TGGiwhvhdT+CoqUFb+OAIZDo7r7Oph9bFRTkxwb3HWJlaE
         g64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mBmy6hb5a23KMKQCkK27hu5NhYaoTF5cRzQ7jlandjM=;
        b=arkvi9QkCzWr6a2pJowH+G+Cs+Lj+NXX810CvHPGd51Dy7ITd2AjNXszzzoL8OwEk5
         H9Z35rHjW7pZeoxYCF53NDGG+wUJjBgdt0E4NXfFCi/mTbfLO6iKKbPQlLgRKYfZ/EZ1
         OWP89Y41M09A8QF4yNlpMnVfmU8lp6tiEZA5tXQEZ6Ob8aiQZZ/3nxY+CwwxqV7dEsaN
         Ii4ubwL5AyLKaPOEea38x2u1Z3U+NSOjOsHaoH1+77eW2xmwcBlSrLgR0nRrh8iw0HRJ
         8RD00BMAQTePfVY9uQgCcU2MkRS0+/4UYKsJIVJFLLXljQmlPXGjW2LIv5TMjXmXUnsG
         x/1A==
X-Gm-Message-State: AOAM531IzjH06CFGrNZyr5/LOAvUDZbTehutxoVDFQpqB0/As6NsEvdz
        M6Ex7QZTfqtH0uH1gJXF6Pr0
X-Google-Smtp-Source: ABdhPJxfHv272Giz/2wpf5HT8QRu8W5Th971wBoM41pooYlIGx9go8TtZAAFxf2vkL9iJ4D4O3z3zw==
X-Received: by 2002:a17:90a:3489:: with SMTP id p9mr1852483pjb.56.1591775122820;
        Wed, 10 Jun 2020 00:45:22 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:630f:1dba:c41:a14e:6586:388a])
        by smtp.gmail.com with ESMTPSA id a20sm11516795pff.147.2020.06.10.00.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:45:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wg@grandegger.com, mkl@pengutronix.de
Cc:     kernel@martin.sperl.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/6] MAINTAINERS: Add entry for Microchip MCP25XXFD CAN network driver
Date:   Wed, 10 Jun 2020 13:14:42 +0530
Message-Id: <20200610074442.10808-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
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

