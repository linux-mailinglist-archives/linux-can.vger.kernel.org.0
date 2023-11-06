Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220C37E25A2
	for <lists+linux-can@lfdr.de>; Mon,  6 Nov 2023 14:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjKFNeC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 6 Nov 2023 08:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjKFNdu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Nov 2023 08:33:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02A0D71;
        Mon,  6 Nov 2023 05:33:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20DEC433C7;
        Mon,  6 Nov 2023 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277624;
        bh=fhwbWYdCumcPgHPLDnQEEaT8uhyEsvzE5JwjkRPwqYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2wYNdL6v1dWXBR8/vEIwQAxxmLpM9ZDQYXoWurXtdvjs2VKgubHoeg3+d5N9aJbR1
         62/sczQNE5vD1YHfV6N59NznKiNxW7B4nKjCG2Pcp+NJvUFZF0aoqzl1DV778NLnYT
         kKRjgQvBPLsA0rGZOhxpEIqBgtc55fcfEoQZs2+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz, Oliver Hartkopp" 
        <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.10 81/95] can: isotp: set max PDU size to 64 kByte
Date:   Mon,  6 Nov 2023 14:04:49 +0100
Message-ID: <20231106130307.668968540@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit 9c0c191d82a1de964ac953a1df8b5744ec670b07 upstream

The reason to extend the max PDU size from 4095 Byte (12 bit length value)
to a 32 bit value (up to 4 GByte) was to be able to flash 64 kByte
bootloaders with a single ISO-TP PDU. The max PDU size in the Linux kernel
implementation was set to 8200 Bytes to be able to test the length
information escape sequence.

It turns out that the demand for 64 kByte PDUs is real so the value for
MAX_MSG_LENGTH is set to 66000 to be able to potentially add some checksums
to the 65.536 Byte block.

Link: https://github.com/linux-can/can-utils/issues/347#issuecomment-1056142301
Link: https://lore.kernel.org/all/20220309120416.83514-3-socketcan@hartkopp.net
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/isotp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -87,9 +87,9 @@ MODULE_ALIAS("can-proto-6");
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


