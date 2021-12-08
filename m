Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5E46D4C6
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 14:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhLHNwp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 08:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhLHNwp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 08:52:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBDBC061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 05:49:13 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1muxJo-0002JG-8L
        for linux-can@vger.kernel.org; Wed, 08 Dec 2021 14:49:12 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 766926BFCE3
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 13:49:11 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 528B06BFCE1
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 13:49:11 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9952edb9
        for <linux-can@vger.kernel.org>;
        Wed, 8 Dec 2021 13:49:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Subject: [PATCH v4 0/2] kvaser_{pciefd,usb} fixes
Date:   Wed,  8 Dec 2021 14:49:08 +0100
Message-Id: <20211208134910.263352-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

picking up Jimmy's work.

Changes since v3:
- dropped 2/4 "can: kvaser_usb: Use CAN_MHZ define in assignment of
  frequency" for easier back porting
- squashed 3/4 "kvaser_usb: Rearrange kvaser_usb_leaf_dev_cfg to avoid
                forward declaration"
  and 4/4: "can: kvaser_usb: Get CAN clock frequency from device"
  for easier back porting.

Jimmy, can you please rephrase the commit message of 2/2 so that it's
clear why this change is done, so that it's clear, why it should be
back ported to stable.

regards,
Marc



