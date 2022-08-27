Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B15A3A30
	for <lists+linux-can@lfdr.de>; Sun, 28 Aug 2022 00:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiH0WP5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 27 Aug 2022 18:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiH0WPz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 27 Aug 2022 18:15:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5389832D8D
        for <linux-can@vger.kernel.org>; Sat, 27 Aug 2022 15:15:53 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oS45n-00076N-9X
        for linux-can@vger.kernel.org; Sun, 28 Aug 2022 00:15:51 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id CA5D4D5152
        for <linux-can@vger.kernel.org>; Sat, 27 Aug 2022 22:15:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9C989D514F;
        Sat, 27 Aug 2022 22:15:50 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d581e6bb;
        Sat, 27 Aug 2022 22:15:50 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     John Whittington <git@jbrengineering.co.uk>
Subject: Re: [PATCH v3 0/2] can: gs_usb: hardware timestamp support
Date:   Sun, 28 Aug 2022 00:15:46 +0200
Message-Id: <20220827221548.3291393-1-mkl@pengutronix.de>
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

after noticing that the gs_usb firmware sends timestamps on the TX,
too, I updated the driver and squashed the 2nd patch. Also added
proper endianness handling to gs_usb_get_timestamp(). I allowed to add
myself as Co-developed-by.

regards,
Marc

Changes since v2: https://lore.kernel.org/all/20220827092545.2971240-1-mkl@pengutronix.de
- new patch 1/2: use common spelling of GS_USB in macros
- squashed both old patches into now 2/2
- use GS_USB instead of GSUSB in macros
- gs_usb_get_timestamp(): renamed from gs_usb_get_sof_timestamp()
- gs_usb_get_timestamp(): take care of endianness
- gs_usb_skb_set_timestamp(): renamed from gs_usb_set_timestamp()
- gs_usb_set_timestamp(): add new function to add timestamp to skb
  from struct gs_host_frame
- add support for TX timestamps
- gs_can_eth_ioctl(): return -EOPNOTSUPP if device doesn't support
  GS_CAN_FEATURE_HW_TIMESTAMP
- gs_usb_get_ts_info(): renamed from gs_usb_get_ts_info_hwts()
- gs_usb_get_ts_info(): call can_ethtool_op_get_ts_info_hwts() if
  device supports GS_CAN_FEATURE_HW_TIMESTAMP, call
  ethtool_op_get_ts_info() otherwise

Changes since v1: https://lore.kernel.org/all/20220826104629.2837024-1-mkl@pengutronix.de
- add new includes sorted
- adjust multi line comment style
- don't use 1e6, but 1 * HZ_PER_MHZ, to fix sparse warning
- use __le32 instead of u32 in struct classic_can_ts and canfd_ts
- place _ts in front of _quirk in union in struct gs_host_frame
- gs_usb_get_sof_timestamp(): pass "const struct gs_can *dev" as 1st
  argument, not struct net_device *netdev, simplify return handling
- gs_usb_timestamp_init(), gs_usb_timestamp_stop(),
  gs_usb_get_ts_info_hwts(): make static
- gs_usb_timestamp_init(): increase cc->shift to maximize precision
- fix long lines, remove braces {} for single statement blocks
- gs_can_open(): move check for GS_CAN_FEATURE_HW_TIMESTAMP after all
  ctrlmode checks
- gs_can_open(): move start polling sof timestamp after kfree(dm)
- gs_can_close(): move stop polling sof timestamp to be symmetric with
  respect to gs_can_open()
- gs_usb_probe(): make calculation of dev->hf_size_rx more robost


