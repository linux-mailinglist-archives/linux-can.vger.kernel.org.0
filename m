Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2E46F93AC
	for <lists+linux-can@lfdr.de>; Sat,  6 May 2023 20:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjEFSpr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 6 May 2023 14:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjEFSpq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 6 May 2023 14:45:46 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76A14E65
        for <linux-can@vger.kernel.org>; Sat,  6 May 2023 11:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683398734; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VUdPLQNVeNaewjWYW9C4HkH6vEWTo0V3lKN+PKBzPYsrqf5QiH27vlLZW/b2G+YG03
    mCtVxoQ3OgyU6t96FXfGjcXCJgNHlo1cohqg1/pDpTLFlP6UfvEIu5N1DOtnQ22q1Mji
    2E9dsQ44We+a5G/nKF+WQkjlLd4Vc/K4yDtMXPL/Y25qwcVqIx+Nwdn26ix+qokMEyXs
    ARm9fawHlAWCGDi3N7yauC+xHhd2IbWzRaNAtDLu2OVU5t+q5GhSYaYVRsOrswiZ2cw6
    QgNZOPob2CFXK3C6/Ul4rhqJUhfSSAF0kA84H2C1rdy9LJcY3pwMb5gwBPWQMAw8T6rW
    qlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683398734;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=k2L4LDqvMDvKT9rTW8lIVLVglQmVCitESdn915sWhi0=;
    b=KDITdW/PhPhrnHVKAnlkd2UQVHFrfR0nJz/Xkt1Ec+HKak3wDi/tigSrNRbzbxc7Fe
    AHsSWIAR8eZ/enuB3PVs6zmuyz+FyL2Z5JYrKrVj9pr9svT9IzwNfyHmoJJX84u36P3n
    NbWW0CLsb0KBQGk4fTpCIMYnTVHTuJl1sjunIE8dkhFl4fQOrCgY6xiU31sgm9+68mEk
    JfL37ZlqEl2WWR3hEZJmtRjQgVkYH6I4XIycXGuUuyBklTkgbbNL8Wmoc+KFayrbRJwB
    hxevw2MDyeJ9DXM2r9jOAaGrG1KecbiYCl29j0YOgEDCILL9wpVxebhdlcceRSrTdWDZ
    l75w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683398734;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=k2L4LDqvMDvKT9rTW8lIVLVglQmVCitESdn915sWhi0=;
    b=VxAa1NK0xknlhP3ksjEK88uuhlhk5ElFvnVzTLMTkYvPnUHIpI9lFnOtDIufRNeCl0
    qRqfmW7+fbgI9omIggcb1/ln3WkrZlKae25cCoAhQ5YSuPJ+2SlJZCBnBdEQ5/3UuqBG
    JEcSH7F/WVrPHIt6BetKebj7g6iQHNwk7/LDUm0ASnSasGuqiakVuIyt4veKudSl4mff
    OAyfe0MmFwoTqW9x3IZhbc9n3e1CxnV+TLfUvvCm1iLirrcQ2zPWzeyNk/X0EBcQfGEE
    js4eAJTMVoPBA+7ZT0Mwl6BUgzH96sptPwEeLZHVaKyxhxaNkHkOVv7K9k3C3dYWuyi/
    OCcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683398734;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=k2L4LDqvMDvKT9rTW8lIVLVglQmVCitESdn915sWhi0=;
    b=TuldbphxCD6QxPDB/weZiULwnamv63/LL4EdR5vrEhxtEWL5JbPXEU0X03kFV6HgVw
    jY0A13TkP3xOfUVYh4Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVsRgOm6JxTkcRMRp1G8vxYDkWr+"
Received: from blue.lan
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id x06214z46IjYKgA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 6 May 2023 20:45:34 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: dev: fix missing CAN XL support in can_put_echo_skb()
Date:   Sat,  6 May 2023 20:45:15 +0200
Message-Id: <20230506184515.39241-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

can_put_echo_skb() checks for the enabled IFF_ECHO flag and the
correct ETH_P type of the given skbuff. When implementing the CAN XL
support the new check for ETH_P_CANXL has been forgotten.

Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/skb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 241ec636e91f..f6d05b3ef59a 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -52,11 +52,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	BUG_ON(idx >= priv->echo_skb_max);
 
 	/* check flag whether this packet has to be looped back */
 	if (!(dev->flags & IFF_ECHO) ||
 	    (skb->protocol != htons(ETH_P_CAN) &&
-	     skb->protocol != htons(ETH_P_CANFD))) {
+	     skb->protocol != htons(ETH_P_CANFD) &&
+	     skb->protocol != htons(ETH_P_CANXL))) {
 		kfree_skb(skb);
 		return 0;
 	}
 
 	if (!priv->echo_skb[idx]) {
-- 
2.39.2

