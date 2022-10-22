Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3878608FBD
	for <lists+linux-can@lfdr.de>; Sat, 22 Oct 2022 23:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJVVgA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 22 Oct 2022 17:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJVVf7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 22 Oct 2022 17:35:59 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F437858E
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 14:35:57 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 70FA6240026
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 23:35:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1666474556; bh=9LuUqEqN5s5Z23z1D88rvBLFEfMsKEPcw1UP8rwWsBY=;
        h=From:To:Subject:Date:From;
        b=V5/y2ubXYGiZRtJAFEmIAotF6DATYkQi4IG2x2HNNDEqP0VLpK0b3TyX6coZxyIQV
         TRLOSf4v82meJmhvQZ4HLxnHofku2tFLGAfjWa9Dzu8/SIA1ENOq0v1DlmXi4+0uGO
         TCCXbzT2boquLEm+1fTf8bK89vp8tZJSG83n/50OT2v072tgpSQKrZm7GaECHq2Vbj
         LYmjj61KRp0OYOkCjQpLnUGZP/9wlL3zRz/vLo7grlpQWRaW8HkwVsMKiC5TOr+A5q
         K0zymBXFQkMH/Ae8Q5W+BsqkbrAaOlEkM/bLRsBRO0Y26gvWoeFabMqFUhwsN/5a63
         KwSVXN90oL07A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Mvvlb5yCWz9rxL
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 23:35:55 +0200 (CEST)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Subject: [PATCH 0/7] can: peak_usb: Introduce configurable user dev id
Date:   Sat, 22 Oct 2022 21:35:28 +0000
Message-Id: <20221022213535.8495-1-lukas.magel@posteo.net>
In-Reply-To: <20220801080446.36374-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series of patches introduces the user device id for the PEAK USB
CAN interfaces. The id can be read/written via ethtool and is exposed as
a read-only attribute via sysfs. This allows users to set the id via
ethtool and write udev rules to match against the sysfs attribute.

Most of the patches were originally introduced by Stéphane Grosjean and
have only been modified slightly. See the following threads for the
original patches:

* https://lore.kernel.org/linux-can/20220128150157.1222850-1-s.grosjean@peak-system.com/T/#mad8014c9f1c89a50d5944a50ae0a585edec79eab
* https://lore.kernel.org/linux-can/20211117150132.37056-1-s.grosjean@peak-system.com/T/#mbf1d7db8433734a1fe08868d79f9927a04fe7ffe

Stéphane Grosjean (5):
  can: peak_usb: rename device_id to a more explicit name
  can: peak_usb: add callback to read user value of CANFD
  can: peak_usb: allow flashing of the user device id
  can: peak_usb: replace unregister_netdev() with
  can: peak_usb: add ethtool interface to user defined

Lukas Magel (2):
  can: peak_usb: export PCAN user device ID as sysfs device
  can: peak_usb: align user device id format in log with

 .../ABI/testing/sysfs-class-net-peak_usb        |  15 +++
 drivers/net/can/usb/peak_usb/pcan_usb.c         |  43 ++++++-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c    | 119 +++++++++++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.h    |  11 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c      |  64 +++++++++-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c     |  26 +++-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h     |   1 +
 7 files changed, 254 insertions(+), 25 deletions(-)


