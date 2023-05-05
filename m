Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19906F812B
	for <lists+linux-can@lfdr.de>; Fri,  5 May 2023 13:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjEELDP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 May 2023 07:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEELDO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2023 07:03:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BC119D42
        for <linux-can@vger.kernel.org>; Fri,  5 May 2023 04:03:13 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1putDT-0004W8-UD
        for linux-can@vger.kernel.org; Fri, 05 May 2023 13:03:11 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4C5521BE808
        for <linux-can@vger.kernel.org>; Fri,  5 May 2023 11:03:11 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D2C261BE802;
        Fri,  5 May 2023 11:03:10 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 76303b65;
        Fri, 5 May 2023 11:03:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: Re: [PATCH v3 0/2] can: isotp: recvmsg(): allow MSG_CMSG_COMPAT flag
Date:   Fri,  5 May 2023 13:03:06 +0200
Message-Id: <20230505110308.81087-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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

sending v3 of Oliver's original patch
(https://lore.kernel.org/all/20230406110845.5180-1-socketcan@hartkopp.net/).

No code change since v2, but resending with standard git Message-Id
headers. I wasn't satisfied with my headers experiment. Sorry for the
noise.

Marc

Changes since v2:
- use standard git send-email message ids
Changes since v1:
- split into separate patches
- add Oleksij's Acked- and Tested-by to the j1939 patch
- adjust subject and patch description.

regards,
Marc


