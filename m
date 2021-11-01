Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D348441B45
	for <lists+linux-can@lfdr.de>; Mon,  1 Nov 2021 13:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhKAMqA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Nov 2021 08:46:00 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:64827 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhKAMp7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Nov 2021 08:45:59 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by smtp.orange.fr with ESMTPA
        id hWejmM6H7ozlihWeqmPsa7; Mon, 01 Nov 2021 13:43:25 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: MDU0YmViZGZmMDIzYiBlMiM2NTczNTRjNWZkZTMwOGRiOGQ4ODf3NWI1ZTMyMzdiODlhOQ==
X-ME-Date: Mon, 01 Nov 2021 13:43:25 +0100
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH v2 0/3] iproute2-next: iplink_can: report the controller capabilities
Date:   Mon,  1 Nov 2021 21:43:11 +0900
Message-Id: <20211101124314.68200-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The patch series serve one purpose: allow the user to check both the
supported and the static capabilities.

Currently, the CAN netlink interface provides no easy ways to check
the capabilities of a given controller. The only method from the
command line is to try each CAN_CTRLMODE_ individually to check
whether the netlink interface returns an -EOPNOTSUPP error or not
(alternatively, one may find it easier to directly check the source
code of the driver instead...)

Here, we introduce a way to directly report the supported features as
well as the statically enabled features.

The first patch of the series only does some clean up. The second
patch is the real thing. The last patch contains the needed
modification to the uapi headers and is only there for convenience.


* Changelog *

v1 -> v2

  - The kernel uapi was modified to use a new NLA_NESTED entry instead
    of reusing struct can_ctrlmode. The second and third patch of the
    series were updated accordingly.

Vincent Mailhol (3):
  iplink_can: code refactoring of print_ctrlmode()
  iplink_can: add ctrlmode_{supported,_static} to the "--details --json"
    output
  can: netlink: add new field to struct can_ctrlmode to report
    capabilities

 include/uapi/linux/can/netlink.h | 11 +++++
 ip/iplink_can.c                  | 69 ++++++++++++++++++++++----------
 2 files changed, 58 insertions(+), 22 deletions(-)

-- 
2.32.0

