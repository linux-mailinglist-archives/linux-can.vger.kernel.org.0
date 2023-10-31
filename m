Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215C97DC980
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbjJaJaV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbjJaJaT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:30:19 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005FBB7;
        Tue, 31 Oct 2023 02:30:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744596; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G70dnC7TKHeSRERFtnrQ5CggAYBhhB4B+U446rQcTycplMbudDVm4pHzxGWnKavI8w
    uHc56p9VeYdPObF2lKji/GEj4veSJS2RnHWukMrLz/OANluQGxICFR254/PKiJ8SSAFM
    K/n63oRZrXeJkiS1vdGsiYNmnwlPgajDYJiuWpayTINbtAG61KvIya3jJHK+JfdXimoX
    iEuG58806e85Yv9TlgRhsumanRFBLaliiUgtkD+3ActW6Nc3eUYxE0oFNRkTFX8NIg4q
    PysHSrmmaDKro4i3zAd0wZ+tooON9t0NdhUG6I0SMjfN3caLPp5s1/CIbr5EE8gkW2Qb
    RBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744596;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=xvB9tfBNwColRkzOE7Dyug3PKRsbP18DQBxBaNs3Obc=;
    b=R/paozWjj5gvBxWtCmn6/20fCuD+BOZp4U06eSQC1y4jTgpr56vwIcVMwXs79ZgKG8
    Ud6K27tp5iksUXqfqxPN1Z+UBHoX4xPmbgKFuEgNIWW5CZbqfKdx5RmKlna3QL+ZnCI9
    8hvTCnof8Judj/6U/kEUIp1+rWxlfqkCMWLPNUd5l36eUwkpu/VRrEmdixqOBQu8UoVG
    ZKQhpUz6CKPdsk1h6OD1lK+CMEFIDOT6SnTk3Bm0ampNW1ng0hyVSmVpgc6X1tQQ5DeQ
    2DI+B7YZ9c01xF5itd3LpupFQs7tFXGXkfX46IB+UAU2UhWEN8FbxhQC7BgPKgckVnIE
    SpkA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744596;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=xvB9tfBNwColRkzOE7Dyug3PKRsbP18DQBxBaNs3Obc=;
    b=anFGaALSUysO6VY4fQynKuoHWw0AqTkINzmj/yvam9bvRKVihBRAGoEdKNQQ15LrL6
    SwHju9w4aiQJXaM/0DAMQFYRvxFWWzkaks6Y+H9mm2V00zPOQGtGzy21LmlyYkTMHwwe
    9tJjR3g/oGrI/mtXPEivDt+1fkwEyikLYnNaK3XrLTLTkdRUI4Yt3/yh9HZ7Jd8lexOc
    t/Xsn4lhvFRpSrd0Y3a1niGhhR1NPrFO06tMGmUPjAkDhbY2W2rIiJPuDDcJL6mlIElK
    iwEyC3i7budSvo+y+XJmiyILy2jPvBUu2F36we2ybW+/ZUJ7u6Q2ZjQKc9hGRTSTo9jj
    QRUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744596;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=xvB9tfBNwColRkzOE7Dyug3PKRsbP18DQBxBaNs3Obc=;
    b=Vx+gln20dYQY5D7xgaOddpY3gauvXVIQE5sPEDFB3EgDeFlWzgh9jQd3D94DMShzmp
    HFzUrfGEG5PO6fr6zxBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9TuFhH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Oct 2023 10:29:56 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Derek Will <derekrobertwill@gmail.com>
Subject: [PATCH stable 5.10 05/10] can: isotp: isotp_bind(): return -EINVAL on incorrect CAN ID formatting
Date:   Tue, 31 Oct 2023 10:29:13 +0100
Message-Id: <20231031092918.2668-6-socketcan@hartkopp.net>
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
index fb179a333784..902cb61b6495 100644
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

