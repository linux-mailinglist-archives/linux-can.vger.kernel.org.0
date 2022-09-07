Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12195B01FC
	for <lists+linux-can@lfdr.de>; Wed,  7 Sep 2022 12:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiIGKiy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Sep 2022 06:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIGKiv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Sep 2022 06:38:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0ED7674F
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 03:38:49 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oVsSG-0001Ic-7t
        for linux-can@vger.kernel.org; Wed, 07 Sep 2022 12:38:48 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A17CEDC663
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 10:38:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1AD2EDC65E;
        Wed,  7 Sep 2022 10:38:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 76d5074d;
        Wed, 7 Sep 2022 10:38:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Mark Bath <mark@baggywrinkle.co.uk>
Subject: [PATCH 0/5] can: bittiming: improve SJW handling and default
Date:   Wed,  7 Sep 2022 12:38:40 +0200
Message-Id: <20220907103845.3929288-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

several people noticed that on modern CAN controllers with wide bit
timing registers the default SJW of 1 can result in unstable or no
synchronization to the CAN network. See Patch 5/5 for details.

This series fixes the issue by first cleaning up the SJW handling,
making it more standard compliant (SJW must not be longer than any
Phase Seg - not just Phase Seg2) and finally using Phase Seg2 / 2 as
default, if the user space provided no SJW configuration.

regards,
Marc



