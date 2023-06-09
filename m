Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2B3729931
	for <lists+linux-can@lfdr.de>; Fri,  9 Jun 2023 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbjFIMLa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Jun 2023 08:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240252AbjFIML2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Jun 2023 08:11:28 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A8435B5
        for <linux-can@vger.kernel.org>; Fri,  9 Jun 2023 05:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686312662; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=S6mhPFfhRQHW/4Vx5HbFmTcLESvx9nF0plljp3hncvRjU4XHWUVbSPqW+tgEa3ih2L
    5JnWX7zvzLhS/zfJ8PTpUBq59v7dl9q7nG2S3qgzEGKk2tyjSFnH7DBv/Tt5F82scQog
    7RJ+xBaDrGzywhy125lglzu8riwW81qQM9EzZdpYb9t3D7GXvPEq9m7r5BRbDOjEXj+m
    Zs7BOxL8+2S7mTGEos4WVNEz98qy7vNK1HhFsTF5SgUcy8FeAiDP3gCd4Gykrsj4kNlu
    S9Pm5fSdy4O7I154NE3VQSnBJH7MNsmxGou+CZvBHjihm+uLvZO6daWBEF6LHw3GbMMa
    7i9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686312662;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=zCY6qVuS/Q4zqCX0BGlvoxG1Whu+3x1L/m6DbAPubBA=;
    b=Uzys/GDWNmJbYnE/6hMhRcvOOQVirel/P7MsxC7cVGfWpe232u5X/599zSvSdzq4D3
    BpUf71Iw3Ae/JhacHvNz+CnIvwJD849iZ8Cesh2BQ4CENNb1wepkThttM9ZKI6dwGbxD
    wGv6wppRX/wQjun0Z930Lxw9ZGhbXZ7TFaDaLvgRJcXCZAa+iqyHNA7/Yxznn++JIGl2
    wJbRAbAVIAdgkYtSsc6Z8nB0wr5vOVeaNs3ZZE1aa7/lPYFDKW5TQYsboRX95JNVALMJ
    boC/oTAZrR9WHFoM+zplX1IVShUo3EXGEu5dKMXSRgCwRQSaHM4cPEkW5IDiJIT+MWtk
    5gNw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686312662;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=zCY6qVuS/Q4zqCX0BGlvoxG1Whu+3x1L/m6DbAPubBA=;
    b=aNfyuH/GDb4tw+lNZzW2AVs1lBXFvKzMhWUw7mz/pC6Iyf/UZzY7JxxPSAS5laLmWI
    A06U1RxXmpnDzC1iBPDqIq1+PkxDTGt9sxboBg/mN46EO14i6IgKjlNxiM1S3rkM68Ze
    njPKRD7wSGsOY0Fwyp6voLMVPGtkbfhnS6qcrI6FZcsFZ3C4kuyJMdhKr0eNQlxELd+1
    oOp9xtFh7ZtzVkEf2Dn9dJR6hXhYmpnpu15zdbxJHAZS9jmLDYKIjPhuvkF8Da3m6qAm
    VURdNpR7K3Y2mMPbkkNgR2ylJs79kHS8dyCdNViajlrNBawaJgzS/RTVmJpb3MSgEwTK
    836g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686312661;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=zCY6qVuS/Q4zqCX0BGlvoxG1Whu+3x1L/m6DbAPubBA=;
    b=46Y0UdQ80gb3CPBDrI3KfGLu53hG/W6H2aALaENjl0Es3r+uI2xxcGLgvq/fK/gNZy
    OVPbbgw9ab+sZxLAZyDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejudJygjsS+Kjg=="
Received: from silver.lan
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id j4ea2az59CB1KCH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 9 Jun 2023 14:11:01 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next] can: uapi: move CAN_RAW_FILTER_MAX definition to raw.h
Date:   Fri,  9 Jun 2023 14:10:51 +0200
Message-Id: <20230609121051.9631-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

CAN_RAW_FILTER_MAX is only relevant for CAN_RAW sockets and used in
linux/can/raw.c or in userspace applications that include the raw.h
file anyway.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can.h     | 1 -
 include/uapi/linux/can/raw.h | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index dd645ea72306..939db2388208 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -283,8 +283,7 @@ struct can_filter {
 	canid_t can_id;
 	canid_t can_mask;
 };
 
 #define CAN_INV_FILTER 0x20000000U /* to be set in can_filter.can_id */
-#define CAN_RAW_FILTER_MAX 512 /* maximum number of can_filter set via setsockopt() */
 
 #endif /* !_UAPI_CAN_H */
diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
index ff12f525c37c..31622c9b7988 100644
--- a/include/uapi/linux/can/raw.h
+++ b/include/uapi/linux/can/raw.h
@@ -47,10 +47,12 @@
 #define _UAPI_CAN_RAW_H
 
 #include <linux/can.h>
 
 #define SOL_CAN_RAW (SOL_CAN_BASE + CAN_RAW)
+#define CAN_RAW_FILTER_MAX 512 /* maximum number of can_filter set via setsockopt() */
+
 enum {
 	SCM_CAN_RAW_ERRQUEUE = 1,
 };
 
 /* for socket options affecting the socket (not the global system) */
-- 
2.30.2

