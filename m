Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18AD4CED7A
	for <lists+linux-can@lfdr.de>; Sun,  6 Mar 2022 20:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiCFTgK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 6 Mar 2022 14:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiCFTgJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 6 Mar 2022 14:36:09 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F22052E66
        for <linux-can@vger.kernel.org>; Sun,  6 Mar 2022 11:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646595314;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=c17LdMuvxzb7KUkRWho2FXQrDZzWXXifTpBgykQqoc8=;
    b=YBnLuIFQro6NahfX7CcIDRLLBv+6k/ShM035BmnqD/0DJp4qbf4u0eGVPYNZzfhyzs
    73gwbDUu0YLRRjRVMbRNkk+73V7EAJcg2KDJEyc9KVZN1e3eEoBRymWYdPqXSGzhKxUA
    pgZCBOimHCIn16TSY5+y64247PAcfm8M2i/OluSgjeaUZ87V3TJNBVKpWukbKNPX5epy
    vMMmiigblb2ek/HHj1dYnziNVVPpvTgduGIJMy/voop1zZ8Q90HsR4rlOXLDAGa8BRPY
    OyaNbhj+k7Rkexk6uOaImygXpZafbY6rxd5s1xE9PPo7GLU7wv9N4O6NnLTnfuGxPmuO
    aVQg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9IyLecSWJafUvprl4"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.40.1 AUTH)
    with ESMTPSA id 6c57e6y26JZE5LB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 6 Mar 2022 20:35:14 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next 2/3] can: isotp: set default value for N_As to 50 micro seconds
Date:   Sun,  6 Mar 2022 20:34:53 +0100
Message-Id: <20220306193454.33158-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220306193454.33158-1-socketcan@hartkopp.net>
References: <20220306193454.33158-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The N_As value describes the time a CAN frame needs on the wire when
transmitted by the CAN controller. Even very short CAN FD frames need
arround 100 usecs (bitrate 1Mbit/s, data bitrate 8Mbit/s).

Having N_As to be zero (the former default) leads to 'no CAN frame
separation' when STmin is set to zero by the receiving node. This 'burst
mode' should not be enabled by default as it could potentially dump a high
number of CAN frames into the netdevice queue from the soft hrtimer context.
This does not affect the system stability but is just not nice and
cooperative.

With this N_As (frame_txtime) value the 'burst mode' is disabled by default.
For testing or (preformance) measurements the frame tx time can be set to
zero by setting the frame_txtime value in the CAN_ISOTP_OPTS sockopts.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/isotp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/can/isotp.h b/include/uapi/linux/can/isotp.h
index c55935b64ccc..3e6e20028969 100644
--- a/include/uapi/linux/can/isotp.h
+++ b/include/uapi/linux/can/isotp.h
@@ -140,11 +140,11 @@ struct can_isotp_ll_options {
 /* default values */
 
 #define CAN_ISOTP_DEFAULT_FLAGS		0
 #define CAN_ISOTP_DEFAULT_EXT_ADDRESS	0x00
 #define CAN_ISOTP_DEFAULT_PAD_CONTENT	0xCC /* prevent bit-stuffing */
-#define CAN_ISOTP_DEFAULT_FRAME_TXTIME	0
+#define CAN_ISOTP_DEFAULT_FRAME_TXTIME	50000 /* 50 micro seconds */
 #define CAN_ISOTP_DEFAULT_RECV_BS	0
 #define CAN_ISOTP_DEFAULT_RECV_STMIN	0x00
 #define CAN_ISOTP_DEFAULT_RECV_WFTMAX	0
 
 #define CAN_ISOTP_DEFAULT_LL_MTU	CAN_MTU
-- 
2.30.2

