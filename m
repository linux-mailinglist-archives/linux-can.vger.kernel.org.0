Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1021349287
	for <lists+linux-can@lfdr.de>; Thu, 25 Mar 2021 14:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYM73 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Mar 2021 08:59:29 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:29127 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhCYM7W (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Mar 2021 08:59:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616677156; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VqkvthETLW4kzMxOgojRKCUOZEjdybvilX+6dbtYnCqlmrWhApHcxWIusAB3L1xI1Q
    kWq1z/PMcvasQAPDrAKrFhLBLJNHd1DPNsxApId9uqIfYp6PiALggivxJLwfsS8dGV65
    WnBCsBwsVZA9ITBrmwIh79rPdqIQ28OEqxeODnx4D2bgRlUEX3B8Qq1Ca/W23QvuyxPB
    Mbl507BHZCxsJFdJ9laBl0gO/ZGo37wPNz0PEKJMemnRjLNaCmyTTuZi+L+LCJoc/N6r
    4gxuxuDd+QwjcJBarJC645kJXyDaZjk4IBCK3txkoV5Zdn8wzBth3hN03c9dFnCZWisE
    JoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616677156;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5da/XseoIf1FLJUIMaN4zg257fUOiUlJl/iL7aMvTYc=;
    b=aNUOI21WkHm8Ytg5X33V4FiHBdOFh9cnSgx8a7FMsQApImwbWM/HybtKj99ZInfsYp
    gL/wEJtBoNcjD6Lih6f3pvAMR21v7w9wEPnaquA+nYNzjklDkNWcH6wZ/hAMJfJakF25
    CGRuGtxLuNzDrRPWXmZMePOsX0UXbjmY1OdqcRylfQ3KuAPuz4e3Lbeat72Hp1UKrL+o
    GyMItkmdcoY+MrYIEDFpY6bgz0jfSHuNsscgCcmDOpBXZv633ok7VuimVNCR6Lz/NfCk
    lTMigafX800sS8FhXK4jkCqgyT/9QB+VAq4G/IAmumwk5DVvORTMJ3qF7DnY4LUJ0TtS
    y9lA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616677156;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5da/XseoIf1FLJUIMaN4zg257fUOiUlJl/iL7aMvTYc=;
    b=jJ7Olchk4ibYrCK1fK3jmwCKV/5iWtrj+JNlGSoAhfX933fIE+yzM6HjIpOkhgoUF8
    Waux5SQniEfBj/i6DMqSAc7GM6D/xIJHDBeuFFlF5bxU/kygvqgeBoXdIEmCdLTygqcF
    828bKNnt/Dcul+rVfPBRrI0sxmuHHbgGiKoFuHUDr89HX+fjgUIG9wRiqaUUiRUpV5TA
    7EOemS+mo/wHwxy+Q4ZxtCtbXBeQG4EO2CkKF5jL7hCIcO5ZPFozI1AGffoICJcXptlq
    HutcfU/Ta0ukdXLyBObW3XPlgh3S9oj/ypImOzXWT1na+JqPs8aPbZImRGLcBEqCYYRz
    JpWQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVLjM8tyWa"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.22.0 DYNA|AUTH)
    with ESMTPSA id z00fabx2PCxG4Ck
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 25 Mar 2021 13:59:16 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/3] can: uapi: can.h: suppress padding of union inside struct can_frame
Date:   Thu, 25 Mar 2021 13:58:50 +0100
Message-Id: <20210325125850.1620-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325125850.1620-1-socketcan@hartkopp.net>
References: <20210325125850.1620-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In commit ea7800565a12 ("can: add optional DLC element to Classical
CAN frame structure") the struct can_frame::can_dlc was put into an
anonymous union with another u8 variable.

For various reasons some members in struct can_frame and canfd_frame
including the first 8 byes of data are expected to have the same
memory layout. This is enforced by a BUILD_BUG_ON check in af_can.c.

Since the above mentioned commit this check fails on some compilers
(e.g. arm-linux-gnueabi-gcc (GCC) 9.3.0) that apply an alignment on
an (anonymous) union (see Link). Rong Chen analyzed the problem and
found that the union in struct can_frame takes 4 bytes instead of
the expected 1:

| struct can_frame {
|          canid_t                    can_id;               /* 0     4 */
|          union {
|                  __u8               len;                  /* 4     1 */
|                  __u8               can_dlc;              /* 4     1 */
|          };                                               /* 4     4 */
|          __u8                       __pad;                /* 8     1 */
|          __u8                       __res0;               /* 9     1 */
|          __u8                       len8_dlc;             /* 10     1 */
|
|          /* XXX 5 bytes hole, try to pack */
|
|          __u8                       data[8]
| __attribute__((__aligned__(8))); /*    16     8 */
|
|          /* size: 24, cachelines: 1, members: 6 */
|          /* sum members: 19, holes: 1, sum holes: 5 */
|          /* forced alignments: 1, forced holes: 1, sum forced holes: 5 */
|          /* last cacheline: 24 bytes */
| } __attribute__((__aligned__(8)));

Marking the anonymous union as __attribute__((packed)) fixes the
BUILD_BUG_ON problem on these compilers.

Fixes: ea7800565a12 ("can: add optional DLC element to Classical CAN frame structure")
Link: https://lore.kernel.org/linux-can/2c82ec23-3551-61b5-1bd8-178c3407ee83@hartkopp.net/
Suggested-by: Rong Chen <rong.a.chen@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Author: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index f75238ac6dce..56abe9b50561 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -111,11 +111,11 @@ struct can_frame {
 		 * was previously named can_dlc so we need to carry that
 		 * name for legacy support
 		 */
 		__u8 len;
 		__u8 can_dlc; /* deprecated */
-	};
+	} __attribute__((packed)); /* disable padding by some compilers */
 	__u8 __pad; /* padding */
 	__u8 __res0; /* reserved / padding */
 	__u8 len8_dlc; /* optional DLC for 8 byte payload length (9 .. 15) */
 	__u8 data[CAN_MAX_DLEN] __attribute__((aligned(8)));
 };
-- 
2.30.2

