Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36974282235
	for <lists+linux-can@lfdr.de>; Sat,  3 Oct 2020 09:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJCHzL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 3 Oct 2020 03:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgJCHzL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 3 Oct 2020 03:55:11 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A8EC0613D0;
        Sat,  3 Oct 2020 00:55:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b12so4181222edz.11;
        Sat, 03 Oct 2020 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CDwSbwZssf462MfM1dKOPyFvlfvWZeJTSIh0pC7ZnjQ=;
        b=UJLwyPfcmDinYs3+jT+yhLhgiA+15jamR1qMAek0wbQZZThapIIbIS6zckayssU8Kp
         +ywmTHVT3wxr8na6Ep97PkJKBH0DHv/X+tCU0IOC9Dkt1S5NYjYNMl/uy24RyT8F6frD
         Av7WMWyUakpzlNoFCSom3t/e5IJ+1JOutBlQzxWBeS1JwVj8zN2RwsYRX4YunGhbvSPd
         wUSDzIwUB4pEqFuOU8IduLCFyuRnlJs4ek7u8J9dvwfNlDkYnIM3e4Kx2h1rOZrt/WOZ
         VG8fjRhu2gNpNXzFYlhTA1aAbw3/lwiAfXn4w2QAY7sgCwEXlexjcFhNr+mk8VT6+d01
         /u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CDwSbwZssf462MfM1dKOPyFvlfvWZeJTSIh0pC7ZnjQ=;
        b=q3ZWD+Dgr5y8BZ78GkxgAHTE59jIlc5lFo3DkN4szqiy1OzhVWwljEN4zu47slKYVH
         wa0VKlPXm+pPhZqACrRuFWWtNG8IbBBmw2S/cv+ebLmsAOYFz79jrQpIJniw4uxUBAP3
         CwLZt17+Klqt0zfVwleQHdtIrt1NqPckXtJMoDRRnK8tLfS9DwbLKaQgnbIIEfokT20A
         Jstf6idUEseyhce/9gZx/FKshKERXcQsJi4nTq63QXqpR7O4EZPstc0Ntj4yZlabtjMV
         ZYGg5l69Gb879BHX5hrW4ms51hHNdZu4LiEIiYqgl9I4JtANsDBDXzMHNAtC7wci1tlY
         CpQg==
X-Gm-Message-State: AOAM530UYY7+hT7HCg0JB7e8qbFf6eSF/xihdr8q54ppSGfAjdfBRw0Y
        dphtrHl/Y3OWhUtmXNMdmtc=
X-Google-Smtp-Source: ABdhPJxkgmJ83cjrOHCJ4qcn0rHCmvs07ctNPUEtyrvd9+dsI5k5pzOXqFnJy2jSsClwrculsE/aoQ==
X-Received: by 2002:a05:6402:cba:: with SMTP id cn26mr6989717edb.230.1601711709639;
        Sat, 03 Oct 2020 00:55:09 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d0f:200:5c8a:6672:a0e2:bacb])
        by smtp.gmail.com with ESMTPSA id k13sm3400867edj.92.2020.10.03.00.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 00:55:08 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust to mcp251xfd file renaming
Date:   Sat,  3 Oct 2020 09:55:00 +0200
Message-Id: <20201003075500.12477-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Commit 27cf93863cbc ("MAINTAINERS: Add entry for Microchip MCP25XXFD
SPI-CAN network driver"), added the MCP25XXFD SPI-CAN NETWORK DRIVER
section with the following two file entries:

F:      Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
F:      drivers/net/can/spi/mcp25xxfd/

Commit 1f0e21a0c065 ("can: mcp251xfd: rename driver files and subdir to
mcp251xfd") renamed the files from mcp25xxfd to mcp251xfd, but missed to
adjust the MAINTAINERS section.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F: \
      Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
  warning: no file matches    F:    drivers/net/can/spi/mcp25xxfd/

Adjust the MCP251XFD SPI-CAN NETWORK DRIVER section to this driver file
renaming.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-2020102

Marc, please pick this minor non-urgent clean-up patch for your -next tree.

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00214bbaa72c..b374e594a779 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10732,14 +10732,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-mcp2221.c
 
-MCP25XXFD SPI-CAN NETWORK DRIVER
+MCP251XFD SPI-CAN NETWORK DRIVER
 M:	Marc Kleine-Budde <mkl@pengutronix.de>
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 R:	Thomas Kopp <thomas.kopp@microchip.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
-F:	drivers/net/can/spi/mcp25xxfd/
+F:	Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
+F:	drivers/net/can/spi/mcp251xfd/
 
 MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@axentia.se>
-- 
2.17.1

