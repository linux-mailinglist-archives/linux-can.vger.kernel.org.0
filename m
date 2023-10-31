Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EA97DC981
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbjJaJaU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343877AbjJaJaT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:30:19 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B8FA3;
        Tue, 31 Oct 2023 02:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744596; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mZQnvT4iK2Lvt1JMZ51ka9y9SSdYmdA6ngeHMOckqGoC7Id/Min7CbOB66LoVvMUg+
    XxTAzkBoXHsQlsQdWIWNYSAFFTr7BQxbFFsFbmNPjsFY+DQEPbJ23yT+3O13AhcEkrS5
    XWf65pkywzWNrOXNbqPsJgjd0ePHyHKtM/P4C66ZAZQJHKphM0SXUumDMslAmsHRJpas
    zKBMZ4hATDTe0sASkUd1OB16AQ9xbnjXbxUV5QEUV4X0oxzkFZEMbljGSJxFotWtJKx9
    eGThYa91vTIJrqr2D2r4Wzx7cJQE4ceP+ylLz36DgF/6O6cu6NTV9tHJbQel+SIsVJKu
    g+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744596;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=n2JhRWAm3CccqPVYy69mwHeSF2G2OgRNkFGMHMG5tEo=;
    b=nq4UY2ee4Hdxy63HDwFSHdEqDxqeERWGqL29mzKCPNjTEuJxbMjJ8RcUzs3eYKa/qr
    /vonjWtLh8e9xDyXY012mgjTnr+DzcD1WFuDT8kATNkSGwCH/KiyjfYaZqu312m92wWH
    T8TuQ3vzQ8QrnV113XFLfgCt7Q7qNL9CtUw156mQjhLGPCF/hEGVWFnbk+SvaH5xqzei
    T2OPaQipyhGqephoBgscLU6yjsau8cRTqenwDIpAbxl4Y+MiLBYayhJlIRKpls0ufplF
    UFvWx/feY0V9/h5sBApB0ftrSPDGBzbZvpqccIT0LqBhPJxjTd4XKIj1fpIJhaYUMcrC
    eFig==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744596;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=n2JhRWAm3CccqPVYy69mwHeSF2G2OgRNkFGMHMG5tEo=;
    b=GRJaulQl+UP37rxace4ddg6n+kE8AaeUTzw4Pt2uMa67FmWbD9IfkuWYha+6Hdhsk+
    07og0olss0hM+2k5Bs8fS/Iq9sIxMvtUQFNH4dktVWiCd4Vf9Hy/Rkxt0iVTlxgzlCtN
    +1yMtnnyLu467B1SwKEru7X3gtB9HloM/ebTiRhwghACHhTlUtT3iKzU7zP5rCzoSJqM
    XeG1SdhFNMFUC/KkMbfJTDm6CIVOAb7IMTyT0MnigjmmC85ubvFYoR8NFk6WB70nr5ik
    c7h9Ktt2JYp5DomWlYn+/2WjdNPB2ucb48kTMfXpt1FsxINEnsXybkU+W5+aIDyOnyGo
    WIyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744596;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=n2JhRWAm3CccqPVYy69mwHeSF2G2OgRNkFGMHMG5tEo=;
    b=QPKdg7aujL6ZhjGCtWhLxANMBsrJdYoofF7C0hnxnZmfAuaVJ3I/SEZKDJo3zVBOs5
    HUzZlvik10Ep1oolGbCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9TtFhF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Oct 2023 10:29:55 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH stable 5.10 04/10] can: isotp: set max PDU size to 64 kByte
Date:   Tue, 31 Oct 2023 10:29:12 +0100
Message-Id: <20231031092918.2668-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031092918.2668-1-socketcan@hartkopp.net>
References: <20231031092918.2668-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

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
---
 net/can/isotp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index ef72e5344789..fb179a333784 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -85,13 +85,13 @@ MODULE_ALIAS("can-proto-6");
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
2.34.1

