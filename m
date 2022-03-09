Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8884D2EA7
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 13:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiCIMF0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 07:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiCIMFY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 07:05:24 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261F3171EE9
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 04:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646827462;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=PuxF4EHph6uDUcP+CDCd3bjU87veCY6Sc6q8zS/Znnk=;
    b=HFa+SpCs75NU2zvkfWgQaNiWV7tIRqTJ3XdwBoLaJXdE/3kVEX1BFslvxi8jE9z0Vj
    8sTtBoGB7x0GuO4j0yjXtpHzvodJvRUA7zwNS8gzqMAcTrMHRNjyyB6HQ1G7hWjjp5l1
    Ue7CVzxiICrCQ4ZETKhat4gdVaFcZbF9S1jOXS1FZ+FxnqeJ7qS1hDJp0PFXJUI4qTk9
    aQOxHaDU8J9gHMyhO5rbEhB3+UrCUvL7/jMvb4xgrQ/23IQOzsvK4skIijexeioeqUXR
    761p67tonro/3ZIsKs3MkseoYw10e79xrDKL0b2RuCp41Ud4G5Vaf3U3q9jY7kk+9yaI
    51wA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9IyLecSWJafUvprl4"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.40.1 AUTH)
    with ESMTPSA id 6c57e6y29C4MEQ9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 9 Mar 2022 13:04:22 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next v2 3/5] can: isotp: set max PDU size to 64 kByte
Date:   Wed,  9 Mar 2022 13:04:14 +0100
Message-Id: <20220309120416.83514-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220309120416.83514-1-socketcan@hartkopp.net>
References: <20220309120416.83514-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The reason to extend the max PDU size from 4095 Byte (12 bit length value)
to a 32 bit value (up to 4 GByte) was to be able to flash 64 kByte
bootloaders with a single ISO-TP PDU. The max PDU size in the Linux kernel
implementation was set to 8200 Bytes to be able to test the length
information escape sequence.

It turns out that the demand for 64 kByte PDUs is real so the value for
MAX_MSG_LENGTH is set to 66000 to be able to potentially add some checksums
to the 65.536 Byte block.

Link: https://github.com/linux-can/can-utils/issues/347#issuecomment-1056142301
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 47404ba59981..d4c0b4704987 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -84,13 +84,13 @@ MODULE_ALIAS("can-proto-6");
 			 (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
 
 /* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the FF_DL can
  * take full 32 bit values (4 Gbyte). We would need some good concept to handle
  * this between user space and kernel space. For now increase the static buffer
- * to something about 8 kbyte to be able to test this new functionality.
+ * to something about 64 kbyte to be able to test this new functionality.
  */
-#define MAX_MSG_LENGTH 8200
+#define MAX_MSG_LENGTH 66000
 
 /* N_PCI type values in bits 7-4 of N_PCI bytes */
 #define N_PCI_SF 0x00	/* single frame */
 #define N_PCI_FF 0x10	/* first frame */
 #define N_PCI_CF 0x20	/* consecutive frame */
-- 
2.30.2

