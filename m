Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE874DE90B
	for <lists+linux-can@lfdr.de>; Sat, 19 Mar 2022 16:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbiCSPc7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 19 Mar 2022 11:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243476AbiCSPc6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 19 Mar 2022 11:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93E852571B6
        for <linux-can@vger.kernel.org>; Sat, 19 Mar 2022 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647703896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RDYbzlAeYYOLKs0jJASD2ePoaygRETdsPOHhL2YcgAw=;
        b=Wv/7y0Atoy9y5Nh2ECQJzKYas2/V27pmOd8H/s0FPY6iE8faoQjCmoqgOCe0Zn9lRIGhda
        JimTwYoi9OFb5vexub+eb5GTFFwP9neo//oSatItlzmI4s6py3zht7n8KJPuCbIkQqfnkp
        Boxf/Lv8L+SUJUecCK98jWDw41r+e3c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-9VbgFw12MLiOZ3BHUd1LVg-1; Sat, 19 Mar 2022 11:31:35 -0400
X-MC-Unique: 9VbgFw12MLiOZ3BHUd1LVg-1
Received: by mail-qt1-f200.google.com with SMTP id b10-20020ac801ca000000b002e1cfb25db9so7419992qtg.1
        for <linux-can@vger.kernel.org>; Sat, 19 Mar 2022 08:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RDYbzlAeYYOLKs0jJASD2ePoaygRETdsPOHhL2YcgAw=;
        b=QuORlJxugWo+lYCIHvW7yhfOM+nsZlcCtIx60xFQcg7rW+XL99ZMfZr0v/ZAEBw3Rp
         l2Yf9ez+sfyUUUUmW18WlW0A+9IAR6KPmEWB2LXy86NW6XMAkfDfj1Uq39xmFpu/1aW4
         aRym6wTqn0mkroL8Gh4/GaunkU1r2iLJb63NJbAR2yqjkBld3nrRE6RCKYhwee5I/Nkl
         TaL1H5qFEFyThl2TkaDW0JHNk50Ks/4izyIxAEycmKbgDYH2ms52ZZ1NB/XmnqExJRQu
         9XIUMU5Ajqp9fycghbBjzcAzk7ocUwMuTldTkw1Pbl2GhqH2p13AkmrnDUdzqsDDKGIH
         zB8A==
X-Gm-Message-State: AOAM532BIuB+sJcE8624C+LNHqecp2PRXpa0UyRjMo5MtuQZ9wflnlDK
        A/hYFcX4JjW0/v1l7MpYictJYVVtgdPcOsRaoJ8Hs3JS3eO0n0DW8WMWpLRt4R6Mw5Tzz6H53pv
        3l/iRXN70BhGWvcw278ZS
X-Received: by 2002:a05:620a:430b:b0:67e:85d1:f53f with SMTP id u11-20020a05620a430b00b0067e85d1f53fmr376980qko.43.1647703894466;
        Sat, 19 Mar 2022 08:31:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylEZz+szJS3qXk/iEXTdbF/WnpVfwDLcvLyw6fK6qEuP1X7aGSWen2MjQL9ePfNbUbvv7PgQ==
X-Received: by 2002:a05:620a:430b:b0:67e:85d1:f53f with SMTP id u11-20020a05620a430b00b0067e85d1f53fmr376962qko.43.1647703894215;
        Sat, 19 Mar 2022 08:31:34 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id b2-20020ac87fc2000000b002e1b9ddb629sm7850596qtk.47.2022.03.19.08.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 08:31:33 -0700 (PDT)
From:   trix@redhat.com
To:     mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        wg@grandegger.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] can: mcp251xfd: return errors from mcp251xfd_register_get_dev_id
Date:   Sat, 19 Mar 2022 08:31:28 -0700
Message-Id: <20220319153128.2164120-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this issue
mcp251xfd-core.c:1813:7: warning: The left operand
  of '&' is a garbage value
  FIELD_GET(MCP251XFD_REG_DEVID_ID_MASK, dev_id),
  ^                                      ~~~~~~

dev_id is set in a successful call to
mcp251xfd_register_get_dev_id().  Though the status
of calls made by mcp251xfd_register_get_dev_id()
are checked and handled, their status' are not
returned.  So return err.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 325024be7b045..f9dd8fdba12bc 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1786,7 +1786,7 @@ mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
  out_kfree_buf_rx:
 	kfree(buf_rx);
 
-	return 0;
+	return err;
 }
 
 #define MCP251XFD_QUIRK_ACTIVE(quirk) \
-- 
2.26.3

