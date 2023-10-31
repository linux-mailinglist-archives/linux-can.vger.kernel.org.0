Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F46B7DC99E
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbjJaJa4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343914AbjJaJay (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:30:54 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A55E8;
        Tue, 31 Oct 2023 02:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744632; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kQDlBYbtdXp0CXQyh4AK0t2LLSYxFV+5oIdzFKk+mS3B5T+iXFRDpkon3NxAiaOL/d
    DhqnHaUjjENYin3LvV3lj3z2VJh7wEMB9G2+uhVVISi5dYR9wToJ2XGkNRwfvLTbx5mt
    TdfM2AfGO7f2T5T3F42eT0yTm0Pcknm3jAjahaDUtE8VJwjLrW54oSKnCG//oEgSpMV9
    VwMIq2CoEhHM+VLkFY8O796SnyNVEP8wQrorzyfb8ux3U+w9e+jJPNbdbH1WZ7eKL5g1
    zbjvk4fZEPh2AOa1vHjFXsdN1j+o/XfjnlEJl41MlS4PYGnXpRreMmltP7FyFzQDisPw
    aA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744632;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=+ERCfMTl28S+8jtTFDpNzqECn8kmUNeMxFcvkBSsPDU=;
    b=nlW30nkXUVMKCLAcHdcS7DiJ0CdPh7+/IrC0/g+ZvTt8tdm2BAdMroUMi/gSjRAfq5
    06q/kV8X8QWgz9isuMPBk+o55Se8qgecmyEldQZhS0O2kGibu2r+wQzsqFlH/CDfp3pf
    R5xuXMukC1K4qO8sGfes9/ldKR6Qtt2dbousQNRYEtegp0HhigdISKu+5oEEHwyVG0XD
    5YYnbyKyi1NwiBKXlgzt8JpzDk5bCrtmnq+OjWAxS2kchVsLi3h7BPV0cS3YWHz5gUmI
    8BRyNDeiYmF5EazrUuoC3pvAFW5sbzuiru2VmZ0AZbZHES8edt0t9xz4vOHFrmi73WYn
    FSJg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744632;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=+ERCfMTl28S+8jtTFDpNzqECn8kmUNeMxFcvkBSsPDU=;
    b=BAydYZeBRddVJwpUsvjToTeulcZCta8SclqroZQYkcNiX6QPutXo1IKWEFBLtaQEOG
    N4f2x7FOH/tCYBAXAAJ4eMvIf9W+Qfe4GhOa52xoWGs0CzuZtFo7wTqYcwW1sLBW3e2K
    lIba47DOeZ1T5Vdl04DEth3aXs8VhuL6BTppk9TizACtrsgrgfEs4b4IzkLLCSRy1Ov5
    hjek1T/NNKesEBzLHfwT2bosUVgyoCPxM9eORFEk+p3ZHmVP+2jnOa6ZVWqZTspkr4Kg
    TuH6mRy4w6rsUQqFjfKIqSlVJRQDtP+7T1b3dvS4seql4Isnz0bEb7dR04jvP1MKlMup
    3zyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744632;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=+ERCfMTl28S+8jtTFDpNzqECn8kmUNeMxFcvkBSsPDU=;
    b=uSsFzM0K9Ijsmi4OonI2jfl0YXee5RFpQqis45T1bCgnOsAMbhg21iis3A8XwpPNTj
    QB56J5B4lRk0pTvtHUDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9UVFhZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Oct 2023 10:30:31 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Derek Will <derekrobertwill@gmail.com>
Subject: [PATCH stable 5.15 2/7] can: isotp: isotp_bind(): return -EINVAL on incorrect CAN ID formatting
Date:   Tue, 31 Oct 2023 10:30:20 +0100
Message-Id: <20231031093025.2699-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031093025.2699-1-socketcan@hartkopp.net>
References: <20231031093025.2699-1-socketcan@hartkopp.net>
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

commit 2aa39889c463195a0dfe2aff9fad413139c32a4f upstream

Commit 3ea566422cbd ("can: isotp: sanitize CAN ID checks in
isotp_bind()") checks the given CAN ID address information by
sanitizing the input values.

This check (silently) removes obsolete bits by masking the given CAN
IDs.

Derek Will suggested to give a feedback to the application programmer
when the 'sanitizing' was actually needed which means the programmer
provided CAN ID content in a wrong format (e.g. SFF CAN IDs with a CAN
ID > 0x7FF).

Link: https://lore.kernel.org/all/20220515181633.76671-1-socketcan@hartkopp.net
Suggested-by: Derek Will <derekrobertwill@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 3e2a7cbade24..b5fdf30a6996 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1140,10 +1140,15 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (rx_id & CAN_EFF_FLAG)
 		rx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
 	else
 		rx_id &= CAN_SFF_MASK;
 
+	/* give feedback on wrong CAN-ID values */
+	if (tx_id != addr->can_addr.tp.tx_id ||
+	    rx_id != addr->can_addr.tp.rx_id)
+		return -EINVAL;
+
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
 	lock_sock(sk);
 
-- 
2.34.1

