Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AD03B64CD
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhF1PPx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 11:15:53 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:25880 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbhF1PPA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:15:00 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id NfCP250070zjR6y03fCWgg; Mon, 28 Jun 2021 17:12:32 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:12:32 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 0/4] add the netlink interface for CAN-FD Transmitter Delay Compensation (TDC)
Date:   Tue, 29 Jun 2021 00:06:03 +0900
Message-Id: <20210628150607.1128574-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series adds a netlink interface for the TDC parameters using
netlink nested attributes.

The first patch allow a user to turn off a feature even if not
supported (e.g. allow "ip link set can0 type can bitrate 500000 fd
off" even if fd is not supported). This feature will be used later by
the four patch of the series.

The third patch addresses the concern of Marc and Stefan concerning
some devices which use a TDCO value relative to the Sample Point (so
far, the TDC implementation used the formula SSP = TDCV + TDCO).

The forth and last patch is the real thing: the TDC netlink interface.

This series completes the implementation of the Transmitter Delay
Compensation (TDC) in the kernel which started in March with those two
patches:
  - commit 289ea9e4ae59 ("can: add new CAN FD bittiming parameters:
    Transmitter Delay Compensation (TDC)")
  - commit c25cc7993243 ("can: bittiming: add calculation for CAN FD
    Transmitter Delay Compensation (TDC)")

The netlink interface was missing from this series because the initial
patch needed rework in order to make it more flexible for future
changes.

At that time, Marc suggested to take inspiration from the recently
released ethtool-netlink interface.
Ref: https://lore.kernel.org/linux-can/20210407081557.m3sotnepbgasarri@pengutronix.de/

ethtool uses nested attributes (c.f. NLA_NESTED type in validation
policy). A bit of trivia: the NLA_NESTED type was introduced in
version 2.6.15 of the kernel and thus actually predates Socket CAN.
Ref: commit bfa83a9e03cf ("[NETLINK]: Type-safe netlink messages/attributes interface")

** Changelog **

v2 -> v3:
  - allows both TDCV and TDCO to be zero.
  - introduce the can_tdc_get_relative_tdco() helper function
  - other path of the series modified accordingly to above changes.

RFC v1 -> v2:
  The v2 fixes several issue in can_tdc_get_size() and
  can_tdc_fill_info(). Namely: can_tdc_get_size() returned an
  incorrect size if TDC was not implemented and can_tdc_fill_info()
  did not include a fail path with nla_nest_cancel().

Vincent Mailhol (4):
  can: netlink: allow user to turn off unsupported features
  can: bittiming: allow TDC{V,O} to be zero and add
    can_tdc_const::tdc{v,o,f}_min
  can: dev: add can_tdc_get_relative_tdco() helper function
  can: netlink: add interface for CAN-FD Transmitter Delay Compensation
    (TDC)

 drivers/net/can/dev/bittiming.c           |  10 +-
 drivers/net/can/dev/netlink.c             | 182 +++++++++++++++++++++-
 drivers/net/can/usb/etas_es58x/es58x_fd.c |   7 +-
 include/linux/can/bittiming.h             |  64 ++++++--
 include/linux/can/dev.h                   |  32 ++++
 include/uapi/linux/can/netlink.h          |  31 +++-
 6 files changed, 297 insertions(+), 29 deletions(-)


base-commit: 214461d6bce8748f7fbd48647a25cef5209e5d1d
-- 
2.31.1

