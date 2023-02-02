Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6AE687B97
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 12:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjBBLJH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 06:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBBLJG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 06:09:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71848DBF8
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 03:09:00 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNXSc-0006m9-PY
        for linux-can@vger.kernel.org; Thu, 02 Feb 2023 12:08:58 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E96AE16D2A8
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 11:08:57 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id CA40716D282;
        Thu,  2 Feb 2023 11:08:56 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id fcb14b52;
        Thu, 2 Feb 2023 11:08:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Thomas Kopp <thomas.kopp@microchip.com>, kernel@pengutronix.de,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Mark Bath <mark@baggywrinkle.co.uk>
Subject: [PATCH v2 00/17] can: bittiming: cleanups and rework SJW handling
Date:   Thu,  2 Feb 2023 12:08:37 +0100
Message-Id: <20230202110854.2318594-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

several people noticed that on modern CAN controllers with wide bit
timing registers the default SJW of 1 can result in unstable or no
synchronization to the CAN network. See Patch 14/17 for details.

During review of v1 Vincent pointed out that the original code and the
series doesn't always check user provided bit timing parameters,
sometimes silently limits them and the return error values are not
consistent.

This series first cleans up some code in bittiming.c, replacing
open-coded variants by macros or functions (Patches 1, 2).

Patch 3 adds the missing assignment of the effective TQ if the
interface is configured with low level timing parameters.

Patch 4 is another code cleanup.

Patches 5, 6 check the bit timing parameter during interface
registration.

Patch 7 adds a validation of the sample point.

The patches 8-13 convert the error messages from netdev_err() to
NL_SET_ERR_MSG_FMT, factor out the SJW handling from
can_fixup_bittiming(), add checking and error messages for the
individual limits and harmonize the error return values.

Patch 14 changes the default SJW value from 1 to min(Phase Seg1, Phase
Seg2 / 2).

Patch 15 switches can_calc_bittiming() to use the new SJW handling.

Patch 16 converts can_calc_bittiming() to NL_SET_ERR_MSG_FMT().

And patch 16 adds a NL_SET_ERR_MSG_FMT() error message to
can_validate_bitrate().

regards,
Marc



