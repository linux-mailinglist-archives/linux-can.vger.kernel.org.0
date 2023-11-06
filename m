Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DA77E251D
	for <lists+linux-can@lfdr.de>; Mon,  6 Nov 2023 14:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjKFN2Z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 6 Nov 2023 08:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjKFN2Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Nov 2023 08:28:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC26CD8;
        Mon,  6 Nov 2023 05:28:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2851DC433C8;
        Mon,  6 Nov 2023 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277301;
        bh=+zcwsPziCP1heQrsNrA204RKNc1KosIUVIDnbHTBPBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJQ5SpRV6UiyPovawfb22YSeh2JxX7y/plBW1yCCjXt2hJrj1PexjIRB6horeLW8b
         KjPaV4i6ckf1zNXLFFTvaJoIE8tjqtSQ5wfad2jApgBbAxhT4xAtDxyZP9yhiVi7nZ
         PzefC6BdH2Mco/wwAw0OS1tKbyl/CVSNT5cl0URQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz, Oliver Hartkopp" 
        <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.15 107/128] can: isotp: handle wait_event_interruptible() return values
Date:   Mon,  6 Nov 2023 14:04:27 +0100
Message-ID: <20231106130314.032914685@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit 823b2e42720f96f277940c37ea438b7c5ead51a4 upstream

When wait_event_interruptible() has been interrupted by a signal the
tx.state value might not be ISOTP_IDLE. Force the state machines
into idle state to inhibit the timer handlers to continue working.

Fixes: 866337865f37 ("can: isotp: fix tx state handling for echo tx processing")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/all/20230112192347.1944-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/isotp.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1071,6 +1071,10 @@ static int isotp_release(struct socket *
 	/* wait for complete transmission of current pdu */
 	wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 
+	/* force state machines to be idle also when a signal occurred */
+	so->tx.state = ISOTP_IDLE;
+	so->rx.state = ISOTP_IDLE;
+
 	spin_lock(&isotp_notifier_lock);
 	while (isotp_busy_notifier == so) {
 		spin_unlock(&isotp_notifier_lock);


